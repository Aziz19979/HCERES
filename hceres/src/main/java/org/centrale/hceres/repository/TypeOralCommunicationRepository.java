package org.centrale.hceres.repository;

import org.centrale.hceres.items.TypeOralCommunication;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TypeOralCommunicationRepository extends JpaRepository<TypeOralCommunication, Integer>{

}
