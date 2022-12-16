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
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 *
 * @author kwyhr
 */
@Entity
@Table(name = "contract_type")
@NamedQueries({
    @NamedQuery(name = "ContractType.findAll", query = "SELECT c FROM ContractType c"),
    @NamedQuery(name = "ContractType.findByIdContractType", query = "SELECT c FROM ContractType c WHERE c.idContractType = :idContractType"),
    @NamedQuery(name = "ContractType.findByNameContractType", query = "SELECT c FROM ContractType c WHERE c.nameContractType = :nameContractType")})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ContractType implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_contract_type")
    private Integer idContractType;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 256)
    @Column(name = "name_contract_type")
    private String nameContractType;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idContractType")
    private List<Contract> contractList;

}