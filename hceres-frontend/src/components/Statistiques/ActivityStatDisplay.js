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
    CartesianGrid, Cell,
    Legend, Pie, PieChart,
    ResponsiveContainer,
    Tooltip,
    XAxis,
    YAxis
} from "recharts";
import getRandomBackgroundColor from "../util/ColorGenerator";


const data = [
    {
        name: 'Page A',
        uv: 4000,
        pv: 2400,
        amt: 2400,
    },
    {
        name: 'Page B',
        uv: 3000,
        pv: 1398,
        amt: 2210,
    },
    {
        name: 'Page C',
        uv: 2000,
        pv: 9800,
        amt: 2290,
    },
    {
        name: 'Page D',
        uv: 2780,
        pv: 3908,
        amt: 2000,
    },
    {
        name: 'Page E',
        uv: 1890,
        pv: 4800,
        amt: 2181,
    },
    {
        name: 'Page F',
        uv: 2390,
        pv: 3800,
        amt: 2500,
    },
    {
        name: 'Page G',
        uv: 3490,
        pv: 4300,
        amt: 2100,
    },
];
//         if (groupBy.key === 'none') {
//             let count = activityStatFilteredList.length;
//             chartData.push({name: 'Total', count: count})
//         } else if (groupBy.key === 'team') {
//             let groupMap = {};
//             activityStatFilteredList.forEach((activity) => {
//                 activity.teamIds.forEach((teamId) => {
//                     if (groupMap[teamId] === undefined) {
//                         groupMap[teamId] = 0;
//                     }
//                     groupMap[teamId]++;
//                 })
//             })
//             chartData = Object.keys(groupMap).map((teamId) => {
//                 let team = teamIdMap[teamId];
//                 let teamName = team ? team.teamName : 'Team id ' + teamId;
//                 return {name: teamName, count: groupMap[teamId]}
//             });
//         } else if (groupBy.key === 'laboratory') {
//             let groupMap = {};
//             activityStatFilteredList.forEach((activity) => {
//                 activity.teamIds.forEach((teamId) => {
//                     let team = teamIdMap[teamId];
//                     if (team) {
//                         let laboratoryId = team.laboratoryId;
//                         if (groupMap[laboratoryId] === undefined) {
//                             groupMap[laboratoryId] = 0;
//                         }
//                         groupMap[laboratoryId]++;
//                     }
//                 })
//             })
//             chartData = Object.keys(groupMap).map((laboratoryId) => {
//                 let laboratory = laboratoryIdMap[laboratoryId];
//                 let labName = laboratory ? laboratory.laboratoryName : 'laboratory id ' + laboratoryId;
//                 return {name: labName, count: groupMap[laboratoryId]}
//             });
//         } else if (groupBy.key === 'institution') {
//             console.log('institution')
//             let groupMap = {};
//             activityStatFilteredList.forEach((activity) => {
//                 activity.teamIds.forEach((teamId) => {
//                     let team = teamIdMap[teamId];
//                     if (team) {
//                         let laboratoryId = team.laboratoryId;
//                         let laboratory = laboratoryIdMap[laboratoryId];
//                         if (laboratory) {
//                             let institutionId = laboratory.institutionId;
//                             if (groupMap[institutionId] === undefined) {
//                                 groupMap[institutionId] = 0;
//                             }
//                             groupMap[institutionId]++;
//                         }
//                     }
//                 })
//             })
//             chartData = Object.keys(groupMap).map((institutionId) => {
//                 let institution = institutionIdMap[institutionId];
//                 let institutionName = institution ? institution.institutionName : 'Institution id ' + institutionId;
//                 return {name: institutionName, count: groupMap[institutionId]}
//             });
//         }


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
                groupKey: 'none',
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
        return activityStat.teamIds.map((teamId) => {
            let team = teamIdMap[teamId];
            if (team) {
                let laboratoryId = team.laboratoryId;
                return {
                    groupKey: laboratoryId,
                    groupLabel: laboratoryIdMap[laboratoryId] ? laboratoryIdMap[laboratoryId].laboratoryName : 'Laboratory id ' + laboratoryId,
                }
            }
        })
    }, [teamIdMap, laboratoryIdMap])

    const groupByInstitutionCallback = React.useCallback((activityStat) => {
        return activityStat.teamIds.map((teamId) => {
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
    });
    const [chartWidth, setChartWidth] = React.useState(500);
    const [chartHeight, setChartHeight] = React.useState(300);

    const [chartTemplateList, setChartTemplateList] = React.useState([
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
    }, [activityStatEntry.idTypeActivity]);

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
            let groupMap = {};
            activityStatFilteredList.forEach((activity) => {
                const groupList = groupBy.callbackGroupBy(activity);
                groupList.forEach((group) => {
                    if (groupMap[group.groupKey] === undefined) {
                        groupMap[group.groupKey] = {
                            groupKey: group.groupKey,
                            groupLabel: group.groupLabel,
                            count: 0,
                        };
                    }
                    groupMap[group.groupKey].count++;
                })
            })
            chartData = Object.keys(groupMap).map((groupKey) => {
                return {
                    key: groupMap[groupKey].groupKey,
                    name: groupMap[groupKey].groupLabel,
                    count: groupMap[groupKey].count
                }
            });
        }

        setChartOptions({
            data: chartData,
        });
    }, [activityStatFilteredList, groupBy])

    // pie chart options
    const renderCustomizedLabel = (entry) => {
        return (
            <text {...entry}
                  fill={"#000000"}
                  stroke={entry.fill}
                  strokeWidth={2}
                  paintOrder="stroke"
            >
                {entry.name} ({entry.count})
            </text>
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
                                    value={chartWidth}
                                    onChange={(e) => setChartWidth(e.target.value)}
                                />
                                <label className={"label"}>Height</label>
                                <input
                                    type={"number"}
                                    value={chartHeight}
                                    onChange={(e) => setChartHeight(e.target.value)}
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
                        width: chartWidth + "px",
                        height: chartHeight + "px",
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
                                <Legend/>
                                <Bar dataKey="count" stackId="a" fill="#8884d8"/>
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
                                    label={renderCustomizedLabel}
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