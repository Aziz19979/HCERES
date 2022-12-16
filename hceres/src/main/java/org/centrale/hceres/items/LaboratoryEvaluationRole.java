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
@Table(name = "laboratory_evaluation_role")
@NamedQueries({
    @NamedQuery(name = "LaboratoryEvaluationRole.findAll", query = "SELECT l FROM LaboratoryEvaluationRole l"),
    @NamedQuery(name = "LaboratoryEvaluationRole.findByLaboratoryEvaluationRoleId", query = "SELECT l FROM LaboratoryEvaluationRole l WHERE l.laboratoryEvaluationRoleId = :laboratoryEvaluationRoleId"),
    @NamedQuery(name = "LaboratoryEvaluationRole.findByNameChoice", query = "SELECT l FROM LaboratoryEvaluationRole l WHERE l.nameChoice = :nameChoice")})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class LaboratoryEvaluationRole implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "laboratory_evaluation_role_id")
    private Integer laboratoryEvaluationRoleId;
    @Size(max = 256)
    @Column(name = "name_choice")
    private String nameChoice;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "laboratoryEvaluationRoleId")
    private List<InstitutionalComitee> institutionalComiteeList;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "laboratoryEvaluationRoleId")
    private List<LaboratoryEvaluation> laboratoryEvaluationList;

}