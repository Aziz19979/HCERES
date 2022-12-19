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
        this.listeIncomingMobilities = null;
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

    addResearcherDataToActivity(response) {
        // returned activity does not contain researcher data but id
        // appending researcher info from researcher list if it exists
        if (this.listeChercheurs) {
            response.data.researcherList = response.data.researcherList
                .map(r => this.listeChercheurs.find(f => f.researcherId === r.researcherId))
        }
        return response
    }
}

export default (new MyClass());