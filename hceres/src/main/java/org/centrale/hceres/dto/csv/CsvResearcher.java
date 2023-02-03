package org.centrale.hceres.dto.csv;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.centrale.hceres.dto.csv.utils.CsvParseException;
import org.centrale.hceres.dto.csv.utils.InDependentCsv;
import org.centrale.hceres.items.Researcher;
import org.centrale.hceres.util.RequestParseException;
import org.centrale.hceres.util.RequestParser;

import java.util.List;

@EqualsAndHashCode(callSuper = true)
@Data
public class CsvResearcher extends InDependentCsv<Researcher, Integer> {
    // id Database is generated on insert to database, either found by defined merging rules
    private String researcherSurname;
    private String researcherName;
    private String researcherEmail;


    @Override
    public void fillCsvData(List<?> csvData) throws CsvParseException {
        int fieldNumber = 0;
        try {
            this.setIdCsv(RequestParser.getAsInteger(csvData.get(fieldNumber++)));
            this.setResearcherSurname(RequestParser.getAsString(csvData.get(fieldNumber++)));
            this.setResearcherName(RequestParser.getAsString(csvData.get(fieldNumber++)));
            this.setResearcherEmail(RequestParser.getAsString(csvData.get(fieldNumber)));
        } catch (RequestParseException e) {
            throw new CsvParseException(e.getMessage() + " at column " + fieldNumber + " at id " + csvData);
        }
    }
    @Override
    public Researcher convertToEntity() {
        Researcher researcher = new Researcher();
        researcher.setResearcherSurname(this.getResearcherSurname());
        researcher.setResearcherName(this.getResearcherName());
        researcher.setResearcherEmail(this.getResearcherEmail());
        return researcher;
    }

    @Override
    public String getMergingKey() {
        return (this.getResearcherSurname()
                + this.getResearcherName()
                + this.getResearcherEmail())
                .toLowerCase();
    }

    @Override
    public String getMergingKey(Researcher researcher) {
        return (researcher.getResearcherSurname()
                + researcher.getResearcherName()
                + researcher.getResearcherEmail())
                .toLowerCase();
    }

    @Override
    public void setIdDatabaseFromEntity(Researcher researcher) {
        this.setIdDatabase(researcher.getResearcherId());
    }
}
