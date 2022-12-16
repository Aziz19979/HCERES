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
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;

/**
 *
 * @author kwyhr
 */
@Entity
@Table(name = "mail_activity")
@NamedQueries({
    @NamedQuery(name = "MailActivity.findAll", query = "SELECT m FROM MailActivity m"),
    @NamedQuery(name = "MailActivity.findByMailActivityId", query = "SELECT m FROM MailActivity m WHERE m.mailActivityId = :mailActivityId"),
    @NamedQuery(name = "MailActivity.findByMailActivityDate", query = "SELECT m FROM MailActivity m WHERE m.mailActivityDate = :mailActivityDate")})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class MailActivity implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "mail_activity_id")
    private Integer mailActivityId;
    @Basic(optional = false)
    @NotNull
    @Column(name = "mail_activity_date")
    @Temporal(TemporalType.DATE)
    private Date mailActivityDate;
    @JoinColumn(name = "id_activity", referencedColumnName = "id_activity")
    @ManyToOne(optional = false)
    private Activity idActivity;
    @JoinColumn(name = "mail_template_id", referencedColumnName = "mail_template_id")
    @ManyToOne(optional = false)
    private MailTemplate mailTemplateId;

}