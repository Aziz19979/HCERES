package org.centrale.hceres.service.csv;

import org.centrale.hceres.dto.CsvActivity;
import org.centrale.hceres.dto.CsvResearcher;
import org.centrale.hceres.dto.CsvTypeActivity;
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

    @Autowired
    private ImportCsvTypeActivity importCsvTypeActivity;

    @Autowired
    private ImportCsvActivity importCsvActivity;

    @Autowired
    private ImportCsvSrAward importCsvSrAward;


    /**
     * @param request Map from {@link SupportedCsvFormat} as String to array matching the specified format
     * @return
     * @throws ParseException
     * @throws FormatNotSupportedException
     */
    public ImportCsvSummary importCsvData(@RequestBody Map<String, Object> request)
            throws FormatNotSupportedException {
        // reorder the map based on dependencies of csv format
        Map<SupportedCsvFormat, List<?>> csvDataRequest = new TreeMap<>(SupportedCsvFormat::compare);

        for (Map.Entry<String, Object> entry : request.entrySet()) {
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
        Map<Integer, CsvResearcher> csvIdToResearcherMap = null;
        Map<Integer, CsvTypeActivity> csvIdToTypeActivityMap = null;
        Map<Integer, Map<Integer, CsvActivity>> activityMap = null;
        for (Map.Entry<SupportedCsvFormat, List<?>> entry : csvDataRequest.entrySet()) {
            SupportedCsvFormat supportedCsvFormat = entry.getKey();
            List<?> csvList = entry.getValue();
            switch (supportedCsvFormat) {
                case RESEARCHER:
                    csvIdToResearcherMap = importCsvResearcher.importCsvList(csvList, importCsvSummary);
                    break;
                case INSTITUTION:
                    break;
                case LABORATORY:
                    break;
                case TEAM:
                    break;
                case BELONG_TEAM:
                    break;
                case NATIONALITY:
                    break;
                case TYPE_ACTIVITY:
                    csvIdToTypeActivityMap = importCsvTypeActivity.importCsvList(csvList, importCsvSummary);
                    break;
                case ACTIVITY:
                    activityMap = importCsvActivity.importCsvList(csvList,
                            importCsvSummary,
                            csvIdToResearcherMap,
                            csvIdToTypeActivityMap);
                    break;
                case SR_AWARD:
                    importCsvSrAward.importCsvList(csvList, importCsvSummary, activityMap);
                    break;
                default:
                    break;
            }
        }
        return importCsvSummary;
    }
}
