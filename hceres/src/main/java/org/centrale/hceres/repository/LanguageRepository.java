package org.centrale.hceres.repository;

import org.centrale.hceres.items.Language;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;


public interface LanguageRepository extends JpaRepository<Language, Integer> {

    @Query("FROM Language WHERE UPPER(languageName) = UPPER(:languageName)")
    Language findByName(@Param("languageName") String languageName);
}
