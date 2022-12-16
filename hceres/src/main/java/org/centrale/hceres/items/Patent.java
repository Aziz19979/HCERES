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
@Table(name = "patent")
@NamedQueries({
    @NamedQuery(name = "Patent.findAll", query = "SELECT p FROM Patent p"),
    @NamedQuery(name = "Patent.findByIdActivity", query = "SELECT p FROM Patent p WHERE p.idActivity = :idActivity"),
    @NamedQuery(name = "Patent.findByTitle", query = "SELECT p FROM Patent p WHERE p.title = :title"),
    @NamedQuery(name = "Patent.findByRegistrationDate", query = "SELECT p FROM Patent p WHERE p.registrationDate = :registrationDate"),
    @NamedQuery(name = "Patent.findByFilingDate", query = "SELECT p FROM Patent p WHERE p.filingDate = :filingDate"),
    @NamedQuery(name = "Patent.findByAcceptationDate", query = "SELECT p FROM Patent p WHERE p.acceptationDate = :acceptationDate"),
    @NamedQuery(name = "Patent.findByLicensingDate", query = "SELECT p FROM Patent p WHERE p.licensingDate = :licensingDate"),
    @NamedQuery(name = "Patent.findByInventors", query = "SELECT p FROM Patent p WHERE p.inventors = :inventors"),
    @NamedQuery(name = "Patent.findByCoOwners", query = "SELECT p FROM Patent p WHERE p.coOwners = :coOwners"),
    @NamedQuery(name = "Patent.findByPriorityNumber", query = "SELECT p FROM Patent p WHERE p.priorityNumber = :priorityNumber"),
    @NamedQuery(name = "Patent.findByPriorityDate", query = "SELECT p FROM Patent p WHERE p.priorityDate = :priorityDate"),
    @NamedQuery(name = "Patent.findByPublicationNumber", query = "SELECT p FROM Patent p WHERE p.publicationNumber = :publicationNumber"),
    @NamedQuery(name = "Patent.findByPublicationDate", query = "SELECT p FROM Patent p WHERE p.publicationDate = :publicationDate"),
    @NamedQuery(name = "Patent.findByInpiLink", query = "SELECT p FROM Patent p WHERE p.inpiLink = :inpiLink"),
    @NamedQuery(name = "Patent.findByStatus", query = "SELECT p FROM Patent p WHERE p.status = :status"),
    @NamedQuery(name = "Patent.findByPctExtensionObtained", query = "SELECT p FROM Patent p WHERE p.pctExtensionObtained = :pctExtensionObtained"),
    @NamedQuery(name = "Patent.findByPublicationNumberPctExtension", query = "SELECT p FROM Patent p WHERE p.publicationNumberPctExtension = :publicationNumberPctExtension"),
    @NamedQuery(name = "Patent.findByPublicationDatePctExtension", query = "SELECT p FROM Patent p WHERE p.publicationDatePctExtension = :publicationDatePctExtension"),
    @NamedQuery(name = "Patent.findByInternationalExtension", query = "SELECT p FROM Patent p WHERE p.internationalExtension = :internationalExtension"),
    @NamedQuery(name = "Patent.findByPublicationNumberInternationalExtension", query = "SELECT p FROM Patent p WHERE p.publicationNumberInternationalExtension = :publicationNumberInternationalExtension"),
    @NamedQuery(name = "Patent.findByPublicationDateInternationalExtension", query = "SELECT p FROM Patent p WHERE p.publicationDateInternationalExtension = :publicationDateInternationalExtension"),
    @NamedQuery(name = "Patent.findByRefTransferContract", query = "SELECT p FROM Patent p WHERE p.refTransferContract = :refTransferContract"),
    @NamedQuery(name = "Patent.findByNameCompanyInvolved", query = "SELECT p FROM Patent p WHERE p.nameCompanyInvolved = :nameCompanyInvolved")})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Patent implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_activity")
    private Integer idActivity;
    @Size(max = 256)
    @Column(name = "title")
    private String title;
    @Column(name = "registration_date")
    @Temporal(TemporalType.DATE)
    private Date registrationDate;
    @Column(name = "filing_date")
    @Temporal(TemporalType.DATE)
    private Date filingDate;
    @Column(name = "acceptation_date")
    @Temporal(TemporalType.DATE)
    private Date acceptationDate;
    @Column(name = "licensing_date")
    @Temporal(TemporalType.DATE)
    private Date licensingDate;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "inventors")
    private String inventors;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "co_owners")
    private String coOwners;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "priority_number")
    private Float priorityNumber;
    @Column(name = "priority_date")
    @Temporal(TemporalType.DATE)
    private Date priorityDate;
    @Size(max = 256)
    @Column(name = "publication_number")
    private String publicationNumber;
    @Column(name = "publication_date")
    @Temporal(TemporalType.DATE)
    private Date publicationDate;
    @Size(max = 256)
    @Column(name = "inpi_link")
    private String inpiLink;
    @Basic(optional = false)
    @NotNull
    @Column(name = "status")
    private boolean status;
    @Basic(optional = false)
    @NotNull
    @Column(name = "pct_extension_obtained")
    private boolean pctExtensionObtained;
    @Size(max = 256)
    @Column(name = "publication_number_pct_extension")
    private String publicationNumberPctExtension;
    @Column(name = "publication_date_pct_extension")
    @Temporal(TemporalType.DATE)
    private Date publicationDatePctExtension;
    @Basic(optional = false)
    @NotNull
    @Column(name = "international_extension")
    private boolean internationalExtension;
    @Size(max = 256)
    @Column(name = "publication_number_international_extension")
    private String publicationNumberInternationalExtension;
    @Column(name = "publication_date_international_extension")
    @Temporal(TemporalType.DATE)
    private Date publicationDateInternationalExtension;
    @Size(max = 256)
    @Column(name = "ref_transfer_contract")
    private String refTransferContract;
    @Size(max = 256)
    @Column(name = "name_company_involved")
    private String nameCompanyInvolved;
    @JoinColumn(name = "id_activity", referencedColumnName = "id_activity", insertable = false, updatable = false)
    @OneToOne(optional = false)
    private Activity activity;
    @JoinColumn(name = "type_patent_id", referencedColumnName = "type_patent_id")
    @ManyToOne(optional = false)
    private TypePatent typePatentId;

}