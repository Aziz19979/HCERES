package org.centrale.hceres.dto.csv;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.centrale.hceres.dto.csv.utils.CsvDependencyException;
import org.centrale.hceres.dto.csv.utils.CsvParseException;
import org.centrale.hceres.dto.csv.utils.DependentCsv;
import org.centrale.hceres.dto.csv.utils.GenericCsv;
import org.centrale.hceres.items.Activity;
import org.centrale.hceres.items.Researcher;
import org.centrale.hceres.items.InvolvementTrainingPedagogical;
import org.centrale.hceres.items.TypeActivity;
import org.centrale.hceres.util.RequestParseException;
import org.centrale.hceres.util.RequestParser;

import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Map;

@EqualsAndHashCode(callSuper = true)
@Data
public class CsvInvolvementTrainingPedagogical extends DependentCsv<Activity, Integer> {

    // important the read field of name id_activity isn't the same
    // id activity in activity.csv
    // to get the id activity use both key:
    // the type of activity and the specific count
    private Integer idCsvInvolvementTrainingPedagogical;

    private Integer year;
    private String nameMaster;

    // check later what default value to put here
    // or does read it from the csv (require to change the csv) ?
    private static final int DEFAULT_ID_TYPE = 1;
    private Integer idType;

    // dependency element
    private CsvActivity csvActivity;
    private Map<Integer, CsvActivity> activityIdCsvMap;

    public CsvInvolvementTrainingPedagogical(Map<Integer, CsvActivity> activityIdCsvMap) {
        this.activityIdCsvMap = activityIdCsvMap;
    }

    @Override
    public void fillCsvDataWithoutDependency(List<?> csvData) throws CsvParseException {
        this.setIdType(DEFAULT_ID_TYPE);
        int fieldNumber = 0;
        try {
            this.setIdCsvInvolvementTrainingPedagogical(RequestParser.getAsInteger(csvData.get(fieldNumber++)));
            this.setYear(RequestParser.getAsInteger(csvData.get(fieldNumber++)));
            this.setNameMaster(RequestParser.getAsString(csvData.get(fieldNumber)));
        } catch (RequestParseException e) {
            throw new CsvParseException(e.getMessage() + " at column " + fieldNumber + " at id " + csvData);
        }
    }

    @Override
    public void initializeDependencies() throws CsvDependencyException {
        // get the activity
        CsvActivity csvActivityDep = this.activityIdCsvMap.get(this.getIdCsvInvolvementTrainingPedagogical());
        if (csvActivityDep == null) {
            throw new CsvDependencyException("No activity found for id " + this.getIdCsvInvolvementTrainingPedagogical());
        }
        this.setCsvActivity(csvActivityDep);
    }

    @Override
    public Activity convertToEntity() {
        Activity activity = this.getCsvActivity().convertToEntity();
        activity.setIdTypeActivity(TypeActivity.IdTypeActivity.INVOLVEMENT_TRAINING_PEDAGOGICAL_RESPONSIBILITY.getId());
        InvolvementTrainingPedagogical involvementTrainingPedagogical = new InvolvementTrainingPedagogical();
        involvementTrainingPedagogical.setYear(this.getYear());
        involvementTrainingPedagogical.setNameMaster(this.getNameMaster());
        involvementTrainingPedagogical.setIdType(this.getIdType());
        activity.setInvolvementTrainingPedagogical(involvementTrainingPedagogical);
        involvementTrainingPedagogical.setActivity(activity);
        return activity;
    }

    @Override
    public String getMergingKey() {
        return (this.getCsvActivity().getCsvResearcher().getIdDatabase()
                + "_" + this.getYear()
                + "_" + this.getNameMaster()
                + "_" + this.getIdType()).toLowerCase();
    }

    @Override
    public String getMergingKey(Activity entity) {
        return (entity.getResearcherList().get(0).getResearcherId()
                + "_" + entity.getInvolvementTrainingPedagogical().getYear()
                + "_" + entity.getInvolvementTrainingPedagogical().getNameMaster()
                + "_" + entity.getInvolvementTrainingPedagogical().getIdType()).toLowerCase();
    }

    @Override
    public void setIdDatabaseFromEntity(Activity entity) {
        this.setIdDatabase(entity.getIdActivity());
    }

    @Override
    public Integer getIdCsv() {
        return this.getIdCsvInvolvementTrainingPedagogical();
    }
}
