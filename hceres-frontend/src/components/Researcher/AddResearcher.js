import React from 'react';
import './Researcher.css';
import 'react-datepicker/dist/react-datepicker.css';
import {Link, useNavigate, useParams} from "react-router-dom";
import Modal from "react-bootstrap/Modal";
import Button from "react-bootstrap/Button";
import {API_URL} from "../../constants";
import axios from "axios";

/**
 * add or edit researcher if present in props.targetResearcher
 */
function AddResearcher(props) {
    const [showModal, setShowModal] = React.useState(true);
    const targetResearcher = props.targetResearcher;

    const silentClose = () => {
        setShowModal(false);
        props.onHideAction();
    };

    const handleClose = (msg) => {
        setShowModal(false);
        props.onHideAction(msg);
    };

    const [AddResearcherFirstName, setAddResearcherFirstName] = React.useState(targetResearcher ? targetResearcher.researcherName : "");
    const [AddResearcherLastName, setAddResearcherLastName] = React.useState(targetResearcher ? targetResearcher.researcherSurname : "");
    const [AddResearcherEmail, setAddResearcherEmail] = React.useState(targetResearcher ? targetResearcher.researcherEmail : "");

    const navigate = useNavigate();

    const handleSubmit = (event) => {
        event.preventDefault();
        let data = {
            "researcherSurname": AddResearcherLastName,
            "researcherName": AddResearcherFirstName,
            "researcherEmail": AddResearcherEmail
        };
        if (targetResearcher) {
            handleUpdateResearcher(data)
        } else {
            handleAddResearcher(data)
        }
    }

    const handleUpdateResearcher = (data) => {
        axios.put(`${API_URL}/updateResearcher/${targetResearcher.researcherId}`, data)
            .then(response => {
                const researcherId = response.data.researcherId;
                const msg = {
                    "researcherUpdated": response.data,
                    "successMsg": "Researcher mise a jour ayant id " + researcherId,
                }
                handleClose(msg);
            }).catch(error => {
            console.log(error);
            const msg = {
                "errorMsg": "Researcher non mise a jour, response status: " + error.response.status,
            }
            handleClose(msg);
        })
    }

    const handleAddResearcher = (data) => {
        axios.get(API_URL + "/AddResearcher", data)
            .then(response => {
                const researcherId = response.data.researcherId;
                const msg = {
                    "researcherAdded": response.data,
                    "successMsg": "Researcher ajoute avec un id " + researcherId,
                }
                handleClose(msg);
            }).catch(error => {
            console.log(error);
            const msg = {
                "errorMsg": "Researcher non ajoute, response status: " + error.response.status,
            }
            handleClose(msg);
        })
    }

    return (
        <div>
            <Modal show={showModal} onHide={() => silentClose()}>
                <form onSubmit={handleSubmit}>
                    <Modal.Header closeButton>
                        <Modal.Title>
                            {!targetResearcher && <div>Ajouter un chercheur</div>}
                            {targetResearcher && <div>Editeur d'un chercheur</div>}
                        </Modal.Title>
                    </Modal.Header>
                    <Modal.Body>
                        <label className='label'>
                            Prénom du chercheur
                        </label>
                        <input
                            placeholder='Prénom'
                            className='input-container'
                            name="AddResearcherFirstName"
                            type="AddResearcherFirstName"
                            value={AddResearcherFirstName}
                            onChange={e => setAddResearcherFirstName(e.target.value)}
                            required/>
                        <label className='label'>
                            Nom du chercheur
                        </label>
                        <input
                            placeholder='Nom'
                            className='input-container'
                            name="AddResearcherLastName"
                            type="AddResearcherLastName"
                            value={AddResearcherLastName}
                            onChange={e => setAddResearcherLastName(e.target.value)}
                            required/>

                        <label className='label'>
                            Email du chercheur
                        </label>
                        <input
                            placeholder='Email'
                            className='input-container'
                            name="AddResearcherEmail"
                            type="AddResearcherEmail"
                            value={AddResearcherEmail}
                            onChange={e => setAddResearcherEmail(e.target.value)}
                            required/>
                    </Modal.Body>
                    <Modal.Footer>
                        <Button variant="secondary" onClick={() => silentClose()}>
                            Close
                        </Button>
                        <Button variant="outline-primary" type={"submit"}>
                            {!targetResearcher && <div>Ajouter</div>}
                            {targetResearcher && <div>Mettre à jour</div>}
                        </Button>
                    </Modal.Footer>
                </form>
            </Modal>
        </div>
    );
}

export default AddResearcher;
