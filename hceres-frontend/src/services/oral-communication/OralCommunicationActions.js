import axios from "axios";
import MyGlobalVar from "../MyGlobalVar";
import {API_URL} from "../../constants";

export const fetchListOralCommunications = async () => {
    if (!MyGlobalVar.listeOralCommunications) {
        const response = await axios.get(API_URL + "/OralCommunications");
        MyGlobalVar.listeOralCommunications = response.data;
    }
    return MyGlobalVar.listeOralCommunications;
}

export const addOralCommunication = async (data) => {
    return await axios.get(API_URL + "/OralCommunication/Create", data).then(response => {
        if (MyGlobalVar.listeOralCommunications) {
            response = MyGlobalVar.addResearcherDataToActivity(response)
            // using method push will use same reference of table,
            // so it will not trigger change state, therefore creating copy of the array
            // using concat method
            MyGlobalVar.listeOralCommunications = MyGlobalVar.listeOralCommunications.concat([response.data])
        }
        return response
    });
}

export const deleteOralCommunication = async (idActivity) => {
    return await axios.delete(API_URL + "/OralCommunication/Delete/" + idActivity).then(response => {
        // change to a new reference => cause change state immediately
        MyGlobalVar.listeOralCommunications = MyGlobalVar.deleteActivity(MyGlobalVar.listeOralCommunications, idActivity)
        return response
    });
}