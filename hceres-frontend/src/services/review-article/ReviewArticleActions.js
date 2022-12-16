import axios from "axios";
import MyGlobalVar from "../MyGlobalVar";

export const fetchListReviewArticles = async () => {
    if (!MyGlobalVar.listeReviewArticle) {
        const response = await axios.get("http://localhost:9000/ReviewArticles");
        MyGlobalVar.listeReviewArticle = response.data;
    }
    return MyGlobalVar.listeReviewArticle;
}

export const addReviewArticle  = async (data) => {
        return await axios.post("http://localhost:9000/ReviewArticle/Create", data).then(response => {
        if (MyGlobalVar.listeReviewArticle)
            // using method push will use same reference of table,
            // so it will not trigger change state, therefore creating copy of the array
            // using concat method
            MyGlobalVar.listeReviewArticle = MyGlobalVar.listeReviewArticle.concat([response.data])
        return response
    });
}

export const deleteReviewArticle  = async (idActivity) => {
    return await axios.delete("http://localhost:9000/ReviewArticle/Delete/" + idActivity).then(response => {
        // change to a new reference => cause change state immediately
        MyGlobalVar.listeReviewArticle = MyGlobalVar.deleteActivity(MyGlobalVar.listeReviewArticle, idActivity)
        return response
    });
}