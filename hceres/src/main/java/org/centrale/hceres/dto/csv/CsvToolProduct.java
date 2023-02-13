package org.centrale.hceres.dto.csv;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.centrale.hceres.dto.csv.utils.CsvDependencyException;
import org.centrale.hceres.dto.csv.utils.CsvParseException;
import org.centrale.hceres.dto.csv.utils.DependentCsv;
import org.centrale.hceres.dto.csv.utils.GenericCsv;
import org.centrale.hceres.items.*;
import org.centrale.hceres.util.RequestParseException;
import org.centrale.hceres.util.RequestParser;

import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Map;

@EqualsAndHashCode(callSuper = true)
@Data
public class CsvToolProduct extends DependentCsv<Activity, Integer> {

    // important the read field of name id_activity isn't the same
    // id activity in activity.csv
    // to get the id activity use both key:
    // the type of activity and the specific count
    private Integer idCsvToolProduct;

    private String toolProductName;
    private Date toolProductCreation;
    private String toolProductAuthors;
    private String toolProductDescription;

    // dependency element
    private CsvActivity csvActivity;
    private Map<Integer, CsvActivity> activityIdCsvMap;


    private ToolProductType.IdToolProductType idToolProductType;

    public CsvToolProduct(Map<Integer, CsvActivity> activityIdCsvMap,
                          ToolProductType.IdToolProductType idToolProductType) {
        this.activityIdCsvMap = activityIdCsvMap;
        this.idToolProductType = idToolProductType;
    }

    @Override
    public void fillCsvDataWithoutDependency(List<?> csvData) throws CsvParseException {
        int fieldNumber = 0;
        try {
            this.setIdCsvToolProduct(RequestParser.getAsInteger(csvData.get(fieldNumber++)));
            this.setToolProductName(RequestParser.getAsString(csvData.get(fieldNumber++)));
            this.setToolProductCreation(RequestParser.getAsDateCsvFormat(csvData.get(fieldNumber++)));
            this.setToolProductAuthors(RequestParser.getAsString(csvData.get(fieldNumber++)));
            this.setToolProductDescription(RequestParser.getAsString(csvData.get(fieldNumber)));
        } catch (RequestParseException e) {
            throw new CsvParseException(e.getMessage() + " at column " + fieldNumber + " at id " + csvData);
        }
    }

    @Override
    public void initializeDependencies() throws CsvDependencyException {
        // get the activity
        CsvActivity csvActivityDep = this.activityIdCsvMap.get(this.getIdCsvToolProduct());
        if (csvActivityDep == null) {
            throw new CsvDependencyException("No activity found for id " + this.getIdCsvToolProduct());
        }
        this.setCsvActivity(csvActivityDep);
    }

    @Override
    public Activity convertToEntity() {
        Activity activity = this.getCsvActivity().convertToEntity();
        activity.setIdTypeActivity(idToolProductType.getIdTypeActivity().getId());
        ToolProduct toolProduct = new ToolProduct();
        toolProduct.setToolProductTypeId(idToolProductType.getId());
        toolProduct.setToolProductName(this.getToolProductName());
        toolProduct.setToolProductCreation(this.getToolProductCreation());
        toolProduct.setToolProductAuthors(this.getToolProductAuthors());
        toolProduct.setToolProductDescription(this.getToolProductDescription());
        activity.setToolProduct(toolProduct);
        toolProduct.setActivity(activity);
        return activity;
    }

    @Override
    public String getMergingKey() {
        return (this.getCsvActivity().getCsvResearcher().getIdDatabase()
                + "_" + this.getToolProductName()
                + "_" + this.getToolProductCreation()
                + "_" + this.getToolProductAuthors()
                + "_" + this.getToolProductDescription()).toLowerCase();
    }

    @Override
    public String getMergingKey(Activity entity) {
        return (entity.getResearcherList().get(0).getResearcherId()
                + "_" + entity.getToolProduct().getToolProductName()
                + "_" + entity.getToolProduct().getToolProductCreation()
                + "_" + entity.getToolProduct().getToolProductAuthors()
                + "_" + entity.getToolProduct().getToolProductDescription()).toLowerCase();
    }

    @Override
    public void setIdDatabaseFromEntity(Activity entity) {
        this.setIdDatabase(entity.getIdActivity());
    }

    @Override
    public Integer getIdCsv() {
        return this.getIdCsvToolProduct();
    }
}
