package org.centrale.hceres.service.csv;

import lombok.Data;
import org.centrale.hceres.dto.csv.CsvActivity;
import org.centrale.hceres.dto.csv.CsvSeiIndustrialRDContract;
import org.centrale.hceres.dto.csv.ImportCsvSummary;
import org.centrale.hceres.dto.csv.utils.GenericCsv;
import org.centrale.hceres.items.Activity;
import org.centrale.hceres.items.TypeActivity;
import org.centrale.hceres.repository.ActivityRepository;
import org.centrale.hceres.service.csv.util.GenericCsvImporter;
import org.centrale.hceres.service.csv.util.SupportedCsvTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Data
@Service
public class ImportCsvSeiIndustrialRDContract {

    @Autowired
    private ActivityRepository activityRepo;

    /**
     * @param seiIndustrialRDContractRows      list of array having fields as defined in csv
     * @param importCsvSummary Summary of the import
     */
    public Map<Integer, GenericCsv<Activity, Integer>> importCsvList(List<?> seiIndustrialRDContractRows, ImportCsvSummary importCsvSummary,
                                                                    Map<Integer, CsvActivity> activityMap) {
        return new GenericCsvImporter<Activity, Integer>().importCsvList(
                seiIndustrialRDContractRows,
                () -> new CsvSeiIndustrialRDContract(activityMap),
                () -> activityRepo.findByIdTypeActivity(TypeActivity.IdTypeActivity.SEI_INDUSTRIAL_R_D_CONTRACT.getId()),
                activityRepo::saveAll,
                SupportedCsvTemplate.SEI_INDUSTRIAL_R_D_CONTRACT,
                importCsvSummary);
    }
}