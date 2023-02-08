package org.centrale.hceres.repository;

import org.centrale.hceres.items.Status;
import org.springframework.data.jpa.repository.JpaRepository;

public interface StatusRepository extends JpaRepository<Status, Integer> {
}