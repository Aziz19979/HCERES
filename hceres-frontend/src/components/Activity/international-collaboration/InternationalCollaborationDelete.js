import {useState} from "react";
import Modal from "react-bootstrap/Modal";
import Button from "react-bootstrap/Button";
import InternationalCollaborationElement from "./InternationalCollaborationElement";
import {deleteInternationalCollaboration} from "../../../services/international-collaboration/InternationalCollaborationActions";

function InternationalCollaborationDelete(props) {
    const [show, setShow] = useState(true);
    const targetInternationalCollaboration = props.targetInternationalCollaboration;

    const handleClose = (msg = null) => {
        setShow(false);
        props.onHideAction(msg);
    };

    const handleDelete = () => {
        deleteInternationalCollaboration(targetInternationalCollaboration.idActivity)
            .then(response => {
                const msg = {
                    "successMsg": "InternationalCollaboration supprimé ayant l'id " + targetInternationalCollaboration.idActivity,
                }
                handleClose(msg);
            }).catch(error => {
            console.log(error);
            const msg = {
                "errorMsg": "InternationalCollaboration non supprimé, response status: " + error.response.status,
            }
            handleClose(msg);
        })
    }

    return (
        <Modal show={show} onHide={handleClose}>
            <Modal.Header closeButton>
                <Modal.Title>Êtes-vous sûr de vouloir supprimer l'internationalCollaboration sélectionné?</Modal.Title>
            </Modal.Header>
            <Modal.Body>
                <InternationalCollaborationElement targetInternationalCollaboration={targetInternationalCollaboration}/>
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


export default InternationalCollaborationDelete;

