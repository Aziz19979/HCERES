import {useState} from "react";
import Modal from "react-bootstrap/Modal";
import Button from "react-bootstrap/Button";
import OralCommunicationElement from "./OralCommunicationElement";
import {deleteOralCommunication} from "../../../services/oral-communication/OralCommunicationActions";

function OralCommunicationDelete(props) {
    const [show, setShow] = useState(true);
    const targetOralCommunication = props.targetOralCommunication;

    const handleClose = (msg = null) => {
        setShow(false);
        props.onHideAction(msg);
    };

    const handleDelete = () => {
        deleteOralCommunication(targetOralCommunication.idActivity)
            .then(response => {
                const msg = {
                    "successMsg": "OralCommunication supprimé ayant l'id " + targetOralCommunication.idActivity,
                }
                handleClose(msg);
            }).catch(error => {
            console.log(error);
            const msg = {
                "errorMsg": "OralCommunication non supprimé, response status: " + error.response.status,
            }
            handleClose(msg);
        })
    }

    return (
        <Modal show={show} onHide={handleClose}>
            <Modal.Header closeButton>
                <Modal.Title>Êtes-vous sûr de vouloir supprimer l'oralCommunication sélectionné?</Modal.Title>
            </Modal.Header>
            <Modal.Body>
                <OralCommunicationElement targetOralCommunication={targetOralCommunication}/>
            </Modal.Body>
            <Modal.Footer>
                <Button variant="secondary" onClick={handleClose}>
                    Non
                </Button>
                <Button variant="danger" onClick={handleDelete}>
                    Oui, Supprimer
                </Button>
            </Modal.Footer>
        </Modal>
    );
}


export default OralCommunicationDelete;

