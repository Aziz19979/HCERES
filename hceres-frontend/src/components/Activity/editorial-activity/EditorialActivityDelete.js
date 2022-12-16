import {useState} from "react";
import Modal from "react-bootstrap/Modal";
import Button from "react-bootstrap/Button";
import EditorialActivityElement from "./EditorialActivityElement";
import {deleteEditorialActivity} from "../../../services/editorial-activity/EditorialActivityActions";

function EditorialActivityDelete(props) {
    const [show, setShow] = useState(true);
    const targetEditorialActivity = props.targetEditorialActivity;

    const handleClose = (msg = null) => {
        setShow(false);
        props.onHideAction(msg);
    };

    const handleDelete = () => {
        deleteEditorialActivity(targetEditorialActivity.idActivity)
            .then(response => {
                const msg = {
                    "successMsg": "EditorialActivity supprimé ayant l'id " + targetEditorialActivity.idActivity,
                }
                handleClose(msg);
            }).catch(error => {
            console.log(error);
            const msg = {
                "errorMsg": "EditorialActivity non supprimé, response status: " + error.response.status,
            }
            handleClose(msg);
        })
    }

    return (
        <Modal show={show} onHide={handleClose}>
            <Modal.Header closeButton>
                <Modal.Title>Êtes-vous sûr de vouloir supprimer l'editorialActivity sélectionné?</Modal.Title>
            </Modal.Header>
            <Modal.Body>
                <EditorialActivityElement targetEditorialActivity={targetEditorialActivity}/>
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


export default EditorialActivityDelete;

