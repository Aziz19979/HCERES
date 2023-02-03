package org.centrale.hceres.service;

import java.text.ParseException;
import java.util.*;

import org.centrale.hceres.items.Activity;
import org.centrale.hceres.items.Team;
import org.centrale.hceres.items.Researcher;
import org.centrale.hceres.items.TypeActivity;
import org.centrale.hceres.repository.ActivityRepository;
import org.centrale.hceres.repository.TeamRepository;
import org.centrale.hceres.util.RequestParseException;
import org.centrale.hceres.util.RequestParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;

import lombok.Data;

// permet de traiter la requete HTTP puis l'associer a la fonction de repository qui va donner une reponse
@Data
@Service
public class TeamService {

    @Autowired
    private TeamRepository teamRepo;

    @Autowired
    private ActivityRepository activityRepo;

    /**
     * permet de retourner la liste
     */
    /**
    public List<Activity> getTeams() {
        return activityRepo.findByIdTypeActivity(TypeActivity.IdTypeActivity.TEAM.getId());
    }
    */
    public List<Team> getTeams() {
        return teamRepo.findAll();
    }
    /**
     * supprimer l'elmt selon son id
     *
     * @param id : id de l'elmt
     */
    public void deleteTeam(final Integer id) {
        teamRepo.deleteById(id);
    }

    /**
     * permet d'ajouter un elmt
     *
     * @return : l'elemt ajouter a la base de donnees
     */
    public Team saveTeam(@RequestBody Map<String, Object> request) throws RequestParseException {

        Team team = new Team();
        team.setTeamName(RequestParser.getAsString(request.get("teamName")));
        team.setTeamCreation(RequestParser.getAsDate(request.get("teamCreation")));
        team.setTeamEnd(RequestParser.getAsDate(request.get("teamEnd")));
        team.setTeamLastReport(RequestParser.getAsDate(request.get("teamLastReport")));

        /**
        // Activity :
        Activity activity = new Activity();
        team.setActivityList((List<Activity>) activity);
        activity.setTeamList((List<Team>) team);
        activity.setIdTypeActivity(TypeActivity.IdTypeActivity.TEAM.getId());

        // get list of researcher doing this activity - currently only one is sent
        activity.setResearcherList(Collections.singletonList(new Researcher(RequestParser.getAsInteger(request.get("researcherId")))));

        activity = activityRepo.save(activity);
        return activity;
        */
        return team;
    }

}
