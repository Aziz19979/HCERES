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
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.CascadeType;

import org.hibernate.engine.internal.CascadePoint;

/**
 *
 * @author kwyhr
 */
@Entity
@Table(name = "sr_award")
@NamedQueries({
    @NamedQuery(name = "SrAward.findAll", query = "SELECT s FROM SrAward s"),
    @NamedQuery(name = "SrAward.findByIdActivity", query = "SELECT s FROM SrAward s WHERE s.idActivity = :idActivity"),
    @NamedQuery(name = "SrAward.findByAwardeeName", query = "SELECT s FROM SrAward s WHERE s.awardeeName = :awardeeName"),
    @NamedQuery(name = "SrAward.findByAwardDate", query = "SELECT s FROM SrAward s WHERE s.awardDate = :awardDate"),
    @NamedQuery(name = "SrAward.findByDescription", query = "SELECT s FROM SrAward s WHERE s.description = :description")})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class SrAward implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_activity")
    private Integer idActivity;
    @Size(max = 256)
    @Column(name = "awardee_name")
    private String awardeeName;
    @Column(name = "award_date")
    @Temporal(TemporalType.DATE)
    private Date awardDate;
    @Size(max = 2147483647)
    @Column(name = "description")
    private String description;
    @JsonIgnore
    @JoinColumn(name = "id_activity", referencedColumnName = "id_activity", insertable = false, updatable = false)
    @OneToOne(optional = false, cascade = CascadeType.ALL)
    private Activity activity;

}