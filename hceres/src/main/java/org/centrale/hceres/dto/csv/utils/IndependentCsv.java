package org.centrale.hceres.dto.csv.utils;

import lombok.Data;
import org.centrale.hceres.dto.csv.utils.CsvParseException;

import java.util.List;

@Data
public class IndependentCsv<E> {
    private Integer idCsv;

    // id Database is not present in csv fields,
    // it is generated on insert to database, either found by defined merging rules
    private Integer idDatabase;

    public IndependentCsv() {
        this.idCsv = -1;
        this.idDatabase = -1;
    }

    private static final String ERROR_IMPLEMENTATION = "This method should be implemented in the child class";

    /**
     * Take the data from the csv and fill the csvInstitution object
     * @param csvData List of data from the csv
     */
    public void fillCsvInstitution(List<?> csvData) throws CsvParseException {
        throw new UnsupportedOperationException(ERROR_IMPLEMENTATION);
    }


    /**
     * Convert the csvInstitution to an entity
     * @return Institution entity
     */
    public E convertToEntity() {
        throw new UnsupportedOperationException(ERROR_IMPLEMENTATION);
    }

    /**
     * Get the merging key for the csvInstitution
     * @return merging key
     */
    public String getMergingKey() {
        throw new UnsupportedOperationException(ERROR_IMPLEMENTATION);
    }

    /**
     * Get the merging key for the entity
     * @param entity entity
     * @return merging key
     */
    public String getMergingKey(E entity) {
        throw new UnsupportedOperationException(ERROR_IMPLEMENTATION);
    }

    public void setIdDatabaseFromEntity(E entity) {
        throw new UnsupportedOperationException(ERROR_IMPLEMENTATION);
    }
}
