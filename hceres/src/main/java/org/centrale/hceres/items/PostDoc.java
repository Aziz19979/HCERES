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
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 *
 * @author kwyhr
 */
@Entity
@Table(name = "post_doc")
@NamedQueries({
    @NamedQuery(name = "PostDoc.findAll", query = "SELECT p FROM PostDoc p"),
    @NamedQuery(name = "PostDoc.findByIdActivity", query = "SELECT p FROM PostDoc p WHERE p.idActivity = :idActivity"),
    @NamedQuery(name = "PostDoc.findByNamePostDoc", query = "SELECT p FROM PostDoc p WHERE p.namePostDoc = :namePostDoc"),
    @NamedQuery(name = "PostDoc.findByNameSupervisor", query = "SELECT p FROM PostDoc p WHERE p.nameSupervisor = :nameSupervisor"),
    @NamedQuery(name = "PostDoc.findByArrivalDate", query = "SELECT p FROM PostDoc p WHERE p.arrivalDate = :arrivalDate"),
    @NamedQuery(name = "PostDoc.findByDepartureDate", query = "SELECT p FROM PostDoc p WHERE p.departureDate = :departureDate"),
    @NamedQuery(name = "PostDoc.findByDuration", query = "SELECT p FROM PostDoc p WHERE p.duration = :duration"),
    @NamedQuery(name = "PostDoc.findByNationality", query = "SELECT p FROM PostDoc p WHERE p.nationality = :nationality"),
    @NamedQuery(name = "PostDoc.findByOriginalLab", query = "SELECT p FROM PostDoc p WHERE p.originalLab = :originalLab"),
    @NamedQuery(name = "PostDoc.findByAssociatedFunding", query = "SELECT p FROM PostDoc p WHERE p.associatedFunding = :associatedFunding"),
    @NamedQuery(name = "PostDoc.findByAssociatedPubliRef", query = "SELECT p FROM PostDoc p WHERE p.associatedPubliRef = :associatedPubliRef")})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class PostDoc implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_activity")
    private Integer idActivity;
    @Size(max = 256)
    @Column(name = "name_post_doc")
    private String namePostDoc;
    @Size(max = 256)
    @Column(name = "name_supervisor")
    private String nameSupervisor;
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
    @Column(name = "original_lab")
    private String originalLab;
    @Size(max = 256)
    @Column(name = "associated_funding")
    private String associatedFunding;
    @Size(max = 256)
    @Column(name = "associated_publi_ref")
    private String associatedPubliRef;
    @JoinColumn(name = "id_activity", referencedColumnName = "id_activity", insertable = false, updatable = false)
    @OneToOne(optional = false, cascade = CascadeType.ALL)
    @JsonIgnore
    private Activity activity;

}