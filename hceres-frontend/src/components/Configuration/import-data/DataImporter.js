import React, {useReducer} from 'react';
import CsvValidator from "./CsvValidator";
import {Alert, Button, Form} from "react-bootstrap";
import {FaUpload} from "react-icons/fa";
import SupportedCsvFormat from "./SupportedCsvFormat";

const DataImporter = () => {
    const initialState = {
        // map from file name to file value
        csvFiles: new Map(),
        csvValidators: new Map(),
        csvParseResults: new Map(),
        csvTemplateAssociations: new Map(),

        // Generated state
        missingCsvDependencies: new Set(),
    }
    const [state, dispatch] = useReducer(reducerFunction, initialState);

    function reducerFunction(state, action) {
        function createInverseMap(originalMap) {
            return Array.from(originalMap.entries()).reduce(
                (inverseMap, [key, value]) => inverseMap.set(value, key),
                new Map()
            );
        }

        function getMissingDependencies(csvTemplateAssociations) {
            let missingDependencies = new Set();
            // create map from format template to filename
            const csvFormatToFileName = createInverseMap(csvTemplateAssociations);
            csvFormatToFileName.forEach((fileName, format) => {
                let formatDependencies = SupportedCsvFormat.getDependencies(format.key);
                formatDependencies.forEach(dependency => {
                    if (!csvFormatToFileName.has(dependency)) {
                        missingDependencies.add(dependency);
                    }
                });
            });
            return missingDependencies;
        }

        switch (action.type) {
            case 'add-list-of-files':
                const selectedFiles = action.payload;
                const filesMap = state.csvFiles;
                const filesValidatorsMap = state.csvValidators;
                for (const selectedFile of selectedFiles) {
                    filesMap.set(selectedFile.name, selectedFile);
                    filesValidatorsMap.set(selectedFile.name,
                        <CsvValidator
                            csvFile={selectedFile}
                            onDiscard={() => dispatch({
                                type: 'clear-file',
                                payload: selectedFile,
                            })}
                            onParseResults={(results) => dispatch({
                                type: 'receive-parse-result',
                                payload: results,
                                file: selectedFile,
                            })}
                            onChangeAssociatedTemplateCsv={(associatedTemlateCsv) => {
                                dispatch({
                                    type: 'receive-template-association',
                                    payload: associatedTemlateCsv,
                                    file: selectedFile,
                                })
                            }}
                        />
                    );
                }
                return {
                    ...state,
                    csvFiles: filesMap,
                    csvValidators: filesValidatorsMap,
                };
            case 'clear-file':
                setTimeout(() => {
                    dispatch({
                        type: 'check-dependencies',
                    })
                }, 1000)
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
                if (state.csvTemplateAssociations.has(fileName)) {
                    state.csvTemplateAssociations.delete(fileName);
                }
                return {...state};
            case 'receive-parse-result':
                // silent update state on receive change from child to prevent render the component
                state.csvParseResults.set(action.file.name, action.payload);
                return state;
            case 'receive-template-association':
                // silent update state on receive change from child to prevent render the component
                state.csvTemplateAssociations.set(action.file.name, action.payload);
                setTimeout(() => {
                    dispatch({
                        type: 'check-dependencies',
                    })
                }, 500)
                return state;
            case 'check-dependencies':
                return {
                    ...state,
                    missingCsvDependencies: getMissingDependencies(state.csvTemplateAssociations),
                };
            case 'insert-into-database':
                return state;
            case 'clear-all-files':
                setTimeout(() => {
                    dispatch({
                        type: 'check-dependencies',
                    })
                }, 500)
                return {
                    ...state,
                    csvFiles: new Map(),
                    csvValidators: new Map(),
                    csvParseResults: new Map(),
                    csvTemplateAssociations: new Map(),
                };
            default:
                return state;
        }
    }

    return (
        <div className="container">
            <br/>
            <div className={"row"}>
                <h3 style={{
                    borderRadius: '0.25em',
                    textAlign: 'center',
                    color: 'darkblue',
                    border: '1px solid darkblue',
                    padding: '0.5em'
                }}>
                    Import Csv Data into database
                </h3>
            </div>
            <div className={"row"}>
                {state.missingCsvDependencies.size > 0 ?
                    <Alert variant={"danger"}>
                        Liste de dépendances manquantes
                        {Array.from(state.missingCsvDependencies)
                            .map((dependency, index) => {
                                return <li key={dependency.key}>{dependency.label}</li>
                            })}
                    </Alert>
                    : <Alert variant={"success"}>
                        All dependencies are satisfied !
                    </Alert>
                }
            </div>
            <div className="row">
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
                            <Button variant={"primary"} onClick={() => dispatch({
                                type: 'insert-into-database'
                            })} hidden={state.missingCsvDependencies.size > 0 || state.csvParseResults.size === 0}>
                                Insérer dans la base de données
                            </Button>
                            <Button variant={"danger"} onClick={() => dispatch({
                                type: 'clear-all-files'
                            })}>
                                Tout effacer
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