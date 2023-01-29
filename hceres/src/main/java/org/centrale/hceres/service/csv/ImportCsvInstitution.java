package org.centrale.hceres.service.csv;


import org.centrale.hceres.dto.csv.CsvInstitution;
import org.centrale.hceres.dto.csv.ImportCsvSummary;
import org.centrale.hceres.dto.csv.utils.IndependentCsv;
import org.centrale.hceres.items.Institution;
import org.centrale.hceres.repository.InstitutionRepository;
import org.centrale.hceres.service.csv.util.ImportIndependentCsv;
import org.centrale.hceres.service.csv.util.SupportedCsvFormat;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.lang.reflect.InvocationTargetException;
import java.util.*;

@Service
public class ImportCsvInstitution {

    @Autowired
    private InstitutionRepository institutionRepository;

    /**
     * @param csvRows          List of csv data
     * @param importCsvSummary Summary of the import
     * @return Map from csv id to {@link CsvInstitution}
     */
    public Map<Integer, IndependentCsv<Institution>> importCsvList(List<?> csvRows, ImportCsvSummary importCsvSummary) {
        try {
            return new ImportIndependentCsv<Institution>()
                    .importCsvList(csvRows,
                            CsvInstitution.class,
                            institutionRepository,
                            SupportedCsvFormat.INSTITUTION,
                            importCsvSummary);
        } catch (NoSuchMethodException | InvocationTargetException | InstantiationException | IllegalAccessException e) {
            return new HashMap<>();
        }
    }
}
