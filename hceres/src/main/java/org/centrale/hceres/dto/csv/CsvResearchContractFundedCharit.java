package org.centrale.hceres.dto.csv;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.centrale.hceres.dto.csv.utils.CsvDependencyException;
import org.centrale.hceres.dto.csv.utils.CsvParseException;
import org.centrale.hceres.dto.csv.utils.DependentCsv;
import org.centrale.hceres.items.Activity;
import org.centrale.hceres.items.ResearchContractFundedCharit;
import org.centrale.hceres.items.TypeActivity;
import org.centrale.hceres.util.RequestParseException;
import org.centrale.hceres.util.RequestParser;

import java.util.Date;
import java.util.List;
import java.util.Map;

@EqualsAndHashCode(callSuper = true)
@Data
public class CsvResearchContractFundedCharit extends DependentCsv<Activity, Integer> {

    // important the read field of name id_activity isn't the same
    // id activity in activity.csv
    // to get the id activity use both key:
    // the type of activity and the specific count
    private Integer idCsvResearchContractFundedCharit;

    private Date dateContractAward;
    private String fundingInstitution;
    private String projectTitle;
    private Integer startYear;
    private Integer endYear;
    private Integer grantAmount;
    private Integer idType;

    // dependency element
    private CsvActivity csvActivity;
    private Map<Integer, CsvActivity> activityIdCsvMap;

    public CsvResearchContractFundedCharit(Map<Integer, CsvActivity> activityIdCsvMap) {
        this.activityIdCsvMap = activityIdCsvMap;
    }

    @Override
    public void fillCsvDataWithoutDependency(List<?> csvData) throws CsvParseException {
        int fieldNumber = 0;
        try {
            this.setIdCsvResearchContractFundedCharit(RequestParser.getAsInteger(csvData.get(fieldNumber++)));
            this.setDateContractAward(RequestParser.getAsDateCsvFormat(csvData.get(fieldNumber++)));
            this.setFundingInstitution(RequestParser.getAsString(csvData.get(fieldNumber++)));
            this.setProjectTitle(RequestParser.getAsString(csvData.get(fieldNumber++)));
            this.setStartYear(RequestParser.getAsInteger(csvData.get(fieldNumber++)));
            this.setEndYear(RequestParser.getAsInteger(csvData.get(fieldNumber++)));
            this.setGrantAmount(RequestParser.getAsInteger(csvData.get(fieldNumber++)));
            this.setIdType(RequestParser.getAsInteger(csvData.get(fieldNumber++)));
        } catch (RequestParseException e) {
            throw new CsvParseException(e.getMessage() + " at column " + fieldNumber + " at id " + csvData);
        }
    }

    @Override
    public void initializeDependencies() throws CsvDependencyException {
        // get the activity
        CsvActivity csvActivityDep = this.activityIdCsvMap.get(this.getIdCsvResearchContractFundedCharit());
        if (csvActivityDep == null) {
            throw new CsvDependencyException("No activity found for id " + this.getIdCsvResearchContractFundedCharit());
        }
        this.setCsvActivity(csvActivityDep);
    }

    @Override
    public Activity convertToEntity() {
        Activity activity = this.getCsvActivity().convertToEntity();
        activity.setIdTypeActivity(TypeActivity.IdTypeActivity.RESEARCH_CONTRACT_FUNDED_PUBLIC_CHARITABLE_INST.getId());
        ResearchContractFundedCharit researchContractFundedCharit = new ResearchContractFundedCharit();
        researchContractFundedCharit.setDateContractAward(this.getDateContractAward());
        researchContractFundedCharit.setFundingInstitution(this.getFundingInstitution());
        researchContractFundedCharit.setProjectTitle(this.getProjectTitle());
        researchContractFundedCharit.setStartYear(this.getStartYear());
        researchContractFundedCharit.setEndYear(this.getEndYear());
        researchContractFundedCharit.setGrantAmount(this.getGrantAmount());
        researchContractFundedCharit.setTypeResearchContractId(this.getIdType());
        activity.setResearchContractFundedCharit(researchContractFundedCharit);
        researchContractFundedCharit.setActivity(activity);
        return activity;
    }

    @Override
    public String getMergingKey() {
        return (this.getCsvActivity().getCsvResearcher().getIdDatabase()
                + "_" + this.getDateContractAward()
                + "_" + this.getFundingInstitution()
                + "_" + this.getProjectTitle()
                + "_" + this.getStartYear()
                + "_" + this.getEndYear()
                + "_" + this.getGrantAmount()
                + "_" + this.getIdType()).toLowerCase();
    }

    @Override
    public String getMergingKey(Activity entity) {
        return (entity.getResearcherList().get(0).getResearcherId()
                + "_" + entity.getResearchContractFundedCharit().getDateContractAward()
                + "_" + entity.getResearchContractFundedCharit().getFundingInstitution()
                + "_" + entity.getResearchContractFundedCharit().getProjectTitle()
                + "_" + entity.getResearchContractFundedCharit().getStartYear()
                + "_" + entity.getResearchContractFundedCharit().getEndYear()
                + "_" + entity.getResearchContractFundedCharit().getGrantAmount()
                + "_" + entity.getResearchContractFundedCharit().getTypeResearchContractId()).toLowerCase();

    }

    @Override
    public void setIdDatabaseFromEntity(Activity entity) {
        this.setIdDatabase(entity.getIdActivity());
    }

    @Override
    public Integer getIdCsv() {
        return this.getIdCsvResearchContractFundedCharit();
    }
}
