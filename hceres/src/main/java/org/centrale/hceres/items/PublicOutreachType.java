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
@Table(name = "public_outreach_type")
@NamedQueries({
    @NamedQuery(name = "PublicOutreachType.findAll", query = "SELECT p FROM PublicOutreachType p"),
    @NamedQuery(name = "PublicOutreachType.findByPublicOutreachTypeId", query = "SELECT p FROM PublicOutreachType p WHERE p.publicOutreachTypeId = :publicOutreachTypeId"),
    @NamedQuery(name = "PublicOutreachType.findByPublicOutreachTypeName", query = "SELECT p FROM PublicOutreachType p WHERE p.publicOutreachTypeName = :publicOutreachTypeName")})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class PublicOutreachType implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "public_outreach_type_id")
    private Integer publicOutreachTypeId;
    @Size(max = 256)
    @Column(name = "public_outreach_type_name")
    private String publicOutreachTypeName;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "publicOutreachTypeId")
    private List<PublicOutreach> publicOutreachList;

}