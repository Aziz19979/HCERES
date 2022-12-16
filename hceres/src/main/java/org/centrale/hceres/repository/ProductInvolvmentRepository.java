package org.centrale.hceres.repository;
import org.centrale.hceres.items.ToolProductInvolvment;
import org.centrale.hceres.items.ToolProductInvolvmentPK;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProductInvolvmentRepository extends JpaRepository<ToolProductInvolvment, Integer> {
    
}
