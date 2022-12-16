import {useState} from "react";
import Modal from "react-bootstrap/Modal";
import Button from "react-bootstrap/Button";
import IncomingMobilityElement from "./IncomingMobilityElement";
import {deleteIncomingMobility} from "../../../services/incoming-mobility/IncomingMobilityActions";

function IncomingMobilityDelete(props) {
    const [show, setShow] = useState(true);
    const targetIncomingMobility = props.targetIncomingMobility;

    const handleClose = (msg = null) => {
        setShow(false);
        props.onHideAction(msg);
    };

    const handleDelete = () => {
        deleteIncomingMobility(targetIncomingMobility.idActivity)
            .then(response => {
                const msg = {
                    "successMsg": "IncomingMobility supprimé ayant l'id " + targetIncomingMobility.idActivity,
                }
                handleClose(msg);
            }).catch(error => {
            console.log(error);
            const msg = {
                "errorMsg": "IncomingMobility non supprimé, response status: " + error.response.status,
            }
            handleClose(msg);
        })
    }

    return (
        <Modal show={show} onHide={handleClose}>
            <Modal.Header closeButton>
                <Modal.Title>Êtes-vous sûr de vouloir supprimer l'incomingMobility sélectionné?</Modal.Title>
            </Modal.Header>
            <Modal.Body>
                <IncomingMobilityElement targetIncomingMobility={targetIncomingMobility}/>
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


export default IncomingMobilityDelete;

