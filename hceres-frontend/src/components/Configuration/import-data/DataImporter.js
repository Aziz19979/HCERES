import React, {useCallback, useRef, useReducer} from 'react';
import CsvValidator from "./CsvValidator";
import {Oval} from "react-loading-icons";
import {Button, Form} from "react-bootstrap";
import {FaUpload} from "react-icons/fa";
import {RiDeleteBin6Line} from "react-icons/ri";

const DataImporter = () => {
    const initialState = {
        // map from file name to file value
        csvFiles: new Map(),
        csvValidators: new Map(),
        csvParseResults: new Map(),
    }
    const [state, dispatch] = useReducer(reducerFunction, initialState);

    function reducerFunction(state, action) {
        switch (action.type) {
            case 'add-list-of-files':
                const selectedFiles = action.payload;
                const filesMap = state.csvFiles;
                const filesValidatorsMap = state.csvValidators;
                for (let i = 0; i < selectedFiles.length; i++) {
                    filesMap.set(selectedFiles[i].name, selectedFiles[i]);
                    filesValidatorsMap.set(selectedFiles[i].name,
                        <CsvValidator
                            csvFile={selectedFiles[i]}
                            onDiscard={() => dispatch({
                                type:'clear-file',
                                payload:selectedFiles[i],
                            })}
                            onParseResults={(results) => dispatch({
                                type:'receive-parse-result',
                                payload:results,
                                file:selectedFiles[i],
                            })}
                        />
                    );
                }
                return {
                    ...state,
                    csvFiles: filesMap,
                    csvValidators: filesValidatorsMap,
                };
            case 'clear-file':
                const fileName = action.payload.name;
                if (state.csvFiles.has(fileName)) {
                    state.csvFiles.delete(fileName);
                }
                if (state.csvValidators.has(fileName)) {
                    state.csvValidators.delete(fileName);
                }
                if (state.csvParseResults.has(fileName)) {
                    state.csvParseResults.delete(fileName);
                }
                return {
                    ...state,
                    triggerChange:1
                };
            case 'receive-parse-result':
                state.csvParseResults.set(action.file.name, action.payload);
                return {...state};
            case 'clear-all-files':
                return {
                    ...state,
                    csvFiles: new Map(),
                    csvValidators: new Map(),
                    csvParseResults: new Map(),
                };
            default:
                return state;
        }
    }

    return (
        <div className="container">
            <div className="d-flex align-items-center justify-content-center">
                <h3>
                    Import Csv Data into database
                </h3>
                <br/>
                <form>
                    <div className="form-group" hidden={state.csvFile}>
                        <div className="btn-group" role="group">
                            <Button variant="success" className="ml-2 btn-group">
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
                                            type: 'add-list-of-files',
                                            payload: e.target.files
                                        })
                                    }}
                                    disabled={state.isLoading}
                                    multiple={true}
                                    style={{display: "none"}}
                                />
                            </Button>
                            <Button variant={"danger"} onClick={() => dispatch({
                                type: 'clear-all-files'
                            })}>
                                Clear all
                            </Button>
                        </div>
                    </div>
                </form>
            </div>
            <div>
                {Array.from(state.csvValidators.entries()).map(([fileName, validator], index) => (
                    <div key={fileName}>{validator}</div>
                ))}
            </div>
        </div>
    )
}

export default DataImporter;