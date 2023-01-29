package org.centrale.hceres.service.csv;


import org.centrale.hceres.dto.csv.CsvInstitution;
import org.centrale.hceres.dto.csv.ImportCsvSummary;
import org.centrale.hceres.dto.csv.utils.InDependentCsv;
import org.centrale.hceres.items.Institution;
import org.centrale.hceres.repository.InstitutionRepository;
import org.centrale.hceres.service.csv.util.InDependentCsvImporter;
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
    public Map<Integer, InDependentCsv<Institution>> importCsvList(List<?> csvRows, ImportCsvSummary importCsvSummary) {
        return new InDependentCsvImporter<Institution>()
                .importCsvList(csvRows,
                        CsvInstitution::new,
                        institutionRepository,
                        SupportedCsvFormat.INSTITUTION,
                        importCsvSummary);
    }
}
