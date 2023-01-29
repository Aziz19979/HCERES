package org.centrale.hceres.dto.csv.utils;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.List;
import java.util.Map;

@Data
public abstract class DependentCsv<E> implements GenericCsv<E> {

    /**
     * id Database is not present in csv fields,
     * it is generated on insert to database, either found by defined merging rules.
     * It may be a concatenation of foreign keys (example case of BelongTeam) or a simple id (example case of Laboratory)
     * It is set by {@link #setIdDatabaseFromEntity}
     */
    private String idDatabase;

    /**
     * Take the data from the csv and fill the csvInstitution object
     *
     * @param csvData List of data from the csv
     * @see #fillCsvDataWithDependency to fill data and initialize dependencies
     */
    @Override
    public abstract void fillCsvData(List<?> csvData) throws CsvParseException;

    /**
     * Initialize dependencies of the entity after filling the csv data containing foreign keys
     * to be used in mapping.
     */
    public abstract void initializeDependencies() throws CsvDependencyException;

    public void fillCsvDataWithDependency(List<?> csvData) throws CsvParseException, CsvDependencyException {
        this.fillCsvData(csvData);
        this.initializeDependencies();
    }

    /**
     * fill missing {@link #setIdDatabase} from the entity
     *
     * @param entity entity extracted from database
     */
    public abstract void setIdDatabaseFromEntity(E entity);

    /**
     * Similar id to {@link #getIdDatabase()} but using csv data
     *
     * @return id csv
     */
    public abstract String getIdCsv();
}
