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
import com.fasterxml.jackson.annotation.JsonBackReference;
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
import javax.persistence.ManyToMany;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
//import org.centrale.tools.Utilities;
import com.fasterxml.jackson.annotation.JsonIgnore;
/**
 *
 * @author kwyhr
 */
@Entity
@Table(name = "researcher")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Researcher implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "researcher_id")
    private Integer researcherId;
    
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 256)
    @Column(name = "researcher_surname")
    private String researcherSurname;
    
    @Size(max = 256)
    @Column(name = "researcher_name")
    private String researcherName;
    
    @Size(max = 256)
    @Column(name = "researcher_email")
    private String researcherEmail;
    
    @Size(max = 256)
    @Column(name = "researcher_orcid")
    private String researcherOrcid;
    
    @Size(max = 256)
    @Column(name = "researcher_login")
    private String researcherLogin;
    
    @Size(max = 1024)
    @Column(name = "researcher_password")
    private String researcherPassword;
    @JsonIgnore
    @ManyToMany(mappedBy = "researcherList")
    private List<Nationality> nationalityList;
    @JsonIgnore
    @ManyToMany(mappedBy = "researcherList")
    private List<Activity> activityList;
    @JsonIgnore
    @OneToMany(mappedBy = "researcherId")
    private List<Connection> connectionList;
    @JsonIgnore
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "researcherId")
    private List<Contract> contractList;
    @JsonIgnore
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "researcherId")
    private List<TeamReferent> teamReferentList;
    @JsonIgnore
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "researcherId")
    private List<Supervisor> supervisorList;
    @JsonIgnore
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "researcherId")
    private List<PhdStudent> phdStudentList;
    @OneToOne(cascade = CascadeType.ALL, mappedBy = "researcher")
    private Admin admin;

    @JsonIgnore
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "researcherId")
    private List<BelongsTeam> belongsTeamList;

}