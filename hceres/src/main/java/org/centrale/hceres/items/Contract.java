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
import java.util.Date;
import javax.persistence.*;
import javax.validation.constraints.Size;

/**
 *
 * @author kwyhr
 */
@Entity
@Table(name = "contract")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Contract implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "id_activity")
    private Integer idActivity;

    @JsonIgnore
    @JoinColumn(name = "id_activity")
    @MapsId
    @OneToOne(cascade = CascadeType.ALL)
    private Activity activity;
    /**
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_contract")
    private Integer idContract;
     */
    @Column(name = "start_contract")
    @Temporal(TemporalType.DATE)
    private Date startContract;
    @Column(name = "end_contract")
    @Temporal(TemporalType.DATE)
    private Date endContract;
    @Size(max = 256)
    @Column(name = "function_contract")
    private String functionContract;
    @JoinColumn(name = "id_contract_type", referencedColumnName = "id_contract_type")
    @ManyToOne(optional = false)
    private ContractType idContractType;
    @JoinColumn(name = "id_employer", referencedColumnName = "id_employer")
    @ManyToOne(optional = false)
    private Employer idEmployer;

    @JsonIgnore
    @JoinColumn(name = "researcher_id", referencedColumnName = "researcher_id")
    @ManyToOne(optional = false)
    private Researcher researcher;
    @JoinColumn(name = "id_status", referencedColumnName = "id_status")
    @ManyToOne(optional = false)
    private Status status;
}