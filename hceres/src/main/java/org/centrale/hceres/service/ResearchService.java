package org.centrale.hceres.service;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.transaction.Transactional;

import org.centrale.hceres.items.Researcher;
import org.centrale.hceres.repository.ResearchRepository;
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
     * permet d'avoir la liste des chercheurs
     */
    public List<Researcher> getResearchers() {
        return researchRepo.findAll();
    }

    /**
     * permet d'avoir la liste des chercheurs
     */
    public Optional<Researcher> getResearcher(final Integer id) {
        return researchRepo.findById(id);
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
    public Researcher saveResearcher(@RequestBody Map<String, Object> request) {

        Researcher researcherTosave = new Researcher();

        // researcherSurname :
        researcherTosave.setResearcherSurname(RequestParser.getAsString(request.get("researcherSurname")));

        // researcherName :
        researcherTosave.setResearcherName(RequestParser.getAsString(request.get("researcherName")));

        // researcherEmail :
        researcherTosave.setResearcherEmail(RequestParser.getAsString(request.get("researcherEmail")));

        // Enregistrer Education dans la base de données :
        Researcher saveResearcher = researchRepo.save(researcherTosave);

        return saveResearcher;
    }
}
