import axios from "axios";
import MyGlobalVar from "../MyGlobalVar";

export const fetchListInternationalCollaborations = async () => {
    if (!MyGlobalVar.listeInternationalCollaborations) {
        const response = await axios.get("http://localhost:9000/InternationalCollaborations");
        MyGlobalVar.listeInternationalCollaborations = response.data;
    }
    return MyGlobalVar.listeInternationalCollaborations;
}

export const addInternationalCollaboration  = async (data) => {
    return await axios.post("http://localhost:9000/InternationalCollaboration/Create", data).then(response => {
        if (MyGlobalVar.listeInternationalCollaborations)
            // using method push will use same reference of table,
            // so it will not trigger change state, therefore creating copy of the array
            // using concat method
            MyGlobalVar.listeInternationalCollaborations = MyGlobalVar.listeInternationalCollaborations.concat([response.data])
        return response
    });
}

export const deleteInternationalCollaboration  = async (idActivity) => {
    return await axios.delete("http://localhost:9000/InternationalCollaboration/Delete/" + idActivity).then(response => {
        // change to a new reference => cause change state immediately
        MyGlobalVar.listeInternationalCollaborations = MyGlobalVar.deleteActivity(MyGlobalVar.listeInternationalCollaborations, idActivity)
        return response
    });
}