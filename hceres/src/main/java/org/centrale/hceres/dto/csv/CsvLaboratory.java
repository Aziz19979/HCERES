package org.centrale.hceres.dto.csv;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.centrale.hceres.dto.csv.utils.*;
import org.centrale.hceres.items.Institution;
import org.centrale.hceres.items.Laboratory;
import org.centrale.hceres.util.RequestParseException;
import org.centrale.hceres.util.RequestParser;

import java.util.List;
import java.util.Map;

@EqualsAndHashCode(callSuper = true)
@Data
public class CsvLaboratory extends DependentCsv<Laboratory, Integer> {
    private Integer idCsv;
    private String laboratoryName;
    private String laboratoryAcronym;
    /**
     * Id of the institution read from the csv,
     * used to initialize the csvInstitution object using the institutionIdCsvMap
     */
    private Integer institutionIdCsv;

    private GenericCsv<Institution, Integer> csvInstitution;
    private final Map<Integer, GenericCsv<Institution, Integer>> institutionIdCsvMap;

    /**
     * Constructor
     *
     * @param institutionIdCsvMap Map from institution id to csvInstitution
     */
    public CsvLaboratory(Map<Integer, GenericCsv<Institution, Integer>> institutionIdCsvMap) {
        this.institutionIdCsvMap = institutionIdCsvMap;
    }

    @Override
    public void fillCsvDataWithoutDependency(List<?> csvData) throws CsvParseException {
        int fieldNumber = 0;
        try {
            this.setIdCsv(RequestParser.getAsInteger(csvData.get(fieldNumber++)));
            this.setLaboratoryName(RequestParser.getAsString(csvData.get(fieldNumber++)));
            this.setLaboratoryAcronym(RequestParser.getAsString(csvData.get(fieldNumber++)));
            this.setInstitutionIdCsv(RequestParser.getAsInteger(csvData.get(fieldNumber)));
        } catch (RequestParseException e) {
            throw new CsvParseException(e.getMessage() + " at column " + fieldNumber + " at id " + csvData);
        }
    }

    @Override
    public void initializeDependencies() throws CsvDependencyException {
        // Set dependency on institution
        if (!this.institutionIdCsvMap.containsKey(this.getInstitutionIdCsv())) {
            throw new CsvDependencyException("Institution with id " + this.getInstitutionIdCsv()
                    + " not found for laboratory with id " + this.getIdCsv());
        }
        this.setCsvInstitution(this.institutionIdCsvMap.get(this.getInstitutionIdCsv()));
    }

    @Override
    public void setIdDatabaseFromEntity(Laboratory entity) {
        setIdDatabase(entity.getLaboratoryId());
    }

    @Override
    public Integer getIdCsv() {
        return this.idCsv;
    }

    @Override
    public Laboratory convertToEntity() {
        Laboratory laboratory = new Laboratory();
        laboratory.setLaboratoryName(this.getLaboratoryName());
        laboratory.setLaboratoryAcronym(this.getLaboratoryAcronym());
        laboratory.setInstitutionId(this.getCsvInstitution().getIdDatabase());
        return laboratory;
    }

    @Override
    public String getMergingKey() {
        return (this.getLaboratoryName()
                + "_" + this.getLaboratoryAcronym()
                + "_" + this.getCsvInstitution().getIdDatabase())
                .toLowerCase();
    }

    @Override
    public String getMergingKey(Laboratory entity) {
        return (entity.getLaboratoryName()
                + "_" + entity.getLaboratoryAcronym()
                + "_" + entity.getInstitutionId())
                .toLowerCase();
    }
}
