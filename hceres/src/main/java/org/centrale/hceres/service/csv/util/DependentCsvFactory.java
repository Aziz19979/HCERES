package org.centrale.hceres.service.csv.util;

import org.centrale.hceres.dto.csv.utils.DependentCsv;

public interface DependentCsvFactory<E> {
    DependentCsv<E> newDependentCsv();
}
