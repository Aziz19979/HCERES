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
public class CsvLearnedScientificSociety extends DependentCsv<Activity, Integer> {

    // important the read field of name id_activity isn't the same
    // id activity in activity.csv
    // to get the id activity use both key:
    // the type of activity and the specific count
    private Integer idCsvLearnedScientificSociety;

    private Date startDate;
    private Date endDate;
    private String scientificSocietyName;

    // dependency element
    private CsvActivity csvActivity;
    private Map<Integer, CsvActivity> activityIdCsvMap;

    public CsvLearnedScientificSociety(Map<Integer, CsvActivity> activityIdCsvMap) {
        this.activityIdCsvMap = activityIdCsvMap;
    }

    @Override
    public void fillCsvDataWithoutDependency(List<?> csvData) throws CsvParseException {
        int fieldNumber = 0;
        try {
            this.setIdCsvLearnedScientificSociety(RequestParser.getAsInteger(csvData.get(fieldNumber++)));
            this.setStartDate(RequestParser.getAsDateCsvFormat(csvData.get(fieldNumber++)));
            this.setEndDate(RequestParser.getAsDateCsvFormatOrDefault(csvData.get(fieldNumber++), null));
            this.setScientificSocietyName(RequestParser.getAsString(csvData.get(fieldNumber)));
        } catch (RequestParseException e) {
            throw new CsvParseException(e.getMessage() + " at column " + fieldNumber + " at id " + csvData);
        }
    }

    @Override
    public void initializeDependencies() throws CsvDependencyException {
        // get the activity
        CsvActivity csvActivityDep = this.activityIdCsvMap.get(this.getIdCsvLearnedScientificSociety());
        if (csvActivityDep == null) {
            throw new CsvDependencyException("No activity found for id " + this.getIdCsvLearnedScientificSociety());
        }
        this.setCsvActivity(csvActivityDep);
    }

    @Override
    public Activity convertToEntity() {
        Activity activity = this.getCsvActivity().convertToEntity();
        activity.setIdTypeActivity(TypeActivity.IdTypeActivity.SR_RESPONSIBILITY_LEARNED_SCIENTIFIC_SOCIETY.getId());
        LearnedScientificSociety learnedScientificSociety = new LearnedScientificSociety();
        learnedScientificSociety.setStartDate(this.getStartDate());
        learnedScientificSociety.setEndDate(this.getEndDate());
        learnedScientificSociety.setLearnedScientificSocietyName(this.getScientificSocietyName());

        // currently setting role id to 1
        // check later if there will be additional csv input
        learnedScientificSociety.setLearnedScientificSocietyRoleId(1);

        activity.setLearnedScientificSociety(learnedScientificSociety);
        learnedScientificSociety.setActivity(activity);
        return activity;
    }

    @Override
    public String getMergingKey() {
        return (this.getCsvActivity().getCsvResearcher().getIdDatabase()
                + "_" + this.getStartDate()
                + "_" + this.getEndDate()
                + "_" + this.getScientificSocietyName()).toLowerCase();

    }

    @Override
    public String getMergingKey(Activity entity) {
        return (entity.getResearcherList().get(0).getResearcherId()
                + "_" + entity.getLearnedScientificSociety().getStartDate()
                + "_" + entity.getLearnedScientificSociety().getEndDate()
                + "_" + entity.getLearnedScientificSociety().getLearnedScientificSocietyName()).toLowerCase();
    }

    @Override
    public void setIdDatabaseFromEntity(Activity entity) {
        this.setIdDatabase(entity.getIdActivity());
    }

    @Override
    public Integer getIdCsv() {
        return this.getIdCsvLearnedScientificSociety();
    }
}
