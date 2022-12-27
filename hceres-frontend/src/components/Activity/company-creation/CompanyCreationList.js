import React from 'react';

import 'react-bootstrap-table-next/dist/react-bootstrap-table2.min.css';
import 'react-bootstrap-table2-filter/dist/react-bootstrap-table2-filter.min.css';
import BootstrapTable from 'react-bootstrap-table-next';
import ToolkitProvider, {Search} from 'react-bootstrap-table2-toolkit/dist/react-bootstrap-table2-toolkit';
import paginationFactory from 'react-bootstrap-table2-paginator';
import filterFactory, {dateFilter} from 'react-bootstrap-table2-filter';
import {Alert} from "react-bootstrap";

import 'react-datepicker/dist/react-datepicker.css';
import Button from "react-bootstrap/Button";
import {Audio} from "react-loading-icons";
import {chercheursColumnOfActivity, paginationOptions} from "../../util/BootStrapTableOptions";
import {ImFilter} from "react-icons/im";
import {AiFillDelete, AiOutlinePlusCircle} from "react-icons/ai";
import {GrDocumentCsv} from "react-icons/gr";

import ActivityTypes from "../../../const/ActivityTypes";
import {fetchListCompanyCreations} from "../../../services/company-creation/CompanyCreationActions";
import {fetchResearcherActivities} from "../../../services/Researcher/ResearcherActions";
import CompanyCreationDelete from "./CompanyCreationDelete";
import CompanyCreationAdd from "./CompanyCreationAdd";

// If targetResearcher is set in props display related information only (
// else load list des tous les companyCreations du database
function CompanyCreationList(props) {
    // parameter constant (List Template)
    const targetResearcher = props.targetResearcher;

    // Cached state (List Template)
    const [companyCreationList, setCompanyCreationList] = React.useState([]);

    // UI states (List Template)
    const [successActivityAlert, setSuccessActivityAlert] = React.useState('');
    const [errorActivityAlert, setErrorActivityAlert] = React.useState('');
    const [showFilter, setShowFilter] = React.useState(false);
    const {SearchBar} = Search;


    // Form state (List Template)
    const [targetCompanyCreation, setTargetCompanyCreation] = React.useState(false);
    const [showCompanyCreationAdd, setShowCompanyCreationAdd] = React.useState(false);
    const [showCompanyCreationDelete, setShowCompanyCreationDelete] = React.useState(false);
    const [listChangeCount, setListChangeCount] = React.useState(0);


    const handleHideModal = (msg = null) => {
        setShowCompanyCreationAdd(false);
        setShowCompanyCreationDelete(false);
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
            fetchListCompanyCreations().then(list => setCompanyCreationList(list))
        } else
            fetchResearcherActivities(targetResearcher.researcherId)
                .then(list => {
                    setCompanyCreationList(list.filter(a => a.idTypeActivity === ActivityTypes.SEI_COMPANY_CREATION));
                })
    }, [listChangeCount, targetResearcher]);


    if (!companyCreationList) {
        return <div><Button><Audio/></Button></div>
    } else {
        if (companyCreationList.length === 0) {
            return <div className={"row"}>
                <br/>
                <div className={"col-8"}>
                    <h3>Aucune Création d'entreprise n'est enregistrée</h3>
                </div>
                <div className={"col-4"}>
                    {showCompanyCreationAdd &&
                        <CompanyCreationAdd targetResearcher={targetResearcher} onHideAction={handleHideModal}/>}
                    <button className="btn btn-success" data-bs-toggle="button"
                            onClick={() => setShowCompanyCreationAdd(true)}>
                        <AiOutlinePlusCircle/> &nbsp; Ajouter une companyCreation
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
                        setTargetCompanyCreation(row)
                        setShowCompanyCreationDelete(true)
                    }}><AiFillDelete/></button>
                    &nbsp;  &nbsp;
                    {row.idActivity}
                </div>)
            }
        }, {
            dataField: 'companyCreation.companyCreationName',
            text: "Nom de l'entreprise",
            sort: true,
            // filter: showFilter ? textFilter() : null,
            // hidden: true, // for csv only
        }, {
            dataField: 'companyCreation.companyCreationDate',
            text: "Date de création",
            sort: true,
            filter: showFilter ? dateFilter() : null,
            // hidden: true, // for csv only
        }, {
            dataField: 'companyCreation.companyCreationActive',
            text: "Entreprise Active?",
            sort: true,
            // filter: showFilter ? textFilter() : null,
            // hidden: true, // for csv only
        }];

        let title = "CompanyCreation"
        if (!targetResearcher) {
            columns.push(chercheursColumnOfActivity)
            title = "Liste des companyCreations pour les Chercheurs"
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
                    data={companyCreationList}
                    columns={columns}
                    exportCSV={ {
                        fileName: 'companyCreationList.csv',
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
                                        {showCompanyCreationAdd &&
                                            <CompanyCreationAdd targetResearcher={targetResearcher}
                                                          onHideAction={handleHideModal}/>}
                                        {showCompanyCreationDelete &&
                                            <CompanyCreationDelete targetCompanyCreation={targetCompanyCreation}
                                                             onHideAction={handleHideModal}/>}
                                        <button className="btn btn-success" data-bs-toggle="button"
                                                onClick={() => setShowCompanyCreationAdd(true)}>
                                            <AiOutlinePlusCircle/> &nbsp; Ajouter une companyCreation
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
                                    pagination={paginationFactory(paginationOptions(companyCreationList.length))}
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

export default CompanyCreationList;