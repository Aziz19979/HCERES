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
import com.fasterxml.jackson.annotation.JsonIgnore;
/**
 *
 * @author kwyhr
 */
@Entity
@Table(name = "education")
@NamedQueries({
    @NamedQuery(name = "Education.findAll", query = "SELECT e FROM Education e"),
    @NamedQuery(name = "Education.findByIdActivity", query = "SELECT e FROM Education e WHERE e.idActivity = :idActivity"),
    @NamedQuery(name = "Education.findByEducationCourseName", query = "SELECT e FROM Education e WHERE e.educationCourseName = :educationCourseName"),
    @NamedQuery(name = "Education.findByEducationCompletion", query = "SELECT e FROM Education e WHERE e.educationCompletion = :educationCompletion"),
    @NamedQuery(name = "Education.findByEducationDescription", query = "SELECT e FROM Education e WHERE e.educationDescription = :educationDescription"),
    @NamedQuery(name = "Education.findByEducationFormation", query = "SELECT e FROM Education e WHERE e.educationFormation = :educationFormation")})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Education implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_activity")
    private Integer idActivity;
    
    @Size(max = 256)
    @Column(name = "education_course_name")
    private String educationCourseName;
    
    @Column(name = "education_completion")
    @Temporal(TemporalType.DATE)
    private Date educationCompletion;
    
    @Size(max = 2147483647)
    @Column(name = "education_description")
    private String educationDescription;
    
    @Size(max = 256)
    @Column(name = "education_formation")
    private String educationFormation;
    @JsonIgnore
    @JoinColumn(name = "id_activity", referencedColumnName = "id_activity", insertable = false, updatable = false)
    @OneToOne(optional = false, cascade = CascadeType.ALL)
    private Activity activity;
    @JsonIgnore
    @JoinColumn(name = "education_involvment_id", referencedColumnName = "education_involvment_id")
    @ManyToOne(optional = false)
    private EducationInvolvment educationInvolvmentId;
    @JsonIgnore
    @JoinColumn(name = "education_level_id", referencedColumnName = "education_level_id")
    @ManyToOne(optional = false)
    private EducationLevel educationLevelId;

}