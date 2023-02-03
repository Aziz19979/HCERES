package org.centrale.hceres.service.csv;

import lombok.Data;
import org.centrale.hceres.dto.csv.CsvActivity;
import org.centrale.hceres.dto.csv.ImportCsvSummary;
import org.centrale.hceres.dto.csv.utils.CsvDependencyException;
import org.centrale.hceres.dto.csv.utils.CsvParseException;
import org.centrale.hceres.dto.csv.utils.GenericCsv;
import org.centrale.hceres.items.Researcher;
import org.centrale.hceres.items.TypeActivity;
import org.centrale.hceres.service.csv.util.SupportedCsvTemplate;
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
    public Map<TypeActivity.IdTypeActivity, Map<Integer, CsvActivity>> importCsvList(List<?> activityRows, ImportCsvSummary importCsvSummary,
                                                                 Map<Integer, GenericCsv<Researcher, Integer>> csvIdToResearcherMap,
                                                                 Map<Integer, GenericCsv<TypeActivity, Integer>> csvIdToTypeActivityMap) {
        // map to store imported Activity from csv,
        EnumMap<TypeActivity.IdTypeActivity, Map<Integer, CsvActivity>> activityMap = new EnumMap<>(TypeActivity.IdTypeActivity.class);
        List<String> errors = new ArrayList<>();

        // parse and collect data from csv
        int lineNumber = 0;
        for (Object activityRow : activityRows) {
            lineNumber++;
            CsvActivity csvActivity = new CsvActivity(csvIdToTypeActivityMap, csvIdToResearcherMap);
            List<?> csvData = (List<?>) activityRow;
            try {
                csvActivity.fillCsvData(csvData);
            } catch (CsvParseException | CsvDependencyException e) {
                errors.add(e.getMessage() + " (line " + lineNumber + ")");
                continue;
            }
            int activityTypeId = csvActivity.getCsvTypeActivity().getIdDatabase();
            TypeActivity.IdTypeActivity activityType = TypeActivity.IdTypeActivity.fromId(activityTypeId);
            activityMap.computeIfAbsent(activityType, k -> new HashMap<>());
            activityMap.get(activityType).put(csvActivity.getSpecificActivityCount(), csvActivity);
        }

        importCsvSummary.getEntityToInsertedCount().put(SupportedCsvTemplate.ACTIVITY.toString(), 0);
        importCsvSummary.getEntityToErrorMsg().put(SupportedCsvTemplate.ACTIVITY.toString(), errors);
        return activityMap;
    }
}
