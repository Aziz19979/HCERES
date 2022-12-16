import {ListGroup} from "react-bootstrap";
import {textFilter} from "react-bootstrap-table2-filter";
import React from "react";

export const paginationOptions = (lengthOfList) => {
    const defaultSizeValues = [5, 10, 25, 50]
    const dynamicSizePerPage = []
    for (let defaultSizeValue of defaultSizeValues) {
        if (lengthOfList > defaultSizeValue)
            dynamicSizePerPage.push({text: defaultSizeValue, value: defaultSizeValue})
    }
    if (lengthOfList < defaultSizeValues[0]) {
        dynamicSizePerPage.push({text: defaultSizeValues[0], value: defaultSizeValues[0]})
    } else {
        dynamicSizePerPage.push({text: lengthOfList, value: lengthOfList})
    }
    return {
        showTotal: true,
        sizePerPageList: dynamicSizePerPage
    }
};

export const filterByResearcherList = (filterVal, data) => {
    if (filterVal) {
        filterVal = filterVal.toLowerCase()
        return data.filter(activity => activity.researcherList
            .map(res => res.researcherName.toLowerCase().includes(filterVal)
                || res.researcherSurname.toLowerCase().includes(filterVal)
                || res.researcherId.toString().includes(filterVal)).includes(true));
    }
    return data;
}

export const chercheursColumnOfActivity = {
    dataField: 'Chercheurs',
    isDummyField: true,
    text: 'Chercheurs',
    formatter: (cell, row) => {
        if (row.researcherList)
            return <ListGroup>
                {row.researcherList.map(res =>
                    <ListGroup.Item
                        key={res.researcherId}>{res.researcherId}. {res.researcherName} {res.researcherSurname}</ListGroup.Item>)}
            </ListGroup>;
        else return ""
    },
    csvFormatter: (cell, row, rowIndex) => {
        if (row.researcherList)
            return row.researcherList.map(res => res.researcherId +"."+ res.researcherName + " " + res.researcherSurname).join(" --- ");
        else return ""
    },
    filter: textFilter({
        onFilter: filterByResearcherList
    })
}