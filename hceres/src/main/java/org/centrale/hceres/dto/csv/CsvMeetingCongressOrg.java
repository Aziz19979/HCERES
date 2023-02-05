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
public class CsvMeetingCongressOrg extends DependentCsv<Activity, Integer> {

    private Integer idCsvMeetingCongressOrg;

    private Integer year;
    private Integer idType;
    private String nameCongress;
    private Date date;
    private String location;



    // dependency element
    private CsvActivity csvActivity;
    private Map<Integer, CsvActivity> activityIdCsvMap;

    public CsvMeetingCongressOrg(Map<Integer, CsvActivity> activityIdCsvMap) {
        this.activityIdCsvMap = activityIdCsvMap;
    }


    @Override
    public void fillCsvDataWithoutDependency(List<?> csvData) throws CsvParseException {
        int fieldNumber = 0;
        try {
            this.setIdCsvMeetingCongressOrg(RequestParser.getAsInteger(csvData.get(fieldNumber++)));
            this.setYear(RequestParser.getAsInteger(csvData.get(fieldNumber++)));
            this.setIdType(RequestParser.getAsInteger(csvData.get(fieldNumber++)));
            this.setNameCongress(RequestParser.getAsString(csvData.get(fieldNumber++)));
            this.setDate(RequestParser.getAsDateCsvFormat(csvData.get(fieldNumber++)));
            this.setLocation(RequestParser.getAsString(csvData.get(fieldNumber)));
        } catch (RequestParseException e) {
            throw new CsvParseException(e.getMessage() + " at column " + fieldNumber + " at id " + csvData);
        }
    }

    @Override
    public void initializeDependencies() throws CsvDependencyException {
        this.csvActivity = this.activityIdCsvMap.get(this.getIdCsvMeetingCongressOrg());
        if (this.csvActivity == null) {
            throw new CsvDependencyException("No activity found for id " + this.getIdCsvMeetingCongressOrg());
        }
    }

    @Override
    public Activity convertToEntity() {
        Activity activity = this.csvActivity.convertToEntity();
        activity.setIdTypeActivity(TypeActivity.IdTypeActivity.MEETING_CONGRESS_ORG.getId());

        MeetingCongressOrg meetingCongressOrg = new MeetingCongressOrg();

        Meeting meeting = new Meeting();
        meeting.setMeetingName(this.getNameCongress());
        if (this.getDate() != null) {
            meeting.setMeetingStart(this.getDate());
        }
        meeting.setMeetingYear(this.getYear());
        meeting.setMeetingLocation(this.getLocation());
        meetingCongressOrg.setMeeting(meeting);

        meetingCongressOrg.setActivity(activity);

        activity.setMeetingCongressOrg(meetingCongressOrg);
        return activity;
    }

    @Override
    public String getMergingKey() {
        return (this.getCsvActivity().getCsvResearcher().getIdDatabase()
                + "_" + this.getDate()
                + "_" + this.getNameCongress()
                + "_" + this.getYear()
                + "_" + this.getLocation()).toLowerCase();
    }


    @Override
    public String getMergingKey(Activity entity) {
        return (entity.getResearcherList().get(0).getResearcherId()
                + "_" + entity.getMeetingCongressOrg().getMeeting().getMeetingStart()
                + "_" + entity.getMeetingCongressOrg().getMeeting().getMeetingName()
                + "_" + entity.getMeetingCongressOrg().getMeeting().getMeetingYear()
                + "_" + entity.getMeetingCongressOrg().getMeeting().getMeetingLocation()).toLowerCase();
    }

    @Override
    public void setIdDatabaseFromEntity(Activity entity) {
        this.setIdDatabase(entity.getIdActivity());
    }

    @Override
    public Integer getIdCsv() {
        return this.getIdCsvMeetingCongressOrg();
    }
}
