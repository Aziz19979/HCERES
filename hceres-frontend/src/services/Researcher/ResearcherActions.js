import axios from "axios";
import MyGlobalVar from "../MyGlobalVar";
import {API_URL} from "../../constants";

export const fetchListResearchers = async function fetchData() {
    if (!MyGlobalVar.listeChercheurs) {
        const response = await axios.get(API_URL + "/Researchers");
        MyGlobalVar.listeChercheurs = response.data;
    }
    return MyGlobalVar.listeChercheurs;
}

// currently not caching activities to facilitate its update on changes
// otherwise create a global map as {researcherId:[listActivities]}
export const fetchResearcherActivities = async function fetchData(researcherId) {
    const response = await axios.get(API_URL + "/Researcher/" + researcherId + "/Activities");
    return response.data
}

