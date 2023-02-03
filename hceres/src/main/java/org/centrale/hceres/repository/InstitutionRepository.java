package org.centrale.hceres.repository;

import org.centrale.hceres.items.Institution;
import org.springframework.data.jpa.repository.JpaRepository;

public interface InstitutionRepository extends JpaRepository<Institution, Integer> {
}