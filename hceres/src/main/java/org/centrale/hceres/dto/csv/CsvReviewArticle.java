package org.centrale.hceres.dto.csv;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.centrale.hceres.dto.csv.utils.CsvDependencyException;
import org.centrale.hceres.dto.csv.utils.CsvParseException;
import org.centrale.hceres.dto.csv.utils.DependentCsv;
import org.centrale.hceres.items.Activity;
import org.centrale.hceres.items.ReviewArticle;
import org.centrale.hceres.items.TypeActivity;
import org.centrale.hceres.service.csv.JournalCreatorCache;
import org.centrale.hceres.util.RequestParseException;
import org.centrale.hceres.util.RequestParser;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

@EqualsAndHashCode(callSuper = true)
@Data
public class CsvReviewArticle extends DependentCsv<Activity, Integer> {
    // important the read field of name id_activity isn't the same
    // id activity in activity.csv
    // to get the id activity use both key:
    // the type of activity and the specific count
    private Integer idCsvReviewArticle;

    private Integer year;
    private String nameJournal;
    private Integer nbReviewedArticles;
    private BigDecimal impactFactorJournal;

    // dependency element
    private CsvActivity csvActivity;
    private Map<Integer, CsvActivity> activityIdCsvMap;

    private JournalCreatorCache journalCreatorCache;


    public CsvReviewArticle(Map<Integer, CsvActivity> activityIdCsvMap, JournalCreatorCache journalCreatorCache) {
        this.activityIdCsvMap = activityIdCsvMap;
        this.journalCreatorCache = journalCreatorCache;
    }

    @Override
    public void fillCsvDataWithoutDependency(List<?> csvData) throws CsvParseException {
        int fieldNumber = 0;
        try {
            this.setIdCsvReviewArticle(RequestParser.getAsInteger(csvData.get(fieldNumber++)));
            this.setYear(RequestParser.getAsInteger(csvData.get(fieldNumber++)));
            this.setNameJournal(RequestParser.getAsString(csvData.get(fieldNumber++)));
            this.setNbReviewedArticles(RequestParser.getAsInteger(csvData.get(fieldNumber++)));
            this.setImpactFactorJournal(RequestParser.getAsBigDecimal(csvData.get(fieldNumber)));
        } catch (RequestParseException e) {
            throw new CsvParseException(e.getMessage() + " at column " + fieldNumber + " at id " + csvData);
        }
    }

    @Override
    public void initializeDependencies() throws CsvDependencyException {
        // get the activity
        CsvActivity csvActivityDep = this.activityIdCsvMap.get(this.getIdCsvReviewArticle());
        if (csvActivityDep == null) {
            throw new CsvDependencyException("No activity found for id " + this.getIdCsvReviewArticle());
        }
        this.setCsvActivity(csvActivityDep);
    }

    @Override
    public Activity convertToEntity() {
        Activity activity = this.getCsvActivity().convertToEntity();
        activity.setIdTypeActivity(TypeActivity.IdTypeActivity.REVIEWING_JOURNAL_ARTICLES.getId());
        ReviewArticle reviewArticle = new ReviewArticle();
        reviewArticle.setYear(this.getYear());
        reviewArticle.setImpactFactor(this.getImpactFactorJournal());
        reviewArticle.setNbReviewedArticles(this.getNbReviewedArticles());
        reviewArticle.setJournal(this.journalCreatorCache.getOrCreateJournal(this.getNameJournal()));
        activity.setReviewArticle(reviewArticle);
        reviewArticle.setActivity(activity);
        return activity;
    }

    @Override
    public String getMergingKey() {
        return (this.getCsvActivity().getCsvResearcher().getIdDatabase()
                + "_" + this.getYear()
                + "_" + this.getNameJournal()
                + "_" + this.getNbReviewedArticles()
                + "_" + this.getImpactFactorJournal()).toLowerCase();
    }

    @Override
    public String getMergingKey(Activity entity) {
        return (entity.getResearcherList().get(0).getResearcherId()
                + "_" + entity.getReviewArticle().getYear()
                + "_" + entity.getReviewArticle().getJournal().getJournalName()
                + "_" + entity.getReviewArticle().getNbReviewedArticles()
                + "_" + entity.getReviewArticle().getImpactFactor()).toLowerCase();
    }

    @Override
    public void setIdDatabaseFromEntity(Activity entity) {
        this.setIdDatabase(entity.getIdActivity());
    }

    @Override
    public Integer getIdCsv() {
        return this.getIdCsvReviewArticle();
    }
}
