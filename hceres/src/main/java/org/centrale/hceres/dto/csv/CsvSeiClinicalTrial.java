package org.centrale.hceres.dto.csv;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.centrale.hceres.dto.csv.utils.CsvDependencyException;
import org.centrale.hceres.dto.csv.utils.CsvParseException;
import org.centrale.hceres.dto.csv.utils.DependentCsv;
import org.centrale.hceres.dto.csv.utils.GenericCsv;
import org.centrale.hceres.items.Activity;
import org.centrale.hceres.items.Researcher;
import org.centrale.hceres.items.SeiClinicalTrial;
import org.centrale.hceres.items.TypeActivity;
import org.centrale.hceres.util.RequestParseException;
import org.centrale.hceres.util.RequestParser;

import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Map;

@EqualsAndHashCode(callSuper = true)
@Data
public class CsvSeiClinicalTrial extends DependentCsv<Activity, Integer> {
//    id_activity;start_date;coordinator_partner;title_clinical_trial;end_date;registration_nb;sponsor_name;included_patients_nb;funding;funding_amount

    // important the read field of name id_activity isn't the same
    // id activity in activity.csv
    // to get the id activity use both key:
    // the type of activity and the specific count
    private Integer idCsvSeiClinicalTrial;
    private Date startDate;
    private Boolean coordinatorPartner;
    private String titleClinicalTrial;
    private Date endDate;
    private String registrationNb;
    private String sponsorName;
    private Integer includedPatientsNb;
    private String funding;
    private Integer fundingAmount;

    // dependency element
    private CsvActivity csvActivity;
    private Map<Integer, CsvActivity> activityIdCsvMap;

    public CsvSeiClinicalTrial(Map<Integer, CsvActivity> activityIdCsvMap) {
        this.activityIdCsvMap = activityIdCsvMap;
    }

    @Override
    public void fillCsvDataWithoutDependency(List<?> csvData) throws CsvParseException {
        int fieldNumber = 0;
        try {
            this.setIdCsvSeiClinicalTrial(RequestParser.getAsInteger(csvData.get(fieldNumber++)));
            this.setStartDate(RequestParser.getAsDateCsvFormat(csvData.get(fieldNumber++)));
            this.setCoordinatorPartner(RequestParser.getAsBoolean(csvData.get(fieldNumber++)));
            this.setTitleClinicalTrial(RequestParser.getAsString(csvData.get(fieldNumber++)));
            this.setEndDate(RequestParser.getAsDateCsvFormat(csvData.get(fieldNumber++)));
            this.setRegistrationNb(RequestParser.getAsString(csvData.get(fieldNumber++)));
            this.setSponsorName(RequestParser.getAsString(csvData.get(fieldNumber++)));
            this.setIncludedPatientsNb(RequestParser.getAsInteger(csvData.get(fieldNumber++)));
            this.setFunding(RequestParser.getAsString(csvData.get(fieldNumber++)));
            this.setFundingAmount(RequestParser.getAsInteger(csvData.get(fieldNumber)));
        } catch (RequestParseException e) {
            throw new CsvParseException(e.getMessage() + " at column " + fieldNumber + " at id " + csvData);
        }
    }

    @Override
    public void initializeDependencies() throws CsvDependencyException {
        // get the activity
        CsvActivity csvActivityDep = this.activityIdCsvMap.get(this.getIdCsvSeiClinicalTrial());
        if (csvActivityDep == null) {
            throw new CsvDependencyException("No activity found for id " + this.getIdCsvSeiClinicalTrial());
        }
        this.setCsvActivity(csvActivityDep);
    }

    @Override
    public Activity convertToEntity() {
        Activity activity = this.getCsvActivity().convertToEntity();
        activity.setIdTypeActivity(TypeActivity.IdTypeActivity.SEI_CLINICAL_TRIAL.getId());
        SeiClinicalTrial seiClinicalTrial = new SeiClinicalTrial();
        seiClinicalTrial.setStartDate(this.getStartDate());
        seiClinicalTrial.setCoordinatorPartner(this.getCoordinatorPartner());
        seiClinicalTrial.setTitleClinicalTrial(this.getTitleClinicalTrial());
        seiClinicalTrial.setEndDate(this.getEndDate());
        seiClinicalTrial.setRegistrationNb(this.getRegistrationNb());
        seiClinicalTrial.setSponsorName(this.getSponsorName());
        seiClinicalTrial.setIncludedPatientsNb(this.getIncludedPatientsNb());
        seiClinicalTrial.setFunding(this.getFunding());
        seiClinicalTrial.setFundingAmount(this.getFundingAmount());

        activity.setSeiClinicalTrial(seiClinicalTrial);
        seiClinicalTrial.setActivity(activity);
        return activity;
    }

    @Override
    public String getMergingKey() {
        return (this.getCsvActivity().getCsvResearcher().getIdDatabase()
                + "_" + this.getStartDate()
                + "_" + this.getCoordinatorPartner()
                + "_" + this.getTitleClinicalTrial()
                + "_" + this.getEndDate()
                + "_" + this.getRegistrationNb()
                + "_" + this.getSponsorName()
                + "_" + this.getIncludedPatientsNb()
                + "_" + this.getFunding()
                + "_" + this.getFundingAmount()).toLowerCase();
    }

    @Override
    public String getMergingKey(Activity entity) {
        return (entity.getResearcherList().get(0).getResearcherId()
                + "_" + entity.getSeiClinicalTrial().getStartDate()
                + "_" + entity.getSeiClinicalTrial().getCoordinatorPartner()
                + "_" + entity.getSeiClinicalTrial().getTitleClinicalTrial()
                + "_" + entity.getSeiClinicalTrial().getEndDate()
                + "_" + entity.getSeiClinicalTrial().getRegistrationNb()
                + "_" + entity.getSeiClinicalTrial().getSponsorName()
                + "_" + entity.getSeiClinicalTrial().getIncludedPatientsNb()
                + "_" + entity.getSeiClinicalTrial().getFunding()
                + "_" + entity.getSeiClinicalTrial().getFundingAmount()).toLowerCase();
    }

    @Override
    public void setIdDatabaseFromEntity(Activity entity) {
        this.setIdDatabase(entity.getIdActivity());
    }

    @Override
    public Integer getIdCsv() {
        return this.getIdCsvSeiClinicalTrial();
    }
}
