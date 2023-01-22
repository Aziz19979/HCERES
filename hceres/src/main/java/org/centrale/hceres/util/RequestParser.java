package org.centrale.hceres.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

public class RequestParser {

    public static final String DEFAULT_DATE_FORMAT = "yyyy-MM-dd";
    public static final String CSV_DEFAULT_DATE_FORMAT = "dd/MM/yy";

    public static Integer getAsInteger(Object number) throws NumberFormatException {
        if (number instanceof Integer)
            return (Integer) number;
        else return Integer.parseInt(String.valueOf(number));
    }

    public static List<?> getAsList(Object objectList) {
        List<?> list = null;
        if (objectList.getClass().isArray()) {
            list = Arrays.asList((Object[])objectList);
        } else if (objectList instanceof Collection) {
            list = new ArrayList<>((Collection<?>)objectList);
        }
        return list;
    }

    public static Float getAsFloat(Object number) throws NumberFormatException {
        if (number instanceof Float)
            return (Float) number;
        else return Float.parseFloat(String.valueOf(number));
    }

    public static String getAsString(Object string) throws NullPointerException {
        if (string == null)
            throw new NullPointerException();
        return String.valueOf(string);
    }

    public static Date getAsDate(Object date) throws ParseException {
        return getAsDate(date, DEFAULT_DATE_FORMAT);
    }
    public static Date getAsDateCsvFormat(Object date) throws ParseException {
        return getAsDate(date, CSV_DEFAULT_DATE_FORMAT);
    }

    public static Date getAsDate(Object date, String dateFormat) throws ParseException {
        Date returnedValue = null;
        // try to convert
        SimpleDateFormat aFormater = new SimpleDateFormat(dateFormat);
        returnedValue = aFormater.parse(getAsString(date));
        return new java.sql.Date(returnedValue.getTime());
    }

    public static Boolean getAsBoolean(Object bool) {
        if (bool instanceof Boolean)
            return (Boolean) bool;
        else return Boolean.parseBoolean(bool.toString());
    }
}
