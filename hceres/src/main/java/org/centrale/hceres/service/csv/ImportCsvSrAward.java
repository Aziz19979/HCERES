package org.centrale.hceres.service.csv;

import lombok.Data;
import org.centrale.hceres.dto.csv.CsvActivity;
import org.centrale.hceres.dto.csv.CsvSrAward;
import org.centrale.hceres.dto.csv.ImportCsvSummary;
import org.centrale.hceres.items.Activity;
import org.centrale.hceres.items.TypeActivity;
import org.centrale.hceres.repository.ActivityRepository;
import org.centrale.hceres.service.csv.util.SupportedCsvFormat;
import org.centrale.hceres.util.RequestParseException;
import org.centrale.hceres.util.RequestParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Data
@Service
public class ImportCsvSrAward {

    @Autowired
    private ActivityRepository activityRepo;

    /**
     * @param srAwardRows  list of array having fields as defined in csv
     * @param importCsvSummary
     */
    public void importCsvList(List<?> srAwardRows, ImportCsvSummary importCsvSummary,
                              Map<Integer, Map<Integer, CsvActivity>> activityMap) {
        // map to store imported SrAward from csv,
        Map<String, CsvSrAward> csvSrAwardMap = new HashMap<>();
        List<String> errors = new ArrayList<>();
        int typeActivityId = TypeActivity.IdTypeActivity.SR_AWARD.getId();
        if (!activityMap.containsKey(typeActivityId)) {
            errors.add("Activity dependency list does not contain any entry of SR_AWARD type.");
            return;
        }

        // parse and collect data from csv
        int i = 0;
        for (Object r : srAwardRows) {
            i++;
            CsvSrAward csvSrAward = new CsvSrAward();
            List<?> csvData = (List<?>) r;
            int field = 0;
            try {
                csvSrAward.setIdCsvSrAward(RequestParser.getAsInteger(csvData.get(field++)));
                csvSrAward.setAwardDate(RequestParser.getAsDateCsvFormat(csvData.get(field++)));
                csvSrAward.setAwardeeName(RequestParser.getAsString(csvData.get(field++)));
                csvSrAward.setDescription(RequestParser.getAsString(csvData.get(field)));
            } catch (RequestParseException e) {
                errors.add(e.getMessage() + " at row " + i + " at column " + field);
                continue;
            }

            if (!activityMap.get(typeActivityId).containsKey(csvSrAward.getIdCsvSrAward())) {
                errors.add(csvSrAward.getIdCsvSrAward() + " activity id used on row " + i + " doesn't have definition in dependency file.");
                continue;
            }
            csvSrAward.setCsvActivity(activityMap.get(typeActivityId).get(csvSrAward.getIdCsvSrAward()));

            csvSrAwardMap.put(CsvSrAward.getMergingKey(csvSrAward), csvSrAward);
        }

        // map to store the SrAwards already present in the database,
        // with key as lowercase concatenation of surname, name and email
        Map<String, Activity> activityMapDb = new HashMap<>();
        activityRepo.findByIdTypeActivity(TypeActivity.IdTypeActivity.SR_AWARD.getId())
                .forEach(r -> activityMapDb.put(CsvSrAward.getMergingKey(r.getSrAward()), r));


        // If a SrAward with the same merging key already exists in the database, use its id,
        // otherwise prepare it to be saved into the database.
        List<Activity> activityToSave = new ArrayList<>();
        for (Map.Entry<String, CsvSrAward> entry : csvSrAwardMap.entrySet()) {
            String key = entry.getKey();
            CsvSrAward csvSrAward = entry.getValue();
            Activity activityInDb = activityMapDb.get(key);
            if (activityInDb != null) {
                csvSrAward.getCsvActivity().setIdDatabase(activityInDb.getIdActivity());
            } else {
                activityToSave.add(csvSrAward.convertToActivity());
            }
        }

        // save new activities
        List<Activity> savedTypeActivities = activityRepo.saveAll(activityToSave);
        savedTypeActivities.forEach(r -> activityMapDb.put(CsvSrAward.getMergingKey(r.getSrAward()), r));

        // add number to total activities
        importCsvSummary.addToTotalActivityCountInserted(activityToSave.size());
        importCsvSummary.getEntityToInsertedCount().put(SupportedCsvFormat.SR_AWARD.toString(), activityToSave.size());
        importCsvSummary.getEntityToErrorMsg().put(SupportedCsvFormat.SR_AWARD.toString(), errors);
    }
}
