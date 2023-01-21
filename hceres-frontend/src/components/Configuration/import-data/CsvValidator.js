import React, {useCallback, useRef, useReducer} from 'react';
import Papa from 'papaparse';
import Select from "react-select";
import FixRequiredSelect from "../../util/FixRequiredSelect";
import {Card, Form, ListGroupItem, Table, Button, Alert} from "react-bootstrap";
import {FaSync, FaUpload} from 'react-icons/fa';
import LoadingIcon from "../../util/LoadingIcon";
import {AiFillDelete} from "react-icons/ai";

const CsvValidator = (props) => {
    const csvFileParameter = props.csvFile
    const onDiscardCsv = props.onDiscard
    const onParseResults = props.onParseResults

    React.useEffect(() => {
        if (csvFileParameter) {
            dispatch({
                type: 'select-and-read-file',
                payload: csvFileParameter
            })
        }
    }, [])

    // how to use reducer see https://blog.logrocket.com/react-usereducer-hook-ultimate-guide/
    // and https://youtu.be/o-nCM1857AQ
    // options for csvDefaultDelimiterOption used in csv
    const options = [
        {value: ';', label: "Semicolon ';' "},
        {value: ',', label: "Comma ',' "},
        {value: ' ', label: "Space ' ' "},
        {value: '\t', label: "Tab '\\t' "},
        {value: '|', label: "Pipe '|' "}
    ];

    const initialState = {
        // ------------- Input states ---------------
        csvFile: null,
        csvFileContent: null,

        // auto remove unless selected via checkbox turn it off
        // similar to auto-detect delimiter behavior
        csvIsAutoRemoveFirstLine: true,
        csvIsDiscardFirstLine: false,

        csvIsAutoDetectDelimiter: true,
        csvDefaultDelimiterOption: options[0],

        // --------------- UI states ---------------
        isLoading: false,
        hideConfiguration: false,

        // --------------- Generated data state ---------------
        csvResults: [],
        /**
         * // Error line structure
         * {
         * 	type: "",     // A generalization of the error
         * 	code: "",     // Standardized error code
         * 	message: "",  // Human-readable details
         * 	row: 0,       // Row index of parsed data where error is
         * }
         */
        errorLines: [],
        infoAlert: '',
        errorAlert: '',
    };
    const [state, dispatch] = useReducer(csvReducer, initialState);

    const fileInputRef = useRef(null);


    const resetForm = useCallback(() => {
        fileInputRef.current.value = "";
        fileInputRef.current.click();
    }, []);


    function csvReducer(state, action) {
        const parseCsvFile = async (file, isAutoDetectDelimiter, defaultDelimiter) => {
            // Set loading state to true
            return new Promise((resolve, reject) => {
                Papa.parse(file, {
                    delimiter: isAutoDetectDelimiter ? "" : defaultDelimiter,
                    skipEmptyLines: true,
                    header: true,
                    complete: (results) => {
                        resolve(results);
                    },
                    error(err) {
                        reject(err);
                    }
                })
            });
        }
        switch (action.type) {
            case 'select-and-read-file':
                const file = action.payload;
                if (file) {
                    const reader = new FileReader();
                    reader.onload = (event) => {
                        dispatch({
                            type: 'done-reading-file',
                            payload: event.target.result
                        })
                        dispatch({
                            type: 'parse-csv',
                            csvIsDiscardFirstLine: false,
                        })
                    };
                    reader.readAsText(file);
                    return {
                        ...state,
                        csvFile: file,
                        isLoading: true,
                        csvResults: [],
                        errorLines: [],
                        errorAlert: null,
                        infoAlert: null,
                        csvIsDiscardFirstLine: false,
                    };
                }
                return state;
            case 'done-reading-file':
                return {
                    ...state,
                    csvFileContent: action.payload,
                }
            case 'parse-csv':
                let csvModifiedFileContent = state.csvFileContent;
                //nullish coalescing operator (??) check  if a variable is set or not
                // and if it's not set then return a default value.
                let isRemoveFirstLine = action.isRemoveFirstLine ?? state.csvIsDiscardFirstLine;
                if (isRemoveFirstLine) {
                    let splittedNewLine = state.csvFileContent.split('\n')
                    splittedNewLine.shift();
                    csvModifiedFileContent = splittedNewLine.join('\n');
                }
                parseCsvFile(csvModifiedFileContent,
                    state.csvIsAutoDetectDelimiter,
                    state.csvDefaultDelimiterOption.value
                ).then(results => {
                    // do something with data
                    const usedDelimiter = results.meta.delimiter;
                    let nextDefaultDelimiterState = state.csvDefaultDelimiterOption;
                    let errorLines = [];

                    if (state.csvIsAutoDetectDelimiter && usedDelimiter !== state.csvDefaultDelimiterOption.value)
                        nextDefaultDelimiterState = {
                            value: usedDelimiter,
                            label: "Detected delimiter: " + usedDelimiter
                        };
                    // Handle any errors from the parse method
                    if (results.errors.length > 0) {
                        const uniqueErrors = [...new Set(
                            results.errors.map(error => JSON.stringify({
                                type: error.type,
                                code: error.code,
                                row: error.row,
                                index: error.index, // not always defined
                                message: error.message,
                            })))].map(error => JSON.parse(error));
                        errorLines = [...new Set(uniqueErrors)];
                    }
                    if (state.csvIsAutoRemoveFirstLine
                        && !isRemoveFirstLine
                        && results?.meta?.fields?.length === 1
                    ) {
                        isRemoveFirstLine = true;
                        dispatch({
                            type: 'parse-csv',
                            isRemoveFirstLine: true,
                        })
                    } else {
                        dispatch({
                            type: 'done-parsing',
                            payload: {
                                ...state,
                                csvDefaultDelimiterOption: nextDefaultDelimiterState,
                                csvResults: results,
                                errorLines: errorLines,
                                isLoading: false,
                                csvIsDiscardFirstLine: isRemoveFirstLine,
                            }
                        })
                    }
                }).catch((exception) => {
                    console.log(exception)
                    dispatch({
                        type: 'done-parsing',
                        payload: {
                            ...state,
                            csvResults: [],
                            errorAlert: exception + "\nTry to upload file again.",
                            isLoading: false,
                            csvIsDiscardFirstLine: isRemoveFirstLine,
                        }
                    })
                })
                return {
                    ...state,
                    csvIsDiscardFirstLine: isRemoveFirstLine
                };
            case 'done-parsing':
                const newState = action.payload
                if (onParseResults) {
                    onParseResults(newState.csvResults);
                }
                return newState;
            case 'delimiter-change':
                return {
                    ...state,
                    csvIsAutoDetectDelimiter: false,
                    csvDefaultDelimiterOption: action.payload,
                    isLoading: true,
                };
            case 'clear-error-alert':
                return {
                    ...state,
                    errorAlert: ''
                }
            default:
                return state;
        }
    }

    const isCsvChargedWithResults = state.csvResults && state.csvResults.meta && state.csvResults.meta.fields;
    const totalRowsResults = isCsvChargedWithResults ? state.csvResults.data.length : 0;

    return (
        <div style={{width: "80%", margin: "0 auto"}}>
            <Card className={"mx-auto"}>
                <Card.Header>
                    Import Data CSV
                </Card.Header>
                <Card.Body>
                    <form>
                        <div className="form-group" hidden={state.csvFile}>
                            <Button variant="success" className="mr-2">
                                <label htmlFor="csv-file" className="file-upload-label border-0">
                                    <FaUpload className={"mr-2"}/>
                                    Upload CSV
                                </label>
                                <Form.File
                                    id="csv-file"
                                    label="Upload CSV file"
                                    accept=".csv"
                                    onChange={(e) => {
                                        dispatch({
                                            type: 'select-and-read-file',
                                            payload: e.target.files[0]
                                        })
                                    }}
                                    disabled={state.isLoading}
                                    ref={fileInputRef}
                                    style={{display: "none"}}
                                />
                            </Button>
                        </div>


                        <div className="form-group">
                            <label htmlFor="separator-select">Select Separator</label>
                            <FixRequiredSelect
                                SelectComponent={Select}
                                options={options}
                                value={state.csvDefaultDelimiterOption}
                                onChange={(option) => {
                                    dispatch({
                                        type: 'delimiter-change',
                                        payload: option
                                    })
                                    dispatch({
                                        type: 'parse-csv'
                                    })
                                }}
                                required={true}
                            />
                        </div>
                    </form>
                    {state.errorAlert && <Alert variant={"danger"}
                                                onClose={() => dispatch({type: 'clear-error-alert'})}
                                                dismissible={true}>{state.errorAlert}</Alert>}
                </Card.Body>
                <Card.Footer>

                    {state.csvFile ?
                        <div>
                            <ListGroupItem variant={"primary"}>
                                <div className="container">
                                    <div className="row">
                                        <div className="col-12 col-md-3">
                                            <div>
                                                {/* First Column, spans both rows */}

                                                {state.isLoading ? <LoadingIcon text={"Parsing file: "}/> :
                                                    <div className="btn-group" role="group">
                                                        {onDiscardCsv &&
                                                            <Button variant="danger" onClick={() => onDiscardCsv()}>
                                                                <AiFillDelete/>
                                                            </Button>
                                                        }
                                                        <Button variant="info" onClick={resetForm}>
                                                            <FaSync/>
                                                        </Button>
                                                    </div>
                                                }
                                            </div>
                                        </div>
                                        <div className="col-12 col-md-9">
                                            <div className="row">
                                                <div className="col-12">
                                                    <div>
                                                        {/* Second Column, row 1 */}
                                                        Charged File :
                                                        {state.csvFile.name}
                                                    </div>
                                                </div>
                                            </div>
                                            <div className="row">
                                                <div className="col-12">
                                                    <div>
                                                        {/* Second Column, row 2 */}
                                                        {totalRowsResults > 0 ?
                                                            "Total records : " + totalRowsResults
                                                            : null}
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ListGroupItem>
                            {isCsvChargedWithResults &&
                                <>
                                    <ListGroupItem>
                                        Number of columns {state.csvResults.meta.fields.length}
                                    </ListGroupItem>
                                    <ListGroupItem>
                                        {state.csvIsDiscardFirstLine && "Horray! First line is automatically discarded!"}
                                        <br/>
                                        Columns headers:
                                        {state.csvResults.meta.fields.map((columnName, index) => {
                                            return <ListGroupItem key={columnName}>{columnName}</ListGroupItem>;
                                        })}
                                    </ListGroupItem>
                                </>
                            }
                            {state.infoAlert ? <ListGroupItem variant={"success"}>
                                {state.infoAlert}
                            </ListGroupItem> : null}
                            {state.errorLines.length > 0 && <ListGroupItem variant={"warning"}>
                                {state.errorLines.length} Total errors
                            </ListGroupItem>}
                        </div>
                        : null}

                    {state.errorLines.length > 0 && <Table>
                        <thead>
                        <tr>
                            <th>Error type</th>
                            <th>Code</th>
                            <th>Line</th>
                            <th>#Character</th>
                            <th>Message</th>
                        </tr>
                        </thead>
                        <tbody>
                        {state.errorLines.map((error, index) => (
                            <tr key={error.row + "" + error.index}>
                                <td>{error.type}</td>
                                <td>{error.code}</td>
                                <td>{error.row + 1}</td>
                                <td>{error.index}</td>
                                <td>{error.message}</td>
                            </tr>
                        ))}
                        </tbody>
                    </Table>}
                </Card.Footer>
            </Card>
        </div>
    );
}


export default CsvValidator;