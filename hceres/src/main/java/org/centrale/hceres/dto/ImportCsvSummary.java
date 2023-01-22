package org.centrale.hceres.dto;

import lombok.Data;

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
}
