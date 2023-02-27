import React from 'react';
import PublicationStat from "./publications/PublicationStat";
import ActivityStatDisplay from "./ActivityStatDisplay";

const activityStatTemplates = [
    PublicationStat,
]

export default function ActivityStatSelector () {

    return (
        <div style={{ justifyContent: 'center', alignItems: 'center', height: '100vh' }}>
            <ActivityStatDisplay
                activityStatEntry={activityStatTemplates[0]}
            />
        </div>
    );
}