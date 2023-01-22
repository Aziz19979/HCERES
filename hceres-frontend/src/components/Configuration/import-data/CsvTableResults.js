import React, {useState, useMemo} from 'react';
import BootstrapTable from 'react-bootstrap-table-next';
import paginationFactory from 'react-bootstrap-table2-paginator';
import {paginationOptions} from "../../util/BootStrapTableOptions";

export default function CsvTableResults({csvResults}) {
    const [searchTerm, setSearchTerm] = useState('');

    const headers = csvResults?.meta?.fields || [];
    const data = useMemo(()=> {
        return csvResults?.data || [];
    }, [csvResults]);

    const columns = headers.map((header, index) => (
        {dataField: header, text: header}
    ));
    columns.unshift({dataField: 'row', text: '#Row', sort: true});

    const originalData = useMemo(() => {
        return data.map((row, index) => ({...row, row: index + 1}));
    }, [data]);

    const filteredData = useMemo(() => {
        if (!searchTerm) return originalData;
        return originalData.filter((row, index) => (row.row).toString().includes(searchTerm));
    }, [originalData, searchTerm]);

    return (
        <div>
            <div className="d-flex justify-content-center">
                <input
                    type="number"
                    min={1}
                    className="form-control"
                    placeholder={`Search in row number`}
                    value={searchTerm}
                    onChange={e => setSearchTerm(e.target.value)}
                />
            </div>
            <BootstrapTable
                keyField='row'
                data={filteredData}
                columns={columns}
                pagination={paginationFactory(paginationOptions(filteredData.length))}
                wrapperClasses="table-responsive"
                noDataIndication='No data to display'
            />
        </div>
    );
}
