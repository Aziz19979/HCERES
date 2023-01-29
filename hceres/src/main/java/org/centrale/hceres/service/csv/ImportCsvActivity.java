package org.centrale.hceres.service.csv;

import lombok.Data;
import org.centrale.hceres.dto.csv.CsvActivity;
import org.centrale.hceres.dto.csv.ImportCsvSummary;
import org.centrale.hceres.dto.csv.utils.InDependentCsv;
import org.centrale.hceres.items.Researcher;
import org.centrale.hceres.items.TypeActivity;
import org.centrale.hceres.service.csv.util.SupportedCsvFormat;
import org.centrale.hceres.util.RequestParseException;
import org.centrale.hceres.util.RequestParser;
import org.springframework.stereotype.Service;

import java.util.*;

@Data
@Service
public class ImportCsvActivity {
    /**
     * @param activityRows list of array having fields as defined in csv
     * @return map from csv Activity type as defined in {@link org.centrale.hceres.items.TypeActivity.IdTypeActivity}
     * to all activities of that type using specific activity count as key from csv file
     */
    public Map<Integer, Map<Integer, CsvActivity>> importCsvList(List<?> activityRows, ImportCsvSummary importCsvSummary,
                                                                 Map<Integer, InDependentCsv<Researcher>> csvIdToResearcherMap,
                                                                 Map<Integer, InDependentCsv<TypeActivity>> csvIdToTypeActivityMap) {
        // map to store imported Activity from csv,
        Map<Integer, Map<Integer, CsvActivity>> activityMap = new HashMap<>();
        List<String> errors = new ArrayList<>();

        // parse and collect data from csv
        int i = 0;
        for (Object activityRow : activityRows) {
            i++;
            CsvActivity csvActivity = new CsvActivity();
            List<?> csvData = (List<?>) activityRow;
            int fieldNo = 0;
            try {
                csvActivity.setIdCsvTypeActivity(RequestParser.getAsInteger(csvData.get(fieldNo++)));
                csvActivity.setIdCsv(RequestParser.getAsInteger(csvData.get(fieldNo++)));
                csvActivity.setIdCsvResearcher(RequestParser.getAsInteger(csvData.get(fieldNo++)));
                csvActivity.setSpecificActivityCount(RequestParser.getAsInteger(csvData.get(fieldNo++)));
                csvActivity.setActivityNameType(RequestParser.getAsString(csvData.get(fieldNo++)));
            } catch (RequestParseException exception) {
                errors.add(exception.getMessage() + " on row " + i + " column " + fieldNo);
                continue;
            }

            // check that type activity is same type
            if (!csvIdToTypeActivityMap.containsKey(csvActivity.getIdCsvTypeActivity())) {
                errors.add(csvActivity.getIdCsvTypeActivity() + " activity type id used on row " + i + " doesn't have definition in dependency file.");
                continue;
            }
            csvActivity.setCsvTypeActivity(csvIdToTypeActivityMap.get(csvActivity.getIdCsvTypeActivity()));


            if (!csvIdToResearcherMap.containsKey(csvActivity.getIdCsvResearcher())) {
                errors.add(csvActivity.getIdCsvResearcher() + " researcher id used on row " + i + " doesn't have definition in dependency file.");
                continue;
            }
            csvActivity.setCsvResearcher(csvIdToResearcherMap.get(csvActivity.getIdCsvResearcher()));


            int activityTypeId = csvActivity.getCsvTypeActivity().getIdDatabase();

            activityMap.computeIfAbsent(activityTypeId, k -> new HashMap<>());
            activityMap.get(activityTypeId).put(csvActivity.getSpecificActivityCount(), csvActivity);
        }

        importCsvSummary.getEntityToInsertedCount().put(SupportedCsvFormat.ACTIVITY.toString(), 0);
        importCsvSummary.getEntityToErrorMsg().put(SupportedCsvFormat.ACTIVITY.toString(), errors);
        return activityMap;
    }
}
