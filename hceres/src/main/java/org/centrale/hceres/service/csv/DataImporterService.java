package org.centrale.hceres.service.csv;

import lombok.SneakyThrows;
import org.centrale.hceres.dto.CsvResearcher;
import org.centrale.hceres.dto.ImportCsvSummary;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;

import java.text.ParseException;
import java.util.*;

@Service
public class DataImporterService {

    @Autowired
    private ImportCsvResearcher importCsvResearcher;


    /**
     *
     * @param request Map from {@link SupportedCsvFormat} as String to array matching the specified format
     * @return
     * @throws ParseException
     * @throws FormatNotSupportedException
     */
    public ImportCsvSummary importCsvData(@RequestBody Map<String, Object> request)
            throws FormatNotSupportedException {
        // reorder the map based on dependencies of csv format
        Map<SupportedCsvFormat, List<?>> csvDataRequest = new TreeMap<>(SupportedCsvFormat::compare);

        for (Map.Entry<String,Object> entry : request.entrySet()) {
            String csvFormat = entry.getKey();
            List<?> csvList = (List<?>) entry.getValue();
            try {
                SupportedCsvFormat supportedCsvFormat = SupportedCsvFormat.valueOf(csvFormat);
                csvDataRequest.put(supportedCsvFormat, csvList);
            } catch (IllegalArgumentException e) {
                e.printStackTrace();
                throw new FormatNotSupportedException(csvFormat + " format is not yet implemented in backend!");
            }
        }


        ImportCsvSummary importCsvSummary = new ImportCsvSummary();
        Map<Integer, CsvResearcher> csvIdToResearcherMap;
        for (Map.Entry<SupportedCsvFormat, List<?>> entry : csvDataRequest.entrySet()) {
            SupportedCsvFormat supportedCsvFormat = entry.getKey();
            List<?> csvList = entry.getValue();
            switch (supportedCsvFormat) {
                case RESEARCHER:
                    csvIdToResearcherMap = importCsvResearcher.importCsvList(csvList, importCsvSummary);
                    break;
                case INSTITUTION:
                case LABORATORY:
                case TEAM:
                case BELONG_TEAM:
                case NATIONALITY:
                case TYPE_ACTIVITY:
                    
                    break;
                case ACTIVITY:
                case SR_AWARD:
                default:
                    break;
            }
        }
        return importCsvSummary;
    }
}
