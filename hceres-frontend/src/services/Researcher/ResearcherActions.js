import axios from "axios";
import MyGlobalVar from "../MyGlobalVar";

export const fetchListResearchers = async function fetchData() {
    if (!MyGlobalVar.listeChercheurs) {
        const response = await axios.get("http://localhost:9000/Researchers");
        MyGlobalVar.listeChercheurs = response.data;
    }
    return MyGlobalVar.listeChercheurs;
}

// currently not caching activities to facilitate its update on changes
// otherwise create a global map as {researcherId:[listActivities]}
export const fetchResearcherActivities = async function fetchData(researcherId) {
    const response = await axios.get("http://localhost:9000/Researcher/" + researcherId + "/Activities");
    return response.data
}

