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
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.io.Serializable;
import java.util.List;
import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 *
 * @author kwyhr
 */
@Entity
@Table(name = "scientific_expertise_type")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ScientificExpertiseType implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "scientific_expertise_type_id")
    private Integer scientificExpertiseTypeId;
    @Basic(optional = false)
    @NotNull
    @Size(max = 256)
    @Column(name = "name_choice")
    private String nameChoice;

    @JsonIgnore
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "scientificExpertiseTypeId")
    private List<ScientificExpertise> scientificExpertiseList;
}