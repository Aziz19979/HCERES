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
@Table(name = "type_oral_communication")
@NamedQueries({
    @NamedQuery(name = "TypeOralCommunication.findAll", query = "SELECT t FROM TypeOralCommunication t"),
    @NamedQuery(name = "TypeOralCommunication.findByTypeOralCommunicationId", query = "SELECT t FROM TypeOralCommunication t WHERE t.typeOralCommunicationId = :typeOralCommunicationId"),
    @NamedQuery(name = "TypeOralCommunication.findByTypeOralCommunicationName", query = "SELECT t FROM TypeOralCommunication t WHERE t.typeOralCommunicationName = :typeOralCommunicationName")})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class TypeOralCommunication implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "type_oral_communication_id")
    private Integer typeOralCommunicationId;
    
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 256)
    @Column(name = "type_oral_communication_name")
    private String typeOralCommunicationName;
    
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "typeOralCommunicationId")
    private List<OralCommunication> oralCommunicationList;

}