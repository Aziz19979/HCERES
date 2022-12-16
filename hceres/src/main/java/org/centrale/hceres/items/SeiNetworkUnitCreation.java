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
@Table(name = "sei_network_unit_creation")
@NamedQueries({
    @NamedQuery(name = "SeiNetworkUnitCreation.findAll", query = "SELECT s FROM SeiNetworkUnitCreation s"),
    @NamedQuery(name = "SeiNetworkUnitCreation.findByIdActivity", query = "SELECT s FROM SeiNetworkUnitCreation s WHERE s.idActivity = :idActivity"),
    @NamedQuery(name = "SeiNetworkUnitCreation.findByNetworkStartDate", query = "SELECT s FROM SeiNetworkUnitCreation s WHERE s.networkStartDate = :networkStartDate"),
    @NamedQuery(name = "SeiNetworkUnitCreation.findByNameNetwork", query = "SELECT s FROM SeiNetworkUnitCreation s WHERE s.nameNetwork = :nameNetwork"),
    @NamedQuery(name = "SeiNetworkUnitCreation.findByNamePartner", query = "SELECT s FROM SeiNetworkUnitCreation s WHERE s.namePartner = :namePartner"),
    @NamedQuery(name = "SeiNetworkUnitCreation.findByTitleProject", query = "SELECT s FROM SeiNetworkUnitCreation s WHERE s.titleProject = :titleProject"),
    @NamedQuery(name = "SeiNetworkUnitCreation.findByNetworkEndDate", query = "SELECT s FROM SeiNetworkUnitCreation s WHERE s.networkEndDate = :networkEndDate"),
    @NamedQuery(name = "SeiNetworkUnitCreation.findByAssociatedPubliRef", query = "SELECT s FROM SeiNetworkUnitCreation s WHERE s.associatedPubliRef = :associatedPubliRef")})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class SeiNetworkUnitCreation implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_activity")
    private Integer idActivity;
    @Column(name = "network_start_date")
    @Temporal(TemporalType.DATE)
    private Date networkStartDate;
    @Size(max = 256)
    @Column(name = "name_network")
    private String nameNetwork;
    @Size(max = 256)
    @Column(name = "name_partner")
    private String namePartner;
    @Size(max = 256)
    @Column(name = "title_project")
    private String titleProject;
    @Column(name = "network_end_date")
    @Temporal(TemporalType.DATE)
    private Date networkEndDate;
    @Size(max = 256)
    @Column(name = "associated_publi_ref")
    private String associatedPubliRef;
    @JoinColumn(name = "id_activity", referencedColumnName = "id_activity", insertable = false, updatable = false)
    @OneToOne(optional = false)
    private Activity activity;

}