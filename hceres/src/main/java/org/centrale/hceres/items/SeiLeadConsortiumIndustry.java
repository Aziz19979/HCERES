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
import javax.persistence.ManyToOne;
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
@Table(name = "sei_lead_consortium_industry")
@NamedQueries({
    @NamedQuery(name = "SeiLeadConsortiumIndustry.findAll", query = "SELECT s FROM SeiLeadConsortiumIndustry s"),
    @NamedQuery(name = "SeiLeadConsortiumIndustry.findByIdActivity", query = "SELECT s FROM SeiLeadConsortiumIndustry s WHERE s.idActivity = :idActivity"),
    @NamedQuery(name = "SeiLeadConsortiumIndustry.findByConsortiumStartDate", query = "SELECT s FROM SeiLeadConsortiumIndustry s WHERE s.consortiumStartDate = :consortiumStartDate"),
    @NamedQuery(name = "SeiLeadConsortiumIndustry.findByNameConsortium", query = "SELECT s FROM SeiLeadConsortiumIndustry s WHERE s.nameConsortium = :nameConsortium"),
    @NamedQuery(name = "SeiLeadConsortiumIndustry.findByTitleProject", query = "SELECT s FROM SeiLeadConsortiumIndustry s WHERE s.titleProject = :titleProject"),
    @NamedQuery(name = "SeiLeadConsortiumIndustry.findByPrivatePartyInvolved", query = "SELECT s FROM SeiLeadConsortiumIndustry s WHERE s.privatePartyInvolved = :privatePartyInvolved"),
    @NamedQuery(name = "SeiLeadConsortiumIndustry.findByConsortiumEndDate", query = "SELECT s FROM SeiLeadConsortiumIndustry s WHERE s.consortiumEndDate = :consortiumEndDate"),
    @NamedQuery(name = "SeiLeadConsortiumIndustry.findByAssociatedPubliRef", query = "SELECT s FROM SeiLeadConsortiumIndustry s WHERE s.associatedPubliRef = :associatedPubliRef")})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class SeiLeadConsortiumIndustry implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_activity")
    private Integer idActivity;
    @Column(name = "consortium_start_date")
    @Temporal(TemporalType.DATE)
    private Date consortiumStartDate;
    @Size(max = 256)
    @Column(name = "name_consortium")
    private String nameConsortium;
    @Size(max = 256)
    @Column(name = "title_project")
    private String titleProject;
    @Size(max = 256)
    @Column(name = "private_party_involved")
    private String privatePartyInvolved;
    @Column(name = "consortium_end_date")
    @Temporal(TemporalType.DATE)
    private Date consortiumEndDate;
    @Size(max = 256)
    @Column(name = "associated_publi_ref")
    private String associatedPubliRef;
    @JoinColumn(name = "id_activity", referencedColumnName = "id_activity", insertable = false, updatable = false)
    @OneToOne(optional = false)
    private Activity activity;
    @JoinColumn(name = "type_consortium_id", referencedColumnName = "type_consortium_id")
    @ManyToOne(optional = false)
    private TypeConsortium typeConsortiumId;

}