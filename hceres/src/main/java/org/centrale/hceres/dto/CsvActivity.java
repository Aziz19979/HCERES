package org.centrale.hceres.dto;

import lombok.Data;
import org.centrale.hceres.items.Activity;

/**
 * This class is used only for mapping between activityTemplate.csv and Researcher.csv
 */
@Data
public class CsvActivity {
    private int idCsvTypeActivity;

    private int idCsv;
    private int idDatabase;


    private int idCsvResearcher;

    // specific count along with idCsvTypeActivity give the id
    // of activity
    private int specificActivityCount;

    // ignored
    private String activityNameType;

    // dependency
    private CsvResearcher csvResearcher;
    private CsvTypeActivity csvTypeActivity;
}
