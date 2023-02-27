package org.centrale.hceres.dto.stat;

import lombok.Data;
import org.centrale.hceres.dto.stat.utils.ActivityStatDto;

import java.util.Date;

@Data
public class PublicationStatDto extends ActivityStatDto {
    private Date publicationDate;
}
