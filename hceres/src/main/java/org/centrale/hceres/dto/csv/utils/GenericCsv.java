package org.centrale.hceres.dto.csv.utils;

import java.util.List;

public interface GenericCsv<E> {
    /**
     * Take the data from the csv and fill the csvInstitution object
     * @param csvData List of data from the csv
     */
    void fillCsvData(List<?> csvData) throws CsvParseException;


    /**
     * Convert the csvEntity to an entity
     * @return Entity
     */
    E convertToEntity();

    /**
     * Get the merging key for the csv entity
     * @return merging key
     */
    String getMergingKey();

    /**
     * Get the merging key for the entity
     * @param entity entity
     * @return merging key
     */
    String getMergingKey(E entity);
}
