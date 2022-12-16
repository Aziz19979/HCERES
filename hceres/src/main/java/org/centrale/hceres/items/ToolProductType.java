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
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 *
 * @author kwyhr
 */
@Entity
@Table(name = "tool_product_type")
@NamedQueries({
    @NamedQuery(name = "ToolProductType.findAll", query = "SELECT t FROM ToolProductType t"),
    @NamedQuery(name = "ToolProductType.findByToolProductTypeId", query = "SELECT t FROM ToolProductType t WHERE t.toolProductTypeId = :toolProductTypeId"),
    @NamedQuery(name = "ToolProductType.findByToolProductTypeName", query = "SELECT t FROM ToolProductType t WHERE t.toolProductTypeName = :toolProductTypeName")})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ToolProductType implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "tool_product_type_id")
    private Integer toolProductTypeId;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 256)
    @Column(name = "tool_product_type_name")
    private String toolProductTypeName;
    @JsonIgnore
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "toolProductTypeId")
    private List<ToolProduct> toolProductList;

}