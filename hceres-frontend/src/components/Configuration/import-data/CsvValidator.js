import React, {useState, useCallback, useRef, useEffect} from 'react';
import Papa from 'papaparse';
import "./CsvValidator.css"
import Select from "react-select";
import FixRequiredSelect from "../../util/FixRequiredSelect";
import {Card, Form, ListGroupItem, Table, Button} from "react-bootstrap";
import {FaSync} from 'react-icons/fa';
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
    const [csvAutoDetectDelimiter, setCsvAutoDetectDelimiter] = React.useState(true);
    const [csvDefaultDelimiterOption, setCsvDefaultDelimiterOption] = React.useState(options[0]);
    const [csvFile, setCsvFile] = React.useState(null);

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
    const [info, setInfo] = useState(null);
    const fileInputRef = useRef(null);


    const handleFileSelect = useCallback((e) => {
        const file = e.target.files[0];
        if (file) {
            setCsvFile(file);
        }
    }, []);

    const resetForm = useCallback((e) => {
        fileInputRef.current.value = "";
        fileInputRef.current.click();
    }, []);

    const handleSeparatorChange = useCallback((value) => {
        console.log("i turn off auto");
        setCsvAutoDetectDelimiter(false);
        setCsvDefaultDelimiterOption(value);
    }, [])

    useEffect(() => {
        if (csvFile) {
            parseCsvFile(csvFile, csvAutoDetectDelimiter, csvDefaultDelimiterOption.value).then(r => {
                // do something with the data
                console.log(r)
                const usedDelimiter = r.meta.delimiter;
                if (csvAutoDetectDelimiter && usedDelimiter !== csvDefaultDelimiterOption.value)
                    setCsvDefaultDelimiterOption({value: usedDelimiter, label: "Detected delimiter: " + usedDelimiter})
            });
        }
    }, [csvFile, csvDefaultDelimiterOption]);

    const parseCsvFile = useCallback(async (file, isAutoDetectDelimiter, defaultDelimiter) => {
        // Set loading state to true
        console.log("parsing file...")
        setIsLoading(true);
        return new Promise((resolve, reject) => {
            Papa.parse(file, {
                delimiter: isAutoDetectDelimiter ? "" : defaultDelimiter,
                skipEmptyLines: true,
                header: true,
                complete: (results) => {
                    // Initialize error lines and clear any previous errors/info
                    setErrorLines([]);
                    setInfo(null);

                    // Handle any errors from the parse method
                    handleErrors(results);

                    // Get the valid data by skipping any invalid lines
                    const validData = skipInvalidLines(results);
                    if (validData.length > 0) {
                        // Set the valid data and update the info message
                        setCsvResults(validData);
                        setInfo(validData.length + " records reads");
                    }
                    // Set loading state to false
                    setIsLoading(false);
                    resolve(results);
                },
                error(err, file) {
                    reject(err);
                }
            })
        });
    }, [])

    //Check if there are any errors and set them in the state
    function handleErrors(results) {
        if (results.errors.length > 0) {
            setErrorLines(results.errors);
        }
    }

    //Iterate through each line of the data and skip any invalid lines
    //Also set any error lines in the state
    function skipInvalidLines(results) {
        // Get the default number of columns
        const defaultNumColumns = getDefaultNumColumns(results);
        let errorLines = [];
        let invalidLines = new Set();
        invalidLines.add(1);

        // Iterate through each line of the data
        for (let i = 0; i < results.data.length; i++) {
            const line = results.data[i];
            if (line.length !== defaultNumColumns) {
                // Add the line to the error lines map
                errorLines.push(
                    {
                        type: "Missing Columns",     // A generalization of the error
                        code: "missingColumns",     // Standardized error code
                        message: `Line ${i + 1} has ${line.length} columns, expected ${defaultNumColumns}.Data: ${line}`,  // Human-readable details
                        row: i + 1,       // Row index of parsed data where error is
                    });
                errorLines.set(i + 1,);
                invalidLines.add(i + 1);
            }
        }
        if (errorLines.size > 0) {
            // Set the error lines in the state
            setErrorLines(errorLines);
        }
        // Return the valid data by filtering out any invalid lines
        return results.data.filter((line, i) => !invalidLines.has(i + 1));
    }

    //Get the default number of columns by checking the first line of the data
    function getDefaultNumColumns(results) {
        let firstLine = results.data[0];
        if (firstLine.length === 1) {
            // If the first line only has one column, skip it
            results.data.shift();
            firstLine = results.data[0];
        }
        return firstLine.length;
    }

    return (
        <div style={{width: "80%", margin: "0 auto"}}>
            <Card className={"mx-auto"}>
                <Card.Header>
                    Import Data CSV
                </Card.Header>
                <Card.Body>
                    <form>
                        <div className="form-group">
                            <Form.File
                                id="csv-file"
                                label="Upload CSV file"
                                accept=".csv"
                                onChange={handleFileSelect}
                                disabled={isLoading}
                                ref={fileInputRef}
                            />
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
                    </form>
                </Card.Body>
                <Card.Footer>

                    {csvFile ?
                        <div>
                            <ListGroupItem variant={errorLines.size > 0 ? "warning" : "success"}>
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
                        </div>
                        : null}

                    {errorLines.size > 0 && <Table>
                        <thead>
                        <tr>
                            <th>Error type</th>
                            <th>Code</th>
                            <th>Line Number</th>
                            <th>Message</th>
                        </tr>
                        </thead>
                        <tbody>
                        {errorLines.map(error => (
                            <tr key={error.row}>
                                <td>{error.type}</td>
                                <td>{error.code}</td>
                                <td>{error.row}</td>
                                <td>{error.message}</td>
                            </tr>
                        ))}
                        </tbody>
                    </Table>}
                    {info ? <div>{info}</div> : null}
                </Card.Footer>
            </Card>
        </div>
    );
}


export default CsvValidator;