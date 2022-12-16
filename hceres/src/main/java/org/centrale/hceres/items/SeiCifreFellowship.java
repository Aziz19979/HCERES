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
@Table(name = "sei_cifre_fellowship")
@NamedQueries({
    @NamedQuery(name = "SeiCifreFellowship.findAll", query = "SELECT s FROM SeiCifreFellowship s"),
    @NamedQuery(name = "SeiCifreFellowship.findByIdActivity", query = "SELECT s FROM SeiCifreFellowship s WHERE s.idActivity = :idActivity"),
    @NamedQuery(name = "SeiCifreFellowship.findByContractStartDate", query = "SELECT s FROM SeiCifreFellowship s WHERE s.contractStartDate = :contractStartDate"),
    @NamedQuery(name = "SeiCifreFellowship.findByNameFellow", query = "SELECT s FROM SeiCifreFellowship s WHERE s.nameFellow = :nameFellow"),
    @NamedQuery(name = "SeiCifreFellowship.findByNameCompanyInvolved", query = "SELECT s FROM SeiCifreFellowship s WHERE s.nameCompanyInvolved = :nameCompanyInvolved"),
    @NamedQuery(name = "SeiCifreFellowship.findByTitleThesis", query = "SELECT s FROM SeiCifreFellowship s WHERE s.titleThesis = :titleThesis"),
    @NamedQuery(name = "SeiCifreFellowship.findByContractEndDate", query = "SELECT s FROM SeiCifreFellowship s WHERE s.contractEndDate = :contractEndDate"),
    @NamedQuery(name = "SeiCifreFellowship.findByContractAmount", query = "SELECT s FROM SeiCifreFellowship s WHERE s.contractAmount = :contractAmount"),
    @NamedQuery(name = "SeiCifreFellowship.findByAssociatedPubliRef", query = "SELECT s FROM SeiCifreFellowship s WHERE s.associatedPubliRef = :associatedPubliRef")})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class SeiCifreFellowship implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_activity")
    private Integer idActivity;
    @Column(name = "contract_start_date")
    @Temporal(TemporalType.DATE)
    private Date contractStartDate;
    @Size(max = 256)
    @Column(name = "name_fellow")
    private String nameFellow;
    @Size(max = 256)
    @Column(name = "name_company_involved")
    private String nameCompanyInvolved;
    @Size(max = 256)
    @Column(name = "title_thesis")
    private String titleThesis;
    @Column(name = "contract_end_date")
    @Temporal(TemporalType.DATE)
    private Date contractEndDate;
    @Column(name = "contract_amount")
    private Integer contractAmount;
    @Size(max = 256)
    @Column(name = "associated_publi_ref")
    private String associatedPubliRef;
    @JoinColumn(name = "id_activity", referencedColumnName = "id_activity", insertable = false, updatable = false)
    @OneToOne(optional = false)
    private Activity activity;

}