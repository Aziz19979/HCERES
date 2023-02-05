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

// currently invited oral communication does not have associated activity
// it seem that OralCommunication defined in the project correspond
// OralCommunicationPoster
@EqualsAndHashCode(callSuper = true)
@Data
public class CsvOralCommunicationPoster extends DependentCsv<Activity, Integer> {
    private Integer idCsvOralCommunication;
    private Integer year;
    private Integer idTypeCom;
    private Integer idChoiceMeeting;
    private String title;
    private String authors;
    private String nameMeeting;
    private Date date;
    private String location;



    // dependency element
    private CsvActivity csvActivity;
    private Map<Integer, CsvActivity> activityIdCsvMap;

    public CsvOralCommunicationPoster(Map<Integer, CsvActivity> activityIdCsvMap) {
        this.activityIdCsvMap = activityIdCsvMap;
    }

    @Override
    public void fillCsvDataWithoutDependency(List<?> csvData) throws CsvParseException {
        int fieldNumber = 0;
        try {
            this.setIdCsvOralCommunication(RequestParser.getAsInteger(csvData.get(fieldNumber++)));
            this.setYear(RequestParser.getAsInteger(csvData.get(fieldNumber++)));
            this.setIdTypeCom(RequestParser.getAsInteger(csvData.get(fieldNumber++)));
            this.setIdChoiceMeeting(RequestParser.getAsInteger(csvData.get(fieldNumber++)));
            this.setTitle(RequestParser.getAsString(csvData.get(fieldNumber++)));
            this.setAuthors(RequestParser.getAsString(csvData.get(fieldNumber++)));
            this.setNameMeeting(RequestParser.getAsString(csvData.get(fieldNumber++)));

            // there is a big problem parsing date in this field as it is not in the same format as the other date
            // it may contain also interval of dates
            // this.setDate(RequestParser.getAsDateCsvFormat(csvData.get(fieldNumber++)));
            Calendar calendar = Calendar.getInstance();
            calendar.set(Calendar.YEAR, this.getYear());
            this.setDate(calendar.getTime());
            fieldNumber++;
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
        // missing file type oral communication for this.getIdTypeCom()
        // currenlty taking 1 as default
        oralCommunication.setTypeOralCommunicationId(1);

        // field could not be interpreted this.getIdChoiceMeeting()

        oralCommunication.setOralCommunicationTitle(this.getTitle());
        oralCommunication.setOralCommunicationDat(this.getDate());
        oralCommunication.setAuthors(this.getAuthors());

        Meeting meeting = new Meeting();
        meeting.setMeetingName(this.getNameMeeting());
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(this.getDate());
        meeting.setMeetingYear(calendar.get(Calendar.YEAR));
        meeting.setMeetingStart(this.getDate());
        meeting.setMeetingLocation(this.getLocation());
        oralCommunication.setMeeting(meeting);

        oralCommunication.setActivity(activity);

        activity.setOralCommunication(oralCommunication);
        return activity;
    }


    @Override
    public String getMergingKey() {
        return (this.getCsvActivity().getCsvResearcher().getIdDatabase()
                + "_" + this.getDate()
                + "_" + this.getTitle()
                + "_" + this.getNameMeeting()
                + "_" + this.getDate()
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
