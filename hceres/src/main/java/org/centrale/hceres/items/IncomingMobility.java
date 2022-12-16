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
import javax.persistence.CascadeType;
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

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 *
 * @author kwyhr
 */
@Entity
@Table(name = "incoming_mobility")
@NamedQueries({
    @NamedQuery(name = "IncomingMobility.findAll", query = "SELECT i FROM IncomingMobility i"),
    @NamedQuery(name = "IncomingMobility.findByIdActivity", query = "SELECT i FROM IncomingMobility i WHERE i.idActivity = :idActivity"),
    @NamedQuery(name = "IncomingMobility.findByNameSeniorScientist", query = "SELECT i FROM IncomingMobility i WHERE i.nameSeniorScientist = :nameSeniorScientist"),
    @NamedQuery(name = "IncomingMobility.findByArrivalDate", query = "SELECT i FROM IncomingMobility i WHERE i.arrivalDate = :arrivalDate"),
    @NamedQuery(name = "IncomingMobility.findByDepartureDate", query = "SELECT i FROM IncomingMobility i WHERE i.departureDate = :departureDate"),
    @NamedQuery(name = "IncomingMobility.findByDuration", query = "SELECT i FROM IncomingMobility i WHERE i.duration = :duration"),
    @NamedQuery(name = "IncomingMobility.findByNationality", query = "SELECT i FROM IncomingMobility i WHERE i.nationality = :nationality"),
    @NamedQuery(name = "IncomingMobility.findByOriginalLabName", query = "SELECT i FROM IncomingMobility i WHERE i.originalLabName = :originalLabName"),
    @NamedQuery(name = "IncomingMobility.findByOriginaLabLocation", query = "SELECT i FROM IncomingMobility i WHERE i.originaLabLocation = :originaLabLocation"),
    @NamedQuery(name = "IncomingMobility.findByPiPartner", query = "SELECT i FROM IncomingMobility i WHERE i.piPartner = :piPartner"),
    @NamedQuery(name = "IncomingMobility.findByProjectTitle", query = "SELECT i FROM IncomingMobility i WHERE i.projectTitle = :projectTitle"),
    @NamedQuery(name = "IncomingMobility.findByAssociatedFunding", query = "SELECT i FROM IncomingMobility i WHERE i.associatedFunding = :associatedFunding"),
    @NamedQuery(name = "IncomingMobility.findByPublicationReference", query = "SELECT i FROM IncomingMobility i WHERE i.publicationReference = :publicationReference"),
    @NamedQuery(name = "IncomingMobility.findByStrategicRecurringCollab", query = "SELECT i FROM IncomingMobility i WHERE i.strategicRecurringCollab = :strategicRecurringCollab"),
    @NamedQuery(name = "IncomingMobility.findByActiveProject", query = "SELECT i FROM IncomingMobility i WHERE i.activeProject = :activeProject"),
    @NamedQuery(name = "IncomingMobility.findByUmrCoordinated", query = "SELECT i FROM IncomingMobility i WHERE i.umrCoordinated = :umrCoordinated"),
    @NamedQuery(name = "IncomingMobility.findByAgreementSigned", query = "SELECT i FROM IncomingMobility i WHERE i.agreementSigned = :agreementSigned")})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class IncomingMobility implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_activity")
    private Integer idActivity;
    @Size(max = 256)
    @Column(name = "name_senior_scientist")
    private String nameSeniorScientist;
    @Column(name = "arrival_date")
    @Temporal(TemporalType.DATE)
    private Date arrivalDate;
    @Column(name = "departure_date")
    @Temporal(TemporalType.DATE)
    private Date departureDate;
    @Column(name = "duration")
    private Integer duration;
    @Size(max = 256)
    @Column(name = "nationality")
    private String nationality;
    @Size(max = 256)
    @Column(name = "original_lab_name")
    private String originalLabName;
    @Size(max = 256)
    @Column(name = "origina_lab_location")
    private String originaLabLocation;
    @Size(max = 256)
    @Column(name = "pi_partner")
    private String piPartner;
    @Size(max = 256)
    @Column(name = "project_title")
    private String projectTitle;
    @Size(max = 256)
    @Column(name = "associated_funding")
    private String associatedFunding;
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
    @JsonIgnore
    @JoinColumn(name = "id_activity", referencedColumnName = "id_activity", insertable = false, updatable = false)
    @OneToOne(optional = false, cascade = CascadeType.ALL)
    private Activity activity;

}