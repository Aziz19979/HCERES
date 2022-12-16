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
import java.util.List;
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
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 *
 * @author kwyhr
 */
@Entity
@Table(name = "mail_template")
@NamedQueries({
    @NamedQuery(name = "MailTemplate.findAll", query = "SELECT m FROM MailTemplate m"),
    @NamedQuery(name = "MailTemplate.findByMailTemplateId", query = "SELECT m FROM MailTemplate m WHERE m.mailTemplateId = :mailTemplateId"),
    @NamedQuery(name = "MailTemplate.findByMailTemplateTitle", query = "SELECT m FROM MailTemplate m WHERE m.mailTemplateTitle = :mailTemplateTitle"),
    @NamedQuery(name = "MailTemplate.findByMailTemplateContent", query = "SELECT m FROM MailTemplate m WHERE m.mailTemplateContent = :mailTemplateContent")})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class MailTemplate implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "mail_template_id")
    private Integer mailTemplateId;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 256)
    @Column(name = "mail_template_title")
    private String mailTemplateTitle;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "mail_template_content")
    private String mailTemplateContent;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "mailTemplateId")
    private List<MailActivity> mailActivityList;

}