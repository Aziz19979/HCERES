package org.centrale.hceres.service.csv;

import lombok.Data;
import org.centrale.hceres.dto.csv.CsvTypeActivity;
import org.centrale.hceres.dto.csv.ImportCsvSummary;
import org.centrale.hceres.dto.csv.utils.InDependentCsv;
import org.centrale.hceres.items.TypeActivity;
import org.centrale.hceres.repository.TypeActivityRepository;
import org.centrale.hceres.service.csv.util.InDependentCsvImporter;
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
     * @param typeActivityRows list of array having fields as defined in csv
     * @param importCsvSummary
     * @return map from csv TypeActivity id to the ImportedTypeActivity object
     */
    public Map<Integer, InDependentCsv<TypeActivity>> importCsvList(List<?> typeActivityRows, ImportCsvSummary importCsvSummary) {
        return new InDependentCsvImporter<TypeActivity>()
                .importCsvList(typeActivityRows,
                        CsvTypeActivity::new,
                        typeActivityRepository,
                        SupportedCsvFormat.TYPE_ACTIVITY,
                        importCsvSummary);
    }
}
