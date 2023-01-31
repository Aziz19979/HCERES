package org.centrale.hceres.dto.csv;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.centrale.hceres.dto.csv.utils.CsvDependencyException;
import org.centrale.hceres.dto.csv.utils.CsvParseException;
import org.centrale.hceres.dto.csv.utils.DependentCsv;
import org.centrale.hceres.items.*;
import org.centrale.hceres.util.RequestParseException;
import org.centrale.hceres.util.RequestParser;

import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

@EqualsAndHashCode(callSuper = true)
@Data
public class CsvOralCommunication extends DependentCsv<Activity, Integer> {
    private Integer idCsvOralCommunication;
    private Date dateCommunication;
    private String title;
    private String nameMeeting;
    private Date dateMeeting;
    private String location;


    // dependency element
    private CsvActivity csvActivity;
    private Map<Integer, CsvActivity> activityIdCsvMap;

    public CsvOralCommunication(Map<Integer, CsvActivity> activityIdCsvMap) {
        this.activityIdCsvMap = activityIdCsvMap;
    }


    @Override
    public void fillCsvDataWithoutDependency(List<?> csvData) throws CsvParseException {
        int fieldNumber = 0;
        try {
            this.setIdCsvOralCommunication(RequestParser.getAsInteger(csvData.get(fieldNumber++)));
            this.setDateCommunication(RequestParser.getAsDateCsvFormat(csvData.get(fieldNumber++)));
            this.setTitle(RequestParser.getAsString(csvData.get(fieldNumber++)));
            this.setNameMeeting(RequestParser.getAsString(csvData.get(fieldNumber++)));
            this.setDateMeeting(RequestParser.getAsDateCsvFormat(csvData.get(fieldNumber++)));
            this.setLocation(RequestParser.getAsString(csvData.get(fieldNumber)));
        } catch (RequestParseException e) {
            throw new CsvParseException(e.getMessage() + " at column " + fieldNumber + " at id " + csvData);
        }
    }

    @Override
    public void initializeDependencies() throws CsvDependencyException {
        this.csvActivity = this.activityIdCsvMap.get(this.getIdCsvOralCommunication());
        if (this.csvActivity == null) {
            throw new CsvDependencyException("No activity found for id " + this.getIdCsvOralCommunication());
        }
    }

    @Override
    public Activity convertToEntity() {
        Activity activity = this.csvActivity.convertToEntity();
        activity.setIdTypeActivity(TypeActivity.IdTypeActivity.INVITED_ORAL_COMMUNICATION.getId());

        OralCommunication oralCommunication = new OralCommunication();
        oralCommunication.setOralCommunicationDat(this.getDateCommunication());
        oralCommunication.setOralCommunicationTitle(this.getTitle());
        // using default value for authors as imported by csv
        oralCommunication.setAuthors("Importé par csv");

        Meeting meeting = new Meeting();
        meeting.setMeetingName(this.getNameMeeting());
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(this.getDateMeeting());
        meeting.setMeetingYear(calendar.get(Calendar.YEAR));
        meeting.setMeetingStart(this.getDateMeeting());
        meeting.setMeetingLocation(this.getLocation());
        oralCommunication.setMeeting(meeting);

        // currently taking default type
        oralCommunication.setTypeOralCommunicationId(1);

        oralCommunication.setActivity(activity);

        activity.setOralCommunication(oralCommunication);
        return activity;
    }

    @Override
    public String getMergingKey() {
        return (this.getCsvActivity().getCsvResearcher().getIdDatabase()
                + "_" + this.getDateCommunication()
                + "_" + this.getTitle()
                + "_" + this.getNameMeeting()
                + "_" + this.getDateMeeting()
                + "_" + this.getLocation()).toLowerCase();
    }

    @Override
    public String getMergingKey(Activity entity) {
        return (entity.getResearcherList().get(0).getResearcherId()
                + "_" + entity.getOralCommunication().getOralCommunicationDat()
                + "_" + entity.getOralCommunication().getOralCommunicationTitle()
                + "_" + entity.getOralCommunication().getMeeting().getMeetingName()
                + "_" + entity.getOralCommunication().getMeeting().getMeetingStart()
                + "_" + entity.getOralCommunication().getMeeting().getMeetingLocation()).toLowerCase();
    }

    @Override
    public void setIdDatabaseFromEntity(Activity entity) {
        this.setIdDatabase(entity.getIdActivity());
    }

    @Override
    public Integer getIdCsv() {
        return this.getIdCsvOralCommunication();
    }
}
