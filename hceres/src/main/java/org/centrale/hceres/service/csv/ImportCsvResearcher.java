package org.centrale.hceres.service.csv;

import lombok.Data;
import org.centrale.hceres.dto.csv.CsvResearcher;
import org.centrale.hceres.dto.csv.ImportCsvSummary;
import org.centrale.hceres.dto.csv.utils.InDependentCsv;
import org.centrale.hceres.items.Researcher;
import org.centrale.hceres.repository.ResearchRepository;
import org.centrale.hceres.service.csv.util.InDependentCsvImporter;
import org.centrale.hceres.service.csv.util.SupportedCsvFormat;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.lang.reflect.InvocationTargetException;
import java.util.*;

@Data
@Service
public class ImportCsvResearcher {
    /**
     * Instanciation de ResearchRepository
     */
    @Autowired
    private ResearchRepository researchRepo;

    /**
     * @param researchersRows  list of array having fields as defined in csv
     * @param importCsvSummary
     * @return map from csv researcher id to the ImportedResearcher object
     */
    public Map<Integer, InDependentCsv<Researcher>> importCsvList(List<?> researchersRows, ImportCsvSummary importCsvSummary) {
        return new InDependentCsvImporter<Researcher>()
                .importCsvList(researchersRows,
                        CsvResearcher::new,
                        researchRepo,
                        SupportedCsvFormat.RESEARCHER,
                        importCsvSummary);

    }
}
