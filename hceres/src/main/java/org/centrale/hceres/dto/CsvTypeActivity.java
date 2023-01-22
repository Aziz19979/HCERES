package org.centrale.hceres.dto;

import lombok.Data;
import org.centrale.hceres.items.Researcher;
import org.centrale.hceres.items.TypeActivity;

@Data
public class CsvTypeActivity {
    private Integer idDatabase;
    private Integer idCsv;
    private String nameType;

    public TypeActivity convertToTypeActivity() {
        TypeActivity typeActivity = new TypeActivity();
        typeActivity.setNameType(this.getNameType());
        return typeActivity;
    }

    /**
     * Type activity ids aren't question to change as hardcoded types are used in enum everywhere
     */
    public static String getMergingKey(TypeActivity typeActivity) {
        return typeActivity.getIdTypeActivity().toString();
    }

    public static String getMergingKey(CsvTypeActivity typeActivity) {
        return typeActivity.getIdCsv().toString();
    }

}
