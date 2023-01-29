package org.centrale.hceres.service.csv;

import org.centrale.hceres.dto.csv.CsvActivity;
import org.centrale.hceres.dto.csv.ImportCsvSummary;
import org.centrale.hceres.dto.csv.utils.GenericCsv;
import org.centrale.hceres.items.*;
import org.centrale.hceres.service.csv.util.CsvTemplateException;
import org.centrale.hceres.service.csv.util.SupportedCsvTemplate;
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
    private ImportCsvTeam importCsvTeam;

    @Autowired
    private ImportCsvTypeActivity importCsvTypeActivity;

    @Autowired
    private ImportCsvActivity importCsvActivity;

    @Autowired
    private ImportCsvSrAward importCsvSrAward;


    /**
     * @param request map from csv format to list of csv rows
     * @return summary of import
     * @throws CsvTemplateException if csv format is not supported
     */
    public ImportCsvSummary importCsvData(@RequestBody Map<String, Object> request)
            throws CsvTemplateException {
        // reorder the map based on dependencies of csv format
        Map<SupportedCsvTemplate, List<?>> csvDataRequest = new TreeMap<>(SupportedCsvTemplate::compare);

        for (Map.Entry<String, Object> entry : request.entrySet()) {
            String csvFormat = entry.getKey();
            List<?> csvList = (List<?>) entry.getValue();
            try {
                SupportedCsvTemplate supportedCsvTemplate = SupportedCsvTemplate.valueOf(csvFormat);
                csvDataRequest.put(supportedCsvTemplate, csvList);
            } catch (IllegalArgumentException e) {
                e.printStackTrace();
                throw new CsvTemplateException(csvFormat + " format is not yet implemented in backend!");
            }
        }


        ImportCsvSummary importCsvSummary = new ImportCsvSummary();
        Map<Integer, GenericCsv<Researcher, Integer>> csvIdToResearcherMap = null;
        Map<Integer, GenericCsv<Institution, Integer>> csvIdToInstitutionMap = null;
        Map<Integer, GenericCsv<Laboratory, Integer>> csvIdToLaboratoryMap = null;
        Map<Integer, GenericCsv<Team, Integer>> csvIdToTeamMap = null;
        Map<Integer, GenericCsv<TypeActivity, Integer>> csvIdToTypeActivityMap = null;
        Map<TypeActivity.IdTypeActivity, Map<Integer, CsvActivity>> activityMap = null;
        for (Map.Entry<SupportedCsvTemplate, List<?>> entry : csvDataRequest.entrySet()) {
            SupportedCsvTemplate supportedCsvTemplate = entry.getKey();
            List<?> csvList = entry.getValue();
            switch (supportedCsvTemplate) {
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
                    assert csvIdToLaboratoryMap != null;
                    csvIdToTeamMap = importCsvTeam.importCsvList(csvList,
                            importCsvSummary,
                            csvIdToLaboratoryMap);
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
                    importCsvSrAward.importCsvList(csvList, importCsvSummary, activityMap.get(TypeActivity.IdTypeActivity.SR_AWARD));
                    break;
                default:
                    break;
            }
        }
        importCsvSummary.updateTotalActivityCount();
        return importCsvSummary;
    }
}
