import React from 'react';
import Modal from "react-bootstrap/Modal";
import Button from "react-bootstrap/Button";
import {ListGroup} from "react-bootstrap";
import {fetchListResearchers} from "../../../services/Researcher/ResearcherActions";
import {addCompanyCreation} from "../../../services/company-creation/CompanyCreationActions";

// If targetResearcher is set in props use it as default without charging list from database
// else load list de chercheurs from database
function CompanyCreationAdd(props) {
    // parameter constant (Add Template)
    const targetResearcher = props.targetResearcher;
    const onHideParentAction = props.onHideAction

    // Cached state (Add Template)
    const [researchers, setResearchers] = React.useState([]);

    // UI states (Add Template)
    const [showModal, setShowModal] = React.useState(true);


    // Form state (Add Template)
    const [researcherId, setResearcherId] = React.useState(targetResearcher ? targetResearcher.researcherId : "");
    const [companyCreationName, setCompanyCreationName] = React.useState();
    const [companyCreationDate, setCompanyCreationDate] = React.useState(null);
    const [companyCreationActive, setCompanyCreationActive] = React.useState(false);


    const handleClose = (msg = null) => {
        setShowModal(false);
        onHideParentAction(msg);
    };

    React.useEffect(() => {
        if (!targetResearcher)
            fetchListResearchers().then(list => {
                setResearchers(list);
                if (list.length > 0) {
                    setResearcherId(list.entries().next().value[1].researcherId)
                }
            });
    }, []);

    const handleSubmit = (event) => {
        event.preventDefault();
        let data = {
            researcherId: researcherId,
            companyCreationName: companyCreationName,
            companyCreationDate: companyCreationDate,
            companyCreationActive: companyCreationActive,
        };

        addCompanyCreation(data).then(response => {
            // const activityId = response.data.researcherId;
            const msg = {
                "successMsg": "CompanyCreation ajouté avec un id " + response.data.idActivity,
            }
            handleClose(msg);
        }).catch(error => {
            console.log(error);
            const msg = {
                "errorMsg": "Erreur CompanyCreation non ajouté, response status: " + error.response.status,
            }
            handleClose(msg);
        })
    }

    const onReseacherSelection = id => setResearcherId(id.target.value);

    return (
        <div>
            <Modal show={showModal} onHide={handleClose}>
                <form onSubmit={handleSubmit}>
                    <Modal.Header closeButton>
                        <Modal.Title>CompanyCreation</Modal.Title>
                    </Modal.Header>
                    <Modal.Body>


                        <label className='label'>
                            Chercheur
                        </label>
                        {targetResearcher ?
                            <ListGroup.Item
                                variant={"primary"}>{targetResearcher.researcherName} {targetResearcher.researcherSurname}</ListGroup.Item> :

                            <select onChange={onReseacherSelection}>
                                {researchers.map(item => {
                                    return (<option key={item.researcherId}
                                                    value={item.researcherId}>{item.researcherName} {item.researcherSurname}</option>);
                                })}
                            </select>
                        }
                        <label className='label'>
                            Nom de l'entreprise
                        </label>
                        <input
                            type={"text"}
                            placeholder="Nom de l'entreprise"
                            className="input-container"
                            value={companyCreationName}
                            onChange={e => setCompanyCreationName(e.target.value)}
                            required/>

                        <label className='label'>
                            Date de création
                        </label>
                        <input
                            type="date"
                            className='input-container'
                            onChange={e => setCompanyCreationDate(e.target.value)}
                            required/>

                        <label className='label'>
                            Entreprise Active?
                        </label>
                        <input
                            type="checkbox"
                            className="input-container"
                            onChange={e => setCompanyCreationActive(e.target.checked)}
                            required/>

                    </Modal.Body>
                    <Modal.Footer>
                        <Button variant="secondary" onClick={handleClose}>
                            Close
                        </Button>
                        <Button variant="outline-primary" type={"submit"}>
                            Ajouter
                        </Button>

                    </Modal.Footer>
                </form>
            </Modal>
        </div>
    );
}

export default CompanyCreationAdd;
