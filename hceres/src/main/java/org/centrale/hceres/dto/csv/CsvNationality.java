package org.centrale.hceres.dto.csv;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.centrale.hceres.dto.csv.utils.CsvParseException;
import org.centrale.hceres.dto.csv.utils.InDependentCsv;
import org.centrale.hceres.items.Nationality;
import org.centrale.hceres.util.RequestParseException;
import org.centrale.hceres.util.RequestParser;

import java.util.List;

@EqualsAndHashCode(callSuper = true)
@Data
public class CsvNationality extends InDependentCsv<Nationality, Integer> {
    private String nationalityName;

    @Override
    public void fillCsvData(List<?> csvData) throws CsvParseException {
        int fieldNumber = 0;
        try {
            this.setIdCsv(RequestParser.getAsInteger(csvData.get(fieldNumber++)));
            this.setNationalityName(RequestParser.getAsString(csvData.get(fieldNumber)));
        } catch (RequestParseException e) {
            throw new CsvParseException(e.getMessage() + " at column " + fieldNumber + " at id " + csvData);
        }
    }

    @Override
    public Nationality convertToEntity() {
        Nationality nationality = new Nationality();
        nationality.setNationalityName(this.getNationalityName());
        return nationality;
    }

    @Override
    public String getMergingKey() {
        return (this.getNationalityName())
                .toLowerCase();
    }

    @Override
    public String getMergingKey(Nationality nationality) {
        return (nationality.getNationalityName())
                .toLowerCase();
    }

    @Override
    public void setIdDatabaseFromEntity(Nationality nationality) {
        setIdDatabase(nationality.getNationalityId());
    }
}
