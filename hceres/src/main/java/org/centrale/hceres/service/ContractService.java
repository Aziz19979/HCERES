package org.centrale.hceres.service;

import lombok.Data;
import org.centrale.hceres.items.*;
import org.centrale.hceres.repository.ActivityRepository;
import org.centrale.hceres.repository.ContractRepository;
import org.centrale.hceres.util.RequestParseException;
import org.centrale.hceres.util.RequestParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;

import javax.transaction.Transactional;
import java.util.Collections;
import java.util.List;
import java.util.Map;

@Data
@Service
public class ContractService {

    @Autowired
    private ContractRepository contraRepo;

    @Autowired
    private ActivityRepository activityRepo;

    /**
     * permet de retourner la liste
     */
    public List<Activity> getContracts() {
        return activityRepo.findByIdTypeActivity(TypeActivity.IdTypeActivity.CONTRACT.getId());
    }

    /**
     * supprimer l'elmt selon son id
     *
     * @param id : id de l'elmt
     */
    public void deleteContract(final Integer id) {
        contraRepo.deleteById(id);
    }

    /**
     * permet d'ajouter un elmt
     *
     * @return : l'elemt ajouté a la base de donnees
     */
    @Transactional
    public Activity saveContract(@RequestBody Map<String, Object> request) throws RequestParseException {

        Contract contract = new Contract();

        // StartContract :
        contract.setStartContract(RequestParser.getAsDate(request.get("startContract")));

        // EndContract :
        contract.setEndContract(RequestParser.getAsDate(request.get("endContract")));

        // FunctionContract :
        contract.setFunctionContract(RequestParser.getAsString(request.get("functionContract")));

        // ContractType
        ContractType contractType = new ContractType();
        contractType.setContractTypeName(RequestParser.getAsString(request.get("nameContractType")));
        contract.setIdContractType(contractType);

        // Employer :
        Employer employer = new Employer();
        employer.setNameEmployer(RequestParser.getAsString(request.get("nameEmployer")));
        contract.setIdEmployer(employer);

        // Researcher :
        Researcher researcher = new Researcher();
        researcher.setResearcherName(RequestParser.getAsString(request.get("researcherName")));
        contract.setResearcher(researcher);

        // Status :
        Status status = new Status();
        status.setStatusName(RequestParser.getAsString(request.get("statusName")));
        contract.setStatus(status);

        // Activity :
        Activity activity = new Activity();
        contract.setActivity(activity);
        activity.setContract(contract);
        activity.setIdTypeActivity(TypeActivity.IdTypeActivity.CONTRACT.getId());

        // get list of researcher doing this activity - currently only one is sent
        activity.setResearcherList(Collections.singletonList(new Researcher(RequestParser.getAsInteger(request.get("researcherId")))));

        activity = activityRepo.save(activity);
        return activity;
    }
}
