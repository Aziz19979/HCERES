import {useState} from "react";
import Modal from "react-bootstrap/Modal";
import Button from "react-bootstrap/Button";
import IndustrialContractElement from "./IndustrialContractElement";
import {deleteIndustrialContract} from "../../../services/industrial-contract/IndustrialContractActions";

function IndustrialContractDelete(props) {
    const [show, setShow] = useState(true);
    const targetIndustrialContract = props.targetIndustrialContract;

    const handleClose = (msg = null) => {
        setShow(false);
        props.onHideAction(msg);
    };

    const handleDelete = () => {
        deleteIndustrialContract(targetIndustrialContract.idActivity)
            .then(response => {
                const msg = {
                    "successMsg": "IndustrialContract supprimé ayant l'id " + targetIndustrialContract.idActivity,
                }
                handleClose(msg);
            }).catch(error => {
            console.log(error);
            const msg = {
                "errorMsg": "IndustrialContract non supprimé, response status: " + error.response.status,
            }
            handleClose(msg);
        })
    }

    return (
        <Modal show={show} onHide={handleClose}>
            <Modal.Header closeButton>
                <Modal.Title>Êtes-vous sûr de vouloir supprimer le Contract industrial sélectionné?</Modal.Title>
            </Modal.Header>
            <Modal.Body>
                <IndustrialContractElement targetIndustrialContract={targetIndustrialContract}/>
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


export default IndustrialContractDelete;

