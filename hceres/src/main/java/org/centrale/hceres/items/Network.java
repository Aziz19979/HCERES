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
import javax.persistence.CascadeType;

/**
 *
 * @author kwyhr
 */
@Entity
@Table(name = "network")
@NamedQueries({
    @NamedQuery(name = "Network.findAll", query = "SELECT n FROM Network n"),
    @NamedQuery(name = "Network.findByIdActivity", query = "SELECT n FROM Network n WHERE n.idActivity = :idActivity"),
    @NamedQuery(name = "Network.findByStartDate", query = "SELECT n FROM Network n WHERE n.startDate = :startDate"),
    @NamedQuery(name = "Network.findByNameNetwork", query = "SELECT n FROM Network n WHERE n.nameNetwork = :nameNetwork"),
    @NamedQuery(name = "Network.findByActiveNetwork", query = "SELECT n FROM Network n WHERE n.activeNetwork = :activeNetwork"),
    @NamedQuery(name = "Network.findByAssociatedFunding", query = "SELECT n FROM Network n WHERE n.associatedFunding = :associatedFunding"),
    @NamedQuery(name = "Network.findByNbResultingPublications", query = "SELECT n FROM Network n WHERE n.nbResultingPublications = :nbResultingPublications"),
    @NamedQuery(name = "Network.findByRefResultingPublications", query = "SELECT n FROM Network n WHERE n.refResultingPublications = :refResultingPublications"),
    @NamedQuery(name = "Network.findByUmrCoordinated", query = "SELECT n FROM Network n WHERE n.umrCoordinated = :umrCoordinated"),
    @NamedQuery(name = "Network.findByAgreementSigned", query = "SELECT n FROM Network n WHERE n.agreementSigned = :agreementSigned")})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Network implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_activity")
    private Integer idActivity;
    @Column(name = "start_date")
    @Temporal(TemporalType.DATE)
    private Date startDate;
    @Size(max = 256)
    @Column(name = "name_network")
    private String nameNetwork;
    @Column(name = "active_network")
    private Boolean activeNetwork;
    @Size(max = 256)
    @Column(name = "associated_funding")
    private String associatedFunding;
    @Column(name = "nb_resulting_publications")
    private Integer nbResultingPublications;
    @Size(max = 256)
    @Column(name = "ref_resulting_publications")
    private String refResultingPublications;
    @Column(name = "umr_coordinated")
    private Boolean umrCoordinated;
    @Column(name = "agreement_signed")
    private Boolean agreementSigned;
    @JoinColumn(name = "id_activity", referencedColumnName = "id_activity", insertable = false, updatable = false)
    @OneToOne(optional = false, cascade = CascadeType.ALL)
    private Activity activity;

}