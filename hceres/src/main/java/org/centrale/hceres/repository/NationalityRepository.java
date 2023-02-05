package org.centrale.hceres.repository;

import org.centrale.hceres.items.Nationality;
import org.springframework.data.jpa.repository.JpaRepository;

public interface NationalityRepository extends JpaRepository<Nationality, Integer> {
}