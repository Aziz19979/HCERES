import React from 'react';

import 'react-bootstrap-table-next/dist/react-bootstrap-table2.min.css';
import 'react-bootstrap-table2-filter/dist/react-bootstrap-table2-filter.min.css';
import BootstrapTable from 'react-bootstrap-table-next';
import ToolkitProvider, {Search} from 'react-bootstrap-table2-toolkit/dist/react-bootstrap-table2-toolkit';
import paginationFactory from 'react-bootstrap-table2-paginator';
import filterFactory from 'react-bootstrap-table2-filter';
import {Alert} from "react-bootstrap";

import 'react-datepicker/dist/react-datepicker.css';
import Button from "react-bootstrap/Button";
import {Circles} from "react-loading-icons";
import {chercheursColumnOfActivity, paginationOptions} from "../../util/BootStrapTableOptions";
import {ImFilter} from "react-icons/im";
import {AiFillDelete, AiOutlinePlusCircle} from "react-icons/ai";
import {GrDocumentCsv} from "react-icons/gr";
import OralCommunicationAdd from "./OralCommunicationAdd";

import ActivityTypes from "../../../const/ActivityTypes";
import {fetchListOralCommunications} from "../../../services/oral-communication/OralCommunicationActions";
import {fetchResearcherActivities} from "../../../services/Researcher/ResearcherActions";
import OralCommunicationDelete from "./OralCommunicationDelete";

// If targetResearcher is set in props display related information only (
// else load list des tous les oralCommunications du database
function OralCommunicationList(props) {
    // parameter constant (List Template)
    const targetResearcher = props.targetResearcher;

    // Cached state (List Template)
    const [oralCommunicationList, setOralCommunicationList] = React.useState(null);

    // UI states (List Template)
    const [successActivityAlert, setSuccessActivityAlert] = React.useState('');
    const [errorActivityAlert, setErrorActivityAlert] = React.useState('');
    const [showFilter, setShowFilter] = React.useState(false);
    const {SearchBar} = Search;


    // Form state (List Template)
    const [targetOralCommunication, setTargetOralCommunication] = React.useState(false);
    const [showOralCommunicationAdd, setShowOralCommunicationAdd] = React.useState(false);
    const [showOralCommunicationDelete, setShowOralCommunicationDelete] = React.useState(false);
    const [listChangeCount, setListChangeCount] = React.useState(0);


    const handleHideModal = (msg = null) => {
        setShowOralCommunicationAdd(false);
        setShowOralCommunicationDelete(false);
        if (msg) {
            // an add or delete did occur
            // re render the table to load new data
            // note the list change count on dependencies table of use effect
            setListChangeCount(listChangeCount + 1)
        }
        displayResultMessage(msg);
    };

    const displayResultMessage = (messages = null) => {
        // silent close
        if (!messages) return;

        if (messages.successMsg) {
            setSuccessActivityAlert(messages.successMsg)
        }

        if (messages.errorMsg) {
            setErrorActivityAlert(messages.errorMsg)
        }
    }


    React.useEffect(() => {
        if (!targetResearcher) {
            // attention that method always change reference to variable not only its content
            fetchListOralCommunications().then(list => setOralCommunicationList(list))
        } else
            fetchResearcherActivities(targetResearcher.researcherId)
                .then(list => {
                    setOralCommunicationList(list.filter(a => a.idTypeActivity === ActivityTypes.ORAL_COMMUNICATION_POSTER));
                })
    }, [listChangeCount, targetResearcher]);


    if (!oralCommunicationList) {
        return <div><Button><Circles/></Button></div>
    } else {
        if (oralCommunicationList.length === 0) {
            return <div className={"row"}>
                <br/>
                <div className={"col-8"}>
                    <h3>Aucune Communication Orale est enregistrée</h3>
                </div>
                <div className={"col-4"}>
                    {showOralCommunicationAdd &&
                        <OralCommunicationAdd targetResearcher={targetResearcher} onHideAction={handleHideModal}/>}
                    <button className="btn btn-success" data-bs-toggle="button"
                            onClick={() => setShowOralCommunicationAdd(true)}>
                        <AiOutlinePlusCircle/> &nbsp; Ajouter une Communication Oral
                    </button>
                </div>
            </div>;
        }

        const columns = [{
            dataField: 'idActivity',
            text: 'ID',
            sort: true,
            formatter: (cell, row) => {
                return (<div>
                    <button className="btn btn-outline-danger btn-sm" onClick={() => {
                        setTargetOralCommunication(row)
                        setShowOralCommunicationDelete(true)
                    }}><AiFillDelete/></button>
                    &nbsp;  &nbsp;
                    {row.idActivity}
                </div>)
            }
        }, {
            dataField: 'oralCommunication.oralCommunicationTitle',
            text: 'Titre',
            sort: true,
        }, {
            dataField: 'oralCommunication.authors',
            text: 'Auteurs',
        }, {
            dataField: 'oralCommunication.oralCommunicationDat',
            text: 'Date',
            sort: true,
        },  {
            dataField: 'oralCommunication.meetingId.meetingId',
            text: 'Identifiant de la réunion',
            hidden: true, // for csv only
        },  {
            dataField: 'oralCommunication.meetingId.meetingName',
            text: 'Nom de la réunion',
            hidden: true, // for csv only
        },  {
            dataField: 'oralCommunication.meetingId.meetingYear',
            text: 'Année de réunion',
            hidden: true, // for csv only
        },  {
            dataField: 'oralCommunication.meetingId.meetingLocation',
            text: 'Lieu de réunion',
            hidden: true, // for csv only
        },  {
            dataField: 'oralCommunication.meetingId.meetingStart',
            text: 'Date de début de la réunion',
            hidden: true, // for csv only
        },  {
            dataField: 'oralCommunication.meetingId.meetingEnd',
            text: 'Date de fin de réunion',
            hidden: true, // for csv only
        },];

        let title = "OralCommunication"
        if (!targetResearcher) {
            columns.push(chercheursColumnOfActivity)
            title = "Liste des communications orales"
        }
        const CaptionElement = <div>
            <h3> {title} - &nbsp;
                <button className={"border-0"}
                        onClick={(e) => setShowFilter(!showFilter)}>{
                    <ImFilter/>}
                </button>
            </h3>
        </div>

        const MyExportCSV = (props) => {
            const handleClick = () => {
                props.onExport();
            };
            return (
                <button className={"border-0"}
                        onClick={handleClick}>{
                    <GrDocumentCsv/>}
                </button>
            );
        };
        return (
            <div>
                <ToolkitProvider
                    bootstrap4
                    keyField="idActivity"
                    data={oralCommunicationList}
                    columns={columns}
                    exportCSV={ {
                        fileName: 'oralCommunicationList.csv',
                        onlyExportFiltered: true,
                        exportAll: false } }
                    search
                >
                    {
                        props => (
                            <div>
                                <br/>
                                <div className={"row"}>
                                    <div className={"col-8"}>
                                        <h3>{CaptionElement}</h3>
                                    </div>
                                    <div className={"col-4"}>
                                        {showOralCommunicationAdd &&
                                            <OralCommunicationAdd targetResearcher={targetResearcher}
                                                                  onHideAction={handleHideModal}/>}
                                        {showOralCommunicationDelete &&
                                            <OralCommunicationDelete targetOralCommunication={targetOralCommunication}
                                                                     onHideAction={handleHideModal}/>}
                                        <button className="btn btn-success" data-bs-toggle="button"
                                                onClick={() => setShowOralCommunicationAdd(true)}>
                                            <AiOutlinePlusCircle/> &nbsp; Ajouter une oralCommunication
                                        </button>
                                    </div>
                                </div>
                                <div className={"row"}>
                                    <div className={"col-4"}>
                                        {showFilter && <SearchBar {...props.searchProps} />}
                                    </div>
                                    <div className={"col-4"}>
                                        <h3>{showFilter && <MyExportCSV  { ...props.csvProps }/>}</h3>
                                    </div>
                                    <div className={"col-4"}>
                                        {successActivityAlert && <Alert variant={"success"}
                                                                        onClose={() => setSuccessActivityAlert("")}
                                                                        dismissible={true}>{successActivityAlert}</Alert>}
                                        {errorActivityAlert && <Alert variant={"danger"}
                                                                      onClose={() => setErrorActivityAlert("")}
                                                                      dismissible={true}>{errorActivityAlert}</Alert>}
                                    </div>
                                </div>
                                <hr/>
                                <BootstrapTable
                                    bootstrap4
                                    filter={filterFactory()}
                                    pagination={paginationFactory(paginationOptions(oralCommunicationList.length))}
                                    striped
                                    hover
                                    condensed
                                    {...props.baseProps} />
                            </div>
                        )
                    }
                </ToolkitProvider>
            </div>
        );
    }
}

export default OralCommunicationList;
