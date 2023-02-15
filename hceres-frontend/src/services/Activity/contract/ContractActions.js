import axios from "axios";
import MyGlobalVar from "../../MyGlobalVar";
import {API_URL} from "../../../constants";

export const fetchListContracts = async () => {
    if (!MyGlobalVar.listeContracts) {
        const response = await axios.get(API_URL + "/Contracts");
        MyGlobalVar.listeContracts = response.data;
    }
    return MyGlobalVar.listeContracts;
}

export const addContract = async (data) => {
    return await axios.post(API_URL + "/Contract/Create", data).then(response => {
        if (MyGlobalVar.listeContracts) {
            response = MyGlobalVar.addResearcherDataToActivity(response)
            // using method push will use same reference of table,
            // so it will not trigger change state, therefore creating copy of the array
            // using concat method
            MyGlobalVar.listeContracts = MyGlobalVar.listeContracts.concat([response.data])
        }
        return response
    });
}

export const deleteContract = async (idActivity) => {
    return await axios.delete(API_URL + "/Contract/Delete/" + idActivity).then(response => {
        // change to a new reference => cause change state immediately
        MyGlobalVar.listeContracts = MyGlobalVar.deleteActivity(MyGlobalVar.listeContracts, idActivity)
        return response
    });
}