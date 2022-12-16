package org.centrale.hceres.repository;

import org.centrale.hceres.items.Activity;
import org.centrale.hceres.items.Researcher;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import javax.persistence.NamedQuery;
import java.util.List;
import java.util.Optional;

@Repository
public interface ActivityRepository extends JpaRepository<Activity, Integer>{

    // using jpa repository convention => no need to explicite named query
    List<Activity> findByIdTypeActivity(Integer idTypeActivity);

    @Query("FROM Activity a WHERE a.idActivity=:idActivity")
    Activity findByIdActivity(@Param("idActivity") Integer idActivity);
}
