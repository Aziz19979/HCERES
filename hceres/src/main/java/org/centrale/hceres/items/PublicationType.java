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

import com.fasterxml.jackson.annotation.JsonIgnore;

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
@Table(name = "publication_type")
@NamedQueries({
    @NamedQuery(name = "PublicationType.findAll", query = "SELECT p FROM PublicationType p"),
    @NamedQuery(name = "PublicationType.findByPublicationTypeId", query = "SELECT p FROM PublicationType p WHERE p.publicationTypeId = :publicationTypeId"),
    @NamedQuery(name = "PublicationType.findByPublicationTypeName", query = "SELECT p FROM PublicationType p WHERE p.publicationTypeName = :publicationTypeName")})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class PublicationType implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "publication_type_id")
    private Integer publicationTypeId;
    @Size(max = 256)
    @Column(name = "publication_type_name")
    private String publicationTypeName;
    @JsonIgnore
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "publicationTypeId")
    private List<Publication> publicationList;

}