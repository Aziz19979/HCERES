package org.centrale.hceres.dto.csv.utils;

import lombok.Data;

@Data
public  abstract class InDependentCsv<E> implements GenericCsv<E> {
    private Integer idCsv;

    // id Database is not present in csv fields,
    // it is generated on insert to database, either found by defined merging rules
    private Integer idDatabase;

    public abstract void setIdDatabaseFromEntity(E entity);
}
