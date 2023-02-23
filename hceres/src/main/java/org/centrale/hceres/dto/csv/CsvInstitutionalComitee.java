package org.centrale.hceres.dto.csv;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.centrale.hceres.dto.csv.utils.CsvDependencyException;
import org.centrale.hceres.dto.csv.utils.CsvParseException;
import org.centrale.hceres.dto.csv.utils.DependentCsv;
import org.centrale.hceres.dto.csv.utils.GenericCsv;
import org.centrale.hceres.items.Activity;
import org.centrale.hceres.items.Researcher;
import org.centrale.hceres.items.InstitutionalComitee;
import org.centrale.hceres.items.TypeActivity;
import org.centrale.hceres.util.RequestParseException;
import org.centrale.hceres.util.RequestParser;

import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Map;

@EqualsAndHashCode(callSuper = true)
@Data
public class CsvInstitutionalComitee extends DependentCsv<Activity, Integer> {

    // important the read field of name id_activity isn't the same
    // id activity in activity.csv
    // to get the id activity use both key:
    // the type of activity and the specific count
    private Integer idCsvInstitutionalComitee;

    private Integer year;
    private String nameInstitutionalComitee;
    private Integer idRolePiLabEval;

    // dependency element
    private CsvActivity csvActivity;
    private Map<Integer, CsvActivity> activityIdCsvMap;

    public CsvInstitutionalComitee(Map<Integer, CsvActivity> activityIdCsvMap) {
        this.activityIdCsvMap = activityIdCsvMap;
    }

    @Override
    public void fillCsvDataWithoutDependency(List<?> csvData) throws CsvParseException {
        int fieldNumber = 0;
        try {
            this.setIdCsvInstitutionalComitee(RequestParser.getAsInteger(csvData.get(fieldNumber++)));
            this.setYear(RequestParser.getAsInteger(csvData.get(fieldNumber++)));
            this.setNameInstitutionalComitee(RequestParser.getAsString(csvData.get(fieldNumber++)));
            this.setIdRolePiLabEval(RequestParser.getAsInteger(csvData.get(fieldNumber)));
        } catch (RequestParseException e) {
            throw new CsvParseException(e.getMessage() + " at column " + fieldNumber + " at id " + csvData);
        }
    }

    @Override
    public void initializeDependencies() throws CsvDependencyException {
        // get the activity
        CsvActivity csvActivityDep = this.activityIdCsvMap.get(this.getIdCsvInstitutionalComitee());
        if (csvActivityDep == null) {
            throw new CsvDependencyException("No activity found for id " + this.getIdCsvInstitutionalComitee());
        }
        this.setCsvActivity(csvActivityDep);
    }

    @Override
    public Activity convertToEntity() {
        Activity activity = this.getCsvActivity().convertToEntity();
        activity.setIdTypeActivity(TypeActivity.IdTypeActivity.RESPONSIBILITY_INSTITUTIONAL_COMITEE_JURY.getId());
        InstitutionalComitee institutionalComitee = new InstitutionalComitee();
        institutionalComitee.setYear(this.getYear());
        institutionalComitee.setInstitutionalComiteeName(this.getNameInstitutionalComitee());
        // clean and verfiy after doctor gives sql insert values for roles
        institutionalComitee.setLaboratoryEvaluationRoleId(this.getIdRolePiLabEval());

        activity.setInstitutionalComitee(institutionalComitee);
        institutionalComitee.setActivity(activity);
        return activity;
    }

    @Override
    public String getMergingKey() {
        return (this.getCsvActivity().getCsvResearcher().getIdDatabase()
                + "_" + this.getYear()
                + "_" + this.getNameInstitutionalComitee()
                + "_" + this.getIdRolePiLabEval()).toLowerCase();
    }

    @Override
    public String getMergingKey(Activity entity) {
        return (entity.getResearcherList().get(0).getResearcherId()
                + "_" + entity.getInstitutionalComitee().getYear()
                + "_" + entity.getInstitutionalComitee().getInstitutionalComiteeName()
                + "_" + entity.getInstitutionalComitee().getLaboratoryEvaluationRoleId()).toLowerCase();
    }

    @Override
    public void setIdDatabaseFromEntity(Activity entity) {
        this.setIdDatabase(entity.getIdActivity());
    }

    @Override
    public Integer getIdCsv() {
        return this.getIdCsvInstitutionalComitee();
    }
}
