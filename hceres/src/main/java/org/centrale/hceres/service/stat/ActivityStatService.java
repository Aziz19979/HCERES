package org.centrale.hceres.service.stat;

import lombok.Data;
import org.centrale.hceres.dto.stat.PublicationStatDto;
import org.centrale.hceres.dto.stat.utils.ActivityStatDto;
import org.centrale.hceres.items.Activity;
import org.centrale.hceres.items.TypeActivity;
import org.centrale.hceres.items.TypeActivityId;
import org.centrale.hceres.repository.ActivityRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Data
@Service
public class ActivityStatService {

    @Autowired
    private ActivityRepository activityRepo;

    public List<ActivityStatDto> getStatByTypeActivity(Integer idTypeActivity) {
        List<ActivityStatDto> activityStatDtoList = new ArrayList<>();
        activityRepo.findByIdTypeActivity(idTypeActivity).forEach(activity ->
                activityStatDtoList.add(createStatActivity(activity)));

        return activityStatDtoList;
    }

    private ActivityStatDto createStatActivity(Activity activity) {
        ActivityStatDto activityStatDto;
        TypeActivityId typeActivityId = TypeActivityId.fromId(activity.getIdTypeActivity());
        switch (typeActivityId) {
            case PUBLICATION:
                activityStatDto = new PublicationStatDto();
                ((PublicationStatDto) activityStatDto).setPublicationDate(activity.getPublication().getPublicationDate());
                break;
            case BOOK:
            default:
                activityStatDto = new ActivityStatDto();
        }

        fillBasicActivityStatDto(activityStatDto, activity);
        return activityStatDto;
    }

    private void fillBasicActivityStatDto(ActivityStatDto activityStatDto, Activity activity) {
        activityStatDto.setIdActivity(activity.getIdActivity());
        activity.getResearcherList().forEach(researcher -> {
            activityStatDto.getResearcherIds().add(researcher.getResearcherId());

            researcher.getBelongsTeamList().forEach(belongsTeams ->
                    activityStatDto.getTeamIds().add(belongsTeams.getTeamId()));
        });
    }
}
