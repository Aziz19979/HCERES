package org.centrale.hceres.dto.csv;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.centrale.hceres.dto.csv.utils.CsvDependencyException;
import org.centrale.hceres.dto.csv.utils.CsvParseException;
import org.centrale.hceres.dto.csv.utils.DependentCsv;
import org.centrale.hceres.dto.csv.utils.GenericCsv;
import org.centrale.hceres.items.Activity;
import org.centrale.hceres.items.Researcher;
import org.centrale.hceres.items.InternationalCollaboration;
import org.centrale.hceres.items.TypeActivity;
import org.centrale.hceres.util.RequestParseException;
import org.centrale.hceres.util.RequestParser;

import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Map;

@EqualsAndHashCode(callSuper = true)
@Data
public class CsvInternationalCollaboration extends DependentCsv<Activity, Integer> {
    // important the read field of name id_activity isn't the same
    // id activity in activity.csv
    // to get the id activity use both key:
    // the type of activity and the specific count
    private Integer idCsvInternationalCollaboration;

    private Date dateProjectStart;
    private Integer idType;
    private String partnerEntity;
    private String countryStateCity;
    private String piPartners;
    private String mailPartners;
    private Boolean activeProject;
    private String refJointPublication;
    private Boolean umr1064Coordinated;
    private Boolean agreementSigned;
    private Integer numberResultingPublications;
    private String associatedFunding;


    // dependency element
    private CsvActivity csvActivity;
    private Map<Integer, CsvActivity> activityIdCsvMap;

    public CsvInternationalCollaboration(Map<Integer, CsvActivity> activityIdCsvMap) {
        this.activityIdCsvMap = activityIdCsvMap;
    }

    @Override
    public void fillCsvDataWithoutDependency(List<?> csvData) throws CsvParseException {
        int fieldNumber = 0;
        try {
            this.setIdCsvInternationalCollaboration(RequestParser.getAsInteger(csvData.get(fieldNumber++)));
            this.setDateProjectStart(RequestParser.getAsDateCsvFormat(csvData.get(fieldNumber++)));
            this.setIdType(RequestParser.getAsInteger(csvData.get(fieldNumber++)));
            this.setPartnerEntity(RequestParser.getAsString(csvData.get(fieldNumber++)));
            this.setCountryStateCity(RequestParser.getAsString(csvData.get(fieldNumber++)));
            this.setPiPartners(RequestParser.getAsString(csvData.get(fieldNumber++)));
            this.setMailPartners(RequestParser.getAsString(csvData.get(fieldNumber++)));
            this.setActiveProject(RequestParser.getAsBoolean(csvData.get(fieldNumber++)));
            this.setRefJointPublication(RequestParser.getAsString(csvData.get(fieldNumber++)));
            this.setUmr1064Coordinated(RequestParser.getAsBoolean(csvData.get(fieldNumber++)));
            this.setAgreementSigned(RequestParser.getAsBoolean(csvData.get(fieldNumber++)));
            this.setNumberResultingPublications(RequestParser.getAsIntegerOrDefault(csvData.get(fieldNumber++), 0));
            this.setAssociatedFunding(RequestParser.getAsString(csvData.get(fieldNumber)));
        } catch (RequestParseException e) {
            throw new CsvParseException(e.getMessage() + " at column " + fieldNumber + " at id " + csvData);
        }
    }

    @Override
    public void initializeDependencies() throws CsvDependencyException {
        // get the activity
        CsvActivity csvActivityDep = this.activityIdCsvMap.get(this.getIdCsvInternationalCollaboration());
        if (csvActivityDep == null) {
            throw new CsvDependencyException("No activity found for id " + this.getIdCsvInternationalCollaboration());
        }
        this.setCsvActivity(csvActivityDep);
    }

    @Override
    public Activity convertToEntity() {
        Activity activity = this.getCsvActivity().convertToEntity();
        activity.setIdTypeActivity(TypeActivity.IdTypeActivity.NATIONAL_INTERNATIONAL_COLLABORATION.getId());
        InternationalCollaboration internationalCollaboration = new InternationalCollaboration();
        internationalCollaboration.setDateProjectStart(this.getDateProjectStart());
        internationalCollaboration.setTypeCollabId(this.getIdType());
        internationalCollaboration.setPartnerEntity(this.getPartnerEntity());
        internationalCollaboration.setCountryStateCity(this.getCountryStateCity());
        internationalCollaboration.setPiPartners(this.getPiPartners());
        internationalCollaboration.setMailPartners(this.getMailPartners());
        internationalCollaboration.setActiveProject(this.getActiveProject());
        internationalCollaboration.setRefJointPublication(this.getRefJointPublication());
        internationalCollaboration.setUmrCoordinated(this.getUmr1064Coordinated());
        internationalCollaboration.setAgreementSigned(this.getAgreementSigned());
        internationalCollaboration.setNumberResultingPublications(this.getNumberResultingPublications());
        internationalCollaboration.setAssociatedFunding(this.getAssociatedFunding());

        activity.setInternationalCollaboration(internationalCollaboration);
        internationalCollaboration.setActivity(activity);
        return activity;
    }

    @Override
    public String getMergingKey() {
        return (this.getCsvActivity().getCsvResearcher().getIdDatabase()
                + "_" + this.getDateProjectStart()
                + "_" + this.getIdType()
                + "_" + this.getPartnerEntity()
                + "_" + this.getCountryStateCity()
                + "_" + this.getPiPartners()
                + "_" + this.getMailPartners()
                + "_" + this.getActiveProject()
                + "_" + this.getRefJointPublication()
                + "_" + this.getUmr1064Coordinated()
                + "_" + this.getAgreementSigned()
                + "_" + this.getNumberResultingPublications()
                + "_" + this.getAssociatedFunding()).toLowerCase();

    }

    @Override
    public String getMergingKey(Activity entity) {
        return (entity.getResearcherList().get(0).getResearcherId()
                + "_" + entity.getInternationalCollaboration().getDateProjectStart()
                + "_" + entity.getInternationalCollaboration().getTypeCollabId()
                + "_" + entity.getInternationalCollaboration().getPartnerEntity()
                + "_" + entity.getInternationalCollaboration().getCountryStateCity()
                + "_" + entity.getInternationalCollaboration().getPiPartners()
                + "_" + entity.getInternationalCollaboration().getMailPartners()
                + "_" + entity.getInternationalCollaboration().getActiveProject()
                + "_" + entity.getInternationalCollaboration().getRefJointPublication()
                + "_" + entity.getInternationalCollaboration().getUmrCoordinated()
                + "_" + entity.getInternationalCollaboration().getAgreementSigned()
                + "_" + entity.getInternationalCollaboration().getNumberResultingPublications()
                + "_" + entity.getInternationalCollaboration().getAssociatedFunding()).toLowerCase();

    }

    @Override
    public void setIdDatabaseFromEntity(Activity entity) {
        this.setIdDatabase(entity.getIdActivity());
    }

    @Override
    public Integer getIdCsv() {
        return this.getIdCsvInternationalCollaboration();
    }
}
