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
@Table(name = "funder")
@NamedQueries({
    @NamedQuery(name = "Funder.findAll", query = "SELECT f FROM Funder f"),
    @NamedQuery(name = "Funder.findByFunderId", query = "SELECT f FROM Funder f WHERE f.funderId = :funderId"),
    @NamedQuery(name = "Funder.findByFunderName", query = "SELECT f FROM Funder f WHERE f.funderName = :funderName")})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Funder implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Size(min = 1, max = 2147483647)
    @Column(name = "funder_id")
    private String funderId;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 256)
    @Column(name = "funder_name")
    private String funderName;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "funderId")
    private List<ProjectEvaluation> projectEvaluationList;

}