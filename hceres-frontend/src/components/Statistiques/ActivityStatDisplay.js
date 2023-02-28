import React from 'react';
import {fetchActivityStatOfType} from "../../services/stat/ActivityStatActions";
import {Form} from "react-bootstrap";
import {Oval} from "react-loading-icons";
import {fetchListTeams} from "../../services/Team/TeamActions";
import {fetchListLaboratories} from "../../services/laboratory/LaboratoryActions";
import {fetchListInstitutions} from "../../services/institution/InstitutionActions";
import {
    Bar,
    BarChart,
    CartesianGrid, Cell, LabelList, Pie, PieChart,
    ResponsiveContainer,
    Tooltip,
    XAxis,
    YAxis
} from "recharts";
import getRandomBackgroundColor from "../util/ColorGenerator";


export default function ActivityStatDisplay({activityStatEntry}) {
    const [teamIdMap, setTeamIdMap] = React.useState({});
    const [laboratoryIdMap, setLaboratoryIdMap] = React.useState({});
    const [institutionIdMap, setInstitutionIdMap] = React.useState({});

    const [activityStatList, setActivityStatList] = React.useState([]);
    const [activityStatFilteredList, setActivityStatFilteredList] = React.useState([]);
    const [isLoading, setLoading] = React.useState(false);

    const groupByNoneCallback = React.useCallback((activityStat) => {
        return [
            {
                // random group key value to generate blue color
                groupKey: 20,
                groupLabel: 'Total',
            }
        ]
    }, [])

    const groupByTeamCallback = React.useCallback((activityStat) => {
        return activityStat.teamIds.map((teamId) => {
            return {
                groupKey: teamId,
                groupLabel: teamIdMap[teamId] ? teamIdMap[teamId].teamName : 'Team id ' + teamId,
            }
        })
    }, [teamIdMap])

    const groupByLaboratoryCallback = React.useCallback((activityStat) => {
        return activityStat.teamIds.map((teamId, index) => {
            let team = teamIdMap[teamId];
            if (team) {
                let laboratoryId = team.laboratoryId;
                return {
                    groupKey: laboratoryId,
                    groupLabel: laboratoryIdMap[laboratoryId] ? laboratoryIdMap[laboratoryId].laboratoryName : 'Laboratory id ' + laboratoryId,
                }
            }
            return {
                groupKey: index,
                groupLabel: 'No laboratory for team id ' + teamId,
            }
        })
    }, [teamIdMap, laboratoryIdMap])

    const groupByInstitutionCallback = React.useCallback((activityStat) => {
        return activityStat.teamIds.map((teamId, index) => {
            let team = teamIdMap[teamId];
            if (team) {
                let laboratoryId = team.laboratoryId;
                let laboratory = laboratoryIdMap[laboratoryId];
                if (laboratory) {
                    let institutionId = laboratory.institutionId;
                    return {
                        groupKey: institutionId,
                        groupLabel: institutionIdMap[institutionId] ? institutionIdMap[institutionId].institutionName : 'Institution id ' + institutionId,
                    }
                }
            }
            return {
                groupKey: index,
                groupLabel: 'No institution for team id ' + teamId,
            }
        })
    }, [teamIdMap, laboratoryIdMap, institutionIdMap])

    const groupByList = React.useMemo(() => [
        {key: 'none', label: 'No group', checked: true, callbackGroupBy: groupByNoneCallback},
        {key: 'team', label: 'Equipe', callbackGroupBy: groupByTeamCallback},
        {key: 'laboratory', label: 'Laboratoire', callbackGroupBy: groupByLaboratoryCallback},
        {key: 'institution', label: 'Institution', callbackGroupBy: groupByInstitutionCallback},
        ...activityStatEntry.customGroupByList
    ], [activityStatEntry, groupByNoneCallback,
        groupByTeamCallback, groupByLaboratoryCallback,
        groupByInstitutionCallback]);

    const [groupBy, setGroupBy] = React.useState(groupByList[0]);


    const [filters, setFilters] = React.useState({});

    const [chartOptions, setChartOptions] = React.useState({
        data: [],
        dataNameMap: {},
        chartWidth: 500,
        chartHeight: 300,
        showCountLabel: true,
        showPercentageLabel: false,
    });
    const handleChartOptionChange = (event) => {
        const {name, value, type, checked} = event.target
        setChartOptions(prevState => ({
            ...prevState,
            [name]: type === "checkbox" ? checked : value
        }))
    }

    const [chartTemplateList] = React.useState([
        {key: 'bar', label: 'Bar chart', checked: true},
        {key: 'pie', label: 'Pie chart'},
        {key: 'line', label: 'Line chart'},
    ]);
    const [chartTemplate, setChartTemplate] = React.useState(chartTemplateList[0]);


    React.useEffect(() => {
        setLoading(true);
        // if groupBy is in groupByList, leave it, else set groupBy to first element of groupByList
        // this check is necessary when activityStatEntry is updated
        if (groupByList.find((groupByItem) => groupByItem.key === groupBy.key) === undefined) {
            setGroupBy(groupByList[0]);
        }
        // setActivityStatFilteredList([]); // uncomment in production
        // setActivityStatList([]); // uncomment in production
        Promise.all([
            fetchActivityStatOfType(activityStatEntry.idTypeActivity),
            fetchListTeams(),
            fetchListLaboratories(),
            fetchListInstitutions(),
        ])
            .then(([activityStatList, teamList, labList, institutionList]) => {
                activityStatList = activityStatEntry.prepareData(activityStatList);
                setActivityStatList(activityStatList);
                setActivityStatFilteredList(activityStatList);
                setTeamIdMap(teamList.reduce((map, obj) => {
                    map[obj.teamId] = obj;
                    return map;
                }, {}));
                setLaboratoryIdMap(labList.reduce((map, obj) => {
                    map[obj.laboratoryId] = obj;
                    return map;
                }, {}));
                setInstitutionIdMap(institutionList.reduce((map, obj) => {
                    map[obj.institutionId] = obj;
                    return map;
                }, {}));
            })
            .catch(error => {
                // handle error
            })
            .finally(() => {
                setLoading(false);
            });
    }, [activityStatEntry]);

    React.useEffect(() => {
        let filteredList = activityStatList.filter((activity) => {
            let keep = true;
            Object.values(filters).forEach((filter) => {
                if (!filter.callbackFilter(activity, filter.value)) {
                    keep = false;
                }
            })
            return keep;
        })
        setActivityStatFilteredList(filteredList)
    }, [filters, activityStatList])
    React.useEffect(() => {
        let chartData = [];
        if (groupBy.callbackGroupBy) {
            // custom group by
            let groupKeyMap = {};
            let groupLabelMap = {};
            activityStatFilteredList.forEach((activity) => {
                const groupList = groupBy.callbackGroupBy(activity);
                groupList.forEach((group) => {
                    if (groupKeyMap[group.groupKey] === undefined) {
                        let groupLabel = group.groupLabel;
                        let groupLabelIndex = 2;
                        // use groupLabelMap to avoid duplicate groupLabel
                        while (groupLabelMap[groupLabel] !== undefined) {
                            groupLabel = group.groupLabel + ' (' + groupLabelIndex + ')';
                            groupLabelIndex++;
                        }
                        groupLabelMap[groupLabel] = true;
                        groupKeyMap[group.groupKey] = {
                            groupKey: group.groupKey,
                            groupLabel: groupLabel,
                            count: 0,
                        }

                    }
                    groupKeyMap[group.groupKey].count++;
                })
            })
            console.log(groupKeyMap);

            chartData = Object.keys(groupKeyMap).map((groupKey) => {
                return {
                    key: groupKeyMap[groupKey].groupKey,
                    name: groupKeyMap[groupKey].groupLabel,
                    count: groupKeyMap[groupKey].count,
                }
            });
            console.log(chartData);
        }

        setChartOptions(prevState => ({
            ...prevState,
            data: chartData,
            dataNameMap: chartData.reduce((map, obj) => {
                map[obj.name] = obj;
                return map;
            }, {}),
        }))
    }, [groupBy, activityStatFilteredList])

    const renderBarCustomizedLabel = (props) => {
        const {x, y, width, height} = props;
        const entry = chartOptions.dataNameMap[props.name];
        const percentage = (entry.count / activityStatFilteredList.length * 100).toFixed(0);
        const {backgroundColor, color} = getRandomBackgroundColor(entry.key);
        const radius = 10;
        return (
            <g>
                {chartOptions.showCountLabel &&
                    <>
                        <ellipse cx={x + width / 2} cy={y - radius} rx={radius * 2} ry={radius} fill={backgroundColor}/>
                        <text x={x + width / 2} y={y - radius} fill={color} textAnchor="middle" dominantBaseline="middle">
                            {entry.count}
                        </text>
                    </>
                }

                {chartOptions.showPercentageLabel && percentage > 0 &&
                    <text x={x + width / 2} y={y + height / 2} fill={color} textAnchor="middle"
                          dominantBaseline="middle">
                        {`${percentage}%`}
                    </text>
                }
            </g>
        );
    };

    // pie chart options
    const RADIAN = Math.PI / 180;
    const renderPieCustomizedLabel = (entry) => {
        const {cx, cy, midAngle, innerRadius, outerRadius, percent} = entry;
        const radius = innerRadius + (outerRadius - innerRadius) * 0.5;
        const x = cx + radius * Math.cos(-midAngle * RADIAN);
        const y = cy + radius * Math.sin(-midAngle * RADIAN);
        const percentage = (percent * 100).toFixed(0);
        console.log(entry.key);
        const {color} = getRandomBackgroundColor(entry.key);
        return (
            <>
                {chartOptions.showPercentageLabel && percentage > 0 &&
                    <text x={x} y={y} fill={color} textAnchor={x > cx ? 'start' : 'end'} dominantBaseline="central">
                        {`${percentage}%`}
                    </text>
                }
                <text {...entry}
                      fill={"#000000"}
                      stroke={entry.fill}
                      strokeWidth={2}
                      paintOrder="stroke"
                >
                    {entry.name}
                    {chartOptions.showCountLabel && ` (${entry.count})`}
                </text>
            </>
        );
    };

    return (
        <div>
            <h1 style={{fontSize: 24, marginBottom: 20}}>Des statistiques sur les {activityStatEntry.label} </h1>
            {/*make loading icon when charging the list*/}
            <div>

                {isLoading && <div><Oval className="ml-2" stroke={"black"}/> Loading...</div>}

            </div>
            <div>
                <div>Total count: {activityStatList?.length}</div>
                <div>Total Filtered count: {activityStatFilteredList?.length}</div>

                <div className={"card"} hidden={activityStatEntry?.filters?.length <= 0}>
                    <div className={"card-header alert-primary"}>
                        <h3 className={"card-header-title"}>Filtres</h3>
                    </div>
                    <div className={"card-content"}>
                        {activityStatEntry.filters.map((filter) => (
                            <div key={filter.key}>
                                <label className={"label"}>{filter.label}</label>
                                <input
                                    type={filter.inputType}
                                    defaultValue={filter.initialValueCallback ? filter.initialValueCallback(activityStatList) : ''}
                                    onChange={(e) => setFilters({
                                        ...filters,
                                        [filter.key]: {
                                            callbackFilter: filter.callbackFilter,
                                            value: e.target.value
                                        }
                                    })}
                                />
                            </div> /*filter*/
                        ))}
                        <br/>
                    </div>
                    {/*card-content*/}
                </div>
                {/*card*/}

                <div className={"card"}>
                    <div className={"card-header alert-primary"}>
                        <h3 className={"card-header-title"}>Chart options</h3>
                    </div>
                    <div className={"card-content"}>
                        <div>
                            <label className={"label"}>Chart type</label>
                            <div style={{display: 'flex'}}>
                                {chartTemplateList.map((chart) => (
                                    <div key={chart.key}>
                                        <Form.Check
                                            type={"radio"}
                                            defaultChecked={chart.checked}
                                            name={"chartType"}
                                            id={chart.key}
                                            label={chart.label}
                                            onChange={() => setChartTemplate(chart)}
                                        />
                                    </div>
                                ))}
                            </div>
                        </div>

                        <div>
                            <label className={"label"}>Chart size (pixels)</label>
                            <div style={{display: 'flex'}}>
                                <label className={"label"}>Width</label>
                                <input
                                    type={"number"}
                                    value={chartOptions.chartWidth}
                                    name={"chartWidth"}
                                    onChange={handleChartOptionChange}
                                />
                                <label className={"label"}>Height</label>
                                <input
                                    type={"number"}
                                    value={chartOptions.chartHeight}
                                    name={"chartHeight"}
                                    onChange={handleChartOptionChange}
                                />
                            </div>
                        </div>

                        <div>
                            <label className={"label"}>Chart Labels</label>
                            <div style={{display: 'flex'}}>
                                <label className={"label"}>Count</label>
                                <input
                                    type={"checkbox"}
                                    checked={chartOptions.showCountLabel}
                                    name={"showCountLabel"}
                                    onChange={handleChartOptionChange}
                                />
                                <label className={"label"}>Percentage</label>
                                <input
                                    type={"checkbox"}
                                    checked={chartOptions.showPercentageLabel}
                                    name={"showPercentageLabel"}
                                    onChange={handleChartOptionChange}
                                />
                            </div>
                        </div>

                        <label className={"label"}>Activités regroupées par </label>
                        <div style={{display: 'flex'}}>
                            {groupByList.map((group) => (
                                <div key={group.key} className={"ml-2"}>
                                    <Form.Check
                                        type={"radio"}
                                        name={"groupBy"}
                                        id={group.key}
                                        label={group.label}
                                        defaultChecked={group.checked}
                                        onChange={() => setGroupBy(group)}
                                    />
                                </div>
                            ))}
                        </div>
                        <br/>
                    </div>
                    {/*card-content*/}
                </div>
                {/*card*/}

                <br/>

                <div
                    style={{
                        width: chartOptions.chartWidth + "px",
                        height: chartOptions.chartHeight + "px",
                    }}
                >
                    {chartTemplate.key === 'bar' ?
                        <ResponsiveContainer>
                            <BarChart
                                data={chartOptions.data}
                                margin={{
                                    top: 20,
                                    right: 30,
                                    left: 20,
                                    bottom: 5,
                                }}
                            >
                                <CartesianGrid strokeDasharray="3 3"/>
                                <XAxis dataKey="name"/>
                                <YAxis/>
                                <Tooltip/>
                                <Bar dataKey="count" stackId="a" fill="#8884d8">
                                    {chartOptions.data.map((entry, index) => (
                                        <Cell key={entry.key}
                                              fill={getRandomBackgroundColor(entry.key).backgroundColor}/>
                                    ))}
                                    <LabelList dataKey="name" content={renderBarCustomizedLabel}/>
                                </Bar>
                            </BarChart>
                        </ResponsiveContainer>
                        : <></>
                    }
                    {chartTemplate.key === 'pie' ?
                        <ResponsiveContainer>
                            <PieChart>
                                <Pie
                                    data={chartOptions.data}
                                    dataKey="count"
                                    cx="50%"
                                    cy="50%"
                                    outerRadius={80}
                                    label={renderPieCustomizedLabel}
                                    fill="#8884d8"
                                >
                                    {chartOptions.data.map((entry, index) => (
                                        <Cell key={entry.key}
                                              fill={getRandomBackgroundColor(entry.key).backgroundColor}/>
                                    ))}
                                </Pie>
                                <Tooltip/>
                            </PieChart>
                        </ResponsiveContainer>
                        : <></>
                    }
                </div>

                <div className={"title"}>
                    <h1 style={{fontSize: 24, marginBottom: 20}}>
                        {chartTemplate?.label} des {activityStatEntry.label}
                        {groupBy.key !== 'noGroupBy' && " regroupées par " + groupBy.label}
                    </h1>
                </div>
            </div>
            <br/>
            <br/>
            <br/>
        </div>
    );
}