import React, {useMemo} from 'react';
import {ListGroup} from "react-bootstrap";
import BootstrapTable from "react-bootstrap-table-next";
import paginationFactory from "react-bootstrap-table2-paginator";
import {paginationOptions} from "../../util/BootStrapTableOptions";

function randomBackgroundColor(seed) {
    const hue = (seed * 137.508) % 360;
    const rgb = hsvToRgb(hue, 0.5, 0.95);
    const bgColor = `rgb(${rgb[0]}, ${rgb[1]}, ${rgb[2]})`;
    const brightness = calculateBrightness(rgb[0], rgb[1], rgb[2]);
    const textColor = (brightness > 186) ? '#000000' : '#ffffff';
    return {
        backgroundColor: bgColor,
        color: textColor
    }
}

function hsvToRgb(h, s, v) {
    let r, g, b;
    const i = Math.floor(h / 60) % 6;
    const f = h / 60 - i;
    const p = v * (1 - s);
    const q = v * (1 - f * s);
    const t = v * (1 - (1 - f) * s);
    switch (i) {
        case 0: r = v; g = t; b = p; break;
        case 1: r = q; g = v; b = p; break;
        case 2: r = p; g = v; b = t; break;
        case 3: r = p; g = q; b = v; break;
        case 4: r = t; g = p; b = v; break;
        case 5: r = v; g = p; b = q; break;
    }
    return [Math.round(r * 255), Math.round(g * 255), Math.round(b * 255)];
}

function calculateBrightness(r, g, b) {
    return r * 0.299 +
        g * 0.587 +
        b * 0.114;
}


export default function ImportCsvDuplicates({csvResultsData, csvResultsMetaFields, duplicateLines}) {
    const data = useMemo(() => {
        const csvFilteredData = [];
        let lineGroup = csvResultsData.length;
        duplicateLines.forEach(lineList => {
            lineGroup++;
            lineList.forEach(line => {
                const filteredLine = csvResultsData[line - 1];
                filteredLine.row = line;
                filteredLine.group = lineGroup;
                csvFilteredData.push(filteredLine);
            });
        });
        return csvFilteredData;
    }, [csvResultsData, duplicateLines]);

    const headers = useMemo(() => {
        // make a copy meta fields
        return [...csvResultsMetaFields];
    }, [csvResultsMetaFields]);

    const columns = headers.map((header, index) => (
        {
            dataField: header,
            text: header
        }
    ));
    columns.unshift({
        dataField: 'row',
        text: 'Ligne',
        style: (cell, row, rowIndex, colIndex) => {
            return row.group ? randomBackgroundColor(row.group) : {};
        }
    });

    return (
        <>
            <ListGroup.Item variant={"warning"}>
                <h4 className="card-title">Lignes dupliquées trouvées: </h4>
            </ListGroup.Item>
            <BootstrapTable
                bootstrap4={true}
                keyField='row'
                data={data}
                striped={true}
                columns={columns}
                pagination={paginationFactory(paginationOptions(data.length))}
                wrapperClasses="table-responsive"
                noDataIndication='No data to display'
            />
        </>
    );
}