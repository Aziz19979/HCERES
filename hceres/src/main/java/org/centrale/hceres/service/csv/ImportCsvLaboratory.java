package org.centrale.hceres.service.csv;

import org.centrale.hceres.dto.csv.CsvLaboratory;
import org.centrale.hceres.dto.csv.ImportCsvSummary;
import org.centrale.hceres.dto.csv.utils.DependentCsv;
import org.centrale.hceres.dto.csv.utils.InDependentCsv;
import org.centrale.hceres.items.Institution;
import org.centrale.hceres.items.Laboratory;
import org.centrale.hceres.items.Researcher;
import org.centrale.hceres.items.TypeActivity;
import org.centrale.hceres.repository.LaboratoryRepository;
import org.centrale.hceres.service.csv.util.DependentCsvImporter;
import org.centrale.hceres.service.csv.util.InDependentCsvImporter;
import org.centrale.hceres.service.csv.util.SupportedCsvFormat;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class ImportCsvLaboratory {

    @Autowired
    private LaboratoryRepository laboratoryRepository;

    public Map<String, DependentCsv<Laboratory>> importCsvList(List<?> laboratoryRows,
                                                               ImportCsvSummary importCsvSummary,
                                                               Map<Integer, InDependentCsv<Institution>> csvIdToInstitutionMap) {
        return new DependentCsvImporter<Laboratory>()
                .importCsvList(laboratoryRows,
                        () -> new CsvLaboratory(csvIdToInstitutionMap),
                        laboratoryRepository,
                        SupportedCsvFormat.LABORATORY,
                        importCsvSummary);
    }
}
