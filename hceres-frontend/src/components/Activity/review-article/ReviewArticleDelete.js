import {useState} from "react";
import Modal from "react-bootstrap/Modal";
import Button from "react-bootstrap/Button";
import ReviewArticleElement from "./ReviewArticleElement";
import {deleteReviewArticle} from "../../../services/review-article/ReviewArticleActions";

function ReviewArticleDelete(props) {
    const [show, setShow] = useState(true);
    const targetReviewArticle = props.targetReviewArticle;

    const handleClose = (msg = null) => {
        setShow(false);
        props.onHideAction(msg);
    };

    const handleDelete = () => {
        deleteReviewArticle(targetReviewArticle.idActivity)
            .then(response => {
                const msg = {
                    "successMsg": "ReviewArticle supprimé ayant l'id " + targetReviewArticle.idActivity,
                }
                handleClose(msg);
            }).catch(error => {
            console.log(error);
            const msg = {
                "errorMsg": "ReviewArticle non supprimé, response status: " + error.response.status,
            }
            handleClose(msg);
        })
    }

    return (
        <Modal show={show} onHide={handleClose}>
            <Modal.Header closeButton>
                <Modal.Title> Êtes-vous sûr de vouloir supprimer la revue d'article sélectionnée ? </Modal.Title>
            </Modal.Header>
            <Modal.Body>
                <ReviewArticleElement targetReviewArticle={targetReviewArticle}/>
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


export default ReviewArticleDelete;

