package org.centrale.hceres.dto.csv.utils;

public class CsvParseException extends Exception {

    public CsvParseException(String message) {
        super(message);
    }

    public CsvParseException(String message, Throwable cause) {
        super(message, cause);
    }

    public CsvParseException(Throwable cause) {
        super(cause);
    }

    public CsvParseException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
