import axios from "axios";
import {API_URL} from "../../../constants";
import MyGlobalVar from "../../MyGlobalVar";


export const insertCsvDataIntoDatabase = async (data) => {
    return await axios.post(API_URL + "/Import/CsvResults", data).then(response => {
        return response
    });
}