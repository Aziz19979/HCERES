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
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 *
 * @author kwyhr
 */
@Entity
@Table(name = "outgoing_mobility")
@NamedQueries({
    @NamedQuery(name = "OutgoingMobility.findAll", query = "SELECT o FROM OutgoingMobility o"),
    @NamedQuery(name = "OutgoingMobility.findByIdActivity", query = "SELECT o FROM OutgoingMobility o WHERE o.idActivity = :idActivity"),
    @NamedQuery(name = "OutgoingMobility.findByNamePersonConcerned", query = "SELECT o FROM OutgoingMobility o WHERE o.namePersonConcerned = :namePersonConcerned"),
    @NamedQuery(name = "OutgoingMobility.findByArrivalDate", query = "SELECT o FROM OutgoingMobility o WHERE o.arrivalDate = :arrivalDate"),
    @NamedQuery(name = "OutgoingMobility.findByDepartureDate", query = "SELECT o FROM OutgoingMobility o WHERE o.departureDate = :departureDate"),
    @NamedQuery(name = "OutgoingMobility.findByDuration", query = "SELECT o FROM OutgoingMobility o WHERE o.duration = :duration"),
    @NamedQuery(name = "OutgoingMobility.findByHostLabName", query = "SELECT o FROM OutgoingMobility o WHERE o.hostLabName = :hostLabName"),
    @NamedQuery(name = "OutgoingMobility.findByHostLabLocation", query = "SELECT o FROM OutgoingMobility o WHERE o.hostLabLocation = :hostLabLocation"),
    @NamedQuery(name = "OutgoingMobility.findByPiPartner", query = "SELECT o FROM OutgoingMobility o WHERE o.piPartner = :piPartner"),
    @NamedQuery(name = "OutgoingMobility.findByProjectTitle", query = "SELECT o FROM OutgoingMobility o WHERE o.projectTitle = :projectTitle"),
    @NamedQuery(name = "OutgoingMobility.findByAssociatedFunding", query = "SELECT o FROM OutgoingMobility o WHERE o.associatedFunding = :associatedFunding"),
    @NamedQuery(name = "OutgoingMobility.findByNbPublications", query = "SELECT o FROM OutgoingMobility o WHERE o.nbPublications = :nbPublications"),
    @NamedQuery(name = "OutgoingMobility.findByPublicationReference", query = "SELECT o FROM OutgoingMobility o WHERE o.publicationReference = :publicationReference"),
    @NamedQuery(name = "OutgoingMobility.findByStrategicRecurringCollab", query = "SELECT o FROM OutgoingMobility o WHERE o.strategicRecurringCollab = :strategicRecurringCollab"),
    @NamedQuery(name = "OutgoingMobility.findByActiveProject", query = "SELECT o FROM OutgoingMobility o WHERE o.activeProject = :activeProject"),
    @NamedQuery(name = "OutgoingMobility.findByUmrCoordinated", query = "SELECT o FROM OutgoingMobility o WHERE o.umrCoordinated = :umrCoordinated"),
    @NamedQuery(name = "OutgoingMobility.findByAgreementSigned", query = "SELECT o FROM OutgoingMobility o WHERE o.agreementSigned = :agreementSigned")})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class OutgoingMobility implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_activity")
    private Integer idActivity;
    @Size(max = 256)
    @Column(name = "name_person_concerned")
    private String namePersonConcerned;
    @Column(name = "arrival_date")
    @Temporal(TemporalType.DATE)
    private Date arrivalDate;
    @Column(name = "departure_date")
    @Temporal(TemporalType.DATE)
    private Date departureDate;
    @Column(name = "duration")
    private Integer duration;
    @Size(max = 256)
    @Column(name = "host_lab_name")
    private String hostLabName;
    @Size(max = 256)
    @Column(name = "host_lab_location")
    private String hostLabLocation;
    @Size(max = 256)
    @Column(name = "pi_partner")
    private String piPartner;
    @Size(max = 256)
    @Column(name = "project_title")
    private String projectTitle;
    @Size(max = 256)
    @Column(name = "associated_funding")
    private String associatedFunding;
    @Column(name = "nb_publications")
    private Integer nbPublications;
    @Size(max = 256)
    @Column(name = "publication_reference")
    private String publicationReference;
    @Column(name = "strategic_recurring_collab")
    private Boolean strategicRecurringCollab;
    @Column(name = "active_project")
    private Boolean activeProject;
    @Column(name = "umr_coordinated")
    private Boolean umrCoordinated;
    @Column(name = "agreement_signed")
    private Boolean agreementSigned;
    @JoinColumn(name = "id_activity", referencedColumnName = "id_activity", insertable = false, updatable = false)
    @OneToOne(optional = false)
    private Activity activity;

}