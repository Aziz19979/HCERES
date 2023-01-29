import ResearcherCsv from "../../../assets/csvSamples/researcher.csv";
import InstitutionCsv from "../../../assets/csvSamples/institution.csv";
import TypeActivityCsv from "../../../assets/csvSamples/type_activity.csv";
import ActivityCsv from "../../../assets/csvSamples/activity.csv";
import SrAwardCsv from "../../../assets/csvSamples/sr_award.csv";
import React from "react";

// <a href={Logo} download>Download File</a>

export default function CsvSampleDownloader() {
    const suppportedCsvSample = [
        ResearcherCsv,
        InstitutionCsv,
        TypeActivityCsv,
        ActivityCsv,
        SrAwardCsv,
    ]

    return suppportedCsvSample.map((file) => {
        return <iframe src={file}
                       title={file}
                       key={file}
                       style={{display: "none"}}></iframe>
    })
}
