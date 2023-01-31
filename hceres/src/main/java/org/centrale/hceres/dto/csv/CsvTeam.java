package org.centrale.hceres.dto.csv;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.centrale.hceres.dto.csv.utils.CsvDependencyException;
import org.centrale.hceres.dto.csv.utils.CsvParseException;
import org.centrale.hceres.dto.csv.utils.DependentCsv;
import org.centrale.hceres.dto.csv.utils.GenericCsv;
import org.centrale.hceres.items.Laboratory;
import org.centrale.hceres.items.Team;
import org.centrale.hceres.util.RequestParseException;
import org.centrale.hceres.util.RequestParser;

import java.util.List;
import java.util.Map;

@EqualsAndHashCode(callSuper = true)
@Data
public class CsvTeam extends DependentCsv<Team, Integer> {
    private Integer idTeamCsv;
    private String teamName;
    private Integer laboratoryIdCsv;


    private GenericCsv<Laboratory, Integer> csvLaboratory;
    private final Map<Integer, GenericCsv<Laboratory, Integer>> laboratoryIdCsvMap;

    public CsvTeam(Map<Integer, GenericCsv<Laboratory, Integer>> laboratoryIdCsvMap) {
        this.laboratoryIdCsvMap = laboratoryIdCsvMap;
    }


    @Override
    public void setIdDatabaseFromEntity(Team entity) {
        setIdDatabase(entity.getTeamId());
    }

    @Override
    public Integer getIdCsv() {
        return this.idTeamCsv;
    }

    @Override
    public void fillCsvDataWithoutDependency(List<?> csvData) throws CsvParseException {
        int fieldNumber = 0;
        try {
            this.setIdTeamCsv(RequestParser.getAsInteger(csvData.get(fieldNumber++)));
            this.setTeamName(RequestParser.getAsString(csvData.get(fieldNumber++)));
            this.setLaboratoryIdCsv(RequestParser.getAsInteger(csvData.get(fieldNumber)));
        } catch (RequestParseException e) {
            throw new CsvParseException(e.getMessage() + " at column " + fieldNumber + " at id " + csvData);
        }
    }

    @Override
    public void initializeDependencies() throws CsvDependencyException {
        // Set dependency on laboratory
        if (!this.laboratoryIdCsvMap.containsKey(this.getLaboratoryIdCsv())) {
            throw new CsvDependencyException("Laboratory with id " + this.getLaboratoryIdCsv()
                    + " not found for team with id " + this.getIdTeamCsv());
        }
        this.setCsvLaboratory(this.laboratoryIdCsvMap.get(this.getLaboratoryIdCsv()));
    }

    @Override
    public Team convertToEntity() {
        Team team = new Team();
        team.setTeamName(this.getTeamName());
        team.setLaboratoryId(this.getCsvLaboratory().getIdDatabase());
        return team;
    }

    @Override
    public String getMergingKey() {
        return (this.getTeamName()
                + "_" + this.getCsvLaboratory().getIdDatabase())
                .toLowerCase();
    }

    @Override
    public String getMergingKey(Team entity) {
        return (entity.getTeamName()
                + "_" + entity.getLaboratoryId())
                .toLowerCase();
    }
}
