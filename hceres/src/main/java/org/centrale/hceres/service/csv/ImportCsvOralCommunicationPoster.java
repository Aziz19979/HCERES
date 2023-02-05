package org.centrale.hceres.service.csv;

import lombok.Data;
import org.centrale.hceres.dto.csv.CsvActivity;
import org.centrale.hceres.dto.csv.CsvInvitedOralCommunication;
import org.centrale.hceres.dto.csv.CsvOralCommunicationPoster;
import org.centrale.hceres.dto.csv.ImportCsvSummary;
import org.centrale.hceres.dto.csv.utils.GenericCsv;
import org.centrale.hceres.items.Activity;
import org.centrale.hceres.items.TypeActivity;
import org.centrale.hceres.repository.ActivityRepository;
import org.centrale.hceres.service.csv.util.GenericCsvImporter;
import org.centrale.hceres.service.csv.util.SupportedCsvTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Data
@Service
public class ImportCsvOralCommunicationPoster {

    @Autowired
    private ActivityRepository activityRepo;

    /**
     * @param oralCommunicationRows      list of array having fields as defined in csv
     * @param importCsvSummary Summary of the import
     */
    public Map<Integer, GenericCsv<Activity, Integer>> importCsvList(List<?> oralCommunicationRows, ImportCsvSummary importCsvSummary,
                                                                    Map<Integer, CsvActivity> activityMap) {
        return new GenericCsvImporter<Activity, Integer>().importCsvList(
                oralCommunicationRows,
                () -> new CsvOralCommunicationPoster(activityMap),
                () -> activityRepo.findByIdTypeActivity(TypeActivity.IdTypeActivity.ORAL_COMMUNICATION_POSTER.getId()),
                activityRepo::saveAll,
                SupportedCsvTemplate.ORAL_COMMUNICATION_POSTER,
                importCsvSummary);
    }
}
