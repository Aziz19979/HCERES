package org.centrale.hceres.service;

import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

import javax.transaction.Transactional;

import org.centrale.hceres.items.BelongsTeam;
import org.centrale.hceres.items.Researcher;
import org.centrale.hceres.repository.BelongsTeamRepository;
import org.centrale.hceres.repository.ResearchRepository;
import org.centrale.hceres.util.RequestParseException;
import org.centrale.hceres.util.RequestParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;

import lombok.Data;

// permet de traiter la requete HTTP puis l'associer a la fonction de repository qui va donner une reponse
@Data
@Service
public class ResearchService {

    /**
     * Instanciation de ResearchRepository
     */
    @Autowired
    private ResearchRepository researchRepo;

    /**
     * Instanciation de ResearchRepository
     */
    @Autowired
    private BelongsTeamRepository belongsTeamRepo;

    /**
     * permet d'avoir la liste des chercheurs
     */
    public List<Researcher> getResearchers() {
        return researchRepo.findAll();
    }

    /**
     * supprimer l'elmt selon son id
     *
     * @param id : id de l'elmt
     */
    public void deleteResearcher(final Integer id) {
        researchRepo.deleteById(id);
    }

    /**
     * permet d'ajouter un elmt
     *
     * @return : l'elemt ajouter a la base de donnees
     */
    @Transactional
    public Researcher saveResearcher(@RequestBody Map<String, Object> request) throws RequestParseException {

        Researcher researcherTosave = new Researcher();
        fillResearcherFromRequest(researcherTosave, request);

        // Enregistrer researcher dans la base de données et flush pour avoir son id
        Researcher saveResearcher = researchRepo.saveAndFlush(researcherTosave);
        Integer researcherId = saveResearcher.getResearcherId();

        // Get teams ids :
        fillResearcherBelongsTeamFromRequest(researcherTosave, researcherId, request);

        saveResearcher = researchRepo.save(researcherTosave);
        return saveResearcher;
    }

    public Researcher updateResearcher(Integer researcherId, Map<String, Object> request) throws RequestParseException {
        Optional<Researcher> e = researchRepo.findById(researcherId);
        if (e.isPresent()) {
            Researcher currentResearcher = e.get();
            // Get researcher fields :
            fillResearcherFromRequest(currentResearcher, request);
            // Get teams ids :
            // temporally solutions delete all previous teams relations
            belongsTeamRepo.deleteAllInBatch(currentResearcher.getBelongsTeamList());
            fillResearcherBelongsTeamFromRequest(currentResearcher, researcherId, request);

            researchRepo.save(currentResearcher);
            return currentResearcher;
        } else {
            throw new RequestParseException("Researcher with id " + researcherId + "not found");
        }
    }

    private void fillResearcherFromRequest(Researcher researcher, Map<String, Object> request) throws RequestParseException {
        researcher.setResearcherSurname(RequestParser.getAsString(request.get("researcherSurname")));
        researcher.setResearcherName(RequestParser.getAsString(request.get("researcherName")));
        researcher.setResearcherEmail(RequestParser.getAsString(request.get("researcherEmail")));
    }


    /**
     * Get teams ids from request and fill researcher belongsTeam list
     * This is a temporal solution to define teams for a researcher,
     * it will be replaced by a separate form to define belongsTeam fields
     *
     * @param researcher   : researcher to fill
     * @param researcherId : researcher id
     * @param request      : request
     */
    private void fillResearcherBelongsTeamFromRequest(Researcher researcher, Integer researcherId, Map<String, Object> request) {
        researcher.setBelongsTeamList(RequestParser.getAsList(
                        request.get("teamIds")).stream()
                .map(teamId -> new BelongsTeam(researcherId, (Integer) teamId))
                .collect(Collectors.toList()));
    }
}
