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
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 *
 * @author kwyhr
 */
@Entity
@Table(name = "public_outreach")
@NamedQueries({
    @NamedQuery(name = "PublicOutreach.findAll", query = "SELECT p FROM PublicOutreach p"),
    @NamedQuery(name = "PublicOutreach.findByIdActivity", query = "SELECT p FROM PublicOutreach p WHERE p.idActivity = :idActivity"),
    @NamedQuery(name = "PublicOutreach.findByCompletionDate", query = "SELECT p FROM PublicOutreach p WHERE p.completionDate = :completionDate"),
    @NamedQuery(name = "PublicOutreach.findByDescription", query = "SELECT p FROM PublicOutreach p WHERE p.description = :description")})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class PublicOutreach implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_activity")
    private Integer idActivity;
    @Column(name = "completion_date")
    @Temporal(TemporalType.DATE)
    private Date completionDate;
    @Size(max = 256)
    @Column(name = "description")
    private String description;
    @JoinColumn(name = "id_activity", referencedColumnName = "id_activity", insertable = false, updatable = false)
    @OneToOne(optional = false)
    private Activity activity;
    @JoinColumn(name = "public_outreach_type_id", referencedColumnName = "public_outreach_type_id")
    @ManyToOne(optional = false)
    private PublicOutreachType publicOutreachTypeId;

}