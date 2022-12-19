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
import org.centrale.hceres.items.IncomingMobility;
import org.centrale.hceres.items.Researcher;
import org.centrale.hceres.items.TypeActivity;
import org.centrale.hceres.repository.ActivityRepository;
import org.centrale.hceres.repository.IncomingMobilityRepository;
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
public class IncomingMobilityService {

    /**
     * Instanciation
     */
    @Autowired
    private ResearchRepository researchRepo;
    @Autowired
    private IncomingMobilityRepository incomingMobilityRepo;
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
    public Optional<IncomingMobility> getIncomingMobility(final Integer id) {
        return incomingMobilityRepo.findById(id);
    }


    /**
     * permet de retourner la liste
     */
    public List<Activity> getIncomingMobilities() {
        return activityRepo.findByIdTypeActivity(TypeActivity.IdTypeActivity.INCOMING_MOBILITY.getId());
    }

    /**
     * supprimer l'elmt selon son id
     *
     * @param id : id de l'elmt
     */
    public void deleteIncomingMobility(final Integer id) {
        incomingMobilityRepo.deleteById(id);
    }

    /**
     * permet d'ajouter un elmt
     *
     * @return : l'elemt ajouter a la base de donnees
     */
    public Activity saveIncomingMobility(@RequestBody Map<String, Object> request) throws ParseException {
        IncomingMobility IncomingMobilityTosave = new IncomingMobility();

        // setNameSeniorScientist :
        IncomingMobilityTosave.setNameSeniorScientist(RequestParser.getAsString(request.get("nameSeniorScientist")));

        // setArrivalDate :
        IncomingMobilityTosave.setArrivalDate(RequestParser.getAsDate(request.get("arrivalDate")));

        // setArrivalDate :
        IncomingMobilityTosave.setDepartureDate(RequestParser.getAsDate(request.get("departureDate")));

        // setDuration :
        IncomingMobilityTosave.setDuration(RequestParser.getAsInteger(request.get("duration")));

        // setNationality :
        IncomingMobilityTosave.setNationality(RequestParser.getAsString(request.get("nationality")));

        // setOriginalLabName :
        IncomingMobilityTosave.setOriginalLabName(RequestParser.getAsString(request.get("originalLabName")));

        // setOriginaLabLocation :
        IncomingMobilityTosave.setOriginaLabLocation(RequestParser.getAsString(request.get("originaLabLocation")));

        // setPiPartner :
        IncomingMobilityTosave.setPiPartner(RequestParser.getAsString(request.get("piPartner")));

        // setProjectTitle :
        IncomingMobilityTosave.setProjectTitle(RequestParser.getAsString(request.get("projectTitle")));

        // setAssociatedFunding :
        IncomingMobilityTosave.setAssociatedFunding(RequestParser.getAsString(request.get("associatedFunding")));

        // setPublicationReference :
        IncomingMobilityTosave.setPublicationReference(RequestParser.getAsString(request.get("publicationReference")));

        // setStrategicRecurringCollab :
        IncomingMobilityTosave.setStrategicRecurringCollab(RequestParser.getAsBoolean(request.get("strategicRecurringCollab")));

        // setActiveProject :
        IncomingMobilityTosave.setActiveProject(RequestParser.getAsBoolean(request.get("activeProject")));

        // setUmrCoordinated :
        IncomingMobilityTosave.setUmrCoordinated(RequestParser.getAsBoolean(request.get("umrCoordinated")));

        // setAgreementSigned :
        IncomingMobilityTosave.setAgreementSigned(RequestParser.getAsBoolean(request.get("agreementSigned")));

        // Activity :
        Activity activity = new Activity();
        TypeActivity typeActivity = typeActivityLevelRepo.getById(TypeActivity.IdTypeActivity.INCOMING_MOBILITY.getId());
        activity.setTypeActivity(typeActivity);


        // get list of researcher doing this activity - currently only one is sent
        Integer researcherId = RequestParser.getAsInteger(request.get("researcherId"));
        Optional<Researcher> researcherOp = researchRepo.findById(researcherId);
        Researcher researcher = researcherOp.get();

        List<Researcher> activityResearch = new ArrayList<>();
        activityResearch.add(researcher);
        activity.setResearcherList(activityResearch);

        Activity savedActivity = activityRepo.save(activity);
        IncomingMobilityTosave.setActivity(savedActivity);

        // Id de l'IncomingMobility :
        Integer idIncomingMobility = activity.getIdActivity();
        IncomingMobilityTosave.setIdActivity(idIncomingMobility);

        // Enregistrer IncomingMobility dans la base de données :
        IncomingMobility saveIncomingMobility = incomingMobilityRepo.save(IncomingMobilityTosave);

        // wrap all saved objects in activity
        savedActivity.setIncomingMobility(saveIncomingMobility);
        return savedActivity;
    }


}

