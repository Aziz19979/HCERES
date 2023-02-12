package org.centrale.hceres.dto.csv;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.centrale.hceres.dto.csv.utils.CsvDependencyException;
import org.centrale.hceres.dto.csv.utils.CsvParseException;
import org.centrale.hceres.dto.csv.utils.DependentCsv;
import org.centrale.hceres.dto.csv.utils.GenericCsv;
import org.centrale.hceres.items.Activity;
import org.centrale.hceres.items.Researcher;
import org.centrale.hceres.items.SeiIndustrialRDContract;
import org.centrale.hceres.items.TypeActivity;
import org.centrale.hceres.util.RequestParseException;
import org.centrale.hceres.util.RequestParser;

import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Map;

@EqualsAndHashCode(callSuper = true)
@Data
public class CsvSeiIndustrialRDContract extends DependentCsv<Activity, Integer> {
    // important the read field of name id_activity isn't the same
    // id activity in activity.csv
    // to get the id activity use both key:
    // the type of activity and the specific count
    private Integer idCsvSeiIndustrialRDContract;
    private Date startDate;
    private String nameCompanyInvolved;
    private String projectTitle;
    private Integer agreementAmount;
    private Date endDate;


    // dependency element
    private CsvActivity csvActivity;
    private Map<Integer, CsvActivity> activityIdCsvMap;

    public CsvSeiIndustrialRDContract(Map<Integer, CsvActivity> activityIdCsvMap) {
        this.activityIdCsvMap = activityIdCsvMap;
    }

    @Override
    public void fillCsvDataWithoutDependency(List<?> csvData) throws CsvParseException {
        int fieldNumber = 0;
        try {
            this.setIdCsvSeiIndustrialRDContract(RequestParser.getAsInteger(csvData.get(fieldNumber++)));
            this.setStartDate(RequestParser.getAsDateCsvFormat(csvData.get(fieldNumber++)));
            this.setNameCompanyInvolved(RequestParser.getAsString(csvData.get(fieldNumber++)));
            this.setProjectTitle(RequestParser.getAsString(csvData.get(fieldNumber++)));
            this.setAgreementAmount(RequestParser.getAsInteger(csvData.get(fieldNumber++)));
            this.setEndDate(RequestParser.getAsDateCsvFormat(csvData.get(fieldNumber)));
        } catch (RequestParseException e) {
            throw new CsvParseException(e.getMessage() + " at column " + fieldNumber + " at id " + csvData);
        }
    }

    @Override
    public void initializeDependencies() throws CsvDependencyException {
        // get the activity
        CsvActivity csvActivityDep = this.activityIdCsvMap.get(this.getIdCsvSeiIndustrialRDContract());
        if (csvActivityDep == null) {
            throw new CsvDependencyException("No activity found for id " + this.getIdCsvSeiIndustrialRDContract());
        }
        this.setCsvActivity(csvActivityDep);
    }

    @Override
    public Activity convertToEntity() {
        Activity activity = this.getCsvActivity().convertToEntity();
        activity.setIdTypeActivity(TypeActivity.IdTypeActivity.SEI_INDUSTRIAL_R_D_CONTRACT.getId());
        SeiIndustrialRDContract seiIndustrialRDContract = new SeiIndustrialRDContract();
        seiIndustrialRDContract.setStartDate(this.getStartDate());
        seiIndustrialRDContract.setNameCompanyInvolved(this.getNameCompanyInvolved());
        seiIndustrialRDContract.setProjectTitle(this.getProjectTitle());
        seiIndustrialRDContract.setAgreementAmount(this.getAgreementAmount());
        seiIndustrialRDContract.setEndDate(this.getEndDate());

        activity.setSeiIndustrialRDContract(seiIndustrialRDContract);
        seiIndustrialRDContract.setActivity(activity);
        return activity;
    }

    @Override
    public String getMergingKey() {
        return (this.getCsvActivity().getCsvResearcher().getIdDatabase()
                + "_" + this.getStartDate()
                + "_" + this.getNameCompanyInvolved()
                + "_" + this.getProjectTitle()
                + "_" + this.getAgreementAmount()
                + "_" + this.getEndDate()).toLowerCase();
    }

    @Override
    public String getMergingKey(Activity entity) {
        return (entity.getResearcherList().get(0).getResearcherId()
                + "_" + entity.getSeiIndustrialRDContract().getStartDate()
                + "_" + entity.getSeiIndustrialRDContract().getNameCompanyInvolved()
                + "_" + entity.getSeiIndustrialRDContract().getProjectTitle()
                + "_" + entity.getSeiIndustrialRDContract().getAgreementAmount()
                + "_" + entity.getSeiIndustrialRDContract().getEndDate()).toLowerCase();
    }

    @Override
    public void setIdDatabaseFromEntity(Activity entity) {
        this.setIdDatabase(entity.getIdActivity());
    }

    @Override
    public Integer getIdCsv() {
        return this.getIdCsvSeiIndustrialRDContract();
    }
}
