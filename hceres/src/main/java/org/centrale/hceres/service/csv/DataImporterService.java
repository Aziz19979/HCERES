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
    private ImportCsvPhdType importCsvPhdType;

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
    private ImportCsvInvitedOralCommunication importCsvInvitedOralCommunication;

    @Autowired
    private ImportCsvOralCommunicationPoster importCsvOralCommunicationPoster;

    @Autowired
    private ImportCsvMeetingCongressOrg importCsvMeetingCongressOrg;

    @Autowired
    private ImportCsvInvitedSeminar importCsvInvitedSeminar;

    @Autowired
    private ImportCsvLanguage importCsvLanguage;

    @Autowired
    private LanguageRepository languageRepository;

    @Autowired
    private ImportCsvPublicationType importCsvPublicationType;

    @Autowired
    private ImportCsvPublication importCsvPublication;

    @Autowired
    private ImportCsvStatus importCsvStatus;

    @Autowired
    private ImportCsvSeiClinicalTrial importCsvSeiClinicalTrial;

    @Autowired
    private ImportCsvPlatform importCsvPlatform;
    @Autowired
    private ImportCsvSeiIndustrialRDContract importCsvSeiIndustrialRDContract;

    @Autowired
    private ImportCsvToolProduct importCsvToolProduct;


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
        Map<Integer, GenericCsv<Status, Integer>> csvIdToStatusMap = null;
        Map<Integer, GenericCsv<PublicationType, Integer>> csvIdToPublicationTypeMap = null;
        Map<Integer, GenericCsv<PhdType, Integer>> csvIdToPhdTypeMap = null;
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
                    importCsvInvitedOralCommunication.importCsvList(csvList, importCsvSummary, specificActivityMap);
                    break;

                case ORAL_COMMUNICATION_POSTER:
                    assert activityMap != null;
                    specificActivityMap = activityMap.computeIfAbsent(TypeActivity.IdTypeActivity.ORAL_COMMUNICATION_POSTER, k -> new HashMap<>());
                    importCsvOralCommunicationPoster.importCsvList(csvList, importCsvSummary, specificActivityMap);
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
                case PHD_TYPE:
                    csvIdToPhdTypeMap = importCsvPhdType.importCsvList(csvList, importCsvSummary);
                    break;
                case PUBLICATION_TYPE:
                    csvIdToPublicationTypeMap = importCsvPublicationType.importCsvList(csvList, importCsvSummary);
                    break;
                case PUBLICATION:
                    assert activityMap != null;
                    specificActivityMap = activityMap.computeIfAbsent(TypeActivity.IdTypeActivity.PUBLICATION, k -> new HashMap<>());
                    importCsvPublication.importCsvList(csvList, importCsvSummary,
                            specificActivityMap,
                            csvIdToPublicationTypeMap);
                    break;
                case STATUS:
                    importCsvStatus.importCsvList(csvList, importCsvSummary);
                    break;
                case SEI_CLINICAL_TRIAL:
                    assert activityMap != null;
                    specificActivityMap = activityMap.computeIfAbsent(TypeActivity.IdTypeActivity.SEI_CLINICAL_TRIAL, k -> new HashMap<>());
                    importCsvSeiClinicalTrial.importCsvList(csvList, importCsvSummary, specificActivityMap);
                    break;
                case PLATFORM:
                    assert activityMap != null;
                    specificActivityMap = activityMap.computeIfAbsent(TypeActivity.IdTypeActivity.PLATFORM, k -> new HashMap<>());
                    importCsvPlatform.importCsvList(csvList, importCsvSummary, specificActivityMap);
                    break;
                case SEI_INDUSTRIAL_R_D_CONTRACT:
                    assert activityMap != null;
                    specificActivityMap = activityMap.computeIfAbsent(TypeActivity.IdTypeActivity.SEI_INDUSTRIAL_R_D_CONTRACT, k -> new HashMap<>());
                    importCsvSeiIndustrialRDContract.importCsvList(csvList, importCsvSummary, specificActivityMap);
                    break;
                case TOOL_PRODUCT_COHORT:
                    assert activityMap != null;
                    specificActivityMap = activityMap.computeIfAbsent(TypeActivity.IdTypeActivity.TOOL_PRODUCT_COHORT, k -> new HashMap<>());
                    importCsvToolProduct.importCsvList(csvList, importCsvSummary, specificActivityMap,
                            ToolProductType.IdToolProductType.COHORT,
                            supportedCsvTemplate);
                    break;
                case TOOL_PRODUCT_DATABASE:
                    assert activityMap != null;
                    specificActivityMap = activityMap.computeIfAbsent(TypeActivity.IdTypeActivity.TOOL_PRODUCT_DATABASE, k -> new HashMap<>());
                    importCsvToolProduct.importCsvList(csvList, importCsvSummary, specificActivityMap,
                            ToolProductType.IdToolProductType.DATABASE,
                            supportedCsvTemplate);
                    break;
                case TOOL_PRODUCT_SOFTWARE:
                    assert activityMap != null;
                    specificActivityMap = activityMap.computeIfAbsent(TypeActivity.IdTypeActivity.TOOL_PRODUCT_SOFTWARE, k -> new HashMap<>());
                    importCsvToolProduct.importCsvList(csvList, importCsvSummary, specificActivityMap,
                            ToolProductType.IdToolProductType.SOFTWARE,
                            supportedCsvTemplate);
                    break;
                case TOOL_PRODUCT_DECISION_SUPPORT_TOOL:
                    assert activityMap != null;
                    specificActivityMap = activityMap.computeIfAbsent(TypeActivity.IdTypeActivity.TOOL_PRODUCT_DECISION_SUPPORT_TOOL, k -> new HashMap<>());
                    importCsvToolProduct.importCsvList(csvList, importCsvSummary, specificActivityMap,
                            ToolProductType.IdToolProductType.DECISION_SUPPORT_TOOL,
                            supportedCsvTemplate);
                    break;
                default:
                    break;
            }
        }
        importCsvSummary.updateTotalActivityCount();
        return importCsvSummary;
    }
}
