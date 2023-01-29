package org.centrale.hceres.service;

import java.text.ParseException;
import java.util.*;

import org.centrale.hceres.items.Activity;
import org.centrale.hceres.items.OralCommunication;
import org.centrale.hceres.items.Meeting;
import org.centrale.hceres.items.Researcher;
import org.centrale.hceres.items.TypeActivity;
import org.centrale.hceres.items.TypeOralCommunication;
import org.centrale.hceres.repository.ActivityRepository;
import org.centrale.hceres.repository.MeetingCongressOrgRepository;
import org.centrale.hceres.repository.MeetingRepository;
import org.centrale.hceres.repository.OralCommunicationRepository;
import org.centrale.hceres.repository.ResearchRepository;
import org.centrale.hceres.repository.TypeActivityRepository;
import org.centrale.hceres.repository.TypeOralCommunicationRepository;
import org.centrale.hceres.util.RequestParseException;
import org.centrale.hceres.util.RequestParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Data;

import javax.transaction.Transactional;

import org.springframework.web.bind.annotation.RequestBody;

@Data
@Service
public class OralCommunicationService {


    @Autowired
    private OralCommunicationRepository oralCommunicationRepo;

    @Autowired
    private TypeOralCommunicationRepository typeOralCommunicationRepo;

    @Autowired
    private MeetingRepository meetingRepo;

    @Autowired
    private ActivityRepository activityRepo;

    @Autowired
    private MeetingCongressOrgRepository meetingCongressOrgRepo;

    public List<Activity> getOralCommunications() {
        return activityRepo.findByIdTypeActivity(TypeActivity.IdTypeActivity.ORAL_COMMUNICATION_POSTER.getId());
    }

    public void deleteOralCommunication(Integer id) {
        oralCommunicationRepo.deleteById(id);
    }

    /**
     * permet d'ajouter un elmt
     *
     * @return : l'elemt ajouter a la base de donnees
     */
    @Transactional
    public Activity saveOralCommunication(@RequestBody Map<String, Object> request) throws RequestParseException {

        OralCommunication oralCommunication = new OralCommunication();

        // OralCommunicationTitle :
        oralCommunication.setOralCommunicationTitle(RequestParser.getAsString(request.get("OralCommunicationTitle")));

        // OralCommunicationDat :
        oralCommunication.setOralCommunicationDat(RequestParser.getAsDate(request.get("OralCommunicationDate")));

        // Authors :
        oralCommunication.setAuthors(RequestParser.getAsString(request.get("Authors")));

        // Meeting
        Meeting meeting = new Meeting();
        meeting.setMeetingName(RequestParser.getAsString(request.get("MeetingName")));
        meeting.setMeetingYear(RequestParser.getAsInteger(request.get("MeetingYear")));
        meeting.setMeetingLocation(RequestParser.getAsString(request.get("MeetingLocation")));
        meeting.setMeetingStart(RequestParser.getAsDate(request.get("MeetingStart")));
        meeting.setMeetingEnd(RequestParser.getAsDate(request.get("MeetingEnd")));
        oralCommunication.setMeetingId(meeting);


        // TypeOralCommunication :
        TypeOralCommunication typeOralCommunication = new TypeOralCommunication();
        typeOralCommunication.setTypeOralCommunicationName(RequestParser.getAsString(request.get("TypeOralCommunicationName")));
        oralCommunication.setTypeOralCommunicationId(typeOralCommunication);


        // Activity :
        Activity activity = new Activity();
        oralCommunication.setActivity(activity);
        activity.setOralCommunication(oralCommunication);
        activity.setIdTypeActivity(TypeActivity.IdTypeActivity.ORAL_COMMUNICATION_POSTER.getId());

        // get list of researcher doing this activity - currently only one is sent
        activity.setResearcherList(Collections.singletonList(new Researcher(RequestParser.getAsInteger(request.get("researcherId")))));

        activity = activityRepo.save(activity);
        return activity;
    }

}
