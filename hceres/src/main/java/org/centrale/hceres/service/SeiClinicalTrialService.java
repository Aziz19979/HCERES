package org.centrale.hceres.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Date;
import java.util.Map;
import java.util.Optional;

import org.centrale.hceres.items.Activity;
import org.centrale.hceres.items.SeiClinicalTrial;
import org.centrale.hceres.items.Researcher;
import org.centrale.hceres.items.TypeActivity;
import org.centrale.hceres.repository.ActivityRepository;
import org.centrale.hceres.repository.SeiClinicalTrialRepository;
import org.centrale.hceres.repository.ResearchRepository;
import org.centrale.hceres.repository.TypeActivityRepository;
import org.centrale.hceres.util.RequestParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;

import lombok.Data;

// permet de traiter la requete HTTP puis l'associer a la fonction de repository qui va donner une reponse
@Data
@Service
public class SeiClinicalTrialService {

    /**
     * Instanciation
     */
    @Autowired
    private ResearchRepository researchRepo;
    @Autowired
    private SeiClinicalTrialRepository seiClinicalTrialRepo;
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
    public Optional<SeiClinicalTrial> getSeiClinicalTrial(final Integer id) {
        return seiClinicalTrialRepo.findById(id);
    }

    /**
     * permet de retourner la liste
     */
    public List<Activity> getSeiClinicalTrials() {
        return activityRepo.findByIdTypeActivity(TypeActivity.IdTypeActivity.SEI_CLINICAL_TRIAL.getId());
    }

    /**
     * supprimer l'elmt selon son id
     *
     * @param id : id de l'elmt
     */
    public void deleteSeiClinicalTrial(final Integer id) {
        seiClinicalTrialRepo.deleteById(id);
    }

    /**
     * permet d'ajouter un elmt
     *
     * @return : l'elemt ajouter a la base de donnees
     */
    public Activity saveSeiClinicalTrial(@RequestBody Map<String, Object> request) throws ParseException {

        SeiClinicalTrial SeiClinicalTrialTosave = new SeiClinicalTrial();


        // setStartDate :
        SeiClinicalTrialTosave.setStartDate(RequestParser.getAsDate(request.get("startDate")));

        // setEndDate :
        SeiClinicalTrialTosave.setEndDate(RequestParser.getAsDate(request.get("endDate")));

        // setCoordinatorPartner :
        SeiClinicalTrialTosave.setCoordinatorPartner(RequestParser.getAsBoolean(request.get("coordinatorPartner")));

        // setTitleClinicalTrial :
        SeiClinicalTrialTosave.setTitleClinicalTrial(RequestParser.getAsString(request.get("titleClinicalTrial")));

        // setRegistrationNb :
        SeiClinicalTrialTosave.setRegistrationNb(RequestParser.getAsString(request.get("registrationNb")));

        // setSponsorName :
        SeiClinicalTrialTosave.setSponsorName(RequestParser.getAsString(request.get("sponsorName")));

        // setIncludedPatientsNb :
        SeiClinicalTrialTosave.setIncludedPatientsNb(RequestParser.getAsInteger(request.get("includedPatientsNb")));

        // setFunding :
        SeiClinicalTrialTosave.setFunding(RequestParser.getAsString(request.get("funding")));

        // setFundingAmount :
        SeiClinicalTrialTosave.setFundingAmount(RequestParser.getAsInteger(request.get("fundingAmount")));

        // Activity :
        Activity activity = new Activity();
        TypeActivity typeActivity = typeActivityLevelRepo.getById(TypeActivity.IdTypeActivity.SEI_CLINICAL_TRIAL.getId());
        activity.setTypeActivity(typeActivity);


        // get list of researcher doing this activity - currently only one is sent
        Integer researcherId = RequestParser.getAsInteger(request.get("researcherId"));
        Optional<Researcher> researcherOp = researchRepo.findById(researcherId);
        Researcher researcher = researcherOp.get();

        List<Researcher> activityResearch = new ArrayList<>();
        activityResearch.add(researcher);
        activity.setResearcherList(activityResearch);

        Activity savedActivity = activityRepo.save(activity);
        SeiClinicalTrialTosave.setActivity(savedActivity);

        // Id de l'SeiClinicalTrial :
        Integer idSeiClinicalTrial = activity.getIdActivity();
        SeiClinicalTrialTosave.setIdActivity(idSeiClinicalTrial);

        // Enregistrer SeiClinicalTrial dans la base de données :
        SeiClinicalTrial saveSeiClinicalTrial = seiClinicalTrialRepo.save(SeiClinicalTrialTosave);

        // wrap all objects in activity
        savedActivity.setSeiClinicalTrial(saveSeiClinicalTrial);
        return activity;
    }

}
