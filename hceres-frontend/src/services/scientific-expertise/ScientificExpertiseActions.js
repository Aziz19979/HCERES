import axios from "axios";
import MyGlobalVar from "../MyGlobalVar";

export const fetchListScientificExpertises = async () => {
    if (!MyGlobalVar.listeScientificExpertises) {
        const response = await axios.get("http://localhost:9000/ScientificExpertises");
        MyGlobalVar.listeScientificExpertises = response.data;
    }
    return MyGlobalVar.listeScientificExpertises;
}

export const addScientificExpertise  = async (data) => {
    return await axios.post("http://localhost:9000/ScientificExpertise/Create", data).then(response => {
        if (MyGlobalVar.listeScientificExpertises)
            // using method push will use same reference of table,
            // so it will not trigger change state, therefore creating copy of the array
            // using concat method
            MyGlobalVar.listeScientificExpertises = MyGlobalVar.listeScientificExpertises.concat([response.data])
        return response
    });
}

export const deleteScientificExpertise  = async (idActivity) => {
    return await axios.delete("http://localhost:9000/ScientificExpertise/Delete/" + idActivity).then(response => {
        // change to a new reference => cause change state immediately
        MyGlobalVar.listeScientificExpertises = MyGlobalVar.deleteActivity(MyGlobalVar.listeScientificExpertises, idActivity)
        return response
    });
}