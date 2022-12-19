package org.centrale.hceres.service;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.centrale.hceres.items.Activity;
import org.centrale.hceres.items.InternationalCollaboration;
import org.centrale.hceres.items.Researcher;
import org.centrale.hceres.items.TypeActivity;
import org.centrale.hceres.items.TypeCollab;
import org.centrale.hceres.repository.ActivityRepository;
import org.centrale.hceres.repository.InternationalCollaborationRepository;
import org.centrale.hceres.repository.ResearchRepository;
import org.centrale.hceres.repository.TypeActivityRepository;
import org.centrale.hceres.repository.TypeCollabRepository;
import org.centrale.hceres.util.RequestParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Data;

import javax.transaction.Transactional;

import org.springframework.web.bind.annotation.RequestBody;

import java.util.Map;

@Data
@Service
public class InternationalCollaborationService {

    /**
     * Instanciation
     */
    @Autowired
    private ResearchRepository researchRepo;

    @Autowired
    private ActivityRepository activityRepo;

    @Autowired
    private TypeActivityRepository typeActivityLevelRepo;

    @Autowired
    private InternationalCollaborationRepository internationalCollaborationRepo;

    @Autowired
    private TypeCollabRepository typeCollabRepo;

    /**
     * permet de retourner la liste
     */
    public List<Activity> getInternationalCollaborations() {
        return activityRepo.findByIdTypeActivity(TypeActivity.IdTypeActivity.NATIONAL_INTERNATIONAL_COLLABORATION.getId());
    }

    /**
     * supprimer l'elmt selon son id
     *
     * @param id : id de l'elmt
     */
    public void deleteInternationalCollaboration(final Integer id) {
        internationalCollaborationRepo.deleteById(id);
    }

    /**
     * permet d'ajouter un elmt
     *
     * @return : l'elemt ajouter a la base de donnees
     */
    @Transactional
    public Activity saveInternationalCollaboration(@RequestBody Map<String, Object> request) throws ParseException {

        InternationalCollaboration InternationalCollaborationTosave = new InternationalCollaboration();

        // DateProjectStart :
        InternationalCollaborationTosave.setDateProjectStart(RequestParser.getAsDate(request.get("DateProjectStart")));

        // PartnerEntity :
        InternationalCollaborationTosave.setPartnerEntity(RequestParser.getAsString(request.get("PartnerEntity")));

        // CountryStateCity :
        InternationalCollaborationTosave.setCountryStateCity(RequestParser.getAsString(request.get("CountryStateCity")));

        // setPiPartners :
        InternationalCollaborationTosave.setPiPartners(RequestParser.getAsString(request.get("PiPartners")));

        // MailPartners
        InternationalCollaborationTosave.setMailPartners(RequestParser.getAsString(request.get("MailPartners")));

        // setProjectTitle
        InternationalCollaborationTosave.setProjectTitle(RequestParser.getAsString(request.get("ProjectTitle")));

        // StrategicRecurringCollab : probleme => boolean n'est pas de type bit
        InternationalCollaborationTosave.setStrategicRecurringCollab(Boolean.valueOf(RequestParser.getAsString(request.get("StrategicRecurringCollab"))));

        // ActiveProject
        InternationalCollaborationTosave.setActiveProject(Boolean.valueOf(RequestParser.getAsString(request.get("ActiveProject"))));

        // AssociatedFunding
        InternationalCollaborationTosave.setAssociatedFunding(RequestParser.getAsString(request.get("AssociatedFunding")));

        // NumberResultingPublications
        InternationalCollaborationTosave.setNumberResultingPublications(RequestParser.getAsInteger(request.get("NumberResultingPublications")));

        // RefJointPublication
        InternationalCollaborationTosave.setRefJointPublication(RequestParser.getAsString(request.get("RefJointPublication")));

        // UmrCoordinated
        InternationalCollaborationTosave.setUmrCoordinated(Boolean.valueOf(RequestParser.getAsString(request.get("UmrCoordinated"))));


        // AgreementSigned
        InternationalCollaborationTosave.setAgreementSigned(Boolean.valueOf(RequestParser.getAsString(request.get("AgreementSigned"))));


        // TypeCollab :
        TypeCollab typeCollab = new TypeCollab();
        typeCollab.setNameChoice(RequestParser.getAsString(request.get("NameChoice")));
        TypeCollab savedTypeCollab = typeCollabRepo.save(typeCollab);
        InternationalCollaborationTosave.setTypeCollabId(savedTypeCollab);

        // Activity :
        Activity activity = new Activity();
        TypeActivity typeActivity = typeActivityLevelRepo.getById(TypeActivity.IdTypeActivity.NATIONAL_INTERNATIONAL_COLLABORATION.getId());
        activity.setTypeActivity(typeActivity);


        // get list of researcher doing this activity - currently only one is sent
        Integer researcherId = RequestParser.getAsInteger(request.get("researcherId"));
        Optional<Researcher> researcherOp = researchRepo.findById(researcherId);
        Researcher researcher = researcherOp.get();

        List<Researcher> activityResearch = new ArrayList<>();
        activityResearch.add(researcher);
        activity.setResearcherList(activityResearch);

        Activity savedActivity = activityRepo.save(activity);
        InternationalCollaborationTosave.setActivity(savedActivity);


        // Id de l'internationalCollaboration :
        Integer idInternationalCollaboration = activity.getIdActivity();
        InternationalCollaborationTosave.setIdActivity(idInternationalCollaboration);

        // Enregistrer InternationalCollaboration dans la base de données :
        InternationalCollaboration InternationalCollaborationSaved = internationalCollaborationRepo.save(InternationalCollaborationTosave);

        savedActivity.setInternationalCollaboration(InternationalCollaborationSaved);
        return savedActivity;
    }

}
