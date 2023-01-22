import {useState} from "react";
import Modal from "react-bootstrap/Modal";
import Button from "react-bootstrap/Button";
import LoadingIcon from "../../util/LoadingIcon";
import CompanyCreationElement from "./CompanyCreationElement";
import {deleteCompanyCreation} from "../../../services/Activity/company-creation/CompanyCreationActions";

function CompanyCreationDelete(props) {
    const [show, setShow] = useState(true);
    const [isLoading, setIsLoading] = useState(false);
    const targetCompanyCreation = props.targetCompanyCreation;

    const handleClose = (msg = null) => {
        setShow(false);
        props.onHideAction(msg);
    };

    const handleDelete = () => {
        setIsLoading(true);
        deleteCompanyCreation(targetCompanyCreation.idActivity)
            .then(response => {
                const msg = {
                    "successMsg": "CompanyCreation supprimé ayant l'id " + targetCompanyCreation.idActivity,
                }
                handleClose(msg);
            }).catch(error => {
            console.log(error);
            const msg = {
                "errorMsg": "CompanyCreation non supprimé, response status: " + error.response.status,
            }
            handleClose(msg);
        })
            .finally(() => setIsLoading(false))
    }

    return (
        <Modal show={show} onHide={handleClose}>
            <Modal.Header closeButton>
                <Modal.Title>Êtes-vous sûr de vouloir supprimer la Création d'entreprise sélectionné?</Modal.Title>
            </Modal.Header>
            <Modal.Body>
                <CompanyCreationElement targetCompanyCreation={targetCompanyCreation}/>
            </Modal.Body>
            <Modal.Footer>
                <Button variant="secondary" onClick={handleClose}>
                    Non
                </Button>
                <Button variant="danger" onClick={handleDelete} disabled={isLoading}>
                    {isLoading ? <LoadingIcon color={"white"}/> : null}
                    {isLoading ? 'Suppression en cours...' : 'Oui, Supprimer'}
                </Button>
            </Modal.Footer>
        </Modal>
    );
}


export default CompanyCreationDelete;

