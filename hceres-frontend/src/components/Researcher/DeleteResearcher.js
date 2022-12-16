import {useState} from "react";
import Modal from "react-bootstrap/Modal";
import Axios from "axios";
import Button from "react-bootstrap/Button";
import ResearcherElement from "./ResearcherElement";

function DeleteResearcher(props) {
    const [show, setShow] = useState(true);
    const targetResearcher = props.targetResearcher;
    const silentClose = () => {
        setShow(false);
        props.onHideAction();
    };

    const handleClose = (msg) => {
        setShow(false);
        props.onHideAction(msg);
    };

    const handleDelete = () => {
        Axios.delete(`http://localhost:9000/deleteResearcher/${targetResearcher.researcherId}`)
            .then(response => {
                const msg = {
                    "researcherDeleted": targetResearcher,
                    "successMsg": "Researcher supprimé ayant l'id " + targetResearcher.researcherId,
                }
                handleClose(msg);
            }).catch(error => {
            console.log(error);
            const msg = {
                "errorMsg": "Researcher non supprimé, response status: " + error.response.status,
            }
            handleClose(msg);
        })
    }

    return (
        <Modal show={show} onHide={silentClose}>
            <Modal.Header closeButton>
                <Modal.Title>Êtes-vous sûr de vouloir supprimer le chercheur sélectionné?</Modal.Title>
            </Modal.Header>
            <Modal.Body>
                <ResearcherElement targetResearcher={targetResearcher} />
            </Modal.Body>
            <Modal.Footer>
                <Button variant="secondary" onClick={silentClose}>
                    Non
                </Button>
                <Button variant="danger" onClick={handleDelete}>
                    Oui, Supprimer
                </Button>
            </Modal.Footer>
        </Modal>
    );
}


export default DeleteResearcher;

