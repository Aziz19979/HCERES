package org.centrale.hceres.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Date;
import java.util.Optional;

import org.centrale.hceres.items.Activity;
import org.centrale.hceres.items.Researcher;
import org.centrale.hceres.items.SeiIndustrialRDContract;
import org.centrale.hceres.items.TypeActivity;
import org.centrale.hceres.repository.ActivityRepository;
import org.centrale.hceres.repository.ResearchRepository;
import org.centrale.hceres.repository.SeiIndustrialRDContractRepository;
import org.centrale.hceres.repository.TypeActivityRepository;
import org.centrale.hceres.util.RequestParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Data;

import javax.transaction.Transactional;

import org.springframework.web.bind.annotation.RequestBody;

import java.util.Map;

@Data
@Service
public class SeiIndustrialRDContractService {
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
    private SeiIndustrialRDContractRepository seiIndustrialRDContractRepo;


    /**
     * permet de retourner la liste
     */
    public List<Activity> getIndustrialContracts() {
        return activityRepo.findByIdTypeActivity(TypeActivity.IdTypeActivity.SEI_INDUSTRIAL_R_D_CONTRACT.getId());
    }

    /**
     * supprimer l'elmt selon son id
     *
     * @param id : id de l'elmt
     */
    public void deleteIndustrialContract(final Integer id) {
        seiIndustrialRDContractRepo.deleteById(id);
    }

    /**
     * permet d'ajouter un elmt
     *
     * @return : l'elemt ajouter a la base de donnees
     */
    @Transactional
    public Activity saveIndustrialContract(@RequestBody Map<String, Object> request) throws ParseException {

        SeiIndustrialRDContract seiIndustrialRDContractToSave = new SeiIndustrialRDContract();

        // StartDate :
        seiIndustrialRDContractToSave.setStartDate(RequestParser.getAsDate(request.get("StartDate")));

        // NameCompanyInvolved :
        seiIndustrialRDContractToSave.setNameCompanyInvolved(RequestParser.getAsString(request.get("NameCompanyInvolved")));

        // ProjectTitle :
        seiIndustrialRDContractToSave.setProjectTitle(RequestParser.getAsString(request.get("ProjectTitle")));

        // AgreementAmount :
        seiIndustrialRDContractToSave.setAgreementAmount(RequestParser.getAsInteger(request.get("AgreementAmount")));

        // EndDate :
        seiIndustrialRDContractToSave.setEndDate(RequestParser.getAsDate(request.get("EndDate")));

        // AssociatedPubliRef
        seiIndustrialRDContractToSave.setAssociatedPubliRef(RequestParser.getAsString(request.get("AssociatedPubliRef")));

        // Activity :
        Activity activity = new Activity();
        TypeActivity typeActivity = typeActivityLevelRepo.getById(TypeActivity.IdTypeActivity.SEI_INDUSTRIAL_R_D_CONTRACT.getId());
        activity.setTypeActivity(typeActivity);


        // get list of researcher doing this activity - currently only one is sent
        Integer researcherId = RequestParser.getAsInteger(request.get("researcherId"));
        Optional<Researcher> researcherOp = researchRepo.findById(researcherId);
        Researcher researcher = researcherOp.get();

        List<Researcher> activityResearch = new ArrayList<>();
        activityResearch.add(researcher);
        activity.setResearcherList(activityResearch);

        Activity savedActivity = activityRepo.save(activity);
        seiIndustrialRDContractToSave.setActivity(savedActivity);


        // Id de l'education :
        Integer idEducation = activity.getIdActivity();
        seiIndustrialRDContractToSave.setIdActivity(idEducation);

        // Enregistrer Education dans la base de données :
        SeiIndustrialRDContract seiIndustrialRDContractSaved = seiIndustrialRDContractRepo.save(seiIndustrialRDContractToSave);

        savedActivity.setSeiIndustrialRDContract(seiIndustrialRDContractSaved);
        return savedActivity;
    }


}
