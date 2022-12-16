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
@Table(name = "book_chapter")
@NamedQueries({
    @NamedQuery(name = "BookChapter.findAll", query = "SELECT b FROM BookChapter b"),
    @NamedQuery(name = "BookChapter.findByIdActivity", query = "SELECT b FROM BookChapter b WHERE b.idActivity = :idActivity"),
    @NamedQuery(name = "BookChapter.findByPublicationDate", query = "SELECT b FROM BookChapter b WHERE b.publicationDate = :publicationDate"),
    @NamedQuery(name = "BookChapter.findByBookTitle", query = "SELECT b FROM BookChapter b WHERE b.bookTitle = :bookTitle"),
    @NamedQuery(name = "BookChapter.findByChapterTitle", query = "SELECT b FROM BookChapter b WHERE b.chapterTitle = :chapterTitle"),
    @NamedQuery(name = "BookChapter.findByEditor", query = "SELECT b FROM BookChapter b WHERE b.editor = :editor"),
    @NamedQuery(name = "BookChapter.findByNbPage", query = "SELECT b FROM BookChapter b WHERE b.nbPage = :nbPage"),
    @NamedQuery(name = "BookChapter.findByAuthors", query = "SELECT b FROM BookChapter b WHERE b.authors = :authors"),
    @NamedQuery(name = "BookChapter.findByAdditionalInfo", query = "SELECT b FROM BookChapter b WHERE b.additionalInfo = :additionalInfo")})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class BookChapter implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_activity")
    private Integer idActivity;
    @Column(name = "publication_date")
    @Temporal(TemporalType.DATE)
    private Date publicationDate;
    @Size(max = 256)
    @Column(name = "book_title")
    private String bookTitle;
    @Size(max = 256)
    @Column(name = "chapter_title")
    private String chapterTitle;
    @Size(max = 256)
    @Column(name = "editor")
    private String editor;
    @Column(name = "nb_page")
    private Integer nbPage;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "authors")
    private String authors;
    @Size(max = 2147483647)
    @Column(name = "additional_info")
    private String additionalInfo;
    @JoinColumn(name = "id_activity", referencedColumnName = "id_activity", insertable = false, updatable = false)
    @OneToOne(optional = false)
    private Activity activity;
    @JoinColumn(name = "language_id", referencedColumnName = "language_id")
    @ManyToOne(optional = false)
    private Language languageId;

}