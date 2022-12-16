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
import javax.persistence.ManyToOne;
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
@Table(name = "national_international_collaboration")
@NamedQueries({
    @NamedQuery(name = "InternationalCollaboration.findAll", query = "SELECT n FROM InternationalCollaboration n"),
    @NamedQuery(name = "InternationalCollaboration.findByIdActivity", query = "SELECT n FROM InternationalCollaboration n WHERE n.idActivity = :idActivity"),
    @NamedQuery(name = "InternationalCollaboration.findByDateProjectStart", query = "SELECT n FROM InternationalCollaboration n WHERE n.dateProjectStart = :dateProjectStart"),
    @NamedQuery(name = "InternationalCollaboration.findByPartnerEntity", query = "SELECT n FROM InternationalCollaboration n WHERE n.partnerEntity = :partnerEntity"),
    @NamedQuery(name = "InternationalCollaboration.findByCountryStateCity", query = "SELECT n FROM InternationalCollaboration n WHERE n.countryStateCity = :countryStateCity"),
    @NamedQuery(name = "InternationalCollaboration.findByPiPartners", query = "SELECT n FROM InternationalCollaboration n WHERE n.piPartners = :piPartners"),
    @NamedQuery(name = "InternationalCollaboration.findByMailPartners", query = "SELECT n FROM InternationalCollaboration n WHERE n.mailPartners = :mailPartners"),
    @NamedQuery(name = "InternationalCollaboration.findByProjetcTitle", query = "SELECT n FROM InternationalCollaboration n WHERE n.projectTitle = :projetcTitle"),
    @NamedQuery(name = "InternationalCollaboration.findByStrategicRecurringCollab", query = "SELECT n FROM InternationalCollaboration n WHERE n.strategicRecurringCollab = :strategicRecurringCollab"),
    @NamedQuery(name = "InternationalCollaboration.findByActiveProject", query = "SELECT n FROM InternationalCollaboration n WHERE n.activeProject = :activeProject"),
    @NamedQuery(name = "InternationalCollaboration.findByAssociatedFunding", query = "SELECT n FROM InternationalCollaboration n WHERE n.associatedFunding = :associatedFunding"),
    @NamedQuery(name = "InternationalCollaboration.findByNumberResultingPublications", query = "SELECT n FROM InternationalCollaboration n WHERE n.numberResultingPublications = :numberResultingPublications"),
    @NamedQuery(name = "InternationalCollaboration.findByRefJointPublication", query = "SELECT n FROM InternationalCollaboration n WHERE n.refJointPublication = :refJointPublication"),
    @NamedQuery(name = "InternationalCollaboration.findByUmrCoordinated", query = "SELECT n FROM InternationalCollaboration n WHERE n.umrCoordinated = :umrCoordinated"),
    @NamedQuery(name = "InternationalCollaboration.findByAgreementSigned", query = "SELECT n FROM InternationalCollaboration n WHERE n.agreementSigned = :agreementSigned")})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class InternationalCollaboration implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_activity")
    private Integer idActivity;
    
    @Column(name = "date_project_start")
    @Temporal(TemporalType.DATE)
    private Date dateProjectStart;
    
    @Size(max = 256)
    @Column(name = "partner_entity")
    private String partnerEntity;
    
    @Size(max = 256)
    @Column(name = "country_state_city")
    private String countryStateCity;
    
    @Size(max = 256)
    @Column(name = "pi_partners")
    private String piPartners;
    
    @Size(max = 256)
    @Column(name = "mail_partners")
    private String mailPartners;
    
    @Size(max = 256)
    @Column(name = "projetc_title")
    private String projectTitle;
    
    @Column(name = "strategic_recurring_collab")
    private Boolean strategicRecurringCollab;
    
    @Column(name = "active_project")
    private Boolean activeProject;
    
    @Size(max = 256)
    @Column(name = "associated_funding")
    private String associatedFunding;
    
    @Column(name = "number_resulting_publications")
    private Integer numberResultingPublications;
    
    @Size(max = 256)
    @Column(name = "ref_joint_publication")
    private String refJointPublication;
    
    @Column(name = "umr_coordinated")
    private Boolean umrCoordinated;
    
    @Column(name = "agreement_signed")
    private Boolean agreementSigned;
    @JsonIgnore
    @JoinColumn(name = "id_activity", referencedColumnName = "id_activity", insertable = false, updatable = false)
    @OneToOne(optional = false, cascade = CascadeType.ALL)
    private Activity activity;
    @JsonIgnore
    @JoinColumn(name = "type_collab_id", referencedColumnName = "type_collab_id")
    @ManyToOne(optional = false)
    private TypeCollab typeCollabId;

}