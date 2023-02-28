package org.centrale.hceres.dto.stat;

import lombok.Data;
import org.centrale.hceres.dto.stat.utils.ActivityStatDto;
import org.centrale.hceres.items.Activity;

import java.util.Date;

@Data
public class PublicationStatDto extends ActivityStatDto {
    private Date publicationDate;

    @Override
    public void fillDataFromActivity(Activity activity) {
        super.fillDataFromActivity(activity);
        this.publicationDate = activity.getPublication().getPublicationDate();
    }
}
