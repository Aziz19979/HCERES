package org.centrale.hceres.dto.csv;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.centrale.hceres.dto.csv.utils.*;
import org.centrale.hceres.items.Activity;
import org.centrale.hceres.items.Institution;
import org.centrale.hceres.items.Researcher;
import org.centrale.hceres.items.TypeActivity;
import org.centrale.hceres.util.RequestParseException;
import org.centrale.hceres.util.RequestParser;

import java.util.Collections;
import java.util.List;
import java.util.Map;

/**
 * This class is used only for mapping between activityTemplate.csv and Researcher.csv
 */
@EqualsAndHashCode(callSuper = true)
@Data
public class CsvActivity extends DependentCsv<Activity, Integer> {
    // id_type;id_activity;id_researcher;specific_activity_count;activity_name_type
    private int idCsvTypeActivity;
    private GenericCsv<TypeActivity, Integer> csvTypeActivity;
    private final Map<Integer, GenericCsv<TypeActivity, Integer>> typeActivityIdCsvMap;

    private int idCsv;

    private int idCsvResearcher;
    private GenericCsv<Researcher, Integer> csvResearcher;
    private final Map<Integer, GenericCsv<Researcher, Integer>> researcherIdCsvMap;

    // specific count along with idCsvTypeActivity give the id
    // of activity
    private int specificActivityCount;

    // ignored
    private String activityNameType;

    public CsvActivity(Map<Integer, GenericCsv<TypeActivity, Integer>> typeActivityIdCsvMap,
                       Map<Integer, GenericCsv<Researcher, Integer>> researcherIdCsvMap) {
        this.typeActivityIdCsvMap = typeActivityIdCsvMap;
        this.researcherIdCsvMap = researcherIdCsvMap;
    }


    @Override
    public void fillCsvDataWithoutDependency(List<?> csvData) throws CsvParseException {
        int fieldNumber = 0;
        try {
            this.setIdCsvTypeActivity(RequestParser.getAsInteger(csvData.get(fieldNumber++)));
            this.setIdCsv(RequestParser.getAsInteger(csvData.get(fieldNumber++)));
            this.setIdCsvResearcher(RequestParser.getAsInteger(csvData.get(fieldNumber++)));
            this.setSpecificActivityCount(RequestParser.getAsInteger(csvData.get(fieldNumber++)));
            this.setActivityNameType(RequestParser.getAsString(csvData.get(fieldNumber)));
        } catch (RequestParseException e) {
            throw new CsvParseException(e.getMessage() + " at id " + this.getIdCsv() + " at column " + fieldNumber);
        }
    }

    @Override
    public void initializeDependencies() throws CsvDependencyException {
        this.csvTypeActivity = this.typeActivityIdCsvMap.get(this.idCsvTypeActivity);
        if (this.csvTypeActivity == null) {
            throw new CsvDependencyException("TypeActivity with id " + this.idCsvTypeActivity + " not found");
        }
        this.csvResearcher = this.researcherIdCsvMap.get(this.idCsvResearcher);
        if (this.csvResearcher == null) {
            throw new CsvDependencyException("Researcher with id " + this.idCsvResearcher + " not found");
        }
    }

    private static final String IMPLEMENTATION_ERROR = "Should not be called, convert Specific Activity instead";

    @Override
    public Activity convertToEntity() {
        Activity activity = new Activity();
        activity.setResearcherList(Collections.singletonList(new Researcher(this.csvResearcher.getIdDatabase())));
        return activity;
    }

    @Override
    public String getMergingKey() {
        throw new UnsupportedOperationException(IMPLEMENTATION_ERROR);
    }

    @Override
    public String getMergingKey(Activity entity) {
        throw new UnsupportedOperationException(IMPLEMENTATION_ERROR);
    }

    @Override
    public void setIdDatabaseFromEntity(Activity entity) {
        this.setIdDatabase(entity.getIdActivity());
    }

    @Override
    public Integer getIdCsv() {
        return this.idCsv;
    }
}
