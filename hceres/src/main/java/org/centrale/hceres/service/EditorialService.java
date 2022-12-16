package org.centrale.hceres.service;

import org.centrale.hceres.items.*;
import org.centrale.hceres.repository.*;
import org.centrale.hceres.util.RequestParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class EditorialService {
    @Autowired
    EditorialRepository editorialRepository;
    @Autowired
    private ResearchRepository researchRepo;
    @Autowired
    private ActivityRepository activityRepo;
    @Autowired
    private TypeActivityRepository typeActivityLevelRepo;
    @Autowired
    private JournalRepository journalRepository;
    @Autowired
    private FunctionEditorialActivityRepository functionEditorialActivityRepository;

    public Optional<EditorialActivity> getEditorial(final Integer id) {
        return editorialRepository.findById(id);
    }

    /**
     * permet de retourner la liste
     */
    public List<Activity> getEditorialActivities() {
        return activityRepo.findByIdTypeActivity(TypeActivity.IdTypeActivity.EDITORIAL_ACTIVITY.getId());
    }

    /**
     * supprimer l'elmt selon son id
     *
     * @param id : id de l'elmt
     */
    public void deleteEditorialActivity(final Integer id) {
        editorialRepository.deleteById(id);
    }

    public Activity saveEditorial(@RequestBody Map<String, Object> request) throws ParseException {

        EditorialActivity editorialToSave = new EditorialActivity();

        // Start Date
        editorialToSave.setStartDate(RequestParser.getAsDate(request.get("startDate")));

        // Start Date
        editorialToSave.setEndDate(RequestParser.getAsDate(request.get("endDate")));

        // Impact Factor
        String impactFactor = RequestParser.getAsString(request.get("impactFactor"));
        BigDecimal impactFactorInt = new BigDecimal(impactFactor);
        editorialToSave.setImpactFactor(impactFactorInt);

        // Activity :
        Activity activity = new Activity();
        TypeActivity typeActivity = typeActivityLevelRepo.getById(TypeActivity.IdTypeActivity.EDITORIAL_ACTIVITY.getId());
        activity.setTypeActivity(typeActivity);


        // get list of researcher doing this activity - currently only one is sent
        Integer researcherId = RequestParser.getAsInteger(request.get("researcherId"));
        Optional<Researcher> researcherOp = researchRepo.findById(researcherId);
        Researcher researcher = researcherOp.get();

        List<Researcher> activityResearch = new ArrayList<>();
        activityResearch.add(researcher);
        activity.setResearcherList(activityResearch);

        Activity savedActivity = activityRepo.save(activity);
        editorialToSave.setActivity(savedActivity);

        // Created Editorial id :
        Integer idEditorial = activity.getIdActivity();
        editorialToSave.setIdActivity(idEditorial);

        // Creating journal object with given name in form (must include in future the possibility to select among the existing journals)
        String journalName = RequestParser.getAsString(request.get("journalName"));

        if (journalRepository.findByName(journalName) == null) {
            Journal journal = new Journal();
            journal.setJournalName(journalName);
            editorialToSave.setJournalId(journal);
        } else {
            Journal journal = journalRepository.findByName(journalName);
            editorialToSave.setJournalId(journal);
        }


        //Creating an editing function
        // Search in dataBase by function name if it doesn't exist create It
        String functionName = RequestParser.getAsString(request.get("functionName"));
        if (functionEditorialActivityRepository.findByName(functionName) == null) {
            FunctionEditorialActivity functionEditorialActivity = new FunctionEditorialActivity();

            // Setting the function Name
            functionEditorialActivity.setFunctionEditorialActivityName(functionName);

            // Getting existing List of editorial activities
            List<EditorialActivity> List = functionEditorialActivity.getEditorialActivityList();

            // Adding the new editorial activity to the List
            if (List == null) {
                List = new ArrayList<EditorialActivity>();
            }
            List.add(editorialToSave);
            functionEditorialActivity.setEditorialActivityList(List);

            // Persist Function editorial activity
            //functionEditorialActivityRepository.save(functionEditorialActivity);

            // Adding id to editorial activity
            editorialToSave.setFunctionEditorialActivityId(functionEditorialActivity);
        } else {
            FunctionEditorialActivity functionEditorialActivity = functionEditorialActivityRepository.findByName(functionName);

            // Getting existing List of editorial activities
            List<EditorialActivity> List = functionEditorialActivity.getEditorialActivityList();

            // Adding the new editorial activity to the List

            List.add(editorialToSave);
            functionEditorialActivity.setEditorialActivityList(List);

            // Persist Function editorial activity
            //functionEditorialActivityRepository.save(functionEditorialActivity);

            // Adding id to editorial activity
            editorialToSave.setFunctionEditorialActivityId(functionEditorialActivity);
        }

        // Persist Platform to database :
        EditorialActivity saveEditorial = editorialRepository.save(editorialToSave);

        //Wrap all saved objects in activity
        savedActivity.setEditorialActivity(saveEditorial);
        return savedActivity;
    }
}
