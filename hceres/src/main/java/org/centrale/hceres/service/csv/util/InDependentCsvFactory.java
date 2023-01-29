package org.centrale.hceres.service.csv.util;

import org.centrale.hceres.dto.csv.utils.InDependentCsv;

public interface InDependentCsvFactory<E> {
    InDependentCsv<E> newInDependentCsv();
}
