package org.centrale.hceres.dto.csv;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.centrale.hceres.dto.csv.utils.CsvParseException;
import org.centrale.hceres.dto.csv.utils.InDependentCsv;
import org.centrale.hceres.items.Institution;
import org.centrale.hceres.util.RequestParseException;
import org.centrale.hceres.util.RequestParser;

import java.util.List;

@EqualsAndHashCode(callSuper = true)
@Data
public class CsvInstitution extends InDependentCsv<Institution, Integer> {
    private String institutionName;

    @Override
    public void fillCsvData(List<?> csvData) throws CsvParseException {
        int fieldNumber = 0;
        try {
            this.setIdCsv(RequestParser.getAsInteger(csvData.get(fieldNumber++)));
            this.setInstitutionName(RequestParser.getAsString(csvData.get(fieldNumber)));
        } catch (RequestParseException e) {
            throw new CsvParseException(e.getMessage() + " at id " + this.getIdCsv() + " at column " + fieldNumber);
        }
    }

    @Override
    public Institution convertToEntity() {
        Institution institution = new Institution();
        institution.setInstitutionName(this.getInstitutionName());
        return institution;
    }

    @Override
    public String getMergingKey() {
        return (this.getInstitutionName())
                .toLowerCase();
    }

    @Override
    public String getMergingKey(Institution institution) {
        return (institution.getInstitutionName())
                .toLowerCase();
    }

    @Override
    public void setIdDatabaseFromEntity(Institution institution) {
        setIdDatabase(institution.getInstitutionId());
    }
}
