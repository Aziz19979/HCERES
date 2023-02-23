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
// it seem that OralComPoster defined in the project correspond
// OralComPoster
@EqualsAndHashCode(callSuper = true)
@Data
public class CsvOralComPoster extends DependentCsv<Activity, Integer> {
    // important the read field of name id_activity isn't the same
    // id activity in activity.csv
    // to get the id activity use both key:
    // the type of activity and the specific count
    private Integer idCsvOralComPoster;
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

    public CsvOralComPoster(Map<Integer, CsvActivity> activityIdCsvMap) {
        this.activityIdCsvMap = activityIdCsvMap;
    }

    @Override
    public void fillCsvDataWithoutDependency(List<?> csvData) throws CsvParseException {
        int fieldNumber = 0;
        try {
            this.setIdCsvOralComPoster(RequestParser.getAsInteger(csvData.get(fieldNumber++)));
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
        this.csvActivity = this.activityIdCsvMap.get(this.getIdCsvOralComPoster());
        if (this.csvActivity == null) {
            throw new CsvDependencyException("No activity found for id " + this.getIdCsvOralComPoster());
        }
    }

    @Override
    public Activity convertToEntity() {
        Activity activity = this.csvActivity.convertToEntity();
        activity.setIdTypeActivity(TypeActivity.IdTypeActivity.INVITED_ORAL_COMMUNICATION.getId());

        OralComPoster oralComPoster = new OralComPoster();
        // direct use of id present in database via sql type_oral_com_poster
        oralComPoster.setTypeOralComPosterId(this.getIdTypeCom());

        // field could not be interpreted this.getIdChoiceMeeting()

        oralComPoster.setOralComPosterTitle(this.getTitle());
        oralComPoster.setOralComPosterDate(this.getDate());
        oralComPoster.setAuthors(this.getAuthors());

        Meeting meeting = new Meeting();
        meeting.setMeetingName(this.getNameMeeting());
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(this.getDate());
        meeting.setMeetingYear(calendar.get(Calendar.YEAR));
        meeting.setMeetingStart(this.getDate());
        meeting.setMeetingLocation(this.getLocation());
        oralComPoster.setMeeting(meeting);

        oralComPoster.setActivity(activity);

        activity.setOralComPoster(oralComPoster);
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
                + "_" + entity.getOralComPoster().getOralComPosterDate()
                + "_" + entity.getOralComPoster().getOralComPosterTitle()
                + "_" + entity.getOralComPoster().getMeeting().getMeetingName()
                + "_" + entity.getOralComPoster().getMeeting().getMeetingStart()
                + "_" + entity.getOralComPoster().getMeeting().getMeetingLocation()).toLowerCase();
    }

    @Override
    public void setIdDatabaseFromEntity(Activity entity) {
        this.setIdDatabase(entity.getIdActivity());
    }

    @Override
    public Integer getIdCsv() {
        return this.getIdCsvOralComPoster();
    }
}
