package org.centrale.hceres.dto.csv;

import lombok.Data;
import org.centrale.hceres.items.Activity;
import org.centrale.hceres.items.Researcher;
import org.centrale.hceres.items.SrAward;
import org.centrale.hceres.items.TypeActivity;

import java.util.Collections;
import java.util.Date;

@Data
public class CsvSrAward {

    // important the read field of name id_activity isn't the same
    // id activity in activity.csv
    // to get the id activity use both key:
    // the type of activity and the specific count
    private int idCsvSrAward;

    private Date awardDate;
    private String awardeeName;
    private String description;

    // dependency element
    private CsvActivity csvActivity;

    public Activity convertToActivity() {
        SrAward srAward = new SrAward();
        srAward.setAwardDate(this.getAwardDate());
        srAward.setAwardeeName(this.getAwardeeName());
        srAward.setDescription(this.getDescription());
        Activity activity = new Activity();
        srAward.setActivity(activity);
        activity.setSrAward(srAward);
        activity.setIdTypeActivity(TypeActivity.IdTypeActivity.SR_AWARD.getId());
        // currently using one researcher id
        activity.setResearcherList(
                Collections.singletonList(
                        new Researcher(
                                this.getCsvActivity().getCsvResearcher().getIdDatabase())));
        return activity;
    }

    public static String getMergingKey(CsvSrAward csvSrAward) {
        return (csvSrAward.getCsvActivity().getCsvResearcher().getIdDatabase()
                + "_" + csvSrAward.getAwardDate()
                + "_" + csvSrAward.getAwardeeName()
                + "_" + csvSrAward.getDescription()).toLowerCase();
    }

    public static String getMergingKey(SrAward srAward) {
        return (srAward.getActivity().getResearcherList().get(0).getResearcherId()
                + "_" + srAward.getAwardDate()
                + "_" + srAward.getAwardeeName()
                + "_" + srAward.getDescription()).toLowerCase();
    }

}
