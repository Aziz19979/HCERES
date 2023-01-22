package org.centrale.hceres.dto;

import lombok.Data;

import java.io.Serializable;
import java.util.HashMap;

@Data
public class ImportCsvSummary implements Serializable {
    private HashMap<String, Integer> entityToInsertedCount;
    public ImportCsvSummary() {
        entityToInsertedCount = new HashMap<>();
    }
}
