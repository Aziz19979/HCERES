package org.centrale.hceres.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class RequestParser {

    public static final String DEFAULT_DATE_FORMAT = "yyyy-MM-dd";

    public static Integer getAsInteger(Object number) throws NumberFormatException {
        if (number instanceof Integer)
            return (Integer) number;
        else return Integer.parseInt(String.valueOf(number));
    }

    public static String getAsString(Object string) throws NullPointerException {
        if (string == null)
            throw new NullPointerException();
        return String.valueOf(string);
    }

    public static Date getAsDate(Object date) throws ParseException {
        Date returnedValue = null;
        // try to convert
        SimpleDateFormat aFormater = new SimpleDateFormat(DEFAULT_DATE_FORMAT);
        returnedValue = aFormater.parse(getAsString(date));
        return returnedValue;
    }

    public static Boolean getAsBoolean(Object bool) {
        if (bool instanceof Boolean)
            return (Boolean) bool;
        else return Boolean.parseBoolean(bool.toString());
    }
}
