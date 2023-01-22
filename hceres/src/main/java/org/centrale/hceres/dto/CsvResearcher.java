package org.centrale.hceres.dto;

import lombok.Data;
import org.centrale.hceres.items.Researcher;

@Data
public class CsvResearcher {
    // id Database is generated on insert to database, either found by defined merging rules
    private int idCsv;
    private int idDatabase;
    private String researcherSurname;
    private String researcherName;
    private String researcherEmail;

    public Researcher convertToResearcher() {
        Researcher researcher = new Researcher();
        researcher.setResearcherSurname(this.getResearcherSurname());
        researcher.setResearcherName(this.getResearcherName());
        researcher.setResearcherEmail(this.getResearcherEmail());
        return researcher;
    }

    public static String getMergingKey(CsvResearcher csvResearcher) {
        return (csvResearcher.getResearcherSurname()
                + csvResearcher.getResearcherName()
                + csvResearcher.getResearcherEmail())
                .toLowerCase();
    }

    public static String getMergingKey(Researcher researcher) {
        return (researcher.getResearcherSurname()
                + researcher.getResearcherName()
                + researcher.getResearcherEmail())
                .toLowerCase();
    }
}
