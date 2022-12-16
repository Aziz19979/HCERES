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
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.Size;

/**
 *
 * @author kwyhr
 */
@Entity
@Table(name = "contract")
@NamedQueries({
    @NamedQuery(name = "Contract.findAll", query = "SELECT c FROM Contract c"),
    @NamedQuery(name = "Contract.findByIdContract", query = "SELECT c FROM Contract c WHERE c.idContract = :idContract"),
    @NamedQuery(name = "Contract.findByStartContract", query = "SELECT c FROM Contract c WHERE c.startContract = :startContract"),
    @NamedQuery(name = "Contract.findByEndContract", query = "SELECT c FROM Contract c WHERE c.endContract = :endContract"),
    @NamedQuery(name = "Contract.findByFunctionContract", query = "SELECT c FROM Contract c WHERE c.functionContract = :functionContract")})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Contract implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_contract")
    private Integer idContract;
    @Column(name = "start_contract")
    @Temporal(TemporalType.DATE)
    private Date startContract;
    @Column(name = "end_contract")
    @Temporal(TemporalType.DATE)
    private Date endContract;
    @Size(max = 256)
    @Column(name = "function_contract")
    private String functionContract;
    @JoinColumn(name = "id_contract_type", referencedColumnName = "id_contract_type")
    @ManyToOne(optional = false)
    private ContractType idContractType;
    @JoinColumn(name = "id_employer", referencedColumnName = "id_employer")
    @ManyToOne(optional = false)
    private Employer idEmployer;
    @JoinColumn(name = "researcher_id", referencedColumnName = "researcher_id")
    @ManyToOne(optional = false)
    private Researcher researcherId;
    @JoinColumn(name = "id_status", referencedColumnName = "id_status")
    @ManyToOne(optional = false)
    private Status idStatus;

}