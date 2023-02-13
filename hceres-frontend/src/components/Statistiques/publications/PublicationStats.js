import React from 'react';
import {fetchListIncomingMobilities} from "../../../services/Activity/incoming-mobility/IncomingMobilityActions";
import {fetchResearcherActivities} from "../../../services/Researcher/ResearcherActions";
import ActivityTypes from "../../../const/ActivityTypes";
import {fetchListPublications} from "../../../services/Activity/publication/PublicationActions";

export default function PublicationStats () {
    // Cached state (List Template)
    const [publicationList, setPublicationList] = React.useState(null);

    React.useEffect(() => {
        fetchListPublications().then(list => setPublicationList(list))
    }, []);


    console.log(publicationList)

    return (
        <div style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', height: '100vh' }}>
            <div style={{ display: 'flex', flexDirection: 'column' , alignItems: 'center' }}>
                <h1 style={{ fontSize: 24, marginBottom: 20 }}>Des statistiques sur les publications</h1>

            </div>
        </div>);
}