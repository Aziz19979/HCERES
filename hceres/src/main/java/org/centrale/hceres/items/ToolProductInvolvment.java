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
import javax.persistence.*;
import javax.validation.constraints.Size;

/**
 *
 * @author kwyhr
 */
@Entity
@Table(name = "tool_product_involvment")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ToolProductInvolvment implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     *
     */
    @EmbeddedId
    protected ToolProductInvolvmentPK toolProductInvolvmentPK;
    @Size(max = 2147483647)
    @Column(name = "tool_product_involvment_researchers")
    private String toolProductInvolvmentResearchers;
    @JsonIgnore
    @JoinColumn(name = "id_activity", referencedColumnName = "id_activity", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private ToolProduct toolProduct;
    @JsonIgnore
    @JoinColumn(name = "tool_product_role_id", referencedColumnName = "tool_product_role_id", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private ToolProductRole toolProductRole;
}