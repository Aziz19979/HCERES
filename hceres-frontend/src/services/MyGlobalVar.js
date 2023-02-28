import {fetchListTeams} from "./Team/TeamActions";

class MyClass {
    constructor() {
        this.initializeLists();
    }

    initializeLists() {
        this.listeChercheurs = null;
        this.listeEducations = null;
        this.listeSrAwards = null;
        this.listePlatforms = null;
        this.listeOralComPosters = null;
        this.listeIndustrialContracts = null;
        this.listeInternationalCollaborations = null;
        this.listeScientificExpertises = null;
        this.listeSeiClinicalTrials = null;
        this.listeIncomingMobilities = null;
        this.listeEditorialActivities = null;
        this.listeReviewArticle = null;
        this.listePostDocs = null;
        this.listeOutgoingMobilities = null;
        this.listeCompanyCreations = null;
        this.listePatents = null;
        this.listeTeams = null;
        this.listePublications = null;
        this.listeLaboratories = null;
        this.listeActivityStats = {};
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

    async addTeamDataToResearchers(researcherList) {
        await fetchListTeams().then(list => {
            researcherList.forEach(r => {
                r["belongsTeamList"].forEach(t => {
                    t["team"] = list.find(f => f.teamId === t.teamId)
                })
            });
        });
    }
}

export default (new MyClass());