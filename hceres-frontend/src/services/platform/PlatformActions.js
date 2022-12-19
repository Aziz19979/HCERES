import axios from "axios";
import MyGlobalVar from "../MyGlobalVar";

export const fetchListPlatforms = async () => {
    if (!MyGlobalVar.listePlatforms) {
        const response = await axios.get("http://localhost:9000/Platforms");
        MyGlobalVar.listePlatforms = response.data;
    }
    return MyGlobalVar.listePlatforms;
}

export const addPlatform = async (data) => {
    return await axios.post("http://localhost:9000/Platform/Create", data).then(response => {
        if (MyGlobalVar.listePlatforms) {
            response = MyGlobalVar.addResearcherDataToActivity(response)
            // using method push will use same reference of table,
            // so it will not trigger change state, therefore creating copy of the array
            // using concat method
            MyGlobalVar.listePlatforms = MyGlobalVar.listePlatforms.concat([response.data])
        }
        return response
    });
}

export const deletePlatform = async (idActivity) => {
    return await axios.delete("http://localhost:9000/Platform/Delete/" + idActivity).then(response => {
        // change to a new reference => cause change state immediately
        MyGlobalVar.listePlatforms = MyGlobalVar.deleteActivity(MyGlobalVar.listePlatforms, idActivity)
        return response
    });
}