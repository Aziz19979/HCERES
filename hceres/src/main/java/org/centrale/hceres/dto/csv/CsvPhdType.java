package org.centrale.hceres.dto.csv;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.centrale.hceres.dto.csv.utils.CsvParseException;
import org.centrale.hceres.dto.csv.utils.InDependentCsv;
import org.centrale.hceres.items.PhdType;
import org.centrale.hceres.util.RequestParseException;
import org.centrale.hceres.util.RequestParser;

import java.util.List;

@EqualsAndHashCode(callSuper = true)
@Data
public class CsvPhdType extends InDependentCsv<PhdType, Integer> {
    private String phdTypeName;

    @Override
    public void fillCsvData(List<?> csvData) throws CsvParseException {
        int fieldNumber = 0;
        try {
            this.setIdCsv(RequestParser.getAsInteger(csvData.get(fieldNumber++)));
            this.setPhdTypeName(RequestParser.getAsString(csvData.get(fieldNumber)));
        } catch (RequestParseException e) {
            throw new CsvParseException(e.getMessage() + " at column " + fieldNumber + " at id " + csvData);
        }
    }

    @Override
    public PhdType convertToEntity() {
        PhdType phdType = new PhdType();
        phdType.setPhdTypeName(this.getPhdTypeName());
        return phdType;
    }

    @Override
    public String getMergingKey() {
        return (this.getPhdTypeName())
                .toLowerCase();
    }

    @Override
    public String getMergingKey(PhdType phdType) {
        return (phdType.getPhdTypeName())
                .toLowerCase();
    }

    @Override
    public void setIdDatabaseFromEntity(PhdType phdType) {
        setIdDatabase(phdType.getPhdTypeId());
    }
}
