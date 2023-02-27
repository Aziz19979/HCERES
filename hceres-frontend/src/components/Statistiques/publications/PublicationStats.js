import React from 'react';
import {fetchListIncomingMobilities} from "../../../services/Activity/incoming-mobility/IncomingMobilityActions";
import {fetchResearcherActivities} from "../../../services/Researcher/ResearcherActions";
import ActivityTypes from "../../../const/ActivityTypes";
import {fetchListPublications} from "../../../services/Activity/publication/PublicationActions";
import { Chart } from 'chart.js/auto';
import moment from 'moment';

export default function PublicationStats() {
    const [chart, setChart] = React.useState(null);
    const [publicationList, setPublicationList] = React.useState([]);

    React.useEffect(() => {
        fetchListPublications().then((list) => setPublicationList(list));
    }, []);

    console.log(publicationList)

    React.useEffect(() => {
        if (publicationList.length > 0) {
            const ctx = document.getElementById('myChart');
            const years = publicationList.map((item) =>
                moment(item.publicationDate).year()
            );

            const count = {};
            years.forEach((year) => {
                count[year] = (count[year] || 0) + 1;
            });

            const data = {
                labels: Object.keys(count),
                datasets: [
                    {
                        label: 'Publications per year',
                        data: Object.values(count),
                        backgroundColor: 'rgba(54, 162, 235, 0.2)',
                        borderColor: 'rgba(54, 162, 235, 1)',
                        borderWidth: 1,
                    },
                ],
            };

            if (chart !== null) {
                chart.destroy();
            }

            const myChart = new Chart(ctx, {
                type: 'bar',
                data: data,
                options: {
                    responsive: true,
                    scales: {
                        yAxes: [
                            {
                                ticks: {
                                    beginAtZero: true,
                                },
                            },
                        ],
                    },
                },
            });

            setChart(myChart);
        }

        return () => {
            if (chart !== null) {
                chart.destroy();
            }
        };
    }, [publicationList, chart]);

    return (
        <div>
            <h2>Publications per year</h2>
            <canvas id="myChart" width="400" height="400"></canvas>
        </div>
    );
}