package org.centrale.hceres.dto.csv.utils;

public class CsvDependencyException extends Exception {
    public CsvDependencyException(String message) {
        super(message);
    }

    public CsvDependencyException(String message, Throwable cause) {
        super(message, cause);
    }

    public CsvDependencyException(Throwable cause) {
        super(cause);
    }

    public CsvDependencyException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
