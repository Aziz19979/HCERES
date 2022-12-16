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
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
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
@Table(name = "laboratory")
@NamedQueries({
    @NamedQuery(name = "Laboratory.findAll", query = "SELECT l FROM Laboratory l"),
    @NamedQuery(name = "Laboratory.findByLaboratoryId", query = "SELECT l FROM Laboratory l WHERE l.laboratoryId = :laboratoryId"),
    @NamedQuery(name = "Laboratory.findByLaboratoryName", query = "SELECT l FROM Laboratory l WHERE l.laboratoryName = :laboratoryName"),
    @NamedQuery(name = "Laboratory.findByLaboratoryAcronym", query = "SELECT l FROM Laboratory l WHERE l.laboratoryAcronym = :laboratoryAcronym")})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Laboratory implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "laboratory_id")
    private Integer laboratoryId;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 256)
    @Column(name = "laboratory_name")
    private String laboratoryName;
    @Size(max = 32)
    @Column(name = "laboratory_acronym")
    private String laboratoryAcronym;
    @JoinColumn(name = "institution_id", referencedColumnName = "institution_id")
    @ManyToOne(optional = false)
    private Institution institutionId;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "laboratoryId")
    private List<Team> teamList;

}