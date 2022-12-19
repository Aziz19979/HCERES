/* --------------------------------------------------------------------------------
 * Projet HCERES
 * 
 * Gestion de données pour l'HCERES
 * 
 * Ecole Centrale Nantes - laboratoire CRTI
 * Avril 2021
 * L LETERTRE, S LIMOUX, JY MARTIN
 * -------------------------------------------------------------------------------- */
package org.centrale.hceres.items;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.io.Serializable;
import java.util.List;
import java.util.Date;
import javax.persistence.*;
import javax.validation.constraints.Size;

/**
 *
 * @author kwyhr
 */
@Entity
@Table(name = "team")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Team implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "team_id")
    private Integer teamId;
    @Size(max = 256)
    @Column(name = "team_name")
    private String teamName;
    @Column(name = "team_creation")
    @Temporal(TemporalType.DATE)
    private Date teamCreation;
    @Column(name = "team_end")
    @Temporal(TemporalType.DATE)
    private Date teamEnd;
    @Column(name = "team_last_report")
    @Temporal(TemporalType.DATE)
    private Date teamLastReport;
    @ManyToMany(mappedBy = "teamList")
    private List<Activity> activityList;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "teamId")
    private List<TeamReferent> teamReferentList;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "team")
    private List<PublicationStatistics> publicationStatisticsList;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "teamId")
    private List<BelongsTeam> belongsTeamList;
    @JoinColumn(name = "laboratory_id", referencedColumnName = "laboratory_id")
    @ManyToOne(optional = false)
    private Laboratory laboratoryId;
}