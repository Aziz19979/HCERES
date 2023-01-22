class SupportedCsvFormat {
    // affected table: researcher
    RESEARCHER = {
        key: "RESEARCHER",
        label: "Liste des chercheurs",
        fileNamePattern: [
            /^researcher.*csv/,
        ],
        fields: [
            "Researcher_id",
            "Researcher_Surname",
            "Researcher_Name",
            "Researcher_Email",
        ],
        mergingRules: ["Merge based on equal ignoring case Surname, Name and Email",
        ],
        dependencies: [],
    };

    // affected table: institution
    INSTITUTION = {
        key: "INSTITUTION",
        label: "Liste des institutions",
        fileNamePattern: [
            /^institution.*csv/,
        ],
        fields: [
            "institution_id",
            "institution_name",
        ],
        mergingRules: ["Merge based on equal ignoring case team name",
        ],
        dependencies: [],
    };

    LABORATORY = {
        key: "LABORATORY",
        label: "Liste des laboratoires",
        fileNamePattern: [
            /^laboratory.*csv/,
        ],
        fields: [
            "laboratory_id",
            "laboratory_name",
            "laboratory_acronym",
            "institution_id"
        ],
        mergingRules: ["Merge based on equal ignoring case laboratory_name and laboratory_acronym",
        ],
        dependencies: [this.INSTITUTION],
    };

    TEAM = {
        key: "TEAM",
        label: "Liste des équipes",
        fileNamePattern: [
            /^team.*csv/,
        ],
        fields: [
            "team_id",
            "team_name",
            "laboratory_id"
        ],
        mergingRules: ["Merge based on equal ignoring case team name",
        ],
        dependencies: [this.LABORATORY],
    };

    BELONG_TEAM = {
        key: "BELONG_TEAM",
        label: "Associations des chercheurs aux équipes",
        fileNamePattern: [
            /^belongs_team.*csv/,
        ],
        fields: [
            "Researcher_ID",
            "Team_ID"
        ],
        mergingRules: ["Merge based using reference of dependencies Researcher and Team",
        ],
        dependencies: [this.RESEARCHER, this.TEAM],
    };

    NATIONALITY = {
        key: "NATIONALITY",
        label: "Liste des nationalités",
        fileNamePattern: [
            /^nationality.*csv/,
        ],
        fields: [
            "nationality_id",
            "nationality_name"
        ],
        mergingRules: ["Merge based on nationality_name",
        ],
        dependencies: [],
    };

    // Groupes of activities
    TYPE_ACTIVITY = {
        key: "TYPE_ACTIVITY",
        label: "Liste des types des activités",
        fileNamePattern: [
            /^type_activity.*csv/,
        ],
        fields: [
            "id_type",
            "name_type"
        ],
        mergingRules: ["Merge based on name_type ignoring case",
        ],
        dependencies: [],
    };
    ACTIVITY = {
        key: "ACTIVITY",
        label: "Liste des activités",
        fileNamePattern: [
            /^activity.*csv/,
        ],
        fields: [
            "id_type",
            "id_activity",
            "id_researcher",
            "specific_activity_count",
            "activity_name_type"
        ],
        mergingRules: ["Merge based on id_researcher, id_type present in dependencies.",
            "Dependency details of activites must be present in activityTemplate.csv matching id_type. Otherwise Entry is ignored",
        ],
        dependencies: [this.RESEARCHER, this.TYPE_ACTIVITY],
    };

    SR_AWARD = {
        key: "SR_AWARD",
        label: "Liste des sr_awards",
        fileNamePattern: [
            /^sr_award.*csv/,
        ],
        fields: [
            "id_activity",
            "award_date",
            "awardee_name",
            "description"
        ],
        mergingRules: ["Merge based on award_date, awardee_name and the researcher getting it",
        ],
        dependencies: [this.ACTIVITY],
    };

    getDependencies(template_key) {
        let dependencies = [];
        let currentAttribute = this[template_key];
        if (!currentAttribute) {
            return dependencies;
        }
        for (let dependency of currentAttribute.dependencies) {
            dependencies.push(dependency);
            dependencies = dependencies.concat(this.getDependencies(dependency.key));
        }
        return dependencies;
    }
}

export default (new SupportedCsvFormat())