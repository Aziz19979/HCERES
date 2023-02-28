import axios from "axios";
import {API_URL} from "../../constants";
import MyGlobalVar from "../MyGlobalVar";

export const fetchActivityStatOfType = async (idTypeActivity) => {
    const response = await axios.get(API_URL + "/ActivityStat/typeActivity/" + idTypeActivity);
    if (!MyGlobalVar.listeActivityStats[idTypeActivity]) {
        MyGlobalVar.listeActivityStats[idTypeActivity] = response.data;
    }
    return MyGlobalVar.listeActivityStats[idTypeActivity];
}