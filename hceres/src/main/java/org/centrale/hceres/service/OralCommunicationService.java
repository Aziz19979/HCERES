package org.centrale.hceres.service;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

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
import org.centrale.hceres.util.RequestParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Data;

import javax.transaction.Transactional;

import org.springframework.web.bind.annotation.RequestBody;

import java.util.Map;

@Data
@Service
public class OralCommunicationService {

    /**
     * Instanciation
     */
    @Autowired
    private ResearchRepository researchRepo;

    @Autowired
    private OralCommunicationRepository oralCommunicationRepo;

    @Autowired
    private TypeOralCommunicationRepository typeOralCommunicationRepo;

    @Autowired
    private MeetingRepository meetingRepo;

    @Autowired
    private TypeActivityRepository typeActivityLevelRepo;

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
    public Activity saveOralCommunication(@RequestBody Map<String, Object> request) throws ParseException {

        OralCommunication oralCommunicationTosave = new OralCommunication();

        // OralCommunicationTitle :
        oralCommunicationTosave.setOralCommunicationTitle(RequestParser.getAsString(request.get("OralCommunicationTitle")));

        // OralCommunicationDat :
        oralCommunicationTosave.setOralCommunicationDat(RequestParser.getAsDate(request.get("OralCommunicationDate")));

        // Authors :
        oralCommunicationTosave.setAuthors(RequestParser.getAsString(request.get("Authors")));

        // Activity :
        Activity activity = new Activity();
        TypeActivity typeActivity = typeActivityLevelRepo.getById(TypeActivity.IdTypeActivity.ORAL_COMMUNICATION_POSTER.getId());
        activity.setTypeActivity(typeActivity);

        // Meeting
        Meeting meeting = new Meeting();
        meeting.setMeetingName(RequestParser.getAsString(request.get("MeetingName")));
        meeting.setMeetingYear(RequestParser.getAsInteger(request.get("MeetingYear")));
        meeting.setMeetingLocation(RequestParser.getAsString(request.get("MeetingLocation")));
        meeting.setMeetingStart(RequestParser.getAsDate(request.get("MeetingStart")));
        meeting.setMeetingEnd(RequestParser.getAsDate(request.get("MeetingEnd")));

        Meeting savedMeeting = meetingRepo.save(meeting);
        oralCommunicationTosave.setMeetingId(savedMeeting);


        // TypeOralCommunication :
        TypeOralCommunication typeOralCommunication = new TypeOralCommunication();
        typeOralCommunication.setTypeOralCommunicationName(RequestParser.getAsString(request.get("TypeOralCommunicationName")));
        TypeOralCommunication savetypeOralCommunication = typeOralCommunicationRepo.save(typeOralCommunication);
        oralCommunicationTosave.setTypeOralCommunicationId(savetypeOralCommunication);


        // get list of researcher doing this activity - currently only one is sent
        Integer researcherId = RequestParser.getAsInteger(request.get("researcherId"));
        Optional<Researcher> researcherOp = researchRepo.findById(researcherId);
        Researcher researcher = researcherOp.get();

        List<Researcher> activityResearch = new ArrayList<>();
        activityResearch.add(researcher);
        activity.setResearcherList(activityResearch);

        Activity savedActivity = activityRepo.save(activity);
        oralCommunicationTosave.setActivity(savedActivity);


        // Id :
        Integer idOralCommunicationTosave = activity.getIdActivity();
        oralCommunicationTosave.setIdActivity(idOralCommunicationTosave);

        // Enregistrer dans la base de données :
        OralCommunication saveOralCommunication = oralCommunicationRepo.save(oralCommunicationTosave);

        savedActivity.setOralCommunication(saveOralCommunication);
        return savedActivity;
    }


}
