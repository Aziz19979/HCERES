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
import java.util.Date;
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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 *
 * @author kwyhr
 */
@Entity
@Table(name = "meeting")
@NamedQueries({
    @NamedQuery(name = "Meeting.findAll", query = "SELECT m FROM Meeting m"),
    @NamedQuery(name = "Meeting.findByMeetingId", query = "SELECT m FROM Meeting m WHERE m.meetingId = :meetingId"),
    @NamedQuery(name = "Meeting.findByNeetingName", query = "SELECT m FROM Meeting m WHERE m.meetingName = :neetingName"),
    @NamedQuery(name = "Meeting.findByMeetingYear", query = "SELECT m FROM Meeting m WHERE m.meetingYear = :meetingYear"),
    @NamedQuery(name = "Meeting.findByMeetingLocation", query = "SELECT m FROM Meeting m WHERE m.meetingLocation = :meetingLocation"),
    @NamedQuery(name = "Meeting.findByMeetingStart", query = "SELECT m FROM Meeting m WHERE m.meetingStart = :meetingStart"),
    @NamedQuery(name = "Meeting.findByMeetingEnd", query = "SELECT m FROM Meeting m WHERE m.meetingEnd = :meetingEnd")})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Meeting implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "meeting_id")
    private Integer meetingId;
    
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 256)
    @Column(name = "neeting_name")
    private String meetingName;
    
    @Basic(optional = false)
    @NotNull
    @Column(name = "meeting_year")
    private int meetingYear;
    
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 256)
    @Column(name = "meeting_location")
    private String meetingLocation;
    
    @Column(name = "meeting_start")
    @Temporal(TemporalType.DATE)
    private Date meetingStart;
    
    @Column(name = "meeting_end")
    @Temporal(TemporalType.DATE)
    private Date meetingEnd;

    @JsonIgnore
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "meetingId")
    private List<MeetingCongressOrg> meetingCongressOrgList;

    @JsonIgnore
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "meetingId")
    private List<OralCommunication> oralCommunicationList;

}