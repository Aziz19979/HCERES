import ActivityTypes from "../../../const/ActivityTypes";
import {ActivityStatTemplate} from "../ActivityStatTemplate";

class PublicationStat extends ActivityStatTemplate {

    constructor() {
        super({
            idTypeActivity: ActivityTypes.PUBLICATION,
            label: "Publications"
        });
    }

    prepareData = (publicationList) => {
        return publicationList.map((publication) => {
            return {
                ...publication,
                publicationDateObj: new Date(publication.publicationDate),
            }
        })
    }

    filters = [
        {
            // unique key across all filters
            key: "startDate",
            // label displayed for the input field
            label: "Publication après le",
            // type of input field
            inputType: "date",
            // callback function to filter the data based on the input value
            callbackFilter: (publication, startDate) => publication.publicationDate >= startDate,
            initialValueCallback: (publicationList) => {
                let minDate = publicationList[0]?.publicationDate;
                publicationList.forEach((publication) => {
                    if (publication.publicationDate < minDate) {
                        minDate = publication.publicationDate;
                    }
                })
                return minDate;
            }
        },
        {
            key: "endDate",
            label: "Publication avant le",
            inputType: "date",
            callbackFilter: (publication, endDate) => publication.publicationDate <= endDate,
            initialValueCallback: (publicationList) => {
                let maxDate = publicationList[0]?.publicationDate;
                publicationList.forEach((publication) => {
                    if (publication.publicationDate > maxDate) {
                        maxDate = publication.publicationDate;
                    }
                })
                return maxDate;
            }
        }
    ]

    customGroupByList = [
        {
            // unique key across all charts
            key: "year",
            // label displayed for the chart
            label: "année",
            // callback function to group the data
            callbackGroupBy: (publication) => {
                return [
                    {
                        groupKey: publication.publicationDateObj.getFullYear(),
                        groupLabel: publication.publicationDateObj.getFullYear(),
                    }
                ]
            },
        }
    ]
}

export default (new PublicationStat());