package org.centrale.hceres.service.csv;

import lombok.Data;
import org.centrale.hceres.items.Researcher;
import org.centrale.hceres.repository.ActivityRepository;
import org.centrale.hceres.repository.InstitutionRepository;
import org.centrale.hceres.repository.LanguageRepository;
import org.centrale.hceres.repository.ResearchRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;

@Data
@Service
public class DatabasePurger {
    @Autowired
    private ActivityRepository activityRepo;

    @Autowired
    private ResearchRepository researchRepo;

    @Autowired
    private InstitutionRepository institutionRepo;

    @Autowired
    private LanguageRepository languageRepo;

    public Researcher getSimpleResearcher(String name) {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        Researcher researcher = new Researcher();
        researcher.setResearcherLogin(name);
        researcher.setResearcherPassword(encoder.encode(name));
        researcher.setResearcherName(name);
        researcher.setResearcherSurname(name);
        researcher.setResearcherEmail(name + "@" + name + ".com");
        return researcher;
    }

    public Researcher getAdminResearcher() {
        return getSimpleResearcher("admin");
    }

    public Researcher getUserResearcher() {
        return getSimpleResearcher("user");
    }

    public List<Researcher> getDefaultResearchers() {
        return Arrays.asList(getAdminResearcher(), getUserResearcher());
    }

    public void purgeData() {
        activityRepo.deleteAll();
        researchRepo.deleteAll();
        institutionRepo.deleteAll();
        languageRepo.deleteAll();
        researchRepo.saveAll(getDefaultResearchers());
    }
}
