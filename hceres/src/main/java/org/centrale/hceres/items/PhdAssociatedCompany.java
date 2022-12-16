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
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 *
 * @author kwyhr
 */
@Entity
@Table(name = "phd_associated_company")
@NamedQueries({
    @NamedQuery(name = "PhdAssociatedCompany.findAll", query = "SELECT p FROM PhdAssociatedCompany p"),
    @NamedQuery(name = "PhdAssociatedCompany.findByPhdStudentId", query = "SELECT p FROM PhdAssociatedCompany p WHERE p.phdAssociatedCompanyPK.phdStudentId = :phdStudentId"),
    @NamedQuery(name = "PhdAssociatedCompany.findByCompanyId", query = "SELECT p FROM PhdAssociatedCompany p WHERE p.phdAssociatedCompanyPK.companyId = :companyId"),
    @NamedQuery(name = "PhdAssociatedCompany.findByPhdAssociatedCompanyStart", query = "SELECT p FROM PhdAssociatedCompany p WHERE p.phdAssociatedCompanyStart = :phdAssociatedCompanyStart"),
    @NamedQuery(name = "PhdAssociatedCompany.findByPhdAssociatedCompanyEnd", query = "SELECT p FROM PhdAssociatedCompany p WHERE p.phdAssociatedCompanyEnd = :phdAssociatedCompanyEnd")})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class PhdAssociatedCompany implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     *
     */
    @EmbeddedId
    protected PhdAssociatedCompanyPK phdAssociatedCompanyPK;
    @Column(name = "phd_associated_company_start")
    @Temporal(TemporalType.DATE)
    private Date phdAssociatedCompanyStart;
    @Column(name = "phd_associated_company_end")
    @Temporal(TemporalType.DATE)
    private Date phdAssociatedCompanyEnd;
    @JoinColumn(name = "company_id", referencedColumnName = "company_id", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Company company;
    @JoinColumn(name = "phd_student_id", referencedColumnName = "phd_student_id", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private PhdStudent phdStudent;

}