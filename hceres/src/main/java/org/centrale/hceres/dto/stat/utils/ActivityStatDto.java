package org.centrale.hceres.dto.stat.utils;


import lombok.Data;

import java.io.Serializable;
import java.util.SortedSet;
import java.util.TreeSet;

@Data
public class ActivityStatDto implements Serializable {
    private int idActivity;
    private SortedSet<Integer> teamIds;

    public ActivityStatDto() {
        this.teamIds = new TreeSet<>();
    }
}
