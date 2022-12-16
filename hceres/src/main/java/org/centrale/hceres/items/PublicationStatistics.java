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
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

/**
 *
 * @author kwyhr
 */
@Entity
@Table(name = "publication_statistics")
@NamedQueries({
    @NamedQuery(name = "PublicationStatistics.findAll", query = "SELECT p FROM PublicationStatistics p"),
    @NamedQuery(name = "PublicationStatistics.findByTeamId", query = "SELECT p FROM PublicationStatistics p WHERE p.publicationStatisticsPK.teamId = :teamId"),
    @NamedQuery(name = "PublicationStatistics.findByPublicationStatisticsYear", query = "SELECT p FROM PublicationStatistics p WHERE p.publicationStatisticsPK.publicationStatisticsYear = :publicationStatisticsYear"),
    @NamedQuery(name = "PublicationStatistics.findByPublicationStatisticsPdc", query = "SELECT p FROM PublicationStatistics p WHERE p.publicationStatisticsPdc = :publicationStatisticsPdc"),
    @NamedQuery(name = "PublicationStatistics.findByPublicationStatisticsCollabInt", query = "SELECT p FROM PublicationStatistics p WHERE p.publicationStatisticsCollabInt = :publicationStatisticsCollabInt"),
    @NamedQuery(name = "PublicationStatistics.findByPublicationStatisticsCollabLabo", query = "SELECT p FROM PublicationStatistics p WHERE p.publicationStatisticsCollabLabo = :publicationStatisticsCollabLabo")})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class PublicationStatistics implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     *
     */
    @EmbeddedId
    protected PublicationStatisticsPK publicationStatisticsPK;
    @Basic(optional = false)
    @NotNull
    @Column(name = "publication_statistics_pdc")
    private int publicationStatisticsPdc;
    @Basic(optional = false)
    @NotNull
    @Column(name = "publication_statistics_collab_int")
    private int publicationStatisticsCollabInt;
    @Basic(optional = false)
    @NotNull
    @Column(name = "publication_statistics_collab_labo")
    private int publicationStatisticsCollabLabo;
    @JoinColumn(name = "team_id", referencedColumnName = "team_id", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Team team;

}