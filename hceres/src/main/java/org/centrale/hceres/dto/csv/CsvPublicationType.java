package org.centrale.hceres.dto.csv;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.centrale.hceres.dto.csv.utils.CsvParseException;
import org.centrale.hceres.dto.csv.utils.InDependentCsv;
import org.centrale.hceres.items.PublicationType;
import org.centrale.hceres.util.RequestParseException;
import org.centrale.hceres.util.RequestParser;

import java.util.List;

@EqualsAndHashCode(callSuper = true)
@Data
public class CsvPublicationType extends InDependentCsv<PublicationType, Integer> {
    private String publicationTypeName;

    @Override
    public void fillCsvData(List<?> csvData) throws CsvParseException {
        int fieldNumber = 0;
        try {
            this.setIdCsv(RequestParser.getAsInteger(csvData.get(fieldNumber++)));
            this.setPublicationTypeName(RequestParser.getAsString(csvData.get(fieldNumber)));
        } catch (RequestParseException e) {
            throw new CsvParseException(e.getMessage() + " at column " + fieldNumber + " at id " + csvData);
        }
    }

    @Override
    public PublicationType convertToEntity() {
        PublicationType publicationType = new PublicationType();
        publicationType.setPublicationTypeName(this.getPublicationTypeName());
        return publicationType;
    }

    @Override
    public String getMergingKey() {
        return (this.getPublicationTypeName())
                .toLowerCase();
    }

    @Override
    public String getMergingKey(PublicationType publicationType) {
        return (publicationType.getPublicationTypeName())
                .toLowerCase();
    }

    @Override
    public void setIdDatabaseFromEntity(PublicationType publicationType) {
        setIdDatabase(publicationType.getPublicationTypeId());
    }
}
