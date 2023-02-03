package org.centrale.hceres.dto.csv;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.centrale.hceres.dto.csv.utils.CsvParseException;
import org.centrale.hceres.dto.csv.utils.InDependentCsv;
import org.centrale.hceres.items.Language;
import org.centrale.hceres.util.RequestParseException;
import org.centrale.hceres.util.RequestParser;

import java.util.List;

@EqualsAndHashCode(callSuper = true)
@Data
public class CsvLanguage extends InDependentCsv<Language, Integer> {
    private String languageName;

    @Override
    public void fillCsvData(List<?> csvData) throws CsvParseException {
        int fieldNumber = 0;
        try {
            this.setIdCsv(RequestParser.getAsInteger(csvData.get(fieldNumber++)));
            this.setLanguageName(RequestParser.getAsString(csvData.get(fieldNumber)));
        } catch (RequestParseException e) {
            throw new CsvParseException(e.getMessage() + " at column " + fieldNumber + " at id " + csvData);
        }
    }

    @Override
    public Language convertToEntity() {
        Language language = new Language();
        language.setLanguageName(this.getLanguageName());
        return language;
    }

    @Override
    public String getMergingKey() {
        return (this.getLanguageName())
                .toLowerCase();
    }

    @Override
    public String getMergingKey(Language language) {
        return (language.getLanguageName())
                .toLowerCase();
    }

    @Override
    public void setIdDatabaseFromEntity(Language language) {
        setIdDatabase(language.getLanguageId());
    }
}
