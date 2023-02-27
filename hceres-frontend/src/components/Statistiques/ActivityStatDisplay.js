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
    CartesianGrid,
    Legend,
    ResponsiveContainer,
    Tooltip,
    XAxis,
    YAxis
} from "recharts";


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


export default function ActivityStatDisplay({activityStatEntry}) {
    const [teamList, setTeamList] = React.useState([]);
    const [labList, setLabList] = React.useState([]);
    const [institutionList, setInstitutionList] = React.useState([]);

    const [activityStatList, setActivityStatList] = React.useState([]);
    const [activityStatFilteredList, setActivityStatFilteredList] = React.useState([]);
    const [isLoading, setLoading] = React.useState(false);
    const groupByList = [
        {key: 'none', label: 'No group', checked: true},
        {key: 'team', label: 'Equipe'},
        {key: 'lab', label: 'Laboratoire'},
        {key: 'institution', label: 'Institution'},
        ...activityStatEntry.customGroupByList
    ]
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
                setTeamList(teamList);
                setLabList(labList);
                setInstitutionList(institutionList);
            })
            .catch(error => {
                // handle error
            })
            .finally(() => {
                setLoading(false);
            });
    }, []);

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
        if (groupBy.key === 'none') {
            let count = activityStatFilteredList.length;
            chartData.push({name: 'Total', count: count})
        } else if (groupBy.key === 'team') {
            let groupMap = {};
            activityStatFilteredList.forEach((activity) => {
                activity.teamIds.forEach((teamId) => {
                    if (groupMap[teamId] === undefined) {
                        groupMap[teamId] = 0;
                    }
                    groupMap[teamId]++;
                })
            })
            let teamIdMap = {};
            teamList.forEach((team) => {
                teamIdMap[team.teamId] = team;
            })
            chartData = Object.keys(groupMap).map((teamId) => {
                let team = teamIdMap[teamId];
                let teamName = team ? team.teamName : 'Team id ' + teamId;
                return {name: teamName, count: groupMap[teamId]}
            });
        } else if (groupBy.key === 'lab') {
            console.log('lab')
        } else if (groupBy.key === 'institution') {
            console.log('institution')
        } else if (groupBy.callbackGroupBy) {
            // custom group by
            let groupMap = {};
            activityStatFilteredList.forEach((activity) => {
                let groupKey = groupBy.callbackGroupBy(activity);
                if (groupMap[groupKey] === undefined) {
                    groupMap[groupKey] = 0;
                }
                groupMap[groupKey]++;
            })
            chartData = Object.keys(groupMap).map((groupKey) => {
                return {name: groupKey, count: groupMap[groupKey]}
            });
        }

        setChartOptions({
            data: chartData,
        });
    }, [activityStatFilteredList, groupBy, teamList, labList, institutionList])

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

                <div className={"card"}>
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
                    <ResponsiveContainer>
                        {chartTemplate.key === 'bar' ?
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
                            : <></>
                        }


                    </ResponsiveContainer>
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