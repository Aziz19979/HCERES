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
@Table(name = "project_evaluation_role")
@NamedQueries({
    @NamedQuery(name = "ProjectEvaluationRole.findAll", query = "SELECT p FROM ProjectEvaluationRole p"),
    @NamedQuery(name = "ProjectEvaluationRole.findByProjectEvaluationRoleId", query = "SELECT p FROM ProjectEvaluationRole p WHERE p.projectEvaluationRoleId = :projectEvaluationRoleId"),
    @NamedQuery(name = "ProjectEvaluationRole.findByProjectEvaluationRoleName", query = "SELECT p FROM ProjectEvaluationRole p WHERE p.projectEvaluationRoleName = :projectEvaluationRoleName")})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ProjectEvaluationRole implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "project_evaluation_role_id")
    private Integer projectEvaluationRoleId;
    @Size(max = 256)
    @Column(name = "project_evaluation_role_name")
    private String projectEvaluationRoleName;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "projectEvaluationRoleId")
    private List<ProjectEvaluation> projectEvaluationList;

}