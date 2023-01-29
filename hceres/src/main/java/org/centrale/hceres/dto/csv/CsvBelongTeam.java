package org.centrale.hceres.dto.csv;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.centrale.hceres.dto.csv.utils.CsvDependencyException;
import org.centrale.hceres.dto.csv.utils.CsvParseException;
import org.centrale.hceres.dto.csv.utils.DependentCsv;
import org.centrale.hceres.dto.csv.utils.GenericCsv;
import org.centrale.hceres.items.BelongsTeam;
import org.centrale.hceres.items.Researcher;
import org.centrale.hceres.items.Team;
import org.centrale.hceres.util.RequestParseException;
import org.centrale.hceres.util.RequestParser;

import java.util.List;
import java.util.Map;

@EqualsAndHashCode(callSuper = true)
@Data
public class CsvBelongTeam extends DependentCsv<BelongsTeam, String> {
    private int idCsvResearcher;
    private GenericCsv<Researcher, Integer> csvResearcher;
    private final Map<Integer, GenericCsv<Researcher, Integer>> researcherIdCsvMap;
    private Integer idTeamCsv;
    private GenericCsv<Team, Integer> csvTeam;
    private final Map<Integer, GenericCsv<Team, Integer>> teamIdCsvMap;

    public CsvBelongTeam(Map<Integer, GenericCsv<Researcher, Integer>> researcherIdCsvMap,
                         Map<Integer, GenericCsv<Team, Integer>> teamIdCsvMap) {
        this.researcherIdCsvMap = researcherIdCsvMap;
        this.teamIdCsvMap = teamIdCsvMap;
    }

    @Override
    public void fillCsvDataWithoutDependency(List<?> csvData) throws CsvParseException {
        int fieldNumber = 0;
        try {
            this.setIdCsvResearcher(RequestParser.getAsInteger(csvData.get(fieldNumber++)));
            this.setIdTeamCsv(RequestParser.getAsInteger(csvData.get(fieldNumber)));
        } catch (RequestParseException e) {
            throw new CsvParseException(e.getMessage() + " at id " + this.getIdCsvResearcher() + " at column " + fieldNumber);
        }
    }

    @Override
    public void initializeDependencies() throws CsvDependencyException {
        this.csvResearcher = this.researcherIdCsvMap.get(this.getIdCsvResearcher());
        if (this.csvResearcher == null) {
            throw new CsvDependencyException("Researcher with id " + this.getIdCsvResearcher() + " not found");
        }
        this.csvTeam = this.teamIdCsvMap.get(this.getIdTeamCsv());
        if (this.csvTeam == null) {
            throw new CsvDependencyException("Team with id " + this.getIdTeamCsv() + " not found");
        }
    }

    @Override
    public BelongsTeam convertToEntity() {
        BelongsTeam belongsTeam = new BelongsTeam();
        belongsTeam.setResearcherId(this.csvResearcher.getIdDatabase());
        belongsTeam.setTeamId(this.csvTeam.getIdDatabase());
        return belongsTeam;
    }

    @Override
    public String getMergingKey() {
        return (this.getCsvResearcher().getIdDatabase()
                + "_" + this.getCsvTeam().getIdDatabase()).toLowerCase();
    }

    @Override
    public String getMergingKey(BelongsTeam entity) {
        return (entity.getResearcherId() + "_" + entity.getTeamId()).toLowerCase();
    }

    @Override
    public void setIdDatabaseFromEntity(BelongsTeam entity) {
        this.setIdDatabase(entity.getResearcherId() + "_" + entity.getTeamId());
    }

    @Override
    public String getIdCsv() {
        return this.getIdCsvResearcher() + "_" + this.getIdTeamCsv();
    }
}
