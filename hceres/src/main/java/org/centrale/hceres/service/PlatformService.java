package org.centrale.hceres.service;

import org.centrale.hceres.items.*;
import org.centrale.hceres.repository.*;
import org.centrale.hceres.util.RequestParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class PlatformService {

    @Autowired
    PlatformRepository platformRepository;
    @Autowired
    private ResearchRepository researchRepo;
    @Autowired
    private ActivityRepository activityRepo;
    @Autowired
    private TypeActivityRepository typeActivityLevelRepo;


    public List<Activity> getPlatforms() {
        return activityRepo.findByIdTypeActivity(TypeActivity.IdTypeActivity.PLATFORM.getId());
    }


    public Optional<Platform> getPlatform(final Integer id) {
        return platformRepository.findById(id);
    }


    public void deletePlatform(final Integer id) {
        platformRepository.deleteById(id);
    }

    public Activity savePlatform(@RequestBody Map<String, Object> request) throws ParseException {

        Platform platfomToSave = new Platform();

        // Creation Date
        platfomToSave.setCreationDate(RequestParser.getAsDate(request.get("creationDate")));

        // Description
        platfomToSave.setDescription(RequestParser.getAsString(request.get("description")));

        // Managers
        platfomToSave.setManagers(RequestParser.getAsString(request.get("managers")));

        // Affiliation
        platfomToSave.setAffiliation(RequestParser.getAsString(request.get("affiliation")));

        // Labellisation
        platfomToSave.setLabellisation(RequestParser.getAsString(request.get("labellisation")));

        // Open Private Researches
        platfomToSave.setOpenPrivateResearchers(RequestParser.getAsBoolean(request.get("openPrivateResearchers")));


        // Activity :
        Activity activity = new Activity();
        TypeActivity typeActivity = typeActivityLevelRepo.getById(TypeActivity.IdTypeActivity.PLATFORM.getId());
        activity.setTypeActivity(typeActivity);


        // get list of researcher doing this activity - currently only one is sent
        Integer researcherId = RequestParser.getAsInteger(request.get("researcherId"));
        Optional<Researcher> researcherOp = researchRepo.findById(researcherId);
        Researcher researcher = researcherOp.get();

        List<Researcher> activityResearch = new ArrayList<>();
        activityResearch.add(researcher);
        activity.setResearcherList(activityResearch);

        Activity savedActivity = activityRepo.save(activity);
        platfomToSave.setActivity(savedActivity);


        // Created platform id :
        Integer idPlatform = activity.getIdActivity();
        platfomToSave.setIdActivity(idPlatform);

        // Persist Platform to database :
        Platform savePlatform = platformRepository.save(platfomToSave);
        savedActivity.setPlatform(savePlatform);
        return savedActivity;
    }
}
