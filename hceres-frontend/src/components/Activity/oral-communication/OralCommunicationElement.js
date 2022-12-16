import {ListGroup} from "react-bootstrap";

const OralCommunicationElement = (props) =>
    props.targetOralCommunication && props.targetOralCommunication.oralCommunication ? <ListGroup horizontal={props.horizontal}>
        <ListGroup.Item variant={"primary"}>ID : {props.targetOralCommunication.idActivity}</ListGroup.Item>
        <ListGroup.Item>Titre : {props.targetOralCommunication.oralCommunication.oralCommunicationTitle}</ListGroup.Item>
        <ListGroup.Item>Auteurs : {props.targetOralCommunication.oralCommunication.authors}</ListGroup.Item>
        <ListGroup.Item>Date : {props.targetOralCommunication.oralCommunication.oralCommunicationDat}</ListGroup.Item>
        <ListGroup.Item>Identifiant de la réunion : {props.targetOralCommunication.oralCommunication.meetingId.meetingId}</ListGroup.Item>
        <ListGroup.Item>Nom de la réunion : {props.targetOralCommunication.oralCommunication.meetingId.meetingName}</ListGroup.Item>
        <ListGroup.Item>Année de réunion : {props.targetOralCommunication.oralCommunication.meetingId.meetingYear}</ListGroup.Item>
        <ListGroup.Item>Lieu de réunion : {props.targetOralCommunication.oralCommunication.meetingId.meetingLocation}</ListGroup.Item>
        <ListGroup.Item>Date de début de la réunion : {props.targetOralCommunication.oralCommunication.meetingId.meetingStart}</ListGroup.Item>
        <ListGroup.Item>Date de fin de réunion : {props.targetOralCommunication.oralCommunication.meetingId.meetingEnd}</ListGroup.Item>
    </ListGroup> : "Target oralCommunication is not send as props!"


export default OralCommunicationElement