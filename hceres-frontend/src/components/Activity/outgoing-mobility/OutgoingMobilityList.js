import React from 'react';

import 'react-bootstrap-table-next/dist/react-bootstrap-table2.min.css';
import 'react-bootstrap-table2-filter/dist/react-bootstrap-table2-filter.min.css';
import BootstrapTable from 'react-bootstrap-table-next';
import ToolkitProvider, {Search} from 'react-bootstrap-table2-toolkit/dist/react-bootstrap-table2-toolkit';
import paginationFactory from 'react-bootstrap-table2-paginator';
import filterFactory, {dateFilter, numberFilter, textFilter} from 'react-bootstrap-table2-filter';
import {Alert} from "react-bootstrap";

import 'react-datepicker/dist/react-datepicker.css';
import Button from "react-bootstrap/Button";
import {Audio} from "react-loading-icons";
import {chercheursColumnOfActivity, paginationOptions} from "../../util/BootStrapTableOptions";
import {ImFilter} from "react-icons/im";
import {AiFillDelete, AiOutlinePlusCircle} from "react-icons/ai";
import {GrDocumentCsv} from "react-icons/gr";

import ActivityTypes from "../../../const/ActivityTypes";
import {fetchListOutgoingMobilities} from "../../../services/outgoing-mobility/OutgoingMobilityActions";
import {fetchResearcherActivities} from "../../../services/Researcher/ResearcherActions";
import OutgoingMobilityDelete from "./OutgoingMobilityDelete";
import OutgoingMobilityAdd from "./OutgoingMobilityAdd";

// If targetResearcher is set in props display related information only (
// else load list des tous les outgoingMobilities du database
function OutgoingMobilityList(props) {
    // parameter constant (List Template)
    const targetResearcher = props.targetResearcher;

    // Cached state (List Template)
    const [outgoingMobilityList, setOutgoingMobilityList] = React.useState(null);

    // UI states (List Template)
    const [successActivityAlert, setSuccessActivityAlert] = React.useState('');
    const [errorActivityAlert, setErrorActivityAlert] = React.useState('');
    const [showFilter, setShowFilter] = React.useState(false);
    const {SearchBar} = Search;


    // Form state (List Template)
    const [targetOutgoingMobility, setTargetOutgoingMobility] = React.useState("");
    const [showOutgoingMobilityAdd, setShowOutgoingMobilityAdd] = React.useState(false);
    const [showOutgoingMobilityDelete, setShowOutgoingMobilityDelete] = React.useState(false);
    const [listChangeCount, setListChangeCount] = React.useState(0);


    const handleHideModal = (msg = null) => {
        setShowOutgoingMobilityAdd(false);
        setShowOutgoingMobilityDelete(false);
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
            fetchListOutgoingMobilities().then(list => setOutgoingMobilityList(list))
        } else
            fetchResearcherActivities(targetResearcher.researcherId)
                .then(list => {
                    setOutgoingMobilityList(list.filter(a => a.idTypeActivity === ActivityTypes.OUTGOING_MOBILITY));
                })
    }, [listChangeCount, targetResearcher]);


    if (!outgoingMobilityList) {
        return <div><Button><Audio/></Button></div>
    } else {
        if (outgoingMobilityList.length === 0) {
            return <div className={"row"}>
                <br/>
                <div className={"col-8"}>
                    <h3>Aucune OutgoingMobility n'est enregistrée</h3>
                </div>
                <div className={"col-4"}>
                    {showOutgoingMobilityAdd &&
                        <OutgoingMobilityAdd targetResearcher={targetResearcher} onHideAction={handleHideModal}/>}
                    <button className="btn btn-success" data-bs-toggle="button"
                            onClick={() => setShowOutgoingMobilityAdd(true)}>
                        <AiOutlinePlusCircle/> &nbsp; Ajouter une outgoingMobility
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
                        setTargetOutgoingMobility(row)
                        setShowOutgoingMobilityDelete(true)
                    }}><AiFillDelete/></button>
                    &nbsp;  &nbsp;
                    {row.idActivity}
                </div>)
            }
        }, {
            dataField: 'outgoingMobility.namePersonConcerned',
            text: "Nom de la personne concernée",
            sort: true,
            // filter: showFilter ? textFilter() : null,
            // hidden: true, // for csv only
        }, {
            dataField: 'outgoingMobility.arrivalDate',
            text: "Date d'arrivée",
            sort: true,
            filter: showFilter ? dateFilter() : null,
            // hidden: true, // for csv only
        }, {
            dataField: 'outgoingMobility.departureDate',
            text: "Date de départ",
            sort: true,
            filter: showFilter ? dateFilter() : null,
            hidden: true, // for csv only
        }, {
            dataField: 'outgoingMobility.duration',
            text: "Durée",
            sort: true,
            // filter: showFilter ? numberFilter() : null,
            // hidden: true, // for csv only
        }, {
            dataField: 'outgoingMobility.hostLabName',
            text: "Nom du laboratoire hôte",
            sort: true,
            // filter: showFilter ? textFilter() : null,
            // hidden: true, // for csv only
        }, {
            dataField: 'outgoingMobility.hostLabLocation',
            text: "Emplacement du laboratoire hôte",
            sort: true,
            filter: showFilter ? textFilter() : null,
            hidden: true, // for csv only
        }, {
            dataField: 'outgoingMobility.piPartner',
            text: "Pi Partenaire",
            sort: true,
            filter: showFilter ? textFilter() : null,
            hidden: true, // for csv only
        }, {
            dataField: 'outgoingMobility.projectTitle',
            text: "Titre du projet",
            sort: true,
            // filter: showFilter ? textFilter() : null,
            // hidden: true, // for csv only
        }, {
            dataField: 'outgoingMobility.associatedFunding',
            text: "Financement associé",
            sort: true,
            filter: showFilter ? textFilter() : null,
            hidden: true, // for csv only
        }, {
            dataField: 'outgoingMobility.nbPublications',
            text: "Nb Publications",
            sort: true,
            filter: showFilter ? numberFilter() : null,
            hidden: true, // for csv only
        }, {
            dataField: 'outgoingMobility.publicationReference',
            text: "Publication Référence",
            sort: true,
            filter: showFilter ? textFilter() : null,
            hidden: true, // for csv only
        }, {
            dataField: 'outgoingMobility.strategicRecurringCollab',
            text: "Collaboration stratégique récurrente?",
            sort: true,
            filter: showFilter ? textFilter() : null,
            hidden: true, // for csv only
        }, {
            dataField: 'outgoingMobility.activeProject',
            text: "Projet actif?",
            sort: true,
            // filter: showFilter ? textFilter() : null,
            // hidden: true, // for csv only
        }, {
            dataField: 'outgoingMobility.umrCoordinated',
            text: "Umr Coordonné?",
            sort: true,
            filter: showFilter ? textFilter() : null,
            hidden: true, // for csv only
        }, {
            dataField: 'outgoingMobility.agreementSigned',
            text: "Accord Signé?",
            sort: true,
            filter: showFilter ? textFilter() : null,
            hidden: true, // for csv only
        }];

        let title = "OutgoingMobility"
        if (!targetResearcher) {
            columns.push(chercheursColumnOfActivity)
            title = "Liste des outgoingMobilities pour les Chercheurs"
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
                    data={outgoingMobilityList}
                    columns={columns}
                    exportCSV={{
                        fileName: 'outgoingMobilityList.csv',
                        onlyExportFiltered: true,
                        exportAll: false
                    }}
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
                                        {showOutgoingMobilityAdd &&
                                            <OutgoingMobilityAdd targetResearcher={targetResearcher}
                                                                 onHideAction={handleHideModal}/>}
                                        {showOutgoingMobilityDelete &&
                                            <OutgoingMobilityDelete targetOutgoingMobility={targetOutgoingMobility}
                                                                    onHideAction={handleHideModal}/>}
                                        <button className="btn btn-success" data-bs-toggle="button"
                                                onClick={() => setShowOutgoingMobilityAdd(true)}>
                                            <AiOutlinePlusCircle/> &nbsp; Ajouter une outgoingMobility
                                        </button>
                                    </div>
                                </div>
                                <div className={"row"}>
                                    <div className={"col-4"}>
                                        {showFilter && <SearchBar {...props.searchProps} />}
                                    </div>
                                    <div className={"col-4"}>
                                        <h3>{showFilter && <MyExportCSV  {...props.csvProps}/>}</h3>
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
                                    pagination={paginationFactory(paginationOptions(outgoingMobilityList.length))}
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

export default OutgoingMobilityList;
