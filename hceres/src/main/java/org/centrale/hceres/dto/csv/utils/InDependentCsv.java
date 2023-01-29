package org.centrale.hceres.dto.csv.utils;

import lombok.Data;

@Data
public  abstract class InDependentCsv<E, I> implements GenericCsv<E, I> {
    private I idCsv;

    // id Database is not present in csv fields,
    // it is generated on insert to database, either found by defined merging rules
    private I idDatabase;
}
