import axios from "axios";
import MyGlobalVar from "../MyGlobalVar";

export const fetchListIndustrialContracts = async () => {
    if (!MyGlobalVar.listeIndustrialContracts) {
        const response = await axios.get('http://localhost:9000/IndustrialContracts');
        MyGlobalVar.listeIndustrialContracts = response.data;
    }
    return MyGlobalVar.listeIndustrialContracts;
}

export const addIndustrialContract  = async (data) => {
    return await axios.post("http://localhost:9000/IndustrialContract/Create", data).then(response => {
        if (MyGlobalVar.listeIndustrialContracts)
            // using method push will use same reference of table,
            // so it will not trigger change state, therefore creating copy of the array
            // using concat method
            MyGlobalVar.listeIndustrialContracts = MyGlobalVar.listeIndustrialContracts.concat([response.data])
        return response
    });
}

export const deleteIndustrialContract  = async (idActivity) => {
    return await axios.delete("http://localhost:9000/IndustrialContract/Delete/" + idActivity).then(response => {
        // change to a new reference => cause change state immediately
        MyGlobalVar.listeIndustrialContracts = MyGlobalVar.deleteActivity(MyGlobalVar.listeIndustrialContracts, idActivity)
        return response
    });
}