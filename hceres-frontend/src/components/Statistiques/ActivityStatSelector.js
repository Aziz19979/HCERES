import React from 'react';
import PublicationStat from "./publications/PublicationStat";
import ActivityStatDisplay from "./ActivityStatDisplay";
import ActivityTypes from "../../const/ActivityTypes";
import {ActivityStatTemplate} from "./ActivityStatTemplate";
import FixRequiredSelect from "../util/FixRequiredSelect";
import Select from "react-select";

const activityStatTemplates = [
    PublicationStat,
    ...Object.keys(ActivityTypes).map(activityType => new ActivityStatTemplate({
        idTypeActivity: ActivityTypes[activityType],
        label: activityType,
    })),
// clear duplicates stat templates based on idTypeActivity
].filter((activityStatTemplate, index, self) =>
        index === self.findIndex((t) => (
            t.idTypeActivity === activityStatTemplate.idTypeActivity
        ))
);


const activityStatOptions = activityStatTemplates.map(activityStatTemplate => {
    return {
        value: activityStatTemplate,
        label: activityStatTemplate.label,
    }
});
//     const csvTemplateOptions = Object.keys(SupportedCsvTemplate).map(template => {
//         return {
//             value: SupportedCsvTemplate[template],
//             label: SupportedCsvTemplate[template].label,
//         }
//     });
//                                             Associated Csv Template:
//                                             <FixRequiredSelect
//                                                 SelectComponent={Select}
//                                                 options={csvTemplateOptions}
//                                                 onChange={(option) => {
//                                                     dispatch({
//                                                         type: 'change-target-template',
//                                                         payload: option
//                                                     })
//                                                 }}
//                                                 value={state.associatedCsvTemplateOption}
//                                                 required={true}
//                                             />
export default function ActivityStatSelector() {
    const [selectedActivityStat, setSelectedActivityStat] = React.useState(activityStatTemplates[0]);

    return (
        <div style={{justifyContent: 'center', alignItems: 'center', height: '100vh'}}>
            <FixRequiredSelect
                SelectComponent={Select}
                options={activityStatOptions}
                onChange={(option) => {
                    setSelectedActivityStat(option.value)
                }}
                value={selectedActivityStat}
                required={true}
            />
            <ActivityStatDisplay
                activityStatEntry={selectedActivityStat}
            />
        </div>
    );
}