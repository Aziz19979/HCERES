import {ListGroup} from "react-bootstrap";

const ContractElement = (props) =>
    props.targetContract && props.targetContract.contract ? <ListGroup horizontal={props.horizontal}>
        <ListGroup.Item variant={"primary"}>ID : {props.targetContract.idActivity}</ListGroup.Item>
        <ListGroup.Item>Départ : {props.targetContract.contract.startContract}</ListGroup.Item>
        <ListGroup.Item>Fin : {props.targetContract.contract.endContract}</ListGroup.Item>
        <ListGroup.Item>Fonction : {props.targetContract.contract.functionContract}</ListGroup.Item>
    </ListGroup> : "Target contract is not send as props!"


export default ContractElement