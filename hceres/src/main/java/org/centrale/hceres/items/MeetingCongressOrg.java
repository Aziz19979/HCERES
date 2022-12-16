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
import javax.validation.constraints.NotNull;

/**
 *
 * @author kwyhr
 */
@Entity
@Table(name = "meeting_congress_org")
@NamedQueries({
    @NamedQuery(name = "MeetingCongressOrg.findAll", query = "SELECT m FROM MeetingCongressOrg m"),
    @NamedQuery(name = "MeetingCongressOrg.findByIdActivity", query = "SELECT m FROM MeetingCongressOrg m WHERE m.idActivity = :idActivity")})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class MeetingCongressOrg implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_activity")
    private Integer idActivity;
    
    @JoinColumn(name = "id_activity", referencedColumnName = "id_activity", insertable = false, updatable = false)
    @OneToOne(optional = false)
    private Activity activity;
    
    @JoinColumn(name = "meeting_id", referencedColumnName = "meeting_id")
    @ManyToOne(optional = false)
    private Meeting meetingId;

}