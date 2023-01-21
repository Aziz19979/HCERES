import React, {useState, useCallback, useRef, useEffect} from 'react';
import Papa from 'papaparse';
import "./CsvValidator.css"
import Select from "react-select";
import FixRequiredSelect from "../../util/FixRequiredSelect";
import {Card, Form, ListGroupItem, Table, Button, Alert} from "react-bootstrap";
import {FaSync, FaUpload} from 'react-icons/fa';
import LoadingIcon from "../../util/LoadingIcon";

const CsvValidator = (props) => {
    // ------------- Input states ---------------
    // options for csvDefaultDelimiterOption used in csv
    const options = [
        {value: ';', label: "Semicolon ';' "},
        {value: ',', label: "Comma ',' "},
        {value: ' ', label: "Space ' ' "},
        {value: '\t', label: "Tab '\\t' "},
        {value: '|', label: "Pipe '|' "}
    ];
    // use semicolon as default option
    const [csvIsDiscardFirstLine, setCsvIsDiscardFirstLine] = React.useState(false);

    const csvIsAutoDetectDelimiter = React.useRef(true);
    const [csvDefaultDelimiterOption, setCsvDefaultDelimiterOption] = React.useState(options[0]);
    const [csvFile, setCsvFile] = React.useState(null);
    const [csvFileContent, setCsvFileContent] = React.useState(null);
    const csvOriginalFileContent = React.useRef(null);

    // --------------- Generated data state ---------------
    const [csvResults, setCsvResults] = useState([]);


    // --------------- UI states ---------------
    const [isLoading, setIsLoading] = React.useState(false);

    /**
     * // Error structure
     * {
     * 	type: "",     // A generalization of the error
     * 	code: "",     // Standardized error code
     * 	message: "",  // Human-readable details
     * 	row: 0,       // Row index of parsed data where error is
     * }
     */
    const [errorLines, setErrorLines] = useState([]);
    const [infoAlert, setInfoAlert] = useState('');
    const [errorAlert, setErrorAlert] = React.useState('');
    const divFileInputRef = useRef(null);
    const fileInputRef = useRef(null);


    const handleFileSelect = useCallback((e) => {
        const file = e.target.files[0];
        if (file) {
            setCsvFile(file);
            const reader = new FileReader();
            reader.onload = (event) => {
                csvOriginalFileContent.current = event.target.result;
                handleChangeFileContent();
            };
            reader.readAsText(file);
        }
        divFileInputRef.current.hidden = true;
    }, []);

    const resetForm = useCallback((e) => {
        fileInputRef.current.value = "";
        fileInputRef.current.click();
    }, []);

    const handleSeparatorChange = useCallback((value) => {
        csvIsAutoDetectDelimiter.current = false;
        setCsvDefaultDelimiterOption(value);
    }, [])

    const handleChangeFileContent = useCallback(() => {
        if (csvIsDiscardFirstLine)
            setCsvFileContent(csvOriginalFileContent.current.split('\n').shift().join('\n'));
        else setCsvFileContent(csvOriginalFileContent.current);
    }, [])

    const parseCsvFile = useCallback(async (file, isAutoDetectDelimiter, defaultDelimiter) => {
        // Set loading state to true
        return new Promise((resolve, reject) => {
            Papa.parse(file, {
                delimiter: isAutoDetectDelimiter ? "" : defaultDelimiter,
                skipEmptyLines: true,
                header: true,
                complete: (results) => {
                    // Initialize error lines and clear any previous errors/infoAlert
                    setErrorLines([]);
                    setInfoAlert(null);

                    // Handle any errors from the parse method
                    handleErrors(results);
                    setCsvResults(results);
                    // Get the valid data by skipping any invalid lines
                    const validData = results.data;
                    if (validData.length > 0) {
                        // Set the valid data and update the infoAlert message
                        setInfoAlert(validData.length + " records reads");
                    }
                    // Set loading state to false
                    resolve(results);
                },
                error(err, file) {
                    reject(err);
                }
            })
        });
    }, [])

    useEffect(() => {
        if (csvFileContent) {
            console.log("i got executed to parse the sample")
            setErrorAlert(null)
            setIsLoading(true);
            parseCsvFile(csvFileContent,
                csvIsAutoDetectDelimiter,
                csvDefaultDelimiterOption.value,
            ).then(r => {
                // do something with the data
                const usedDelimiter = r.meta.delimiter;
                if (csvIsAutoDetectDelimiter && usedDelimiter !== csvDefaultDelimiterOption.value)
                    setCsvDefaultDelimiterOption({value: usedDelimiter, label: "Detected delimiter: " + usedDelimiter})
            }).catch((exception) => {
                setErrorAlert("" + exception + "\nTry to upload file again.");
                setCsvResults([]);
                console.log(exception);
            }).finally(() => {
                setIsLoading(false);
            });
        }
    }, [csvFileContent, csvDefaultDelimiterOption, parseCsvFile]);

    //Check if there are any errors and set them in the state
    function handleErrors(results) {
        if (results.errors.length > 0) {
            const uniqueErrors = [...new Set(
                results.errors.map(error => JSON.stringify({
                    type: error.type,
                    code: error.code,
                    row: error.row,
                    index: error.index, // not always defined
                    message: error.message,
                })))].map(error => JSON.parse(error));
            setErrorLines([...new Set(uniqueErrors)]);
        }
    }

    return (
        <div style={{width: "80%", margin: "0 auto"}}>
            <Card className={"mx-auto"}>
                <Card.Header>
                    Import Data CSV
                </Card.Header>
                <Card.Body>
                    <form>
                        <div className="form-group" ref={divFileInputRef}>
                            <Button variant="success" className="mr-2">
                                <label htmlFor="csv-file" className="file-upload-label border-0">
                                    <FaUpload className={"mr-2"}/>
                                    Upload CSV
                                </label>
                                <Form.File
                                    id="csv-file"
                                    label="Upload CSV file"
                                    accept=".csv"
                                    onChange={handleFileSelect}
                                    disabled={isLoading}
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
                                value={csvDefaultDelimiterOption}
                                onChange={handleSeparatorChange}
                                required={true}
                            />
                        </div>
                        <div className="form-group">
                            <label className='label'>
                                Discard first line
                            </label>
                            <input
                                type="checkbox"
                                className="input-container"
                                checked={csvIsDiscardFirstLine}
                                onChange={e => {setCsvIsDiscardFirstLine(e.target.checked)}}
                            />
                        </div>
                    </form>
                    {errorAlert && <Alert variant={"danger"}
                                          onClose={() => setErrorAlert("")}
                                          dismissible={true}>{errorAlert}</Alert>}
                </Card.Body>
                <Card.Footer>

                    {csvFile ?
                        <div>
                            <ListGroupItem variant={"primary"}>
                                {isLoading ? <LoadingIcon text={"Parsing file: "}/> :
                                    <>
                                        <Button variant="info" onClick={resetForm} className={"mr-2"}>
                                            <FaSync/>
                                        </Button>
                                        Charged File :
                                    </>
                                }
                                {csvFile.name}
                            </ListGroupItem>
                            {csvResults && csvResults.meta && csvResults.meta.fields &&
                                <>
                                    <ListGroupItem>
                                        Number of columns {csvResults.meta.fields.length}
                                    </ListGroupItem>
                                    <ListGroupItem>
                                        Columns headers:
                                        {csvResults.meta.fields.map((columnName, index) => {
                                            return <ListGroupItem key={index}>{columnName}</ListGroupItem>;
                                        })}
                                    </ListGroupItem>
                                </>
                            }
                            {infoAlert ? <ListGroupItem variant={"success"}>
                                {infoAlert}
                            </ListGroupItem> : null}
                            {errorLines.length > 0 && <ListGroupItem variant={"warning"}>
                                {errorLines.length} Total errors
                            </ListGroupItem>}
                        </div>
                        : null}

                    {errorLines.length > 0 && <Table>
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
                        {errorLines.map((error, index) => (
                            <tr key={index}>
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