import axios from "axios";
import MyGlobalVar from "../MyGlobalVar";

export const fetchListIncomingMobilitys = async () => {
    if (!MyGlobalVar.listeIncomingMobilitys) {
        const response = await axios.get("http://localhost:9000/IncomingMobilities");
        MyGlobalVar.listeIncomingMobilitys = response.data;
    }
    return MyGlobalVar.listeIncomingMobilitys;
}

export const addIncomingMobility  = async (data) => {
    return await axios.post("http://localhost:9000/IncomingMobility/Create", data).then(response => {
        if (MyGlobalVar.listeIncomingMobilitys)
            // using method push will use same reference of table,
            // so it will not trigger change state, therefore creating copy of the array
            // using concat method
            MyGlobalVar.listeIncomingMobilitys = MyGlobalVar.listeIncomingMobilitys.concat([response.data])
        return response
    });
}

export const deleteIncomingMobility  = async (idActivity) => {
    return await axios.delete("http://localhost:9000/IncomingMobility/Delete/" + idActivity).then(response => {
        // change to a new reference => cause change state immediately
        MyGlobalVar.listeIncomingMobilitys = MyGlobalVar.deleteActivity(MyGlobalVar.listeIncomingMobilitys, idActivity)
        return response
    });
}