package org.centrale.hceres.service;

import lombok.Data;
import org.centrale.hceres.items.*;
import org.centrale.hceres.repository.ActivityRepository;
import org.centrale.hceres.repository.ResearcherRepository;
import org.centrale.hceres.repository.TypeActivityRepository;
import org.centrale.hceres.repository.PublicationRepository;
import org.centrale.hceres.repository.PublicationTypeRepository;
import org.centrale.hceres.util.RequestParseException;
import org.centrale.hceres.util.RequestParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;


import javax.transaction.Transactional;
import java.math.BigDecimal;
import java.util.*;

@Data
@Service
public class PublicationService {

    /**
     * Instanciation
     */

    @Autowired
    private PublicationRepository publicationrepo;
    @Autowired
    private PublicationTypeRepository publicationTypeRepo;
    @Autowired
    private ResearcherRepository researchRepo;
    @Autowired
    private ActivityRepository activityRepo;
    @Autowired
    private TypeActivityRepository typeActivityLevelRepo;

    /**
     * Retourner la liste des publications
     */
    public Iterable<Publication> getPublications() {
        return publicationrepo.findAll();
    }

    /**
     * retourner l'elmt selon son id
     *
     * @param id : id de l'elmt
     * @return : elmt a retourner
     */
    public Optional<Publication> getPublication(final Integer id) {
        return publicationrepo.findById(id);
    }

    /**
     * permet d'ajouter un elmt
     *
     * @return : l'elemt ajouter a la base de donnees
     */
    @Transactional
    public Publication savePublication(@RequestBody Map<String, Object> request) throws RequestParseException {

        Publication publicationTosave = new Publication();

        //Publication title
        publicationTosave.setTitle(RequestParser.getAsString(request.get("title")));

        //Publication authors
        publicationTosave.setAuthors(RequestParser.getAsString(request.get("authors")));

        //Publication source
        publicationTosave.setSource(RequestParser.getAsString(request.get("source")));

        //Publication date
        publicationTosave.setPublicationDate(RequestParser.getAsDate(request.get("publicationDate")));

        //Publication pmid
        publicationTosave.setPmid(RequestParser.getAsString(request.get("pmid")));

        //Publication impact_factor
        String inputString = RequestParser.getAsString(request.get("impactFactor"));
        BigDecimal result = new BigDecimal(inputString);
        publicationTosave.setImpactFactor((result));

        //Publication type
        PublicationType publicationType = new PublicationType();
        publicationType.setPublicationTypeName(RequestParser.getAsString(request.get("publicationTypeName")));
        PublicationType savePublicationType = publicationTypeRepo.save(publicationType);
        publicationTosave.setPublicationType(savePublicationType);

        // Activity :
        Activity activity = new Activity();
        TypeActivity typeActivity = typeActivityLevelRepo.getById(1);
        activity.setTypeActivity(typeActivity);


        // get list of researcher doing this activity - currently only one is sent
        Integer researcherId = RequestParser.getAsInteger(request.get("researcherId"));
        Optional<Researcher> researcherOp = researchRepo.findById(researcherId);
        Researcher researcher = researcherOp.get();

        List<Researcher> activityResearch = new ArrayList<>();
        activityResearch.add(researcher);
        activity.setResearcherList(activityResearch);

        Activity savedActivity = activityRepo.save(activity);
        publicationTosave.setActivity(savedActivity);

        // Created publication id :
        Integer idPublication = activity.getIdActivity();
        publicationTosave.setIdActivity(idPublication);

        // Persist publication to database :
        Publication savePublication = publicationrepo.save(publicationTosave);

        return savePublication;

    }
}

