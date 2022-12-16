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
import javax.validation.constraints.Size;

/**
 *
 * @author kwyhr
 */
@Entity
@Table(name = "type_research_contract")
@NamedQueries({
    @NamedQuery(name = "TypeResearchContract.findAll", query = "SELECT t FROM TypeResearchContract t"),
    @NamedQuery(name = "TypeResearchContract.findByIdType", query = "SELECT t FROM TypeResearchContract t WHERE t.idType = :idType"),
    @NamedQuery(name = "TypeResearchContract.findByNameChoice", query = "SELECT t FROM TypeResearchContract t WHERE t.nameChoice = :nameChoice")})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class TypeResearchContract implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_type")
    private Integer idType;
    @Size(max = 256)
    @Column(name = "name_choice")
    private String nameChoice;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idType")
    private List<ResearchContractFundedPublicCharitableInst> researchContractFundedPublicCharitableInstList;

}