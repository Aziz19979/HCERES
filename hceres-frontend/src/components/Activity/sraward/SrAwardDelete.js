import {useState} from "react";
import Modal from "react-bootstrap/Modal";
import Button from "react-bootstrap/Button";
import SrAwardElement from "./SrAwardElement";
import {deleteSrAward} from "../../../services/sraward/SrAwardActions";

function SrAwardDelete(props) {
    const [show, setShow] = useState(true);
    const targetSrAward = props.targetSrAward;

    const handleClose = (msg = null) => {
        setShow(false);
        props.onHideAction(msg);
    };

    const handleDelete = () => {
        deleteSrAward(targetSrAward.idActivity)
            .then(response => {
                const msg = {
                    "successMsg": "SrAward supprimé ayant l'id " + targetSrAward.idActivity,
                }
                handleClose(msg);
            }).catch(error => {
            console.log(error);
            const msg = {
                "errorMsg": "SrAward non supprimé, response status: " + error.response.status,
            }
            handleClose(msg);
        })
    }

    return (
        <Modal show={show} onHide={handleClose}>
            <Modal.Header closeButton>
                <Modal.Title>Êtes-vous sûr de vouloir supprimer le prix sélectionné?</Modal.Title>
            </Modal.Header>
            <Modal.Body>
                <SrAwardElement targetSrAward={targetSrAward}/>
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


export default SrAwardDelete;

