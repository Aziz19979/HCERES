package org.centrale.hceres.controller;

import org.centrale.hceres.dto.ImportCsvSummary;
import org.centrale.hceres.service.csv.DataImporterService;
import org.centrale.hceres.service.csv.DatabasePurger;
import org.centrale.hceres.service.csv.FormatNotSupportedException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.text.ParseException;
import java.util.Map;

@RestController
@CrossOrigin(originPatterns = "*")
public class DataImporterController {

    @Autowired
    private DataImporterService dataImporterService;

    /**
     * Import data present in csv files sent
     *
     * @return ImportCsvResults
     */
    @PostMapping(value = "/DataImporter/Import/CsvResults")
    public ImportCsvSummary importCsvData(@RequestBody Map<String, Object> request)
            throws FormatNotSupportedException {
        return dataImporterService.importCsvData(request);
    }
}
