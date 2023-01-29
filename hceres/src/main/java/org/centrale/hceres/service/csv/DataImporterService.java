package org.centrale.hceres.service.csv;

import org.centrale.hceres.dto.csv.CsvActivity;
import org.centrale.hceres.dto.csv.ImportCsvSummary;
import org.centrale.hceres.dto.csv.utils.DependentCsv;
import org.centrale.hceres.dto.csv.utils.InDependentCsv;
import org.centrale.hceres.items.Institution;
import org.centrale.hceres.items.Laboratory;
import org.centrale.hceres.items.Researcher;
import org.centrale.hceres.items.TypeActivity;
import org.centrale.hceres.service.csv.util.CsvFormatNotSupportedException;
import org.centrale.hceres.service.csv.util.SupportedCsvFormat;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.*;

@Service
public class DataImporterService {

    @Autowired
    private ImportCsvResearcher importCsvResearcher;

    @Autowired
    private ImportCsvInstitution importCsvInstitution;

    @Autowired
    private ImportCsvLaboratory importCsvLaboratory;

    @Autowired
    private ImportCsvTypeActivity importCsvTypeActivity;

    @Autowired
    private ImportCsvActivity importCsvActivity;

    @Autowired
    private ImportCsvSrAward importCsvSrAward;


    /**
     * @param request map from csv format to list of csv rows
     * @return summary of import
     * @throws CsvFormatNotSupportedException if csv format is not supported
     */
    public ImportCsvSummary importCsvData(@RequestBody Map<String, Object> request)
            throws CsvFormatNotSupportedException {
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
                throw new CsvFormatNotSupportedException(csvFormat + " format is not yet implemented in backend!");
            }
        }


        ImportCsvSummary importCsvSummary = new ImportCsvSummary();
        Map<Integer, InDependentCsv<Researcher>> csvIdToResearcherMap = null;
        Map<Integer, InDependentCsv<Institution>> csvIdToInstitutionMap = null;
        Map<String, DependentCsv<Laboratory>> csvIdToLaboratoryMap = null;
        Map<Integer, InDependentCsv<TypeActivity>> csvIdToTypeActivityMap = null;
        Map<Integer, Map<Integer, CsvActivity>> activityMap = null;
        for (Map.Entry<SupportedCsvFormat, List<?>> entry : csvDataRequest.entrySet()) {
            SupportedCsvFormat supportedCsvFormat = entry.getKey();
            List<?> csvList = entry.getValue();
            switch (supportedCsvFormat) {
                case RESEARCHER:
                    csvIdToResearcherMap = importCsvResearcher.importCsvList(csvList, importCsvSummary);
                    break;
                case INSTITUTION:
                    csvIdToInstitutionMap = importCsvInstitution.importCsvList(csvList, importCsvSummary);
                    break;
                case LABORATORY:
                    assert csvIdToInstitutionMap != null;
                    csvIdToLaboratoryMap = importCsvLaboratory.importCsvList(csvList,
                            importCsvSummary,
                            csvIdToInstitutionMap);
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
                    assert activityMap != null;
                    importCsvSrAward.importCsvList(csvList, importCsvSummary, activityMap);
                    break;
                default:
                    break;
            }
        }
        return importCsvSummary;
    }
}
