package org.centrale.hceres.service.csv.util;

import org.centrale.hceres.dto.csv.CsvInstitution;
import org.centrale.hceres.dto.csv.ImportCsvSummary;
import org.centrale.hceres.dto.csv.utils.CsvDependencyException;
import org.centrale.hceres.dto.csv.utils.CsvParseException;
import org.centrale.hceres.dto.csv.utils.GenericCsv;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class GenericCsvImporter<E, I> {

    /**
     * @param csvRows          List of csv data
     * @param importCsvSummary Summary of the import
     * @return Map from csv id to {@link CsvInstitution}
     */
    public Map<I, GenericCsv<E, I>> importCsvList(List<?> csvRows,
                                                         CsvDtoFactory<E, I> genericCsvFactory,
                                                         JpaRepository<E, ?> entityRepository,
                                                         SupportedCsvTemplate supportedCsvTemplate,
                                                         ImportCsvSummary importCsvSummary) {
        // map to store imported entities from csv,
        // with merging key as key
        Map<String, GenericCsv<E, I>> csvEntityMap = new LinkedHashMap<>();
        List<String> errors = new ArrayList<>();

        // parse and collect data from csv
        int lineNumber = 0;
        for (Object csvRow : csvRows) {
            lineNumber++;
            GenericCsv<E, I> csvEntity = genericCsvFactory.newCsvDto();
            try {
                List<?> csvData = (List<?>) csvRow;
                csvEntity.fillCsvData(csvData);
            } catch (CsvParseException | CsvDependencyException e) {
                errors.add(e.getMessage() + " (line " + lineNumber + ")");
                continue;
            }
            csvEntityMap.put(csvEntity.getMergingKey(), csvEntity);
        }

        // map to store the entities already present in the database,
        // with merging key as key
        GenericCsv<E, I> csvEntityUtil = genericCsvFactory.newCsvDto();
        Map<String, E> entityMap = new LinkedHashMap<>();
        entityRepository.findAll().forEach(r -> entityMap.put(csvEntityUtil.getMergingKey(r), r));

        // If an entity with the same merging key already exists in the database, use its id,
        // otherwise prepare it to be saved into the database.
        List<E> entitiesToSave = new ArrayList<>();
        for (Map.Entry<String, GenericCsv<E, I>> entry : csvEntityMap.entrySet()) {
            String key = entry.getKey();
            GenericCsv<E, I> csvEntity = entry.getValue();
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
            GenericCsv<E, I> csvEntity = csvEntityMap.get(csvEntityUtil.getMergingKey(savedEntity));
            csvEntity.setIdDatabaseFromEntity(savedEntity);
        }

        // update the summary
        importCsvSummary.getEntityToInsertedCount().put(supportedCsvTemplate.toString(), entitiesToSave.size());
        importCsvSummary.getEntityToErrorMsg().put(supportedCsvTemplate.toString(), errors);

        // return the map from csv id to csv entity
        Map<I, GenericCsv<E, I>> csvEntityIdMap = new LinkedHashMap<>();
        csvEntityMap.forEach((k, v) -> csvEntityIdMap.put(v.getIdCsv(), v));
        return csvEntityIdMap;
    }
}
