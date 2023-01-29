package org.centrale.hceres.service.csv.util;

import org.centrale.hceres.dto.csv.CsvInstitution;
import org.centrale.hceres.dto.csv.utils.CsvParseException;
import org.centrale.hceres.dto.csv.ImportCsvSummary;
import org.centrale.hceres.dto.csv.utils.IndependentCsv;
import org.springframework.data.jpa.repository.JpaRepository;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class ImportIndependentCsv<E> {

    /**
     * @param csvRows          List of csv data
     * @param importCsvSummary Summary of the import
     * @return Map from csv id to {@link CsvInstitution}
     */
    public Map<Integer, IndependentCsv<E>> importCsvList(List<?> csvRows,
                                                         Class<? extends IndependentCsv<E>> csvClass,
                                                         JpaRepository<E, Integer> entityRepository,
                                                         SupportedCsvFormat supportedCsvFormat,
                                                         ImportCsvSummary importCsvSummary)
            throws NoSuchMethodException, InvocationTargetException, InstantiationException, IllegalAccessException {
        // map to store imported entities from csv,
        // with merging key as key
        Map<String, IndependentCsv<E>> csvEntityMap = new LinkedHashMap<>();
        List<String> errors = new ArrayList<>();

        // parse and collect data from csv
        for (Object csvRow : csvRows) {
            IndependentCsv<E> csvEntity = csvClass.getDeclaredConstructor().newInstance();
            try {
                List<?> csvData = (List<?>) csvRow;
                csvEntity.fillCsvInstitution(csvData);
            } catch (CsvParseException e) {
                errors.add(e.getMessage());
                continue;
            }
            csvEntityMap.put(csvEntity.getMergingKey(), csvEntity);
        }

        // map to store the entities already present in the database,
        // with merging key as key
        IndependentCsv<E> csvEntityUtil = csvClass.getDeclaredConstructor().newInstance();
        Map<String, E> entityMap = new LinkedHashMap<>();
        entityRepository.findAll().forEach(r -> entityMap.put(csvEntityUtil.getMergingKey(r), r));

        // If an entity with the same merging key already exists in the database, use its id,
        // otherwise prepare it to be saved into the database.
        List<E> entitiesToSave = new ArrayList<>();
        for (Map.Entry<String, IndependentCsv<E>> entry : csvEntityMap.entrySet()) {
            String key = entry.getKey();
            IndependentCsv<E> csvEntity = entry.getValue();
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
            IndependentCsv<E> csvEntity = csvEntityMap.get(csvEntityUtil.getMergingKey(savedEntity));
            csvEntity.setIdDatabaseFromEntity(savedEntity);
        }

        // update the summary
        importCsvSummary.getEntityToInsertedCount().put(supportedCsvFormat.toString(), entitiesToSave.size());
        importCsvSummary.getEntityToErrorMsg().put(supportedCsvFormat.toString(), errors);

        // return the map from csv id to csv entity
        Map<Integer, IndependentCsv<E>> csvEntityIdMap = new LinkedHashMap<>();
        csvEntityMap.forEach((k, v) -> csvEntityIdMap.put(v.getIdCsv(), v));
        return csvEntityIdMap;
    }
}
