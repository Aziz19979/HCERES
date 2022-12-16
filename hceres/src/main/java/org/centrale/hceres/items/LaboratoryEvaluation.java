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
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 *
 * @author kwyhr
 */
@Entity
@Table(name = "laboratory_evaluation")
@NamedQueries({
    @NamedQuery(name = "LaboratoryEvaluation.findAll", query = "SELECT l FROM LaboratoryEvaluation l"),
    @NamedQuery(name = "LaboratoryEvaluation.findByIdActivity", query = "SELECT l FROM LaboratoryEvaluation l WHERE l.idActivity = :idActivity"),
    @NamedQuery(name = "LaboratoryEvaluation.findByLaboratoryEvaluationName", query = "SELECT l FROM LaboratoryEvaluation l WHERE l.laboratoryEvaluationName = :laboratoryEvaluationName"),
    @NamedQuery(name = "LaboratoryEvaluation.findByYear", query = "SELECT l FROM LaboratoryEvaluation l WHERE l.year = :year")})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class LaboratoryEvaluation implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_activity")
    private Integer idActivity;
    @Size(max = 256)
    @Column(name = "laboratory_evaluation_name")
    private String laboratoryEvaluationName;
    @Column(name = "year")
    private Integer year;
    @JoinColumn(name = "id_activity", referencedColumnName = "id_activity", insertable = false, updatable = false)
    @OneToOne(optional = false)
    private Activity activity;
    @JoinColumn(name = "laboratory_evaluation_role_id", referencedColumnName = "laboratory_evaluation_role_id")
    @ManyToOne(optional = false)
    private LaboratoryEvaluationRole laboratoryEvaluationRoleId;

}