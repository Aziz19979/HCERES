package org.centrale.hceres.service.csv;

import org.centrale.hceres.dto.csv.CsvActivity;
import org.centrale.hceres.dto.csv.ImportCsvSummary;
import org.centrale.hceres.dto.csv.utils.GenericCsv;
import org.centrale.hceres.items.*;
import org.centrale.hceres.repository.LanguageRepository;
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
    private ImportCsvNationality importCsvNationality;


    @Autowired
    private ImportCsvInstitution importCsvInstitution;

    @Autowired
    private ImportCsvLaboratory importCsvLaboratory;

    @Autowired
    private ImportCsvTeam importCsvTeam;

    @Autowired
    private ImportCsvBelongsTeam importCsvBelongsTeam;

    @Autowired
    private ImportCsvTypeActivity importCsvTypeActivity;

    @Autowired
    private ImportCsvActivity importCsvActivity;

    @Autowired
    private ImportCsvSrAward importCsvSrAward;

    @Autowired
    private ImportCsvBook importCsvBook;

    @Autowired
    private ImportCsvOralCommunication importCsvOralCommunication;

    @Autowired
    private ImportCsvMeetingCongressOrg importCsvMeetingCongressOrg;

    @Autowired
    private ImportCsvInvitedSeminar importCsvInvitedSeminar;

    @Autowired
    private ImportCsvLanguage importCsvLanguage;

    @Autowired
    private LanguageRepository languageRepository;


    /**
     * @param request map from csv format to list of csv rows
     * @return summary of import
     * @throws CsvTemplateException if csv format is not supported
     */
    public ImportCsvSummary importCsvData(@RequestBody Map<String, Object> request)
            throws CsvTemplateException {
        // reorder the map based on dependencies of csv format
        Map<SupportedCsvTemplate, List<?>> csvDataRequest = new TreeMap<>(SupportedCsvTemplate::compare);
        LanguageCreatorCache languageCreatorCache = new LanguageCreatorCache(languageRepository);
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
        Map<String, GenericCsv<BelongsTeam, String>> csvIdToBelongsTeamMap = null;
        Map<Integer, GenericCsv<Nationality, Integer>> csvIdToNationalityMap = null;
        Map<Integer, GenericCsv<TypeActivity, Integer>> csvIdToTypeActivityMap = null;
        Map<TypeActivity.IdTypeActivity, Map<Integer, CsvActivity>> activityMap = null;
        Map<Integer, CsvActivity> specificActivityMap = null;
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
                    assert csvIdToTeamMap != null;
                    csvIdToBelongsTeamMap = importCsvBelongsTeam.importCsvList(csvList,
                            importCsvSummary,
                            csvIdToResearcherMap,
                            csvIdToTeamMap);
                    break;
                case NATIONALITY:
                    csvIdToNationalityMap = importCsvNationality.importCsvList(csvList, importCsvSummary);
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
                    specificActivityMap = activityMap.computeIfAbsent(TypeActivity.IdTypeActivity.SR_AWARD, k -> new HashMap<>());
                    importCsvSrAward.importCsvList(csvList, importCsvSummary, specificActivityMap);
                    break;
                case BOOK:
                    assert activityMap != null;
                    specificActivityMap = activityMap.computeIfAbsent(TypeActivity.IdTypeActivity.BOOK, k -> new HashMap<>());
                    importCsvBook.importCsvList(csvList, importCsvSummary,
                            specificActivityMap,
                            languageCreatorCache);
                    break;
                case INVITED_ORAL_COMMUNICATION:
                    assert activityMap != null;
                    specificActivityMap = activityMap.computeIfAbsent(TypeActivity.IdTypeActivity.INVITED_ORAL_COMMUNICATION, k -> new HashMap<>());
                    importCsvOralCommunication.importCsvList(csvList, importCsvSummary, specificActivityMap);
                    break;
                case MEETING_CONGRESS_ORG:
                    assert activityMap != null;
                    specificActivityMap = activityMap.computeIfAbsent(TypeActivity.IdTypeActivity.MEETING_CONGRESS_ORG, k -> new HashMap<>());
                    importCsvMeetingCongressOrg.importCsvList(csvList, importCsvSummary, specificActivityMap);
                    break;
                case INVITED_SEMINAR:
                    assert activityMap != null;
                    specificActivityMap = activityMap.computeIfAbsent(TypeActivity.IdTypeActivity.INVITED_SEMINAR, k -> new HashMap<>());
                    importCsvInvitedSeminar.importCsvList(csvList, importCsvSummary, specificActivityMap);
                    break;
                case LANGUAGE:
                    importCsvLanguage.importCsvList(csvList, importCsvSummary);
                    break;
                default:
                    break;
            }
        }
        importCsvSummary.updateTotalActivityCount();
        return importCsvSummary;
    }
}
