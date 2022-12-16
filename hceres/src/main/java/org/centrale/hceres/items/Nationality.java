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
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 *
 * @author kwyhr
 */
@Entity
@Table(name = "nationality")
@NamedQueries({
    @NamedQuery(name = "Nationality.findAll", query = "SELECT n FROM Nationality n"),
    @NamedQuery(name = "Nationality.findByNationalityId", query = "SELECT n FROM Nationality n WHERE n.nationalityId = :nationalityId"),
    @NamedQuery(name = "Nationality.findByNationalityName", query = "SELECT n FROM Nationality n WHERE n.nationalityName = :nationalityName")})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Nationality implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "nationality_id")
    private Integer nationalityId;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 128)
    @Column(name = "nationality_name")
    private String nationalityName;
    @JoinTable(name = "researcher_nationality", joinColumns = {
        @JoinColumn(name = "nationality_id", referencedColumnName = "nationality_id")}, inverseJoinColumns = {
        @JoinColumn(name = "researcher_id", referencedColumnName = "researcher_id")})
    @ManyToMany
    private List<Researcher> researcherList;

}