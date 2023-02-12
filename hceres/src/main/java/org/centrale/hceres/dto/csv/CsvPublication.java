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

import java.math.BigDecimal;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Map;

@EqualsAndHashCode(callSuper = true)
@Data
public class CsvPublication extends DependentCsv<Activity, Integer> {
    // important the read field of name id_activity isn't the same
    // id activity in activity.csv
    // to get the id activity use both key:
    // the type of activity and the specific count
    private Integer idCsvPublication;

    private String title;
    private String authors;
    private String source;
    private Date publicationDate;
    private String pmid;
    private BigDecimal impactFactor;
    private Boolean clinic;
    private Boolean pdc;
    private Boolean colabInter;
    private Boolean colabIntraCrti;
    private Integer idChoice;

    // dependency element
    private CsvActivity csvActivity;
    private Map<Integer, CsvActivity> activityIdCsvMap;

    private GenericCsv<PublicationType, Integer> csvPublicationType;
    private Map<Integer, GenericCsv<PublicationType, Integer>> publicationTypeIdCsvMap;

    public CsvPublication(Map<Integer, CsvActivity> activityIdCsvMap, Map<Integer, GenericCsv<PublicationType, Integer>> publicationTypeIdCsvMap) {
        this.activityIdCsvMap = activityIdCsvMap;
        this.publicationTypeIdCsvMap = publicationTypeIdCsvMap;
    }

    @Override
    public void fillCsvDataWithoutDependency(List<?> csvData) throws CsvParseException {
        int fieldNumber = 0;
        try {
            this.setIdCsvPublication(RequestParser.getAsInteger(csvData.get(fieldNumber++)));
            this.setTitle(RequestParser.getAsString(csvData.get(fieldNumber++)));
            this.setAuthors(RequestParser.getAsString(csvData.get(fieldNumber++)));
            this.setSource(RequestParser.getAsString(csvData.get(fieldNumber++)));
            this.setPublicationDate(RequestParser.getAsDateCsvFormat(csvData.get(fieldNumber++)));
            this.setPmid(RequestParser.getAsString(csvData.get(fieldNumber++)));
            this.setImpactFactor(RequestParser.getAsBigDecimal(csvData.get(fieldNumber++)));
            this.setClinic(RequestParser.getAsBoolean(csvData.get(fieldNumber++)));
            this.setPdc(RequestParser.getAsBoolean(csvData.get(fieldNumber++)));
            this.setColabInter(RequestParser.getAsBoolean(csvData.get(fieldNumber++)));
            this.setColabIntraCrti(RequestParser.getAsBoolean(csvData.get(fieldNumber++)));
            this.setIdChoice(RequestParser.getAsInteger(csvData.get(fieldNumber)));
        } catch (RequestParseException e) {
            throw new CsvParseException(e.getMessage() + " at column " + fieldNumber + " at id " + csvData);
        }
    }

    @Override
    public void initializeDependencies() throws CsvDependencyException {
        // get the activity
        CsvActivity csvActivityDep = this.activityIdCsvMap.get(this.getIdCsvPublication());
        if (csvActivityDep == null) {
            throw new CsvDependencyException("No activity found for id " + this.getIdCsvPublication());
        }
        this.setCsvActivity(csvActivityDep);
        // get the publication type
        GenericCsv<PublicationType, Integer> csvPublicationTypeDep = this.publicationTypeIdCsvMap.get(this.getIdChoice());
        if (csvPublicationTypeDep == null) {
            throw new CsvDependencyException("No publication type found for id " + this.getIdChoice());
        }
        this.setCsvPublicationType(csvPublicationTypeDep);
    }

    @Override
    public Activity convertToEntity() {
        Activity activity = this.getCsvActivity().convertToEntity();
        activity.setIdTypeActivity(TypeActivity.IdTypeActivity.PUBLICATION.getId());
        Publication publication = new Publication();
        publication.setTitle(this.getTitle());
        publication.setAuthors(this.getAuthors());
        publication.setSource(this.getSource());
        publication.setPublicationDate(this.getPublicationDate());
        publication.setPmid(this.getPmid());
        publication.setImpactFactor(this.getImpactFactor());
        publication.setPublicationTypeId(this.getCsvPublicationType().getIdDatabase());
        activity.setResearcherList(Collections.singletonList(new Researcher(this.getCsvActivity().getCsvResearcher().getIdDatabase())));

        activity.setPublication(publication);
        publication.setActivity(activity);
        return activity;
    }

    @Override
    public String getMergingKey() {
        return (this.getCsvActivity().getCsvResearcher().getIdDatabase()
                + "_" + this.getTitle()
                + "_" + this.getAuthors()
                + "_" + this.getSource()
                + "_" + this.getPublicationDate()
                + "_" + this.getPmid()
                + "_" + this.getImpactFactor()
                + "_" + this.getCsvPublicationType().getIdDatabase()).toLowerCase();
    }

    @Override
    public String getMergingKey(Activity entity) {
        return (entity.getResearcherList().get(0).getResearcherId()
                + "_" + entity.getPublication().getTitle()
                + "_" + entity.getPublication().getAuthors()
                + "_" + entity.getPublication().getSource()
                + "_" + entity.getPublication().getPublicationDate()
                + "_" + entity.getPublication().getPmid()
                + "_" + entity.getPublication().getImpactFactor()
                + "_" + entity.getPublication().getPublicationTypeId()).toLowerCase();
    }

    @Override
    public void setIdDatabaseFromEntity(Activity entity) {
        this.setIdDatabase(entity.getIdActivity());
    }

    @Override
    public Integer getIdCsv() {
        return this.getIdCsvPublication();
    }
}
