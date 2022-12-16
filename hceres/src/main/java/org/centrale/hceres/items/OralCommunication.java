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
import javax.persistence.CascadeType;
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
import javax.persistence.CascadeType;
import com.fasterxml.jackson.annotation.JsonIgnore;


/**
 *
 * @author kwyhr
 */
@Entity
@Table(name = "oral_communication")
@NamedQueries({
    @NamedQuery(name = "OralCommunication.findAll", query = "SELECT o FROM OralCommunication o"),
    @NamedQuery(name = "OralCommunication.findByIdActivity", query = "SELECT o FROM OralCommunication o WHERE o.idActivity = :idActivity"),
    @NamedQuery(name = "OralCommunication.findByOralCommunicationTitle", query = "SELECT o FROM OralCommunication o WHERE o.oralCommunicationTitle = :oralCommunicationTitle"),
    @NamedQuery(name = "OralCommunication.findByOralCommunicationDat", query = "SELECT o FROM OralCommunication o WHERE o.oralCommunicationDat = :oralCommunicationDat"),
    @NamedQuery(name = "OralCommunication.findByAuthors", query = "SELECT o FROM OralCommunication o WHERE o.authors = :authors")})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class OralCommunication implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_activity")
    private Integer idActivity;
    
    @Size(max = 512)
    @Column(name = "oral_communication_title")
    private String oralCommunicationTitle;
    
    @Basic(optional = false)
    @NotNull
    @Column(name = "oral_communication_dat")
    @Temporal(TemporalType.DATE)
    private Date oralCommunicationDat;
    
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "authors")
    private String authors;
    @JsonIgnore
    @JoinColumn(name = "id_activity", referencedColumnName = "id_activity", insertable = false, updatable = false)
    @OneToOne(optional = false, cascade = CascadeType.ALL)
    private Activity activity;

    @JoinColumn(name = "meeting_id", referencedColumnName = "meeting_id")
    @ManyToOne(optional = false)
    private Meeting meetingId;
    @JsonIgnore
    @JoinColumn(name = "type_oral_communication_id", referencedColumnName = "type_oral_communication_id")
    @ManyToOne(optional = false)
    private TypeOralCommunication typeOralCommunicationId;

}