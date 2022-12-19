import axios from "axios";
import MyGlobalVar from "../MyGlobalVar";

export const fetchListIncomingMobilities = async () => {
    if (!MyGlobalVar.listeIncomingMobilities) {
        const response = await axios.get("http://localhost:9000/IncomingMobilities");
        MyGlobalVar.listeIncomingMobilities = response.data;
    }
    return MyGlobalVar.listeIncomingMobilities;
}

export const addIncomingMobility  = async (data) => {
    return await axios.post("http://localhost:9000/IncomingMobility/Create", data).then(response => {
        if (MyGlobalVar.listeIncomingMobilities)
            // using method push will use same reference of table,
            // so it will not trigger change state, therefore creating copy of the array
            // using concat method
            MyGlobalVar.listeIncomingMobilities = MyGlobalVar.listeIncomingMobilities.concat([response.data])
        return response
    });
}

export const deleteIncomingMobility  = async (idActivity) => {
    return await axios.delete("http://localhost:9000/IncomingMobility/Delete/" + idActivity).then(response => {
        // change to a new reference => cause change state immediately
        MyGlobalVar.listeIncomingMobilities = MyGlobalVar.deleteActivity(MyGlobalVar.listeIncomingMobilities, idActivity)
        return response
    });
}