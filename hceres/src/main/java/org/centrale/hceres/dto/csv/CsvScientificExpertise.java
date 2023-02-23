package org.centrale.hceres.dto.csv;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.centrale.hceres.dto.csv.utils.CsvDependencyException;
import org.centrale.hceres.dto.csv.utils.CsvParseException;
import org.centrale.hceres.dto.csv.utils.DependentCsv;
import org.centrale.hceres.dto.csv.utils.GenericCsv;
import org.centrale.hceres.items.Activity;
import org.centrale.hceres.items.Researcher;
import org.centrale.hceres.items.ScientificExpertise;
import org.centrale.hceres.items.TypeActivity;
import org.centrale.hceres.util.RequestParseException;
import org.centrale.hceres.util.RequestParser;

import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Map;

@EqualsAndHashCode(callSuper = true)
@Data
public class CsvScientificExpertise extends DependentCsv<Activity, Integer> {

    // important the read field of name id_activity isn't the same
    // id activity in activity.csv
    // to get the id activity use both key:
    // the type of activity and the specific count
    private Integer idCsvScientificExpertise;

    private Date startDate;
    private Integer idType;
    private String description;
    private Date endDate;


    // dependency element
    private CsvActivity csvActivity;
    private Map<Integer, CsvActivity> activityIdCsvMap;

    public CsvScientificExpertise(Map<Integer, CsvActivity> activityIdCsvMap) {
        this.activityIdCsvMap = activityIdCsvMap;
    }

    @Override
    public void fillCsvDataWithoutDependency(List<?> csvData) throws CsvParseException {
        int fieldNumber = 0;
        try {
            this.setIdCsvScientificExpertise(RequestParser.getAsInteger(csvData.get(fieldNumber++)));
            this.setStartDate(RequestParser.getAsDateCsvFormat(csvData.get(fieldNumber++)));
            this.setIdType(RequestParser.getAsInteger(csvData.get(fieldNumber++)));
            this.setDescription(RequestParser.getAsString(csvData.get(fieldNumber++)));
            this.setEndDate(RequestParser.getAsDateCsvFormatOrDefault(csvData.get(fieldNumber), null));
        } catch (RequestParseException e) {
            throw new CsvParseException(e.getMessage() + " at column " + fieldNumber + " at id " + csvData);
        }
    }

    @Override
    public void initializeDependencies() throws CsvDependencyException {
        // get the activity
        CsvActivity csvActivityDep = this.activityIdCsvMap.get(this.getIdCsvScientificExpertise());
        if (csvActivityDep == null) {
            throw new CsvDependencyException("No activity found for id " + this.getIdCsvScientificExpertise());
        }
        this.setCsvActivity(csvActivityDep);
    }

    @Override
    public Activity convertToEntity() {
        Activity activity = this.getCsvActivity().convertToEntity();
        activity.setIdTypeActivity(TypeActivity.IdTypeActivity.SCIENTIFIC_EXPERTISE.getId());
        ScientificExpertise scientificExpertise = new ScientificExpertise();
        scientificExpertise.setStartDate(this.getStartDate());
        // direct use of id saved in database scientific_expertise_type
        scientificExpertise.setScientificExpertiseTypeId(this.getIdType());
        scientificExpertise.setDescription(this.getDescription());
        scientificExpertise.setEndDate(this.getEndDate());

        activity.setScientificExpertise(scientificExpertise);
        scientificExpertise.setActivity(activity);
        return activity;
    }

    @Override
    public String getMergingKey() {
        return (this.getCsvActivity().getCsvResearcher().getIdDatabase()
                + "_" + this.getStartDate()
                + "_" + this.getIdType()
                + "_" + this.getDescription()).toLowerCase();
    }

    @Override
    public String getMergingKey(Activity entity) {
        return (entity.getResearcherList().get(0).getResearcherId()
                + "_" + entity.getScientificExpertise().getStartDate()
                + "_" + entity.getScientificExpertise().getScientificExpertiseTypeId()
                + "_" + entity.getScientificExpertise().getDescription()).toLowerCase();
    }

    @Override
    public void setIdDatabaseFromEntity(Activity entity) {
        this.setIdDatabase(entity.getIdActivity());
    }

    @Override
    public Integer getIdCsv() {
        return this.getIdCsvScientificExpertise();
    }
}
