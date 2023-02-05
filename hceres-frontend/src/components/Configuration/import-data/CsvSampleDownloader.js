import ResearcherCsv from "../../../assets/csvSamples/researcher.csv";
import InstitutionCsv from "../../../assets/csvSamples/institution.csv";
import LaboratoryCsv from "../../../assets/csvSamples/laboratory.csv";
import TeamCsv from "../../../assets/csvSamples/team.csv";
import BelongsTeamCsv from "../../../assets/csvSamples/belongs_team.csv";
import TypeActivityCsv from "../../../assets/csvSamples/type_activity.csv";
import ActivityCsv from "../../../assets/csvSamples/activity.csv";
import SrAwardCsv from "../../../assets/csvSamples/sr_award.csv";
import BookCsv from "../../../assets/csvSamples/book.csv";
import InvitedOralCommunicationCsv from "../../../assets/csvSamples/invited_oral_communication.csv";
import MeetingCongressOrgCsv from "../../../assets/csvSamples/meeting_congress_org.csv";
import InvitedSeminarCsv from "../../../assets/csvSamples/invited_seminar.csv";
import LanguageCsv from "../../../assets/csvSamples/language.csv";
import NationalityCsv from "../../../assets/csvSamples/nationality.csv";
import PhdTypeCsv from "../../../assets/csvSamples/phd_type.csv";
import React from "react";

// <a href={Logo} download>Download File</a>

export default function CsvSampleDownloader() {
    const supportedCsvSample = [
        ResearcherCsv,
        InstitutionCsv,
        LaboratoryCsv,
        TeamCsv,
        BelongsTeamCsv,
        TypeActivityCsv,
        ActivityCsv,
        SrAwardCsv,
        BookCsv,
        InvitedOralCommunicationCsv,
        MeetingCongressOrgCsv,
        InvitedSeminarCsv,
        LanguageCsv,
        NationalityCsv,
        PhdTypeCsv,
    ]

    return supportedCsvSample.map((file) => {
        return <iframe src={file}
                       title={file}
                       key={file}
                       style={{display: "none"}}></iframe>
    })
}
