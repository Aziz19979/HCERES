package org.centrale.hceres.dto.csv;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.centrale.hceres.dto.csv.utils.CsvParseException;
import org.centrale.hceres.dto.csv.utils.InDependentCsv;
import org.centrale.hceres.items.Status;
import org.centrale.hceres.util.RequestParseException;
import org.centrale.hceres.util.RequestParser;

import java.util.List;

@EqualsAndHashCode(callSuper = true)
@Data
public class CsvStatus extends InDependentCsv<Status, Integer> {
    private String statusName;

    @Override
    public void fillCsvData(List<?> csvData) throws CsvParseException {
        int fieldNumber = 0;
        try {
            this.setIdCsv(RequestParser.getAsInteger(csvData.get(fieldNumber++)));
            this.setStatusName(RequestParser.getAsString(csvData.get(fieldNumber)));
        } catch (RequestParseException e) {
            throw new CsvParseException(e.getMessage() + " at column " + fieldNumber + " at id " + csvData);
        }
    }

    @Override
    public Status convertToEntity() {
        Status status = new Status();
        status.setStatusName(this.getStatusName());
        return status;
    }

    @Override
    public String getMergingKey() {
        return (this.getStatusName())
                .toLowerCase();
    }

    @Override
    public String getMergingKey(Status status) {
        return (status.getStatusName())
                .toLowerCase();
    }

    @Override
    public void setIdDatabaseFromEntity(Status status) {
        setIdDatabase(status.getStatusId());
    }
}
