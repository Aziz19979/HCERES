import axios from "axios";
import MyGlobalVar from "../MyGlobalVar";

export const fetchListPatents = async () => {
    if (!MyGlobalVar.listePatents) {
        const response = await axios.get("http://localhost:9000/Patents");
        MyGlobalVar.listePatents = response.data;
    }
    return MyGlobalVar.listePatents;
}

export const addPatent = async (data) => {
    return await axios.post("http://localhost:9000/Patent/Create", data).then(response => {
        if (MyGlobalVar.listePatents) {
            response = MyGlobalVar.addResearcherDataToActivity(response)
            // using method push will use same reference of table,
            // so it will not trigger change state, therefore creating copy of the array
            // using concat method
            MyGlobalVar.listePatents = MyGlobalVar.listePatents.concat([response.data])
        }
        return response
    });
}

export const deletePatent = async (idActivity) => {
    return await axios.delete("http://localhost:9000/Patent/Delete/" + idActivity).then(response => {
        // change to a new reference => cause change state immediately
        MyGlobalVar.listePatents = MyGlobalVar.deleteActivity(MyGlobalVar.listePatents, idActivity)
        return response
    });
}