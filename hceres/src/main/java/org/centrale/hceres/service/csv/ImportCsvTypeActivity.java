package org.centrale.hceres.service.csv;

import lombok.Data;
import org.centrale.hceres.dto.CsvTypeActivity;
import org.centrale.hceres.dto.ImportCsvSummary;
import org.centrale.hceres.items.TypeActivity;
import org.centrale.hceres.repository.TypeActivityRepository;
import org.centrale.hceres.util.RequestParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Data
@Service
public class ImportCsvTypeActivity {
    @Autowired
    private TypeActivityRepository typeActivityRepository;

    /**
     * @param typeActivityRows  list of array having fields as defined in csv
     * @param importCsvSummary
     * @return map from csv TypeActivity id to the ImportedTypeActivity object
     */
    public Map<Integer, CsvTypeActivity> importCsvList(List<?> typeActivityRows, ImportCsvSummary importCsvSummary) {
        // map to store imported TypeActivity from csv,
        Map<String, CsvTypeActivity> csvTypeActivityMap = new LinkedHashMap<>();

        // parse and collect data from csv
        typeActivityRows.forEach(r -> {
            CsvTypeActivity csvTypeActivity = new CsvTypeActivity();
            List<?> csvData = (List<?>) r;
            csvTypeActivity.setIdCsv(RequestParser.getAsInteger(csvData.get(0)));
            csvTypeActivity.setNameType(RequestParser.getAsString(csvData.get(1)));
            csvTypeActivityMap.put(CsvTypeActivity.getMergingKey(csvTypeActivity), csvTypeActivity);
        });

        // map to store the TypeActivitys already present in the database,
        // with key as lowercase concatenation of surname, name and email
        Map<String, TypeActivity> typeActivityMap = new HashMap<>();
        typeActivityRepository.findAll().forEach(r -> typeActivityMap.put(CsvTypeActivity.getMergingKey(r), r));


        // If a TypeActivity with the same merging key already exists in the database, use its id,
        // otherwise prepare it to be saved into the database.
        List<TypeActivity> typeActivitysToSave = new ArrayList<>();
        for (Map.Entry<String, CsvTypeActivity> entry : csvTypeActivityMap.entrySet()) {
            String key = entry.getKey();
            CsvTypeActivity csvTypeActivity = entry.getValue();
            TypeActivity typeActivityInDb = typeActivityMap.get(key);
            if (typeActivityInDb != null) {
                csvTypeActivity.setIdDatabase(typeActivityInDb.getIdTypeActivity());
            } else {
                typeActivitysToSave.add(csvTypeActivity.convertToTypeActivity());
            }
        }

        // save new TypeActivitys
        List<TypeActivity> savedTypeActivities = typeActivityRepository.saveAll(typeActivitysToSave);
        savedTypeActivities.forEach(r -> typeActivityMap.put(CsvTypeActivity.getMergingKey(r), r));

        // assign generated ids
        for (TypeActivity savedTypeActivity : savedTypeActivities) {
            String key = CsvTypeActivity.getMergingKey(savedTypeActivity);
            csvTypeActivityMap.get(key).setIdDatabase(savedTypeActivity.getIdTypeActivity());
        }

        // prepare map from csvId to TypeActivity map and return it
        Map<Integer, CsvTypeActivity> csvIdToTypeActivityMap = new HashMap<>();
        csvTypeActivityMap.forEach((key, r) -> csvIdToTypeActivityMap.put(r.getIdCsv(), r));
        return csvIdToTypeActivityMap;
    }
}
