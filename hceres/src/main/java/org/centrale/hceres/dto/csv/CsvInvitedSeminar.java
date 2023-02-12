package org.centrale.hceres.dto.csv;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.centrale.hceres.dto.csv.utils.CsvDependencyException;
import org.centrale.hceres.dto.csv.utils.CsvParseException;
import org.centrale.hceres.dto.csv.utils.DependentCsv;
import org.centrale.hceres.dto.csv.utils.GenericCsv;
import org.centrale.hceres.items.Activity;
import org.centrale.hceres.items.Researcher;
import org.centrale.hceres.items.InvitedSeminar;
import org.centrale.hceres.items.TypeActivity;
import org.centrale.hceres.util.RequestParseException;
import org.centrale.hceres.util.RequestParser;

import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Map;

@EqualsAndHashCode(callSuper = true)
@Data
public class CsvInvitedSeminar extends DependentCsv<Activity, Integer> {
    // important the read field of name id_activity isn't the same
    // id activity in activity.csv
    // to get the id activity use both key:
    // the type of activity and the specific count
    private Integer idCsvInvitedSeminar;
    private Date date;
    private String titleSeminar;
    private String location;
    private String invitedBy;

    // dependency element
    private CsvActivity csvActivity;
    private Map<Integer, CsvActivity> activityIdCsvMap;

    public CsvInvitedSeminar(Map<Integer, CsvActivity> activityIdCsvMap) {
        this.activityIdCsvMap = activityIdCsvMap;
    }


    @Override
    public void fillCsvDataWithoutDependency(List<?> csvData) throws CsvParseException {
int fieldNumber = 0;
        try {
            this.setIdCsvInvitedSeminar(RequestParser.getAsInteger(csvData.get(fieldNumber++)));
            this.setDate(RequestParser.getAsDateCsvFormat(csvData.get(fieldNumber++)));
            this.setTitleSeminar(RequestParser.getAsString(csvData.get(fieldNumber++)));
            this.setLocation(RequestParser.getAsString(csvData.get(fieldNumber++)));
            this.setInvitedBy(RequestParser.getAsString(csvData.get(fieldNumber)));
        } catch (RequestParseException e) {
            throw new CsvParseException(e.getMessage() + " at column " + fieldNumber + " at id " + csvData);
        }
    }

    @Override
    public void initializeDependencies() throws CsvDependencyException {
        this.setCsvActivity(this.activityIdCsvMap.get(this.getIdCsvInvitedSeminar()));
        if (this.getCsvActivity() == null) {
            throw new CsvDependencyException("Activity not found for id " + this.getIdCsvInvitedSeminar());
        }
    }

    @Override
    public Activity convertToEntity() {
        Activity activity = this.getCsvActivity().convertToEntity();
        activity.setIdTypeActivity(TypeActivity.IdTypeActivity.INVITED_SEMINAR.getId());
        InvitedSeminar invitedSeminar = new InvitedSeminar();
        invitedSeminar.setDate(this.getDate());
        invitedSeminar.setTitleSeminar(this.getTitleSeminar());
        invitedSeminar.setLocation(this.getLocation());
        invitedSeminar.setInvitedBy(this.getInvitedBy());
        invitedSeminar.setActivity(activity);
        activity.setInvitedSeminar(invitedSeminar);
        return activity;
    }

    @Override
    public String getMergingKey() {
        return (this.getCsvActivity().getCsvResearcher().getIdDatabase()
                + "_" + this.getDate()
                + "_" + this.getTitleSeminar()
                + "_" + this.getLocation()
                + "_" + this.getInvitedBy()).toLowerCase();
    }

    @Override
    public String getMergingKey(Activity entity) {
        return (entity.getResearcherList().get(0).getResearcherId()
                + "_" + entity.getInvitedSeminar().getDate()
                + "_" + entity.getInvitedSeminar().getTitleSeminar()
                + "_" + entity.getInvitedSeminar().getLocation()
                + "_" + entity.getInvitedSeminar().getInvitedBy()).toLowerCase();
    }

    @Override
    public void setIdDatabaseFromEntity(Activity entity) {
        this.setIdDatabase(entity.getIdActivity());
    }

    @Override
    public Integer getIdCsv() {
        return this.getIdCsvInvitedSeminar();
    }
}
