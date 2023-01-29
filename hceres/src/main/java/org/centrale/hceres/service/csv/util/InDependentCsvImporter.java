package org.centrale.hceres.service.csv.util;

import org.centrale.hceres.dto.csv.CsvInstitution;
import org.centrale.hceres.dto.csv.utils.CsvParseException;
import org.centrale.hceres.dto.csv.ImportCsvSummary;
import org.centrale.hceres.dto.csv.utils.InDependentCsv;
import org.springframework.data.jpa.repository.JpaRepository;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class InDependentCsvImporter<E> {

    /**
     * @param csvRows          List of csv data
     * @param importCsvSummary Summary of the import
     * @return Map from csv id to {@link CsvInstitution}
     */
    public Map<Integer, InDependentCsv<E>> importCsvList(List<?> csvRows,
                                                         InDependentCsvFactory<E> inDependentCsvFactory,
                                                         JpaRepository<E, Integer> entityRepository,
                                                         SupportedCsvFormat supportedCsvFormat,
                                                         ImportCsvSummary importCsvSummary) {
        // map to store imported entities from csv,
        // with merging key as key
        Map<String, InDependentCsv<E>> csvEntityMap = new LinkedHashMap<>();
        List<String> errors = new ArrayList<>();

        // parse and collect data from csv
        int lineNumber = 0;
        for (Object csvRow : csvRows) {
            lineNumber++;
            InDependentCsv<E> csvEntity = inDependentCsvFactory.newInDependentCsv();
            try {
                List<?> csvData = (List<?>) csvRow;
                csvEntity.fillCsvData(csvData);
            } catch (CsvParseException e) {
                errors.add(e.getMessage() + " (line " + lineNumber + ")");
                continue;
            }
            csvEntityMap.put(csvEntity.getMergingKey(), csvEntity);
        }

        // map to store the entities already present in the database,
        // with merging key as key
        InDependentCsv<E> csvEntityUtil = inDependentCsvFactory.newInDependentCsv();
        Map<String, E> entityMap = new LinkedHashMap<>();
        entityRepository.findAll().forEach(r -> entityMap.put(csvEntityUtil.getMergingKey(r), r));

        // If an entity with the same merging key already exists in the database, use its id,
        // otherwise prepare it to be saved into the database.
        List<E> entitiesToSave = new ArrayList<>();
        for (Map.Entry<String, InDependentCsv<E>> entry : csvEntityMap.entrySet()) {
            String key = entry.getKey();
            InDependentCsv<E> csvEntity = entry.getValue();
            E entityInDb = entityMap.get(key);
            if (entityInDb != null) {
                csvEntity.setIdDatabaseFromEntity(entityInDb);
            } else {
                entitiesToSave.add(csvEntity.convertToEntity());
            }
        }

        // Save the entities into the database
        List<E> savedEntities = entityRepository.saveAll(entitiesToSave);

        // update the id of the csv Entities using entities that were saved into the database
        for (E savedEntity : savedEntities) {
            InDependentCsv<E> csvEntity = csvEntityMap.get(csvEntityUtil.getMergingKey(savedEntity));
            csvEntity.setIdDatabaseFromEntity(savedEntity);
        }

        // update the summary
        importCsvSummary.getEntityToInsertedCount().put(supportedCsvFormat.toString(), entitiesToSave.size());
        importCsvSummary.getEntityToErrorMsg().put(supportedCsvFormat.toString(), errors);

        // return the map from csv id to csv entity
        Map<Integer, InDependentCsv<E>> csvEntityIdMap = new LinkedHashMap<>();
        csvEntityMap.forEach((k, v) -> csvEntityIdMap.put(v.getIdCsv(), v));
        return csvEntityIdMap;
    }
}
