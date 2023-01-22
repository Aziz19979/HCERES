package org.centrale.hceres.service.csv;

import lombok.Data;
import org.centrale.hceres.dto.CsvResearcher;
import org.centrale.hceres.dto.ImportCsvSummary;
import org.centrale.hceres.items.Researcher;
import org.centrale.hceres.repository.ResearchRepository;
import org.centrale.hceres.util.RequestParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
    public Map<Integer, CsvResearcher> importCsvList(List<?> researchersRows, ImportCsvSummary importCsvSummary) {
        // map to store imported researchers from csv,
        // with key as lowercase concatenation of surname, name and email
        Map<String, CsvResearcher> csvResearchersMap = new LinkedHashMap<>();

        // parse and collect data from csv
        researchersRows.forEach(r -> {
            CsvResearcher csvResearcher = new CsvResearcher();
            List<?> csvData = (List<?>) r;
            csvResearcher.setIdCsv(RequestParser.getAsInteger(csvData.get(0)));
            csvResearcher.setResearcherSurname(RequestParser.getAsString(csvData.get(1)));
            csvResearcher.setResearcherName(RequestParser.getAsString(csvData.get(2)));
            csvResearcher.setResearcherEmail(RequestParser.getAsString(csvData.get(3)));
            csvResearchersMap.put(CsvResearcher.getMergingKey(csvResearcher), csvResearcher);
        });

        // map to store the researchers already present in the database,
        // with key as lowercase concatenation of surname, name and email
        Map<String, Researcher> researcherMap = new HashMap<>();
        researchRepo.findAll().forEach(r -> researcherMap.put(CsvResearcher.getMergingKey(r), r));


        // If a researcher with the same merging key already exists in the database, use its id,
        // otherwise prepare it to be saved into the database.
        List<Researcher> researchersToSave = new ArrayList<>();
        for (Map.Entry<String, CsvResearcher> entry : csvResearchersMap.entrySet()) {
            String key = entry.getKey();
            CsvResearcher csvResearcher = entry.getValue();
            Researcher researcherInDb = researcherMap.get(key);
            if (researcherInDb != null) {
                csvResearcher.setIdDatabase(researcherInDb.getResearcherId());
            } else {
                researchersToSave.add(csvResearcher.convertToResearcher());
            }
        }

        // save new researchers
        List<Researcher> savedResearchers = researchRepo.saveAll(researchersToSave);
        savedResearchers.forEach(r -> researcherMap.put(CsvResearcher.getMergingKey(r), r));

        // assign generated ids
        for (Researcher savedResearcher : savedResearchers) {
            String key = CsvResearcher.getMergingKey(savedResearcher);
            csvResearchersMap.get(key).setIdDatabase(savedResearcher.getResearcherId());
        }

        importCsvSummary.getEntityToInsertedCount().put(SupportedCsvFormat.RESEARCHER.toString(), researchersToSave.size());

        // prepare map from csvId to researcher map and return it
        Map<Integer, CsvResearcher> csvIdToResearchersMap = new HashMap<>();
        csvResearchersMap.forEach((key, r) -> csvIdToResearchersMap.put(r.getIdCsv(), r));
        return csvIdToResearchersMap;
    }
}
