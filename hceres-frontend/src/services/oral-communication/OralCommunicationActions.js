import axios from "axios";
import MyGlobalVar from "../MyGlobalVar";

export const fetchListOralCommunications = async () => {
    if (!MyGlobalVar.listeOralCommunications) {
        const response = await axios.get("http://localhost:9000/OralCommunications");
        MyGlobalVar.listeOralCommunications = response.data;
    }
    return MyGlobalVar.listeOralCommunications;
}

export const addOralCommunication  = async (data) => {
    return await axios.post("http://localhost:9000/OralCommunication/Create", data).then(response => {
        if (MyGlobalVar.listeOralCommunications)
            // using method push will use same reference of table,
            // so it will not trigger change state, therefore creating copy of the array
            // using concat method
            MyGlobalVar.listeOralCommunications = MyGlobalVar.listeOralCommunications.concat([response.data])
        return response
    });
}

export const deleteOralCommunication  = async (idActivity) => {
    return await axios.delete("http://localhost:9000/OralCommunication/Delete/" + idActivity).then(response => {
        // change to a new reference => cause change state immediately
        MyGlobalVar.listeOralCommunications = MyGlobalVar.deleteActivity(MyGlobalVar.listeOralCommunications, idActivity)
        return response
    });
}