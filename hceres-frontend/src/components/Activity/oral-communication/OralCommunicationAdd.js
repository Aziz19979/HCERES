import React from 'react';
import Modal from "react-bootstrap/Modal";
import Button from "react-bootstrap/Button";
import ResearcherSelect from "../../util/ResearcherSelect";
import {addOralCommunication} from "../../../services/oral-communication/OralCommunicationActions";

// If targetResearcher is set in props use it as default without charging list from database
// else load list de chercheurs from database
function OralCommunicationAdd(props) {
    // parameter constant (Add Template)
    const targetResearcher = props.targetResearcher;
    const onHideParentAction = props.onHideAction

    // Cached state (Add Template)

    // UI states (Add Template)
    const [showModal, setShowModal] = React.useState(true);


    // Form state (Add Template)
    const [researcherId, setResearcherId] = React.useState(targetResearcher ? targetResearcher.researcherId : "");
    const [OralCommunicationTitle, setOralCommunicationTitle] = React.useState(null);
    const [OralCommunicationDate, setOralCommunicationDate] = React.useState("");
    const [Authors, setAuthors] = React.useState("");
    const [MeetingName, setMeetingName] = React.useState("");
    const [MeetingYear, setMeetingYear] = React.useState(null);
    const [MeetingLocation, setMeetingLocation] = React.useState("");
    const [MeetingStart, setMeetingStart] = React.useState("");
    const [MeetingEnd, setMeetingEnd] = React.useState("");
    const [TypeOralCommunicationName, setTypeOralCommunicationName] = React.useState("");


    const handleClose = (msg = null) => {
        setShowModal(false);
        onHideParentAction(msg);
    };


    const handleSubmit = (event) => {
        event.preventDefault();
        let data = {
            researcherId: researcherId,
            TypeOralCommunicationName: TypeOralCommunicationName,
            MeetingEnd: MeetingEnd,
            MeetingStart: MeetingStart,
            MeetingLocation: MeetingLocation,
            MeetingYear: MeetingYear,
            MeetingName: MeetingName,
            Authors: Authors,
            OralCommunicationDate: OralCommunicationDate,
            OralCommunicationTitle: OralCommunicationTitle
        };

        addOralCommunication(data).then(response => {
            // const activityId = response.data.researcherId;
            const msg = {
                "successMsg": "OralCommunication ajouté avec un id " + response.data.idActivity,
            }
            handleClose(msg);
        }).catch(error => {
            console.log(error);
            const msg = {
                "errorMsg": "Erreur OralCommunication non ajouté, response status: " + error.response.status,
            }
            handleClose(msg);
        })
    }

    return (
        <div>
            <Modal show={showModal} onHide={handleClose}>
                <form onSubmit={handleSubmit}>
                    <Modal.Header closeButton>
                        <Modal.Title>OralCommunication</Modal.Title>
                    </Modal.Header>
                    <Modal.Body>


                        <label className='label'>
                            Chercheur
                        </label>
                        <ResearcherSelect
                            targetResearcher={targetResearcher}
                            onchange={React.useCallback(resId => setResearcherId(resId),[])}
                        />

                        <label className='label'>
                            Oral Communication Title
                        </label>
                        <input
                            placeholder='OralCommunicationTitle'
                            className='input-container'
                            name="OralCommunicationTitle"
                            type="OralCommunicationTitle"
                            value={OralCommunicationTitle}
                            onChange={e => setOralCommunicationTitle(e.target.value)}
                            required/>

                        <label className='label'>
                            Oral Communication Date
                        </label>
                        <input
                            type="date"
                            className='input-container'
                            onChange={e => setOralCommunicationDate(e.target.value)}
                            required/>


                        <label className='label'>
                            Authors
                        </label>
                        <input
                            placeholder='Authors '
                            className='input-container'
                            name="Authors"
                            type="Authors"
                            value={Authors}
                            onChange={e => setAuthors(e.target.value)}
                            required/>

                        <label className='label'>
                            Meeting Name
                        </label>
                        <input
                            placeholder='MeetingName'
                            type="MeetingName"
                            className='input-container'
                            name="MeetingName"
                            value={MeetingName}
                            onChange={e => setMeetingName(e.target.value)}
                            required/>

                        <label className='label'>
                            Meeting Year
                        </label>
                        <input
                            type="number"
                            placeholder='MeetingYear'
                            className='input-container'
                            value={MeetingYear}
                            onChange={e => setMeetingYear(e.target.value)}
                            required/>

                        <label className='label'>
                            Meeting Location
                        </label>
                        <input
                            placeholder='MeetingLocation '
                            className='input-container'
                            name="MeetingLocation"
                            type="MeetingLocation"
                            value={MeetingLocation}
                            onChange={e => setMeetingLocation(e.target.value)}
                            required/>

                        <label className='label'>
                            Meeting Start
                        </label>
                        <input
                            type="date"
                            className='input-container'
                            onChange={e => setMeetingStart(e.target.value)}
                            required/>

                        <label className='label'>
                            Meeting End
                        </label>
                        <input
                            type="date"
                            className='input-container'
                            onChange={e => setMeetingEnd(e.target.value)}
                            required/>

                        <label className='label'>
                            Type Oral CommunicationName
                        </label>
                        <input
                            placeholder='TypeOralCommunicationName '
                            className='input-container'
                            name="TypeOralCommunicationName"
                            type="TypeOralCommunicationName"
                            value={TypeOralCommunicationName}
                            onChange={e => setTypeOralCommunicationName(e.target.value)}
                            required/>

                    </Modal.Body>
                    <Modal.Footer>
                        <Button variant="secondary" onClick={handleClose}>
                            Close
                        </Button>
                        <Button variant="outline-primary" type={"submit"}>
                            Ajouter
                        </Button>

                    </Modal.Footer>
                </form>
            </Modal>
        </div>
    );
}

export default OralCommunicationAdd;
