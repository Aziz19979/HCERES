package org.centrale.hceres.service.csv;

import lombok.Data;
import org.centrale.hceres.dto.csv.CsvResearcher;
import org.centrale.hceres.dto.csv.CsvTypeActivity;
import org.centrale.hceres.dto.csv.ImportCsvSummary;
import org.centrale.hceres.dto.csv.utils.IndependentCsv;
import org.centrale.hceres.items.Researcher;
import org.centrale.hceres.items.TypeActivity;
import org.centrale.hceres.repository.TypeActivityRepository;
import org.centrale.hceres.service.csv.util.ImportIndependentCsv;
import org.centrale.hceres.service.csv.util.SupportedCsvFormat;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.lang.reflect.InvocationTargetException;
import java.util.*;

@Data
@Service
public class ImportCsvTypeActivity {
    @Autowired
    private TypeActivityRepository typeActivityRepository;

    /**
     * @param typeActivityRows  list of array having fields as defined in csv
     * @param importCsvSummary
     * @return map from csv TypeActivity id to the ImportedTypeActivity object
     */
    public Map<Integer, IndependentCsv<TypeActivity>> importCsvList(List<?> typeActivityRows, ImportCsvSummary importCsvSummary) {
        try {
            return new ImportIndependentCsv<TypeActivity>()
                    .importCsvList(typeActivityRows,
                            CsvTypeActivity.class,
                            typeActivityRepository,
                            SupportedCsvFormat.TYPE_ACTIVITY,
                            importCsvSummary);
        } catch (NoSuchMethodException | InvocationTargetException | InstantiationException | IllegalAccessException e) {
            return new HashMap<>();
        }
    }
}
