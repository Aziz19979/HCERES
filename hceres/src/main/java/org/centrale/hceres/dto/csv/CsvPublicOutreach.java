package org.centrale.hceres.dto.csv;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.centrale.hceres.dto.csv.utils.CsvDependencyException;
import org.centrale.hceres.dto.csv.utils.CsvParseException;
import org.centrale.hceres.dto.csv.utils.DependentCsv;
import org.centrale.hceres.dto.csv.utils.GenericCsv;
import org.centrale.hceres.items.Activity;
import org.centrale.hceres.items.Researcher;
import org.centrale.hceres.items.PublicOutreach;
import org.centrale.hceres.items.TypeActivity;
import org.centrale.hceres.util.RequestParseException;
import org.centrale.hceres.util.RequestParser;

import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Map;

@EqualsAndHashCode(callSuper = true)
@Data
public class CsvPublicOutreach extends DependentCsv<Activity, Integer> {

    // important the read field of name id_activity isn't the same
    // id activity in activity.csv
    // to get the id activity use both key:
    // the type of activity and the specific count
    private Integer idCsvPublicOutreach;

    private String description;
    private Integer idType;

    // dependency element
    private CsvActivity csvActivity;
    private Map<Integer, CsvActivity> activityIdCsvMap;

    public CsvPublicOutreach(Map<Integer, CsvActivity> activityIdCsvMap) {
        this.activityIdCsvMap = activityIdCsvMap;
    }

    @Override
    public void fillCsvDataWithoutDependency(List<?> csvData) throws CsvParseException {
        int fieldNumber = 0;
        try {
            this.setIdCsvPublicOutreach(RequestParser.getAsInteger(csvData.get(fieldNumber++)));
            this.setDescription(RequestParser.getAsString(csvData.get(fieldNumber++)));
            this.setIdType(RequestParser.getAsInteger(csvData.get(fieldNumber++)));
        } catch (RequestParseException e) {
            throw new CsvParseException(e.getMessage() + " at column " + fieldNumber + " at id " + csvData);
        }
    }

    @Override
    public void initializeDependencies() throws CsvDependencyException {
        // get the activity
        CsvActivity csvActivityDep = this.activityIdCsvMap.get(this.getIdCsvPublicOutreach());
        if (csvActivityDep == null) {
            throw new CsvDependencyException("No activity found for id " + this.getIdCsvPublicOutreach());
        }
        this.setCsvActivity(csvActivityDep);
    }

    @Override
    public Activity convertToEntity() {
        Activity activity = this.getCsvActivity().convertToEntity();
        activity.setIdTypeActivity(TypeActivity.IdTypeActivity.PUBLIC_OUTREACH.getId());
        PublicOutreach publicOutreach = new PublicOutreach();
        publicOutreach.setDescription(this.getDescription());
        // direct use of id present in database public_outreach_type
        publicOutreach.setPublicOutreachTypeId(this.getIdType());
        activity.setPublicOutreach(publicOutreach);
        publicOutreach.setActivity(activity);
        return activity;
    }

    @Override
    public String getMergingKey() {
        return (this.getCsvActivity().getCsvResearcher().getIdDatabase()
                + "_" + this.getDescription()
                + "_" + this.getIdType()).toLowerCase();
    }

    @Override
    public String getMergingKey(Activity entity) {
        return (entity.getResearcherList().get(0).getResearcherId()
                + "_" + entity.getPublicOutreach().getDescription()
                + "_" + entity.getPublicOutreach().getPublicOutreachTypeId()).toLowerCase();
    }

    @Override
    public void setIdDatabaseFromEntity(Activity entity) {
        this.setIdDatabase(entity.getIdActivity());
    }

    @Override
    public Integer getIdCsv() {
        return this.getIdCsvPublicOutreach();
    }
}
