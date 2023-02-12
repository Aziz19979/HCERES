package org.centrale.hceres.dto.csv;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.centrale.hceres.dto.csv.utils.CsvDependencyException;
import org.centrale.hceres.dto.csv.utils.CsvParseException;
import org.centrale.hceres.dto.csv.utils.DependentCsv;
import org.centrale.hceres.dto.csv.utils.GenericCsv;
import org.centrale.hceres.items.Activity;
import org.centrale.hceres.items.Researcher;
import org.centrale.hceres.items.Platform;
import org.centrale.hceres.items.TypeActivity;
import org.centrale.hceres.util.RequestParseException;
import org.centrale.hceres.util.RequestParser;

import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Map;

@EqualsAndHashCode(callSuper = true)
@Data
public class CsvPlatform extends DependentCsv<Activity, Integer> {
//    id_activity;creation_date;description;managers;affiliation;labellisation;open_private_researchers
    private Integer idCsvPlatform;

    private Date creationDate;
    private String description;
    private String managers;
    private String affiliation;
    private String labellisation;
    private Boolean openPrivateResearchers;

    // dependency element
    private CsvActivity csvActivity;
    private Map<Integer, CsvActivity> activityIdCsvMap;

    public CsvPlatform(Map<Integer, CsvActivity> activityIdCsvMap) {
        this.activityIdCsvMap = activityIdCsvMap;
    }

    @Override
    public void fillCsvDataWithoutDependency(List<?> csvData) throws CsvParseException {
        int fieldNumber = 0;
        try {
            this.setIdCsvPlatform(RequestParser.getAsInteger(csvData.get(fieldNumber++)));
            this.setCreationDate(RequestParser.getAsDateCsvFormat(csvData.get(fieldNumber++)));
            this.setDescription(RequestParser.getAsString(csvData.get(fieldNumber++)));
            this.setManagers(RequestParser.getAsString(csvData.get(fieldNumber++)));
            this.setAffiliation(RequestParser.getAsString(csvData.get(fieldNumber++)));
            this.setLabellisation(RequestParser.getAsString(csvData.get(fieldNumber++)));
            this.setOpenPrivateResearchers(RequestParser.getAsBoolean(csvData.get(fieldNumber)));
        } catch (RequestParseException e) {
            throw new CsvParseException(e.getMessage() + " at column " + fieldNumber + " at id " + csvData);
        }
    }

    @Override
    public void initializeDependencies() throws CsvDependencyException {
        // get the activity
        CsvActivity csvActivityDep = this.activityIdCsvMap.get(this.getIdCsvPlatform());
        if (csvActivityDep == null) {
            throw new CsvDependencyException("No activity found for id " + this.getIdCsvPlatform());
        }
        this.setCsvActivity(csvActivityDep);
    }

    @Override
    public Activity convertToEntity() {
        Activity activity = this.getCsvActivity().convertToEntity();
        activity.setIdTypeActivity(TypeActivity.IdTypeActivity.PLATFORM.getId());
        Platform platform = new Platform();
        platform.setCreationDate(this.getCreationDate());
        platform.setDescription(this.getDescription());
        platform.setManagers(this.getManagers());
        platform.setAffiliation(this.getAffiliation());
        platform.setLabellisation(this.getLabellisation());
        platform.setOpenPrivateResearchers(this.getOpenPrivateResearchers());
        activity.setPlatform(platform);
        platform.setActivity(activity);
        return activity;
    }

    @Override
    public String getMergingKey() {
        return (this.getCsvActivity().getCsvResearcher().getIdDatabase()
                + "_" + this.getCreationDate()
                + "_" + this.getDescription()
                + "_" + this.getManagers()
                + "_" + this.getAffiliation()
                + "_" + this.getLabellisation()
                + "_" + this.getOpenPrivateResearchers()).toLowerCase();
    }
    @Override
    public String getMergingKey(Activity entity) {
        return (entity.getResearcherList().get(0).getResearcherId()
                + "_" + entity.getPlatform().getCreationDate()
                + "_" + entity.getPlatform().getDescription()
                + "_" + entity.getPlatform().getManagers()
                + "_" + entity.getPlatform().getAffiliation()
                + "_" + entity.getPlatform().getLabellisation()
                + "_" + entity.getPlatform().getOpenPrivateResearchers()).toLowerCase();
    }

    @Override
    public void setIdDatabaseFromEntity(Activity entity) {
        this.setIdDatabase(entity.getIdActivity());
    }

    @Override
    public Integer getIdCsv() {
        return this.getIdCsvPlatform();
    }
}
