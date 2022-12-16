package org.centrale.hceres.service;

import org.centrale.hceres.items.*;
import org.centrale.hceres.repository.*;
import org.centrale.hceres.repository.PostDocRepository;

import org.centrale.hceres.util.RequestParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class PostDocService {

    /**
     * Instanciation
     */
    @Autowired
    private ResearchRepository researchRepo;
    @Autowired
    private PostDocRepository postDocRepository;
    @Autowired
    private ActivityRepository activityRepo;
    @Autowired
    private TypeActivityRepository typeActivityLevelRepo;

    public Optional<PostDoc> getPostDoc(final Integer id) {
        return postDocRepository.findById(id);
    }


    /**
     * permet de retourner la liste
     */
    public List<Activity> getPostDocs() {
        return activityRepo.findByIdTypeActivity(TypeActivity.IdTypeActivity.POST_DOC.getId());
    }

    /**
     * supprimer l'elmt selon son id
     *
     * @param id : id de l'elmt
     */
    public void deletePostDoc(final Integer id) {
        postDocRepository.deleteById(id);
    }

    public Activity savePostDoc(@RequestBody Map<String, Object> request) throws ParseException {
        PostDoc postDocToSave = new PostDoc();

        // PostDocName :
        postDocToSave.setNamePostDoc(RequestParser.getAsString(request.get("postDocName")));

        // Supervisor Name
        postDocToSave.setNameSupervisor(RequestParser.getAsString(request.get("supervisorName")));

        // Arrival Date :
        postDocToSave.setArrivalDate(RequestParser.getAsDate(request.get("arrivalDate")));

        // Departure Date :
        postDocToSave.setDepartureDate(RequestParser.getAsDate(request.get("departureDate")));

        // Duration:
        postDocToSave.setDuration(RequestParser.getAsInteger(request.get("duration")));

        // Nationality:
        postDocToSave.setNationality(RequestParser.getAsString(request.get("nationality")));

        // Original Lab:
        postDocToSave.setOriginalLab(RequestParser.getAsString(request.get("originalLab")));

        // Associated Funding:
        postDocToSave.setAssociatedFunding(RequestParser.getAsString(request.get("associatedFunding")));

        // Associated Publication Ref:
        postDocToSave.setAssociatedPubliRef(RequestParser.getAsString(request.get("associatedPubliRef")));

        // Activity :
        Activity activity = new Activity();
        TypeActivity typeActivity = typeActivityLevelRepo.getById(TypeActivity.IdTypeActivity.POST_DOC.getId());
        activity.setTypeActivity(typeActivity);


        // get list of researcher doing this activity - currently only one is sent
        Integer researcherId = RequestParser.getAsInteger(request.get("researcherId"));
        Optional<Researcher> researcherOp = researchRepo.findById(researcherId);
        Researcher researcher = researcherOp.get();

        List<Researcher> activityResearch = new ArrayList<>();
        activityResearch.add(researcher);
        activity.setResearcherList(activityResearch);

        Activity savedActivity = activityRepo.save(activity);
        postDocToSave.setActivity(savedActivity);


        // Added PostDoc Id :
        Integer idPostDoc = activity.getIdActivity();
        postDocToSave.setIdActivity(idPostDoc);


        // Persist PostDoc object to the data base :
        PostDoc savePostDoc = postDocRepository.save(postDocToSave);

        savedActivity.setPostDoc(savePostDoc);
        return savedActivity;
    }
}
