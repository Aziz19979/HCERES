import {useState} from "react";
import Modal from "react-bootstrap/Modal";
import Button from "react-bootstrap/Button";
import PatentElement from "./PatentElement";
import {deletePatent} from "../../../services/patent/PatentActions";

function PatentDelete(props) {
    const [show, setShow] = useState(true);
    const targetPatent = props.targetPatent;

    const handleClose = (msg = null) => {
        setShow(false);
        props.onHideAction(msg);
    };

    const handleDelete = () => {
        deletePatent(targetPatent.idActivity)
            .then(response => {
                const msg = {
                    "successMsg": "Patent supprimé ayant l'id " + targetPatent.idActivity,
                }
                handleClose(msg);
            }).catch(error => {
            console.log(error);
            const msg = {
                "errorMsg": "Patent non supprimé, response status: " + error.response.status,
            }
            handleClose(msg);
        })
    }

    return (
        <Modal show={show} onHide={handleClose}>
            <Modal.Header closeButton>
                <Modal.Title>Êtes-vous sûr de vouloir supprimer l'patent sélectionné?</Modal.Title>
            </Modal.Header>
            <Modal.Body>
                <PatentElement targetPatent={targetPatent}/>
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


export default PatentDelete;

