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
@Table(name = "learned_scientific_society_role")
@NamedQueries({
    @NamedQuery(name = "LearnedScientificSocietyRole.findAll", query = "SELECT l FROM LearnedScientificSocietyRole l"),
    @NamedQuery(name = "LearnedScientificSocietyRole.findByLearnedScientificSocietyRoleId", query = "SELECT l FROM LearnedScientificSocietyRole l WHERE l.learnedScientificSocietyRoleId = :learnedScientificSocietyRoleId"),
    @NamedQuery(name = "LearnedScientificSocietyRole.findByNameChoice", query = "SELECT l FROM LearnedScientificSocietyRole l WHERE l.nameChoice = :nameChoice")})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class LearnedScientificSocietyRole implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "learned_scientific_society_role_id")
    private Integer learnedScientificSocietyRoleId;
    @Size(max = 256)
    @Column(name = "name_choice")
    private String nameChoice;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "learnedScientificSocietyRoleId")
    private List<LearnedScientificSociety> learnedScientificSocietyList;

}