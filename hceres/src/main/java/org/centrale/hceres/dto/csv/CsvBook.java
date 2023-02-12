package org.centrale.hceres.dto.csv;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.centrale.hceres.dto.csv.utils.CsvDependencyException;
import org.centrale.hceres.dto.csv.utils.CsvParseException;
import org.centrale.hceres.dto.csv.utils.DependentCsv;
import org.centrale.hceres.items.Activity;
import org.centrale.hceres.items.Book;
import org.centrale.hceres.items.TypeActivity;
import org.centrale.hceres.service.csv.LanguageCreatorCache;
import org.centrale.hceres.util.RequestParseException;
import org.centrale.hceres.util.RequestParser;

import java.util.Date;
import java.util.List;
import java.util.Map;

@EqualsAndHashCode(callSuper = true)
@Data
public class CsvBook extends DependentCsv<Activity, Integer> {
    // important the read field of name id_activity isn't the same
    // id activity in activity.csv
    // to get the id activity use both key:
    // the type of activity and the specific count
    private Integer idCsvBook;

    private Date publicationDate;
    private String title;
    private String editor;
    private String authors;
    private String language;


    // dependency element
    private CsvActivity csvActivity;
    private Map<Integer, CsvActivity> activityIdCsvMap;
    private LanguageCreatorCache languageCreatorCache;

    public CsvBook(Map<Integer, CsvActivity> activityIdCsvMap, LanguageCreatorCache languageCreatorCache) {
        this.activityIdCsvMap = activityIdCsvMap;
        this.languageCreatorCache = languageCreatorCache;
    }

    @Override
    public void fillCsvDataWithoutDependency(List<?> csvData) throws CsvParseException {
        int fieldNumber = 0;
        try {
            this.setIdCsvBook(RequestParser.getAsInteger(csvData.get(fieldNumber++)));
            this.setPublicationDate(RequestParser.getAsDateCsvFormat(csvData.get(fieldNumber++)));
            this.setTitle(RequestParser.getAsString(csvData.get(fieldNumber++)));
            this.setEditor(RequestParser.getAsString(csvData.get(fieldNumber++)));
            this.setAuthors(RequestParser.getAsString(csvData.get(fieldNumber++)));
            this.setLanguage(RequestParser.getAsString(csvData.get(fieldNumber)));
        } catch (RequestParseException e) {
            throw new CsvParseException(e.getMessage() + " at column " + fieldNumber + " at id " + csvData);
        }
    }

    @Override
    public void initializeDependencies() throws CsvDependencyException {
        this.csvActivity = this.activityIdCsvMap.get(this.getIdCsvBook());
        if (this.csvActivity == null) {
            throw new CsvDependencyException("Activity not found for id " + this.getIdCsvBook());
        }
    }

    @Override
    public Activity convertToEntity() {
        Activity activity = this.csvActivity.convertToEntity();
        activity.setIdTypeActivity(TypeActivity.IdTypeActivity.BOOK.getId());

        Book book = new Book();
        book.setPublicationDate(this.getPublicationDate());
        book.setTitle(this.getTitle());
        book.setEditor(this.getEditor());
        book.setAuthors(this.getAuthors());
        book.setLanguage(this.languageCreatorCache.getLanguage(this.getLanguage()));
        book.setLanguageId(this.languageCreatorCache.getLanguage(this.getLanguage()).getLanguageId());
        book.setActivity(activity);

        activity.setBook(book);
        return activity;
    }


    @Override
    public String getMergingKey() {
        return (this.getCsvActivity().getCsvResearcher().getIdDatabase()
                + "_" + this.getPublicationDate()
                + "_" + this.getTitle()
                + "_" + this.getEditor()
                + "_" + this.getAuthors()
                + "_" + this.getLanguage()).toLowerCase();
    }

    @Override
    public String getMergingKey(Activity entity) {
        return (entity.getResearcherList().get(0).getResearcherId()
                + "_" + entity.getBook().getPublicationDate()
                + "_" + entity.getBook().getTitle()
                + "_" + entity.getBook().getEditor()
                + "_" + entity.getBook().getAuthors()
                + "_" + entity.getBook().getLanguage().getLanguageName()).toLowerCase();
    }

    @Override
    public void setIdDatabaseFromEntity(Activity entity) {
        this.setIdDatabase(entity.getIdActivity());
    }

    @Override
    public Integer getIdCsv() {
        return this.getIdCsvBook();
    }
}
