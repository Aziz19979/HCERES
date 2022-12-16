import {useState} from "react";
import Modal from "react-bootstrap/Modal";
import Button from "react-bootstrap/Button";
import PlatformElement from "./PlatformElement";
import {deletePlatform} from "../../../services/platform/PlatformActions";

function PlatformDelete(props) {
    const [show, setShow] = useState(true);
    const targetPlatform = props.targetPlatform;

    const handleClose = (msg = null) => {
        setShow(false);
        props.onHideAction(msg);
    };

    const handleDelete = () => {
        deletePlatform(targetPlatform.idActivity)
            .then(response => {
                const msg = {
                    "successMsg": "Platform supprimé ayant l'id " + targetPlatform.idActivity,
                }
                handleClose(msg);
            }).catch(error => {
            console.log(error);
            const msg = {
                "errorMsg": "Platform non supprimé, response status: " + error.response.status,
            }
            handleClose(msg);
        })
    }

    return (
        <Modal show={show} onHide={handleClose}>
            <Modal.Header closeButton>
                <Modal.Title>Êtes-vous sûr de vouloir supprimer le platform sélectionné?</Modal.Title>
            </Modal.Header>
            <Modal.Body>
                <PlatformElement targetPlatform={targetPlatform}/>
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


export default PlatformDelete;

