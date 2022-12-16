class MyClass {
    constructor() {
        this.listeChercheurs = null;
        this.listeEducations = null;
        this.listeSrAwards = null;
        this.listePlatforms = null;
        this.listeOralCommunications = null;
        this.listeIndustrialContracts = null;
        this.listeInternationalCollaborations = null;
        this.listeScientificExpertises = null;
        this.listeSeiClinicalTrials = null;
        this.listeIncomingMobilitys = null;
        this.listeEditorialActivities = null;
        this.listeReviewArticle = null;
        this.listePostDocs = null;
    }

    deleteActivity(activityList, idActivity) {
        if (activityList) {
            activityList = activityList.filter(edu => edu.idActivity !== idActivity)
        }
        return activityList
    }
}

export default (new MyClass());