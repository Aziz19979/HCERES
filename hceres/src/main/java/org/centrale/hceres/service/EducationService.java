package org.centrale.hceres.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Date;
import java.util.Optional;


import org.centrale.hceres.items.Activity;
import org.centrale.hceres.items.Education;
import org.centrale.hceres.items.EducationInvolvment;
import org.centrale.hceres.items.EducationLevel;
import org.centrale.hceres.items.Researcher;
import org.centrale.hceres.items.TypeActivity;
import org.centrale.hceres.repository.ActivityRepository;
import org.centrale.hceres.repository.EducationInvolvmentRespository;
import org.centrale.hceres.repository.EducationLevelRepository;
import org.centrale.hceres.repository.EducationRepository;
import org.centrale.hceres.repository.ResearchRepository;
import org.centrale.hceres.repository.TypeActivityRepository;
import org.centrale.hceres.util.RequestParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import lombok.Data;

import javax.transaction.Transactional;

import org.springframework.web.bind.annotation.RequestBody;

import java.util.Map;

// permet de traiter la requete HTTP puis l'associer a la fonction de repository qui va donner une reponse
@Data
@Service
public class EducationService {

    /**
     * Instanciation
     */
    @Autowired
    private ResearchRepository researchRepo;
    @Autowired
    private EducationRepository educationRepo;
    @Autowired
    private EducationInvolvmentRespository educationInvolvmentRepo;
    @Autowired
    private EducationLevelRepository educationLevelRepo;
    @Autowired
    private ActivityRepository activityRepo;
    @Autowired
    private TypeActivityRepository typeActivityLevelRepo;

    /**
     * retourner l'elmt selon son id
     *
     * @param id : id de l'elmt
     * @return : elmt a retourner
     */
    public Optional<Education> getEducation(final Integer id) {
        return educationRepo.findById(id);
    }

    /**
     * permet de retourner la liste
     */
    public List<Activity> getEducations() {
        return activityRepo.findByIdTypeActivity(TypeActivity.IdTypeActivity.EDUCATIONAL_OUTPUT.getId());
    }

    /**
     * supprimer l'elmt selon son id
     *
     * @param id : id de l'elmt
     */
    public void deleteEducation(final Integer id) {
        educationRepo.deleteById(id);
    }

    /**
     * permet d'ajouter un elmt
     *
     * @return : l'elemt ajouter a la base de donnees
     */
    @Transactional
    public Activity saveEducation(@RequestBody Map<String, Object> request) throws ParseException {

        Education educationTosave = new Education();

        // EducationCourseName :
        educationTosave.setEducationCourseName(RequestParser.getAsString(request.get("educationCourseName")));

        // EducationCompletion :
        educationTosave.setEducationCompletion(RequestParser.getAsDate(request.get("educationCompletion")));

        // EducationDescription :
        educationTosave.setEducationDescription(RequestParser.getAsString(request.get("educationDescription")));

        // EducationFormation :
        educationTosave.setEducationFormation(RequestParser.getAsString(request.get("educationFormation")));


        // EducationInvolvment
        EducationInvolvment educationInvolvment = new EducationInvolvment();
        educationInvolvment.setEducationInvolvmentName(RequestParser.getAsString(request.get("educationInvolvmentText")));
        EducationInvolvment savedEducationInvolvment = educationInvolvmentRepo.save(educationInvolvment);
        educationTosave.setEducationInvolvmentId(savedEducationInvolvment);


        // EducationLevel :
        EducationLevel educationLevel = new EducationLevel();
        educationLevel.setEducationLevelName(RequestParser.getAsString(request.get("educationLevelText")));
        EducationLevel saveEducationLevel = educationLevelRepo.save(educationLevel);
        educationTosave.setEducationLevelId(saveEducationLevel);

        // Activity :
        Activity activity = new Activity();
        TypeActivity typeActivity = typeActivityLevelRepo.getById(TypeActivity.IdTypeActivity.EDUCATIONAL_OUTPUT.getId());
        activity.setTypeActivity(typeActivity);


        // get list of researcher doing this activity - currently only one is sent
        Integer researcherId = RequestParser.getAsInteger(request.get("researcherId"));
        Optional<Researcher> researcherOp = researchRepo.findById(researcherId);
        Researcher researcher = researcherOp.get();

        List<Researcher> activityResearch = new ArrayList<>();
        activityResearch.add(researcher);
        activity.setResearcherList(activityResearch);

        Activity savedActivity = activityRepo.save(activity);
        educationTosave.setActivity(savedActivity);


        // Id de l'education :
        Integer idEducation = activity.getIdActivity();
        educationTosave.setIdActivity(idEducation);

        // Enregistrer Education dans la base de données :
        Education saveEducation = educationRepo.save(educationTosave);

        // wrapping all elements in activity
        savedActivity.setEducation(saveEducation);
        return savedActivity;
    }
}












