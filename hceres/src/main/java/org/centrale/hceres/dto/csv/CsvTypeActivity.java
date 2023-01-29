package org.centrale.hceres.dto.csv;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.centrale.hceres.dto.csv.utils.CsvParseException;
import org.centrale.hceres.dto.csv.utils.IndependentCsv;
import org.centrale.hceres.items.TypeActivity;
import org.centrale.hceres.util.RequestParseException;
import org.centrale.hceres.util.RequestParser;

import java.util.List;

@EqualsAndHashCode(callSuper = true)
@Data
public class CsvTypeActivity extends IndependentCsv<TypeActivity> {
    private String nameType;

    @Override
    public void fillCsvInstitution(List<?> csvData) throws CsvParseException {
        int fieldNumber = 0;
        try {
            this.setIdCsv(RequestParser.getAsInteger(csvData.get(fieldNumber++)));
            this.setNameType(RequestParser.getAsString(csvData.get(fieldNumber)));
        } catch (RequestParseException e) {
            throw new CsvParseException(e.getMessage() + " at row " + this.getIdCsv() + " at column " + fieldNumber);
        }
    }

    @Override
    public TypeActivity convertToEntity() {
        TypeActivity typeActivity = new TypeActivity();
        // exception for idTypeActivity as it is fixed in application with enum
        typeActivity.setIdTypeActivity(this.getIdCsv());
        typeActivity.setNameType(this.getNameType());
        return typeActivity;
    }

    @Override
    public String getMergingKey() {
        return this.getIdCsv().toString();
    }

    /**
     * Type activity ids aren't question to change as hardcoded types are used in enum everywhere
     */
    @Override
    public String getMergingKey(TypeActivity typeActivity) {
        return typeActivity.getIdTypeActivity().toString();
    }

    @Override
    public void setIdDatabaseFromEntity(TypeActivity typeActivity) {
        setIdDatabase(typeActivity.getIdTypeActivity());
    }

}
