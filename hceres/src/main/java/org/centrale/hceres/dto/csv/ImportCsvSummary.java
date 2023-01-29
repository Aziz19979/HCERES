package org.centrale.hceres.dto.csv;

import lombok.Data;
import org.centrale.hceres.service.csv.util.SupportedCsvFormat;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;

@Data
public class ImportCsvSummary implements Serializable {
    private HashMap<String, Integer> entityToInsertedCount;
    private HashMap<String, List<String>> entityToErrorMsg;

    public ImportCsvSummary() {
        entityToInsertedCount = new HashMap<>();
        entityToErrorMsg = new HashMap<>();
    }

    public void addToTotalActivityCountInserted(int newActivitiesInserted) {
        String activityKey = SupportedCsvFormat.ACTIVITY.toString();
        if (!this.getEntityToInsertedCount().containsKey(activityKey)) {
            this.getEntityToInsertedCount().put(activityKey,
                    this.getEntityToInsertedCount().get(activityKey) + newActivitiesInserted);
        } else {
            this.getEntityToInsertedCount().put(activityKey, newActivitiesInserted);
        }
    }
}