import axios from "axios";
import MyGlobalVar from "../MyGlobalVar";
import {API_URL} from "../../constants";

export const fetchListStatus = async function fetchData() {
    if (!MyGlobalVar.listeStatus) {
        const response = await axios.get(API_URL + "/Status");
        MyGlobalVar.listeStatus = response.data;
    }
    return MyGlobalVar.listeStatus;
}