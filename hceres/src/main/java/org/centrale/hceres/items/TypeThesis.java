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
@Table(name = "type_thesis")
@NamedQueries({
    @NamedQuery(name = "TypeThesis.findAll", query = "SELECT t FROM TypeThesis t"),
    @NamedQuery(name = "TypeThesis.findByTypeThesisId", query = "SELECT t FROM TypeThesis t WHERE t.typeThesisId = :typeThesisId"),
    @NamedQuery(name = "TypeThesis.findByTypeThesisName", query = "SELECT t FROM TypeThesis t WHERE t.typeThesisName = :typeThesisName")})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class TypeThesis implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "type_thesis_id")
    private Integer typeThesisId;
    @Size(max = 256)
    @Column(name = "type_thesis_name")
    private String typeThesisName;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "typeThesisId")
    private List<EvaluationThesis> evaluationThesisList;

}