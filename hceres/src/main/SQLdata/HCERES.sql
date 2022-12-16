--
-- PostgreSQL database dump
--

-- Dumped from database version 13.4
-- Dumped by pg_dump version 13.4

-- Started on 2022-04-01 14:49:44

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 200 (class 1259 OID 24663)
-- Name: activity; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.activity (
    id_activity integer NOT NULL,
    id_type_activity integer NOT NULL
);


ALTER TABLE public.activity OWNER TO hceres;

--
-- TOC entry 201 (class 1259 OID 24666)
-- Name: activity_researcher; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.activity_researcher (
    researcher_id integer NOT NULL,
    id_activity integer NOT NULL
);


ALTER TABLE public.activity_researcher OWNER TO hceres;

--
-- TOC entry 202 (class 1259 OID 24669)
-- Name: activity_team; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.activity_team (
    id_activity integer NOT NULL,
    team_id integer NOT NULL
);


ALTER TABLE public.activity_team OWNER TO hceres;

--
-- TOC entry 203 (class 1259 OID 24672)
-- Name: admin; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.admin (
    researcher_id integer NOT NULL
);


ALTER TABLE public.admin OWNER TO hceres;

--
-- TOC entry 204 (class 1259 OID 24675)
-- Name: belongs_team; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.belongs_team (
    id_belongs_team integer NOT NULL,
    researcher_id integer NOT NULL,
    team_id integer NOT NULL,
    onboarding_date date,
    leaving_date date
);


ALTER TABLE public.belongs_team OWNER TO hceres;

--
-- TOC entry 205 (class 1259 OID 24678)
-- Name: belongs_team_id_belongs_team_seq; Type: SEQUENCE; Schema: public; Owner: prweb
--

CREATE SEQUENCE public.belongs_team_id_belongs_team_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.belongs_team_id_belongs_team_seq OWNER TO prweb;

--
-- TOC entry 206 (class 1259 OID 24680)
-- Name: book; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.book (
    id_activity integer NOT NULL,
    publication_date date,
    title character varying(256),
    editor character varying(256),
    nb_page integer,
    authors text NOT NULL,
    language_id integer NOT NULL
);


ALTER TABLE public.book OWNER TO hceres;

--
-- TOC entry 207 (class 1259 OID 24686)
-- Name: book_chapter; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.book_chapter (
    id_activity integer NOT NULL,
    publication_date date,
    book_title character varying(256),
    chapter_title character varying(256),
    editor character varying(256),
    nb_page integer,
    authors text NOT NULL,
    additional_info text,
    language_id integer NOT NULL
);


ALTER TABLE public.book_chapter OWNER TO hceres;

--
-- TOC entry 208 (class 1259 OID 24692)
-- Name: choice_public_outreach_id_type_seq; Type: SEQUENCE; Schema: public; Owner: prweb
--

CREATE SEQUENCE public.choice_public_outreach_id_type_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.choice_public_outreach_id_type_seq OWNER TO prweb;

--
-- TOC entry 209 (class 1259 OID 24694)
-- Name: choice_type_collab_id_type_seq; Type: SEQUENCE; Schema: public; Owner: prweb
--

CREATE SEQUENCE public.choice_type_collab_id_type_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.choice_type_collab_id_type_seq OWNER TO prweb;

--
-- TOC entry 210 (class 1259 OID 24696)
-- Name: company; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.company (
    company_id integer NOT NULL,
    company_name character varying(256) NOT NULL
);


ALTER TABLE public.company OWNER TO hceres;

--
-- TOC entry 211 (class 1259 OID 24699)
-- Name: company_creation; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.company_creation (
    id_activity integer NOT NULL,
    company_creation_name character varying(256),
    company_creation_date date,
    company_creation_active bool DEFAULT true NOT NULL
);


ALTER TABLE public.company_creation OWNER TO hceres;

--
-- TOC entry 212 (class 1259 OID 24703)
-- Name: connection; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.connection (
    connection_code character varying(255) NOT NULL,
    connection_login character varying(255) NOT NULL,
    connection_expire timestamp without time zone NOT NULL,
    researcher_id integer,
    connection_status integer DEFAULT 0
);


ALTER TABLE public.connection OWNER TO hceres;

--
-- TOC entry 213 (class 1259 OID 24710)
-- Name: contract; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.contract (
    id_contract integer NOT NULL,
    researcher_id integer NOT NULL,
    id_employer integer NOT NULL,
    id_contract_type integer NOT NULL,
    id_status integer NOT NULL,
    start_contract date,
    end_contract date,
    function_contract character varying(256)
);


ALTER TABLE public.contract OWNER TO hceres;

--
-- TOC entry 214 (class 1259 OID 24713)
-- Name: contract_type; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.contract_type (
    id_contract_type integer NOT NULL,
    name_contract_type character varying(256) NOT NULL
);


ALTER TABLE public.contract_type OWNER TO hceres;

--
-- TOC entry 215 (class 1259 OID 24716)
-- Name: editorial_activity; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.editorial_activity (
    id_activity integer NOT NULL,
    journal_id integer NOT NULL,
    start_date date,
    end_date date,
    impact_factor numeric NOT NULL,
    function_editorial_activity_id integer NOT NULL
);


ALTER TABLE public.editorial_activity OWNER TO hceres;

--
-- TOC entry 216 (class 1259 OID 24722)
-- Name: education; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.education (
    id_activity integer NOT NULL,
    education_course_name character varying(256),
    education_completion date,
    education_description text,
    education_level_id integer NOT NULL,
    education_formation character varying(256),
    education_involvment_id integer NOT NULL
);


ALTER TABLE public.education OWNER TO hceres;

--
-- TOC entry 217 (class 1259 OID 24728)
-- Name: education_involvment; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.education_involvment (
    education_involvment_id integer NOT NULL,
    education_involvment_name character varying(256) NOT NULL
);


ALTER TABLE public.education_involvment OWNER TO hceres;

--
-- TOC entry 218 (class 1259 OID 24731)
-- Name: education_level; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.education_level (
    education_level_id integer NOT NULL,
    education_level_name character varying(64) NOT NULL
);


ALTER TABLE public.education_level OWNER TO hceres;

--
-- TOC entry 219 (class 1259 OID 24734)
-- Name: employer; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.employer (
    id_employer integer NOT NULL,
    name_employer character varying(256)
);


ALTER TABLE public.employer OWNER TO hceres;

--
-- TOC entry 220 (class 1259 OID 24737)
-- Name: employer_id_employer_seq; Type: SEQUENCE; Schema: public; Owner: prweb
--

CREATE SEQUENCE public.employer_id_employer_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.employer_id_employer_seq OWNER TO prweb;

--
-- TOC entry 221 (class 1259 OID 24739)
-- Name: evaluation_thesis; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.evaluation_thesis (
    id_activity integer NOT NULL,
    type_thesis_id integer NOT NULL,
    evaluation_thesis_role_id integer NOT NULL,
    year integer,
    name_university character varying(256)
);


ALTER TABLE public.evaluation_thesis OWNER TO hceres;

--
-- TOC entry 222 (class 1259 OID 24742)
-- Name: evaluation_thesis_role; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.evaluation_thesis_role (
    evaluation_thesis_role_id integer NOT NULL,
    evaluation_thesis_role_name character varying(256)
);


ALTER TABLE public.evaluation_thesis_role OWNER TO hceres;

--
-- TOC entry 223 (class 1259 OID 24745)
-- Name: evaluation_thesis_role_evaluation_thesis_role_id_seq; Type: SEQUENCE; Schema: public; Owner: hceres
--

CREATE SEQUENCE public.evaluation_thesis_role_evaluation_thesis_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.evaluation_thesis_role_evaluation_thesis_role_id_seq OWNER TO hceres;

--
-- TOC entry 3888 (class 0 OID 0)
-- Dependencies: 223
-- Name: evaluation_thesis_role_evaluation_thesis_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hceres
--

ALTER SEQUENCE public.evaluation_thesis_role_evaluation_thesis_role_id_seq OWNED BY public.evaluation_thesis_role.evaluation_thesis_role_id;


--
-- TOC entry 224 (class 1259 OID 24747)
-- Name: function_editorial_activity; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.function_editorial_activity (
    function_editorial_activity_id integer NOT NULL,
    function_editorial_activity_name character varying(256)
);


ALTER TABLE public.function_editorial_activity OWNER TO hceres;

--
-- TOC entry 225 (class 1259 OID 24750)
-- Name: funder; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.funder (
    funder_id character varying NOT NULL,
    funder_name character varying(256) NOT NULL
);


ALTER TABLE public.funder OWNER TO hceres;

--
-- TOC entry 226 (class 1259 OID 24756)
-- Name: incoming_mobility; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.incoming_mobility (
    id_activity integer NOT NULL,
    name_senior_scientist character varying(256),
    arrival_date date,
    departure_date date,
    duration integer,
    nationality character varying(256),
    original_lab_name character varying(256),
    origina_lab_location character varying(256),
    pi_partner character varying(256),
    project_title character varying(256),
    associated_funding character varying(256),
    publication_reference character varying(256),
    strategic_recurring_collab bool,
    active_project bool,
    umr_coordinated bool,
    agreement_signed bool
);


ALTER TABLE public.incoming_mobility OWNER TO hceres;

--
-- TOC entry 227 (class 1259 OID 24762)
-- Name: institution; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.institution (
    institution_id integer NOT NULL,
    institution_name character varying(256) NOT NULL
);


ALTER TABLE public.institution OWNER TO hceres;

--
-- TOC entry 228 (class 1259 OID 24765)
-- Name: institutional_comitee; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.institutional_comitee (
    id_activity integer NOT NULL,
    institutional_comitee_name character varying(256),
    year integer,
    laboratory_evaluation_role_id integer NOT NULL
);


ALTER TABLE public.institutional_comitee OWNER TO hceres;

--
-- TOC entry 229 (class 1259 OID 24768)
-- Name: invited_seminar; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.invited_seminar (
    id_activity integer NOT NULL,
    title_seminar character varying(256),
    date date,
    location character varying(256),
    invited_by character varying(256)
);


ALTER TABLE public.invited_seminar OWNER TO hceres;

--
-- TOC entry 230 (class 1259 OID 24774)
-- Name: journal; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.journal (
    journal_id integer NOT NULL,
    journal_name character varying(256) NOT NULL
);


ALTER TABLE public.journal OWNER TO hceres;

--
-- TOC entry 231 (class 1259 OID 24777)
-- Name: labcom_creation; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.labcom_creation (
    id_activity integer NOT NULL,
    labcom_creation_name character varying(256),
    contract_start_date date,
    name_company_involved character varying(256),
    title_project character varying(256),
    contract_end_date date,
    associated_publi_ref character varying(256)
);


ALTER TABLE public.labcom_creation OWNER TO hceres;

--
-- TOC entry 232 (class 1259 OID 24783)
-- Name: laboratory; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.laboratory (
    laboratory_id integer NOT NULL,
    laboratory_name character varying(256) NOT NULL,
    laboratory_acronym character varying(32),
    institution_id integer NOT NULL
);


ALTER TABLE public.laboratory OWNER TO hceres;

--
-- TOC entry 233 (class 1259 OID 24786)
-- Name: laboratory_evaluation; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.laboratory_evaluation (
    id_activity integer NOT NULL,
    laboratory_evaluation_name character varying(256),
    year integer,
    laboratory_evaluation_role_id integer NOT NULL
);


ALTER TABLE public.laboratory_evaluation OWNER TO hceres;

--
-- TOC entry 234 (class 1259 OID 24789)
-- Name: laboratory_evaluation_role; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.laboratory_evaluation_role (
    laboratory_evaluation_role_id integer NOT NULL,
    name_choice character varying(256)
);


ALTER TABLE public.laboratory_evaluation_role OWNER TO hceres;

--
-- TOC entry 235 (class 1259 OID 24792)
-- Name: language; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.language (
    language_id integer NOT NULL,
    language_name character varying(256) NOT NULL
);


ALTER TABLE public.language OWNER TO hceres;

--
-- TOC entry 236 (class 1259 OID 24795)
-- Name: learned_scientific_society; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.learned_scientific_society (
    id_activity integer NOT NULL,
    learned_scientific_society_role_id integer NOT NULL,
    learned_scientific_society_name character varying(256),
    start_date date,
    end_date date
);


ALTER TABLE public.learned_scientific_society OWNER TO hceres;

--
-- TOC entry 237 (class 1259 OID 24798)
-- Name: learned_scientific_society_role; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.learned_scientific_society_role (
    learned_scientific_society_role_id integer NOT NULL,
    name_choice character varying(256)
);


ALTER TABLE public.learned_scientific_society_role OWNER TO hceres;

--
-- TOC entry 238 (class 1259 OID 24801)
-- Name: mail_activity; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.mail_activity (
    mail_activity_id integer NOT NULL,
    id_activity integer NOT NULL,
    mail_template_id integer NOT NULL,
    mail_activity_date date NOT NULL
);


ALTER TABLE public.mail_activity OWNER TO hceres;

--
-- TOC entry 239 (class 1259 OID 24804)
-- Name: mail_template; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.mail_template (
    mail_template_id integer NOT NULL,
    mail_template_title character varying(256) NOT NULL,
    mail_template_content text NOT NULL
);


ALTER TABLE public.mail_template OWNER TO hceres;

--
-- TOC entry 240 (class 1259 OID 24810)
-- Name: meeting; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.meeting (
    meeting_id integer NOT NULL,
    neeting_name character varying(256) NOT NULL,
    meeting_year integer NOT NULL,
    meeting_location character varying(256) NOT NULL,
    meeting_start date,
    meeting_end date
);


ALTER TABLE public.meeting OWNER TO hceres;

--
-- TOC entry 241 (class 1259 OID 24816)
-- Name: meeting_congress_org; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.meeting_congress_org (
    id_activity integer NOT NULL,
    meeting_id integer NOT NULL
);


ALTER TABLE public.meeting_congress_org OWNER TO hceres;

--
-- TOC entry 242 (class 1259 OID 24819)
-- Name: national_international_collaboration; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.national_international_collaboration (
    id_activity integer NOT NULL,
    type_collab_id integer NOT NULL,
    date_project_start date,
    partner_entity character varying(256),
    country_state_city character varying(256),
    pi_partners character varying(256),
    mail_partners character varying(256),
    projetc_title character varying(256),
    strategic_recurring_collab bool,
    active_project bool,
    associated_funding character varying(256),
    number_resulting_publications integer,
    ref_joint_publication character varying(256),
    umr_coordinated bool,
    agreement_signed bool
);


ALTER TABLE public.national_international_collaboration OWNER TO hceres;

--
-- TOC entry 243 (class 1259 OID 24825)
-- Name: nationality; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.nationality (
    nationality_id integer NOT NULL,
    nationality_name character varying(128) NOT NULL
);


ALTER TABLE public.nationality OWNER TO hceres;

--
-- TOC entry 244 (class 1259 OID 24828)
-- Name: network; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.network (
    id_activity integer NOT NULL,
    start_date date,
    name_network character varying(256),
    active_network bool,
    associated_funding character varying(256),
    nb_resulting_publications integer,
    ref_resulting_publications character varying(256),
    umr_coordinated bool,
    agreement_signed bool
);


ALTER TABLE public.network OWNER TO hceres;

--
-- TOC entry 245 (class 1259 OID 24834)
-- Name: oral_communication; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.oral_communication (
    id_activity integer NOT NULL,
    oral_communication_title character varying(512),
    type_oral_communication_id integer NOT NULL,
    oral_communication_dat date NOT NULL,
    meeting_id integer NOT NULL,
    authors text NOT NULL
);


ALTER TABLE public.oral_communication OWNER TO hceres;

--
-- TOC entry 246 (class 1259 OID 24840)
-- Name: outgoing_mobility; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.outgoing_mobility (
    id_activity integer NOT NULL,
    name_person_concerned character varying(256),
    arrival_date date,
    departure_date date,
    duration integer,
    host_lab_name character varying(256),
    host_lab_location character varying(256),
    pi_partner character varying(256),
    project_title character varying(256),
    associated_funding character varying(256),
    nb_publications integer,
    publication_reference character varying(256),
    strategic_recurring_collab bit(1),
    active_project bit(1),
    umr_coordinated bit(1),
    agreement_signed bool
);


ALTER TABLE public.outgoing_mobility OWNER TO hceres;

--
-- TOC entry 247 (class 1259 OID 24846)
-- Name: parameter; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.parameter (
    parameter_id integer NOT NULL,
    parameter_name character varying(256) NOT NULL,
    parameter_value character varying(1024)
);


ALTER TABLE public.parameter OWNER TO hceres;

--
-- TOC entry 248 (class 1259 OID 24852)
-- Name: patent; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.patent (
    id_activity integer NOT NULL,
    type_patent_id integer NOT NULL,
    title character varying(256),
    registration_date date,
    filing_date date,
    acceptation_date date,
    licensing_date date,
    inventors text NOT NULL,
    co_owners text NOT NULL,
    priority_number real,
    priority_date date,
    publication_number character varying(256),
    publication_date date,
    inpi_link character varying(256),
    status bool DEFAULT false NOT NULL,
    pct_extension_obtained bool DEFAULT false NOT NULL,
    publication_number_pct_extension character varying(256),
    publication_date_pct_extension date,
    international_extension bool DEFAULT false NOT NULL,
    publication_number_international_extension character varying(256),
    publication_date_international_extension date,
    ref_transfer_contract character varying(256),
    name_company_involved character varying(256)
);


ALTER TABLE public.patent OWNER TO hceres;

--
-- TOC entry 249 (class 1259 OID 24861)
-- Name: phd_associated_company; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.phd_associated_company (
    phd_student_id integer NOT NULL,
    company_id integer NOT NULL,
    phd_associated_company_start date,
    phd_associated_company_end date
);


ALTER TABLE public.phd_associated_company OWNER TO hceres;

--
-- TOC entry 250 (class 1259 OID 24864)
-- Name: phd_student; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.phd_student (
    phd_student_id integer NOT NULL,
    researcher_id integer NOT NULL,
    phd_start date NOT NULL,
    phd_type_id integer NOT NULL,
    phd_main_funding character varying(256),
    phd_defense_date date,
    phd_duration integer DEFAULT 0 NOT NULL,
    phd_futur text
);


ALTER TABLE public.phd_student OWNER TO hceres;

--
-- TOC entry 251 (class 1259 OID 24871)
-- Name: phd_type; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.phd_type (
    phd_type_id integer NOT NULL,
    phd_type_name character varying(256) NOT NULL
);


ALTER TABLE public.phd_type OWNER TO hceres;

--
-- TOC entry 252 (class 1259 OID 24874)
-- Name: platform; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.platform (
    id_activity integer NOT NULL,
    creation_date date,
    description character varying(256),
    managers character varying(256),
    affiliation character varying(256),
    labellisation character varying(256),
    open_private_researchers bool
);


ALTER TABLE public.platform OWNER TO hceres;

--
-- TOC entry 253 (class 1259 OID 24880)
-- Name: post_doc; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.post_doc (
    id_activity integer NOT NULL,
    name_post_doc character varying(256),
    name_supervisor character varying(256),
    arrival_date date,
    departure_date date,
    duration integer,
    nationality character varying(256),
    original_lab character varying(256),
    associated_funding character varying(256),
    associated_publi_ref character varying(256)
);


ALTER TABLE public.post_doc OWNER TO hceres;

--
-- TOC entry 254 (class 1259 OID 24886)
-- Name: project_evaluation; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.project_evaluation (
    id_activity integer NOT NULL,
    funder_id character varying NOT NULL,
    year integer,
    project_evaluation_role_id integer NOT NULL,
    project_evaluation_category_id integer NOT NULL
);


ALTER TABLE public.project_evaluation OWNER TO hceres;

--
-- TOC entry 255 (class 1259 OID 24892)
-- Name: project_evaluation_category; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.project_evaluation_category (
    project_evaluation_category_id integer NOT NULL,
    project_evaluation_category_name character varying(256)
);


ALTER TABLE public.project_evaluation_category OWNER TO hceres;

--
-- TOC entry 256 (class 1259 OID 24895)
-- Name: project_evaluation_role; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.project_evaluation_role (
    project_evaluation_role_id integer NOT NULL,
    project_evaluation_role_name character varying(256)
);


ALTER TABLE public.project_evaluation_role OWNER TO hceres;

--
-- TOC entry 257 (class 1259 OID 24898)
-- Name: public_outreach; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.public_outreach (
    id_activity integer NOT NULL,
    public_outreach_type_id integer NOT NULL,
    completion_date date,
    description character varying(256)
);


ALTER TABLE public.public_outreach OWNER TO hceres;

--
-- TOC entry 258 (class 1259 OID 24901)
-- Name: public_outreach_type; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.public_outreach_type (
    public_outreach_type_id integer NOT NULL,
    public_outreach_type_name character varying(256)
);


ALTER TABLE public.public_outreach_type OWNER TO hceres;

--
-- TOC entry 259 (class 1259 OID 24904)
-- Name: publication; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.publication (
    id_activity integer NOT NULL,
    title character varying(512),
    authors text NOT NULL,
    source character varying(256),
    publication_date date,
    publication_type_id integer NOT NULL,
    pmid character varying(16),
    impact_factor numeric
);


ALTER TABLE public.publication OWNER TO hceres;

--
-- TOC entry 260 (class 1259 OID 24910)
-- Name: publication_statistics; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.publication_statistics (
    team_id integer NOT NULL,
    publication_statistics_year integer NOT NULL,
    publication_statistics_pdc integer DEFAULT 0 NOT NULL,
    publication_statistics_collab_int integer DEFAULT 0 NOT NULL,
    publication_statistics_collab_labo integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.publication_statistics OWNER TO hceres;

--
-- TOC entry 261 (class 1259 OID 24916)
-- Name: publication_type; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.publication_type (
    publication_type_id integer NOT NULL,
    publication_type_name character varying(256)
);


ALTER TABLE public.publication_type OWNER TO hceres;

--
-- TOC entry 262 (class 1259 OID 24919)
-- Name: research_contract_funded_public_charitable_inst; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.research_contract_funded_public_charitable_inst (
    id_activity integer NOT NULL,
    id_type integer NOT NULL,
    date_contract_award date,
    funding_intitution character varying(256),
    project_title character varying(256),
    start_year integer,
    end_year integer,
    grant_amount integer
);


ALTER TABLE public.research_contract_funded_public_charitable_inst OWNER TO hceres;

--
-- TOC entry 263 (class 1259 OID 24925)
-- Name: researcher; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.researcher (
    researcher_id integer NOT NULL,
    researcher_surname character varying(256) NOT NULL,
    researcher_name character varying(256),
    researcher_email character varying(256),
    researcher_orcid character varying(256),
    researcher_login character varying(256),
    researcher_password character varying(1024)
);


ALTER TABLE public.researcher OWNER TO hceres;

--
-- TOC entry 264 (class 1259 OID 24931)
-- Name: researcher_nationality; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.researcher_nationality (
    nationality_id integer NOT NULL,
    researcher_id integer NOT NULL
);


ALTER TABLE public.researcher_nationality OWNER TO hceres;

--
-- TOC entry 265 (class 1259 OID 24934)
-- Name: reviewing_journal_articles; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.reviewing_journal_articles (
    id_activity integer NOT NULL,
    journal_id integer NOT NULL,
    year integer,
    nb_reviewed_articles integer,
    impact_factor numeric
);


ALTER TABLE public.reviewing_journal_articles OWNER TO hceres;

--
-- TOC entry 266 (class 1259 OID 24940)
-- Name: scientific_expertise; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.scientific_expertise (
    id_activity integer NOT NULL,
    scientific_expertise_type_id integer NOT NULL,
    start_date date,
    end_date date,
    description text NOT NULL
);


ALTER TABLE public.scientific_expertise OWNER TO hceres;

--
-- TOC entry 267 (class 1259 OID 24946)
-- Name: scientific_expertise_type; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.scientific_expertise_type (
    scientific_expertise_type_id integer NOT NULL,
    name_choice character varying(256)
);


ALTER TABLE public.scientific_expertise_type OWNER TO hceres;

--
-- TOC entry 268 (class 1259 OID 24949)
-- Name: scientific_expertise_type_scientific_expertise_type_id_seq; Type: SEQUENCE; Schema: public; Owner: hceres
--

CREATE SEQUENCE public.scientific_expertise_type_scientific_expertise_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.scientific_expertise_type_scientific_expertise_type_id_seq OWNER TO hceres;

--
-- TOC entry 3889 (class 0 OID 0)
-- Dependencies: 268
-- Name: scientific_expertise_type_scientific_expertise_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hceres
--

ALTER SEQUENCE public.scientific_expertise_type_scientific_expertise_type_id_seq OWNED BY public.scientific_expertise_type.scientific_expertise_type_id;


--
-- TOC entry 269 (class 1259 OID 24951)
-- Name: sei_cifre_fellowship; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.sei_cifre_fellowship (
    id_activity integer NOT NULL,
    contract_start_date date,
    name_fellow character varying(256),
    name_company_involved character varying(256),
    title_thesis character varying(256),
    contract_end_date date,
    contract_amount integer,
    associated_publi_ref character varying(256)
);


ALTER TABLE public.sei_cifre_fellowship OWNER TO hceres;

--
-- TOC entry 270 (class 1259 OID 24957)
-- Name: sei_clinical_trial; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.sei_clinical_trial (
    id_activity integer NOT NULL,
    start_date date,
    coordinator_partner bool,
    title_clinical_trial character varying(256),
    end_date date,
    registration_nb character varying(256),
    sponsor_name character varying(256),
    included_patients_nb integer,
    funding character varying(256),
    funding_amount integer
);


ALTER TABLE public.sei_clinical_trial OWNER TO hceres;

--
-- TOC entry 271 (class 1259 OID 24963)
-- Name: sei_industrial_r_d_contract; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.sei_industrial_r_d_contract (
    id_activity integer NOT NULL,
    start_date date,
    name_company_involved character varying(256),
    project_title character varying(256),
    agreement_amount integer,
    end_date date,
    associated_publi_ref character varying(256)
);


ALTER TABLE public.sei_industrial_r_d_contract OWNER TO hceres;

--
-- TOC entry 272 (class 1259 OID 24969)
-- Name: sei_lead_consortium_industry; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.sei_lead_consortium_industry (
    id_activity integer NOT NULL,
    type_consortium_id integer NOT NULL,
    consortium_start_date date,
    name_consortium character varying(256),
    title_project character varying(256),
    private_party_involved character varying(256),
    consortium_end_date date,
    associated_publi_ref character varying(256)
);


ALTER TABLE public.sei_lead_consortium_industry OWNER TO hceres;

--
-- TOC entry 273 (class 1259 OID 24975)
-- Name: sei_network_unit_creation; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.sei_network_unit_creation (
    id_activity integer NOT NULL,
    network_start_date date,
    name_network character varying(256),
    name_partner character varying(256),
    title_project character varying(256),
    network_end_date date,
    associated_publi_ref character varying(256)
);


ALTER TABLE public.sei_network_unit_creation OWNER TO hceres;

--
-- TOC entry 274 (class 1259 OID 24981)
-- Name: seq_activity; Type: SEQUENCE; Schema: public; Owner: hceres
--

CREATE SEQUENCE public.seq_activity
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
    CYCLE;


ALTER TABLE public.seq_activity OWNER TO hceres;

--
-- TOC entry 3890 (class 0 OID 0)
-- Dependencies: 274
-- Name: seq_activity; Type: SEQUENCE OWNED BY; Schema: public; Owner: hceres
--

ALTER SEQUENCE public.seq_activity OWNED BY public.activity.id_activity;


--
-- TOC entry 275 (class 1259 OID 24983)
-- Name: seq_belongs_team; Type: SEQUENCE; Schema: public; Owner: hceres
--

CREATE SEQUENCE public.seq_belongs_team
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
    CYCLE;


ALTER TABLE public.seq_belongs_team OWNER TO hceres;

--
-- TOC entry 3891 (class 0 OID 0)
-- Dependencies: 275
-- Name: seq_belongs_team; Type: SEQUENCE OWNED BY; Schema: public; Owner: hceres
--

ALTER SEQUENCE public.seq_belongs_team OWNED BY public.belongs_team.id_belongs_team;


--
-- TOC entry 276 (class 1259 OID 24985)
-- Name: seq_choice_publication; Type: SEQUENCE; Schema: public; Owner: hceres
--

CREATE SEQUENCE public.seq_choice_publication
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_choice_publication OWNER TO hceres;

--
-- TOC entry 3892 (class 0 OID 0)
-- Dependencies: 276
-- Name: seq_choice_publication; Type: SEQUENCE OWNED BY; Schema: public; Owner: hceres
--

ALTER SEQUENCE public.seq_choice_publication OWNED BY public.publication_type.publication_type_id;


--
-- TOC entry 277 (class 1259 OID 24987)
-- Name: seq_company; Type: SEQUENCE; Schema: public; Owner: hceres
--

CREATE SEQUENCE public.seq_company
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_company OWNER TO hceres;

--
-- TOC entry 3893 (class 0 OID 0)
-- Dependencies: 277
-- Name: seq_company; Type: SEQUENCE OWNED BY; Schema: public; Owner: hceres
--

ALTER SEQUENCE public.seq_company OWNED BY public.company.company_id;


--
-- TOC entry 278 (class 1259 OID 24989)
-- Name: seq_contract; Type: SEQUENCE; Schema: public; Owner: hceres
--

CREATE SEQUENCE public.seq_contract
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_contract OWNER TO hceres;

--
-- TOC entry 3894 (class 0 OID 0)
-- Dependencies: 278
-- Name: seq_contract; Type: SEQUENCE OWNED BY; Schema: public; Owner: hceres
--

ALTER SEQUENCE public.seq_contract OWNED BY public.contract.id_contract;


--
-- TOC entry 279 (class 1259 OID 24991)
-- Name: seq_contract_type; Type: SEQUENCE; Schema: public; Owner: hceres
--

CREATE SEQUENCE public.seq_contract_type
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_contract_type OWNER TO hceres;

--
-- TOC entry 3895 (class 0 OID 0)
-- Dependencies: 279
-- Name: seq_contract_type; Type: SEQUENCE OWNED BY; Schema: public; Owner: hceres
--

ALTER SEQUENCE public.seq_contract_type OWNED BY public.contract_type.id_contract_type;


--
-- TOC entry 280 (class 1259 OID 24993)
-- Name: seq_education_involvment; Type: SEQUENCE; Schema: public; Owner: hceres
--

CREATE SEQUENCE public.seq_education_involvment
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_education_involvment OWNER TO hceres;

--
-- TOC entry 3896 (class 0 OID 0)
-- Dependencies: 280
-- Name: seq_education_involvment; Type: SEQUENCE OWNED BY; Schema: public; Owner: hceres
--

ALTER SEQUENCE public.seq_education_involvment OWNED BY public.education_involvment.education_involvment_id;


--
-- TOC entry 281 (class 1259 OID 24995)
-- Name: seq_education_level; Type: SEQUENCE; Schema: public; Owner: hceres
--

CREATE SEQUENCE public.seq_education_level
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_education_level OWNER TO hceres;

--
-- TOC entry 3897 (class 0 OID 0)
-- Dependencies: 281
-- Name: seq_education_level; Type: SEQUENCE OWNED BY; Schema: public; Owner: hceres
--

ALTER SEQUENCE public.seq_education_level OWNED BY public.education_level.education_level_id;


--
-- TOC entry 282 (class 1259 OID 24997)
-- Name: seq_employer; Type: SEQUENCE; Schema: public; Owner: hceres
--

CREATE SEQUENCE public.seq_employer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_employer OWNER TO hceres;

--
-- TOC entry 3898 (class 0 OID 0)
-- Dependencies: 282
-- Name: seq_employer; Type: SEQUENCE OWNED BY; Schema: public; Owner: hceres
--

ALTER SEQUENCE public.seq_employer OWNED BY public.employer.id_employer;


--
-- TOC entry 283 (class 1259 OID 24999)
-- Name: seq_function_editorial_activity; Type: SEQUENCE; Schema: public; Owner: hceres
--

CREATE SEQUENCE public.seq_function_editorial_activity
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_function_editorial_activity OWNER TO hceres;

--
-- TOC entry 3899 (class 0 OID 0)
-- Dependencies: 283
-- Name: seq_function_editorial_activity; Type: SEQUENCE OWNED BY; Schema: public; Owner: hceres
--

ALTER SEQUENCE public.seq_function_editorial_activity OWNED BY public.function_editorial_activity.function_editorial_activity_id;


--
-- TOC entry 284 (class 1259 OID 25001)
-- Name: seq_funder; Type: SEQUENCE; Schema: public; Owner: hceres
--

CREATE SEQUENCE public.seq_funder
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_funder OWNER TO hceres;

--
-- TOC entry 3900 (class 0 OID 0)
-- Dependencies: 284
-- Name: seq_funder; Type: SEQUENCE OWNED BY; Schema: public; Owner: hceres
--

ALTER SEQUENCE public.seq_funder OWNED BY public.funder.funder_id;


--
-- TOC entry 285 (class 1259 OID 25003)
-- Name: seq_institution; Type: SEQUENCE; Schema: public; Owner: hceres
--

CREATE SEQUENCE public.seq_institution
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_institution OWNER TO hceres;

--
-- TOC entry 3901 (class 0 OID 0)
-- Dependencies: 285
-- Name: seq_institution; Type: SEQUENCE OWNED BY; Schema: public; Owner: hceres
--

ALTER SEQUENCE public.seq_institution OWNED BY public.institution.institution_id;


--
-- TOC entry 286 (class 1259 OID 25005)
-- Name: seq_journal; Type: SEQUENCE; Schema: public; Owner: hceres
--

CREATE SEQUENCE public.seq_journal
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_journal OWNER TO hceres;

--
-- TOC entry 3902 (class 0 OID 0)
-- Dependencies: 286
-- Name: seq_journal; Type: SEQUENCE OWNED BY; Schema: public; Owner: hceres
--

ALTER SEQUENCE public.seq_journal OWNED BY public.journal.journal_id;


--
-- TOC entry 287 (class 1259 OID 25007)
-- Name: seq_laboratory; Type: SEQUENCE; Schema: public; Owner: hceres
--

CREATE SEQUENCE public.seq_laboratory
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_laboratory OWNER TO hceres;

--
-- TOC entry 3903 (class 0 OID 0)
-- Dependencies: 287
-- Name: seq_laboratory; Type: SEQUENCE OWNED BY; Schema: public; Owner: hceres
--

ALTER SEQUENCE public.seq_laboratory OWNED BY public.laboratory.laboratory_id;


--
-- TOC entry 288 (class 1259 OID 25009)
-- Name: seq_laboratory_evaluation_role; Type: SEQUENCE; Schema: public; Owner: hceres
--

CREATE SEQUENCE public.seq_laboratory_evaluation_role
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_laboratory_evaluation_role OWNER TO hceres;

--
-- TOC entry 3904 (class 0 OID 0)
-- Dependencies: 288
-- Name: seq_laboratory_evaluation_role; Type: SEQUENCE OWNED BY; Schema: public; Owner: hceres
--

ALTER SEQUENCE public.seq_laboratory_evaluation_role OWNED BY public.laboratory_evaluation_role.laboratory_evaluation_role_id;


--
-- TOC entry 289 (class 1259 OID 25011)
-- Name: seq_language; Type: SEQUENCE; Schema: public; Owner: hceres
--

CREATE SEQUENCE public.seq_language
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_language OWNER TO hceres;

--
-- TOC entry 3905 (class 0 OID 0)
-- Dependencies: 289
-- Name: seq_language; Type: SEQUENCE OWNED BY; Schema: public; Owner: hceres
--

ALTER SEQUENCE public.seq_language OWNED BY public.language.language_id;


--
-- TOC entry 290 (class 1259 OID 25013)
-- Name: seq_learned_scientific_society_role; Type: SEQUENCE; Schema: public; Owner: hceres
--

CREATE SEQUENCE public.seq_learned_scientific_society_role
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_learned_scientific_society_role OWNER TO hceres;

--
-- TOC entry 3906 (class 0 OID 0)
-- Dependencies: 290
-- Name: seq_learned_scientific_society_role; Type: SEQUENCE OWNED BY; Schema: public; Owner: hceres
--

ALTER SEQUENCE public.seq_learned_scientific_society_role OWNED BY public.learned_scientific_society_role.learned_scientific_society_role_id;


--
-- TOC entry 291 (class 1259 OID 25015)
-- Name: seq_mail_activity; Type: SEQUENCE; Schema: public; Owner: hceres
--

CREATE SEQUENCE public.seq_mail_activity
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_mail_activity OWNER TO hceres;

--
-- TOC entry 3907 (class 0 OID 0)
-- Dependencies: 291
-- Name: seq_mail_activity; Type: SEQUENCE OWNED BY; Schema: public; Owner: hceres
--

ALTER SEQUENCE public.seq_mail_activity OWNED BY public.mail_activity.mail_activity_id;


--
-- TOC entry 292 (class 1259 OID 25017)
-- Name: seq_mail_template; Type: SEQUENCE; Schema: public; Owner: hceres
--

CREATE SEQUENCE public.seq_mail_template
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_mail_template OWNER TO hceres;

--
-- TOC entry 3908 (class 0 OID 0)
-- Dependencies: 292
-- Name: seq_mail_template; Type: SEQUENCE OWNED BY; Schema: public; Owner: hceres
--

ALTER SEQUENCE public.seq_mail_template OWNED BY public.mail_template.mail_template_id;


--
-- TOC entry 293 (class 1259 OID 25019)
-- Name: seq_meeting; Type: SEQUENCE; Schema: public; Owner: hceres
--

CREATE SEQUENCE public.seq_meeting
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_meeting OWNER TO hceres;

--
-- TOC entry 3909 (class 0 OID 0)
-- Dependencies: 293
-- Name: seq_meeting; Type: SEQUENCE OWNED BY; Schema: public; Owner: hceres
--

ALTER SEQUENCE public.seq_meeting OWNED BY public.meeting.meeting_id;


--
-- TOC entry 294 (class 1259 OID 25021)
-- Name: seq_nationality; Type: SEQUENCE; Schema: public; Owner: hceres
--

CREATE SEQUENCE public.seq_nationality
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_nationality OWNER TO hceres;

--
-- TOC entry 3910 (class 0 OID 0)
-- Dependencies: 294
-- Name: seq_nationality; Type: SEQUENCE OWNED BY; Schema: public; Owner: hceres
--

ALTER SEQUENCE public.seq_nationality OWNED BY public.nationality.nationality_id;


--
-- TOC entry 295 (class 1259 OID 25023)
-- Name: seq_parameter; Type: SEQUENCE; Schema: public; Owner: hceres
--

CREATE SEQUENCE public.seq_parameter
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_parameter OWNER TO hceres;

--
-- TOC entry 3911 (class 0 OID 0)
-- Dependencies: 295
-- Name: seq_parameter; Type: SEQUENCE OWNED BY; Schema: public; Owner: hceres
--

ALTER SEQUENCE public.seq_parameter OWNED BY public.parameter.parameter_id;


--
-- TOC entry 296 (class 1259 OID 25025)
-- Name: seq_phd_student; Type: SEQUENCE; Schema: public; Owner: hceres
--

CREATE SEQUENCE public.seq_phd_student
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_phd_student OWNER TO hceres;

--
-- TOC entry 3912 (class 0 OID 0)
-- Dependencies: 296
-- Name: seq_phd_student; Type: SEQUENCE OWNED BY; Schema: public; Owner: hceres
--

ALTER SEQUENCE public.seq_phd_student OWNED BY public.phd_student.phd_student_id;


--
-- TOC entry 297 (class 1259 OID 25027)
-- Name: seq_phd_type; Type: SEQUENCE; Schema: public; Owner: hceres
--

CREATE SEQUENCE public.seq_phd_type
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_phd_type OWNER TO hceres;

--
-- TOC entry 3913 (class 0 OID 0)
-- Dependencies: 297
-- Name: seq_phd_type; Type: SEQUENCE OWNED BY; Schema: public; Owner: hceres
--

ALTER SEQUENCE public.seq_phd_type OWNED BY public.phd_type.phd_type_id;


--
-- TOC entry 298 (class 1259 OID 25029)
-- Name: seq_project_evaluation_category; Type: SEQUENCE; Schema: public; Owner: hceres
--

CREATE SEQUENCE public.seq_project_evaluation_category
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_project_evaluation_category OWNER TO hceres;

--
-- TOC entry 3914 (class 0 OID 0)
-- Dependencies: 298
-- Name: seq_project_evaluation_category; Type: SEQUENCE OWNED BY; Schema: public; Owner: hceres
--

ALTER SEQUENCE public.seq_project_evaluation_category OWNED BY public.project_evaluation_category.project_evaluation_category_id;


--
-- TOC entry 299 (class 1259 OID 25031)
-- Name: seq_project_evaluation_role; Type: SEQUENCE; Schema: public; Owner: hceres
--

CREATE SEQUENCE public.seq_project_evaluation_role
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_project_evaluation_role OWNER TO hceres;

--
-- TOC entry 3915 (class 0 OID 0)
-- Dependencies: 299
-- Name: seq_project_evaluation_role; Type: SEQUENCE OWNED BY; Schema: public; Owner: hceres
--

ALTER SEQUENCE public.seq_project_evaluation_role OWNED BY public.project_evaluation_role.project_evaluation_role_id;


--
-- TOC entry 300 (class 1259 OID 25033)
-- Name: seq_public_outreach_type; Type: SEQUENCE; Schema: public; Owner: hceres
--

CREATE SEQUENCE public.seq_public_outreach_type
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_public_outreach_type OWNER TO hceres;

--
-- TOC entry 3916 (class 0 OID 0)
-- Dependencies: 300
-- Name: seq_public_outreach_type; Type: SEQUENCE OWNED BY; Schema: public; Owner: hceres
--

ALTER SEQUENCE public.seq_public_outreach_type OWNED BY public.public_outreach_type.public_outreach_type_id;


--
-- TOC entry 301 (class 1259 OID 25035)
-- Name: seq_researcher; Type: SEQUENCE; Schema: public; Owner: hceres
--

CREATE SEQUENCE public.seq_researcher
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
    CYCLE;


ALTER TABLE public.seq_researcher OWNER TO hceres;

--
-- TOC entry 3917 (class 0 OID 0)
-- Dependencies: 301
-- Name: seq_researcher; Type: SEQUENCE OWNED BY; Schema: public; Owner: hceres
--

ALTER SEQUENCE public.seq_researcher OWNED BY public.researcher.researcher_id;


--
-- TOC entry 302 (class 1259 OID 25037)
-- Name: status; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.status (
    id_status integer NOT NULL,
    name_status character varying(256) NOT NULL
);


ALTER TABLE public.status OWNER TO hceres;

--
-- TOC entry 303 (class 1259 OID 25040)
-- Name: seq_status; Type: SEQUENCE; Schema: public; Owner: hceres
--

CREATE SEQUENCE public.seq_status
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_status OWNER TO hceres;

--
-- TOC entry 3918 (class 0 OID 0)
-- Dependencies: 303
-- Name: seq_status; Type: SEQUENCE OWNED BY; Schema: public; Owner: hceres
--

ALTER SEQUENCE public.seq_status OWNED BY public.status.id_status;


--
-- TOC entry 304 (class 1259 OID 25042)
-- Name: supervisor; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.supervisor (
    supervisor_id integer NOT NULL,
    researcher_id integer NOT NULL,
    phd_student_id integer NOT NULL,
    supervisor_percentage numeric DEFAULT 100
);


ALTER TABLE public.supervisor OWNER TO hceres;

--
-- TOC entry 305 (class 1259 OID 25049)
-- Name: seq_supervisor_id; Type: SEQUENCE; Schema: public; Owner: hceres
--

CREATE SEQUENCE public.seq_supervisor_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_supervisor_id OWNER TO hceres;

--
-- TOC entry 3919 (class 0 OID 0)
-- Dependencies: 305
-- Name: seq_supervisor_id; Type: SEQUENCE OWNED BY; Schema: public; Owner: hceres
--

ALTER SEQUENCE public.seq_supervisor_id OWNED BY public.supervisor.supervisor_id;


--
-- TOC entry 306 (class 1259 OID 25051)
-- Name: team; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.team (
    team_id integer NOT NULL,
    team_name character varying(256),
    team_creation date,
    team_end date,
    team_last_report date,
    laboratory_id integer NOT NULL
);


ALTER TABLE public.team OWNER TO hceres;

--
-- TOC entry 307 (class 1259 OID 25054)
-- Name: seq_team; Type: SEQUENCE; Schema: public; Owner: hceres
--

CREATE SEQUENCE public.seq_team
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
    CYCLE;


ALTER TABLE public.seq_team OWNER TO hceres;

--
-- TOC entry 3920 (class 0 OID 0)
-- Dependencies: 307
-- Name: seq_team; Type: SEQUENCE OWNED BY; Schema: public; Owner: hceres
--

ALTER SEQUENCE public.seq_team OWNED BY public.team.team_id;


--
-- TOC entry 308 (class 1259 OID 25056)
-- Name: team_referent; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.team_referent (
    team_referent_id integer NOT NULL,
    researcher_id integer NOT NULL,
    team_id integer NOT NULL,
    team_referent_start date,
    team_referent_end date
);


ALTER TABLE public.team_referent OWNER TO hceres;

--
-- TOC entry 309 (class 1259 OID 25059)
-- Name: seq_team_referent; Type: SEQUENCE; Schema: public; Owner: hceres
--

CREATE SEQUENCE public.seq_team_referent
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_team_referent OWNER TO hceres;

--
-- TOC entry 3921 (class 0 OID 0)
-- Dependencies: 309
-- Name: seq_team_referent; Type: SEQUENCE OWNED BY; Schema: public; Owner: hceres
--

ALTER SEQUENCE public.seq_team_referent OWNED BY public.team_referent.team_referent_id;


--
-- TOC entry 310 (class 1259 OID 25061)
-- Name: tool_product_type; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.tool_product_type (
    tool_product_type_id integer NOT NULL,
    tool_product_type_name character varying(256) NOT NULL
);


ALTER TABLE public.tool_product_type OWNER TO hceres;

--
-- TOC entry 311 (class 1259 OID 25064)
-- Name: seq_tool_product; Type: SEQUENCE; Schema: public; Owner: hceres
--

CREATE SEQUENCE public.seq_tool_product
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_tool_product OWNER TO hceres;

--
-- TOC entry 3922 (class 0 OID 0)
-- Dependencies: 311
-- Name: seq_tool_product; Type: SEQUENCE OWNED BY; Schema: public; Owner: hceres
--

ALTER SEQUENCE public.seq_tool_product OWNED BY public.tool_product_type.tool_product_type_id;


--
-- TOC entry 312 (class 1259 OID 25066)
-- Name: tool_product_role; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.tool_product_role (
    tool_product_role_id integer NOT NULL,
    tool_product_role_name character varying(256) NOT NULL
);


ALTER TABLE public.tool_product_role OWNER TO hceres;

--
-- TOC entry 313 (class 1259 OID 25069)
-- Name: seq_tool_product_role; Type: SEQUENCE; Schema: public; Owner: hceres
--

CREATE SEQUENCE public.seq_tool_product_role
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_tool_product_role OWNER TO hceres;

--
-- TOC entry 3923 (class 0 OID 0)
-- Dependencies: 313
-- Name: seq_tool_product_role; Type: SEQUENCE OWNED BY; Schema: public; Owner: hceres
--

ALTER SEQUENCE public.seq_tool_product_role OWNED BY public.tool_product_role.tool_product_role_id;


--
-- TOC entry 314 (class 1259 OID 25071)
-- Name: type_activity; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.type_activity (
    id_type_activity integer NOT NULL,
    name_type character varying(256)
);


ALTER TABLE public.type_activity OWNER TO hceres;

--
-- TOC entry 315 (class 1259 OID 25074)
-- Name: seq_type_activity; Type: SEQUENCE; Schema: public; Owner: hceres
--

CREATE SEQUENCE public.seq_type_activity
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_type_activity OWNER TO hceres;

--
-- TOC entry 3924 (class 0 OID 0)
-- Dependencies: 315
-- Name: seq_type_activity; Type: SEQUENCE OWNED BY; Schema: public; Owner: hceres
--

ALTER SEQUENCE public.seq_type_activity OWNED BY public.type_activity.id_type_activity;


--
-- TOC entry 316 (class 1259 OID 25076)
-- Name: type_collab; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.type_collab (
    type_collab_id integer NOT NULL,
    name_choice character varying(256)
);


ALTER TABLE public.type_collab OWNER TO hceres;

--
-- TOC entry 317 (class 1259 OID 25079)
-- Name: seq_type_collab; Type: SEQUENCE; Schema: public; Owner: hceres
--

CREATE SEQUENCE public.seq_type_collab
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_type_collab OWNER TO hceres;

--
-- TOC entry 3925 (class 0 OID 0)
-- Dependencies: 317
-- Name: seq_type_collab; Type: SEQUENCE OWNED BY; Schema: public; Owner: hceres
--

ALTER SEQUENCE public.seq_type_collab OWNED BY public.type_collab.type_collab_id;


--
-- TOC entry 318 (class 1259 OID 25081)
-- Name: type_oral_communication; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.type_oral_communication (
    type_oral_communication_id integer NOT NULL,
    type_oral_communication_name character varying(256) NOT NULL
);


ALTER TABLE public.type_oral_communication OWNER TO hceres;

--
-- TOC entry 319 (class 1259 OID 25084)
-- Name: seq_type_oral_communication; Type: SEQUENCE; Schema: public; Owner: hceres
--

CREATE SEQUENCE public.seq_type_oral_communication
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_type_oral_communication OWNER TO hceres;

--
-- TOC entry 3926 (class 0 OID 0)
-- Dependencies: 319
-- Name: seq_type_oral_communication; Type: SEQUENCE OWNED BY; Schema: public; Owner: hceres
--

ALTER SEQUENCE public.seq_type_oral_communication OWNED BY public.type_oral_communication.type_oral_communication_id;


--
-- TOC entry 320 (class 1259 OID 25086)
-- Name: type_patent; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.type_patent (
    type_patent_id integer NOT NULL,
    name_choice character varying(256)
);


ALTER TABLE public.type_patent OWNER TO hceres;

--
-- TOC entry 321 (class 1259 OID 25089)
-- Name: seq_type_patent; Type: SEQUENCE; Schema: public; Owner: hceres
--

CREATE SEQUENCE public.seq_type_patent
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_type_patent OWNER TO hceres;

--
-- TOC entry 3927 (class 0 OID 0)
-- Dependencies: 321
-- Name: seq_type_patent; Type: SEQUENCE OWNED BY; Schema: public; Owner: hceres
--

ALTER SEQUENCE public.seq_type_patent OWNED BY public.type_patent.type_patent_id;


--
-- TOC entry 322 (class 1259 OID 25091)
-- Name: type_research_contract; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.type_research_contract (
    id_type integer NOT NULL,
    name_choice character varying(256)
);


ALTER TABLE public.type_research_contract OWNER TO hceres;

--
-- TOC entry 323 (class 1259 OID 25094)
-- Name: seq_type_research; Type: SEQUENCE; Schema: public; Owner: hceres
--

CREATE SEQUENCE public.seq_type_research
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_type_research OWNER TO hceres;

--
-- TOC entry 3928 (class 0 OID 0)
-- Dependencies: 323
-- Name: seq_type_research; Type: SEQUENCE OWNED BY; Schema: public; Owner: hceres
--

ALTER SEQUENCE public.seq_type_research OWNED BY public.type_research_contract.id_type;


--
-- TOC entry 324 (class 1259 OID 25096)
-- Name: sr_award; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.sr_award (
    id_activity integer NOT NULL,
    awardee_name character varying(256),
    award_date date,
    description text
);


ALTER TABLE public.sr_award OWNER TO hceres;

--
-- TOC entry 325 (class 1259 OID 25102)
-- Name: supervisor_id_supervisor_seq; Type: SEQUENCE; Schema: public; Owner: prweb
--

CREATE SEQUENCE public.supervisor_id_supervisor_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.supervisor_id_supervisor_seq OWNER TO prweb;

--
-- TOC entry 326 (class 1259 OID 25104)
-- Name: tool_product; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.tool_product (
    id_activity integer NOT NULL,
    tool_product_type_id integer NOT NULL,
    tool_product_nam character varying(256),
    tool_product_creation date NOT NULL,
    tool_product_authors text NOT NULL,
    tool_product_description text NOT NULL
);


ALTER TABLE public.tool_product OWNER TO hceres;

--
-- TOC entry 327 (class 1259 OID 25110)
-- Name: tool_product_involvment; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.tool_product_involvment (
    id_activity integer NOT NULL,
    tool_product_role_id integer NOT NULL,
    tool_product_involvment_researchers text
);


ALTER TABLE public.tool_product_involvment OWNER TO hceres;

--
-- TOC entry 328 (class 1259 OID 25116)
-- Name: type_consortium; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.type_consortium (
    type_consortium_id integer NOT NULL,
    type_consortium_name character varying(256)
);


ALTER TABLE public.type_consortium OWNER TO hceres;

--
-- TOC entry 329 (class 1259 OID 25119)
-- Name: type_consortium_type_consortium_id_seq; Type: SEQUENCE; Schema: public; Owner: hceres
--

CREATE SEQUENCE public.type_consortium_type_consortium_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.type_consortium_type_consortium_id_seq OWNER TO hceres;

--
-- TOC entry 3929 (class 0 OID 0)
-- Dependencies: 329
-- Name: type_consortium_type_consortium_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hceres
--

ALTER SEQUENCE public.type_consortium_type_consortium_id_seq OWNED BY public.type_consortium.type_consortium_id;


--
-- TOC entry 330 (class 1259 OID 25121)
-- Name: type_thesis; Type: TABLE; Schema: public; Owner: hceres
--

CREATE TABLE public.type_thesis (
    type_thesis_id integer NOT NULL,
    type_thesis_name character varying(256)
);


ALTER TABLE public.type_thesis OWNER TO hceres;

--
-- TOC entry 331 (class 1259 OID 25124)
-- Name: type_thesis_type_thesis_id_seq; Type: SEQUENCE; Schema: public; Owner: hceres
--

CREATE SEQUENCE public.type_thesis_type_thesis_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.type_thesis_type_thesis_id_seq OWNER TO hceres;

--
-- TOC entry 3930 (class 0 OID 0)
-- Dependencies: 331
-- Name: type_thesis_type_thesis_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hceres
--

ALTER SEQUENCE public.type_thesis_type_thesis_id_seq OWNED BY public.type_thesis.type_thesis_id;


--
-- TOC entry 3311 (class 2604 OID 25126)
-- Name: activity id_activity; Type: DEFAULT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.activity ALTER COLUMN id_activity SET DEFAULT nextval('public.seq_activity'::regclass);


--
-- TOC entry 3312 (class 2604 OID 25127)
-- Name: belongs_team id_belongs_team; Type: DEFAULT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.belongs_team ALTER COLUMN id_belongs_team SET DEFAULT nextval('public.seq_belongs_team'::regclass);


--
-- TOC entry 3313 (class 2604 OID 25128)
-- Name: company company_id; Type: DEFAULT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.company ALTER COLUMN company_id SET DEFAULT nextval('public.seq_company'::regclass);


--
-- TOC entry 3316 (class 2604 OID 25129)
-- Name: contract id_contract; Type: DEFAULT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.contract ALTER COLUMN id_contract SET DEFAULT nextval('public.seq_contract'::regclass);


--
-- TOC entry 3317 (class 2604 OID 25130)
-- Name: contract_type id_contract_type; Type: DEFAULT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.contract_type ALTER COLUMN id_contract_type SET DEFAULT nextval('public.seq_contract_type'::regclass);


--
-- TOC entry 3318 (class 2604 OID 25131)
-- Name: education_involvment education_involvment_id; Type: DEFAULT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.education_involvment ALTER COLUMN education_involvment_id SET DEFAULT nextval('public.seq_education_involvment'::regclass);


--
-- TOC entry 3319 (class 2604 OID 25132)
-- Name: education_level education_level_id; Type: DEFAULT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.education_level ALTER COLUMN education_level_id SET DEFAULT nextval('public.seq_education_level'::regclass);


--
-- TOC entry 3320 (class 2604 OID 25133)
-- Name: employer id_employer; Type: DEFAULT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.employer ALTER COLUMN id_employer SET DEFAULT nextval('public.seq_employer'::regclass);


--
-- TOC entry 3321 (class 2604 OID 25134)
-- Name: evaluation_thesis_role evaluation_thesis_role_id; Type: DEFAULT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.evaluation_thesis_role ALTER COLUMN evaluation_thesis_role_id SET DEFAULT nextval('public.evaluation_thesis_role_evaluation_thesis_role_id_seq'::regclass);


--
-- TOC entry 3322 (class 2604 OID 25135)
-- Name: function_editorial_activity function_editorial_activity_id; Type: DEFAULT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.function_editorial_activity ALTER COLUMN function_editorial_activity_id SET DEFAULT nextval('public.seq_function_editorial_activity'::regclass);


--
-- TOC entry 3323 (class 2604 OID 25136)
-- Name: funder funder_id; Type: DEFAULT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.funder ALTER COLUMN funder_id SET DEFAULT nextval('public.seq_funder'::regclass);


--
-- TOC entry 3324 (class 2604 OID 25137)
-- Name: institution institution_id; Type: DEFAULT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.institution ALTER COLUMN institution_id SET DEFAULT nextval('public.seq_institution'::regclass);


--
-- TOC entry 3325 (class 2604 OID 25138)
-- Name: journal journal_id; Type: DEFAULT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.journal ALTER COLUMN journal_id SET DEFAULT nextval('public.seq_journal'::regclass);


--
-- TOC entry 3326 (class 2604 OID 25139)
-- Name: laboratory laboratory_id; Type: DEFAULT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.laboratory ALTER COLUMN laboratory_id SET DEFAULT nextval('public.seq_laboratory'::regclass);


--
-- TOC entry 3327 (class 2604 OID 25140)
-- Name: laboratory_evaluation_role laboratory_evaluation_role_id; Type: DEFAULT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.laboratory_evaluation_role ALTER COLUMN laboratory_evaluation_role_id SET DEFAULT nextval('public.seq_laboratory_evaluation_role'::regclass);


--
-- TOC entry 3328 (class 2604 OID 25141)
-- Name: language language_id; Type: DEFAULT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.language ALTER COLUMN language_id SET DEFAULT nextval('public.seq_language'::regclass);


--
-- TOC entry 3329 (class 2604 OID 25142)
-- Name: learned_scientific_society_role learned_scientific_society_role_id; Type: DEFAULT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.learned_scientific_society_role ALTER COLUMN learned_scientific_society_role_id SET DEFAULT nextval('public.seq_learned_scientific_society_role'::regclass);


--
-- TOC entry 3330 (class 2604 OID 25143)
-- Name: mail_activity mail_activity_id; Type: DEFAULT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.mail_activity ALTER COLUMN mail_activity_id SET DEFAULT nextval('public.seq_mail_activity'::regclass);


--
-- TOC entry 3331 (class 2604 OID 25144)
-- Name: mail_template mail_template_id; Type: DEFAULT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.mail_template ALTER COLUMN mail_template_id SET DEFAULT nextval('public.seq_mail_template'::regclass);


--
-- TOC entry 3332 (class 2604 OID 25145)
-- Name: meeting meeting_id; Type: DEFAULT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.meeting ALTER COLUMN meeting_id SET DEFAULT nextval('public.seq_meeting'::regclass);


--
-- TOC entry 3333 (class 2604 OID 25146)
-- Name: nationality nationality_id; Type: DEFAULT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.nationality ALTER COLUMN nationality_id SET DEFAULT nextval('public.seq_nationality'::regclass);


--
-- TOC entry 3334 (class 2604 OID 25147)
-- Name: parameter parameter_id; Type: DEFAULT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.parameter ALTER COLUMN parameter_id SET DEFAULT nextval('public.seq_parameter'::regclass);


--
-- TOC entry 3339 (class 2604 OID 25148)
-- Name: phd_student phd_student_id; Type: DEFAULT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.phd_student ALTER COLUMN phd_student_id SET DEFAULT nextval('public.seq_phd_student'::regclass);


--
-- TOC entry 3340 (class 2604 OID 25149)
-- Name: phd_type phd_type_id; Type: DEFAULT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.phd_type ALTER COLUMN phd_type_id SET DEFAULT nextval('public.seq_phd_type'::regclass);


--
-- TOC entry 3341 (class 2604 OID 25150)
-- Name: project_evaluation_category project_evaluation_category_id; Type: DEFAULT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.project_evaluation_category ALTER COLUMN project_evaluation_category_id SET DEFAULT nextval('public.seq_project_evaluation_category'::regclass);


--
-- TOC entry 3342 (class 2604 OID 25151)
-- Name: project_evaluation_role project_evaluation_role_id; Type: DEFAULT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.project_evaluation_role ALTER COLUMN project_evaluation_role_id SET DEFAULT nextval('public.seq_project_evaluation_role'::regclass);


--
-- TOC entry 3343 (class 2604 OID 25152)
-- Name: public_outreach_type public_outreach_type_id; Type: DEFAULT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.public_outreach_type ALTER COLUMN public_outreach_type_id SET DEFAULT nextval('public.seq_public_outreach_type'::regclass);


--
-- TOC entry 3347 (class 2604 OID 25153)
-- Name: publication_type publication_type_id; Type: DEFAULT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.publication_type ALTER COLUMN publication_type_id SET DEFAULT nextval('public.seq_choice_publication'::regclass);


--
-- TOC entry 3348 (class 2604 OID 25154)
-- Name: researcher researcher_id; Type: DEFAULT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.researcher ALTER COLUMN researcher_id SET DEFAULT nextval('public.seq_researcher'::regclass);


--
-- TOC entry 3349 (class 2604 OID 25155)
-- Name: scientific_expertise_type scientific_expertise_type_id; Type: DEFAULT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.scientific_expertise_type ALTER COLUMN scientific_expertise_type_id SET DEFAULT nextval('public.scientific_expertise_type_scientific_expertise_type_id_seq'::regclass);


--
-- TOC entry 3350 (class 2604 OID 25156)
-- Name: status id_status; Type: DEFAULT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.status ALTER COLUMN id_status SET DEFAULT nextval('public.seq_status'::regclass);


--
-- TOC entry 3352 (class 2604 OID 25157)
-- Name: supervisor supervisor_id; Type: DEFAULT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.supervisor ALTER COLUMN supervisor_id SET DEFAULT nextval('public.seq_supervisor_id'::regclass);


--
-- TOC entry 3353 (class 2604 OID 25158)
-- Name: team team_id; Type: DEFAULT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.team ALTER COLUMN team_id SET DEFAULT nextval('public.seq_team'::regclass);


--
-- TOC entry 3354 (class 2604 OID 25159)
-- Name: team_referent team_referent_id; Type: DEFAULT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.team_referent ALTER COLUMN team_referent_id SET DEFAULT nextval('public.seq_team_referent'::regclass);


--
-- TOC entry 3356 (class 2604 OID 25160)
-- Name: tool_product_role tool_product_role_id; Type: DEFAULT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.tool_product_role ALTER COLUMN tool_product_role_id SET DEFAULT nextval('public.seq_tool_product_role'::regclass);


--
-- TOC entry 3355 (class 2604 OID 25161)
-- Name: tool_product_type tool_product_type_id; Type: DEFAULT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.tool_product_type ALTER COLUMN tool_product_type_id SET DEFAULT nextval('public.seq_tool_product'::regclass);


--
-- TOC entry 3357 (class 2604 OID 25162)
-- Name: type_activity id_type_activity; Type: DEFAULT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.type_activity ALTER COLUMN id_type_activity SET DEFAULT nextval('public.seq_type_activity'::regclass);


--
-- TOC entry 3358 (class 2604 OID 25163)
-- Name: type_collab type_collab_id; Type: DEFAULT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.type_collab ALTER COLUMN type_collab_id SET DEFAULT nextval('public.seq_type_collab'::regclass);


--
-- TOC entry 3362 (class 2604 OID 25164)
-- Name: type_consortium type_consortium_id; Type: DEFAULT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.type_consortium ALTER COLUMN type_consortium_id SET DEFAULT nextval('public.type_consortium_type_consortium_id_seq'::regclass);


--
-- TOC entry 3359 (class 2604 OID 25165)
-- Name: type_oral_communication type_oral_communication_id; Type: DEFAULT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.type_oral_communication ALTER COLUMN type_oral_communication_id SET DEFAULT nextval('public.seq_type_oral_communication'::regclass);


--
-- TOC entry 3360 (class 2604 OID 25166)
-- Name: type_patent type_patent_id; Type: DEFAULT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.type_patent ALTER COLUMN type_patent_id SET DEFAULT nextval('public.seq_type_patent'::regclass);


--
-- TOC entry 3361 (class 2604 OID 25167)
-- Name: type_research_contract id_type; Type: DEFAULT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.type_research_contract ALTER COLUMN id_type SET DEFAULT nextval('public.seq_type_research'::regclass);


--
-- TOC entry 3363 (class 2604 OID 25168)
-- Name: type_thesis type_thesis_id; Type: DEFAULT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.type_thesis ALTER COLUMN type_thesis_id SET DEFAULT nextval('public.type_thesis_type_thesis_id_seq'::regclass);


--
-- TOC entry 3751 (class 0 OID 24663)
-- Dependencies: 200
-- Data for Name: activity; Type: TABLE DATA; Schema: public; Owner: hceres
--

INSERT INTO public.activity (id_activity, id_type_activity) VALUES (1, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (2, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (3, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (4, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (5, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (6, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (7, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (8, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (9, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (10, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (11, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (12, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (13, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (14, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (15, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (16, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (17, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (18, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (19, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (20, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (21, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (22, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (23, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (24, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (25, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (26, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (27, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (28, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (29, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (30, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (31, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (32, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (33, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (34, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (35, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (36, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (37, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (38, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (39, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (40, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (41, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (42, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (43, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (44, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (45, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (46, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (47, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (48, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (49, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (50, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (51, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (52, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (53, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (54, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (55, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (56, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (57, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (58, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (59, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (60, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (61, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (62, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (63, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (64, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (65, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (66, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (67, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (68, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (69, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (70, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (71, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (72, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (73, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (74, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (75, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (76, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (77, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (78, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (79, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (80, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (81, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (82, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (83, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (84, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (85, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (86, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (87, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (88, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (89, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (90, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (91, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (92, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (93, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (94, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (95, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (96, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (97, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (98, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (99, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (100, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (101, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (102, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (103, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (104, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (105, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (106, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (107, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (108, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (109, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (110, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (111, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (112, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (113, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (114, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (115, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (116, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (117, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (118, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (119, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (120, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (121, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (122, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (123, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (124, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (125, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (126, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (127, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (128, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (129, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (130, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (131, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (132, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (133, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (134, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (135, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (136, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (137, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (138, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (139, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (140, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (141, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (142, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (143, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (144, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (145, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (146, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (147, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (148, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (149, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (150, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (151, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (152, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (153, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (154, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (155, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (156, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (157, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (158, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (159, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (160, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (161, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (162, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (163, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (164, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (165, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (166, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (167, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (168, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (169, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (170, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (171, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (172, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (173, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (174, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (175, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (176, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (177, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (178, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (179, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (180, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (181, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (182, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (183, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (184, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (185, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (186, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (187, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (188, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (189, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (190, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (191, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (192, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (193, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (194, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (195, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (196, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (197, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (198, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (199, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (200, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (201, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (202, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (203, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (204, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (205, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (206, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (207, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (208, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (209, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (210, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (211, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (212, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (213, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (214, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (215, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (216, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (217, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (218, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (219, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (220, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (221, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (222, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (223, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (224, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (225, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (226, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (227, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (228, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (229, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (230, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (231, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (232, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (233, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (234, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (235, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (236, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (237, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (238, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (239, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (240, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (241, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (242, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (243, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (244, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (245, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (246, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (247, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (248, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (249, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (250, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (251, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (252, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (253, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (254, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (255, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (256, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (257, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (258, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (259, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (260, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (261, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (262, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (263, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (264, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (265, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (266, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (267, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (268, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (269, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (270, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (271, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (272, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (273, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (274, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (275, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (276, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (277, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (278, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (279, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (280, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (281, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (282, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (283, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (284, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (285, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (286, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (287, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (288, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (289, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (290, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (291, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (292, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (293, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (294, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (295, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (296, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (297, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (298, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (299, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (300, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (301, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (302, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (303, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (304, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (305, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (306, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (307, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (308, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (309, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (310, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (311, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (312, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (313, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (314, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (315, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (316, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (317, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (318, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (319, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (320, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (321, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (322, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (323, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (324, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (325, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (326, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (327, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (328, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (329, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (330, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (331, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (332, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (333, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (334, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (335, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (336, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (337, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (338, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (339, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (340, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (341, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (342, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (343, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (344, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (345, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (346, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (347, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (348, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (349, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (350, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (351, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (352, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (353, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (354, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (355, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (356, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (357, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (358, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (359, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (360, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (361, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (362, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (363, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (364, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (365, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (366, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (367, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (368, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (369, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (370, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (371, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (372, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (373, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (374, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (375, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (376, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (377, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (378, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (379, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (380, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (381, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (382, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (383, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (384, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (385, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (386, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (387, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (388, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (389, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (390, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (391, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (392, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (393, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (394, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (395, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (396, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (397, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (398, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (399, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (400, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (401, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (402, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (403, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (404, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (405, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (406, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (407, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (408, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (409, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (410, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (411, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (412, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (413, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (414, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (415, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (416, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (417, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (418, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (419, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (420, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (421, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (422, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (423, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (424, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (425, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (426, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (427, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (428, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (429, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (430, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (431, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (432, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (433, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (434, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (435, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (436, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (437, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (438, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (439, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (440, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (441, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (442, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (443, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (444, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (445, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (446, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (447, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (448, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (449, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (450, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (451, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (452, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (453, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (454, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (455, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (456, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (457, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (458, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (459, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (460, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (461, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (462, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (463, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (464, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (465, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (466, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (467, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (468, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (469, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (470, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (471, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (472, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (473, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (474, 1);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (475, 2);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (476, 2);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (477, 2);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (478, 2);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (479, 2);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (480, 2);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (481, 2);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (482, 2);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (483, 2);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (484, 2);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (485, 2);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (486, 2);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (487, 2);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (488, 2);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (489, 2);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (490, 2);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (491, 2);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (492, 2);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (493, 2);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (494, 2);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (495, 2);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (496, 2);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (497, 2);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (498, 2);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (499, 2);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (500, 2);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (501, 2);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (502, 29);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (503, 29);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (504, 29);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (505, 29);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (506, 29);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (507, 29);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (508, 29);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (509, 29);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (510, 29);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (511, 14);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (512, 14);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (513, 16);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (514, 16);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (515, 16);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (516, 16);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (517, 16);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (518, 41);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (519, 41);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (520, 41);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (521, 41);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (522, 41);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (523, 16);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (524, 16);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (525, 34);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (526, 34);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (527, 34);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (528, 34);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (529, 41);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (530, 16);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (531, 16);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (532, 16);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (533, 6);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (534, 6);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (535, 6);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (536, 6);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (537, 6);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (538, 6);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (539, 6);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (540, 6);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (541, 6);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (542, 6);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (543, 16);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (544, 16);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (545, 29);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (546, 6);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (547, 6);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (548, 6);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (549, 6);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (550, 16);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (551, 16);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (552, 16);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (553, 16);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (554, 34);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (555, 16);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (556, 16);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (557, 41);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (558, 41);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (559, 16);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (560, 16);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (561, 29);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (562, 16);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (563, 16);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (564, 16);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (565, 16);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (566, 16);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (568, 16);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (569, 5);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (570, 16);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (571, 29);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (572, 29);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (573, 29);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (574, 29);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (575, 12);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (576, 21);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (577, 29);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (578, 29);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (579, 32);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (580, 32);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (581, 6);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (582, 6);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (583, 6);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (584, 6);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (585, 32);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (586, 40);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (588, 16);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (589, 41);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (590, 41);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (591, 41);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (592, 34);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (593, 13);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (594, 5);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (595, 5);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (596, 6);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (597, 6);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (598, 5);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (599, 16);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (600, 41);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (601, 41);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (602, 34);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (603, 12);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (604, 29);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (605, 6);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (606, 32);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (607, 12);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (608, 12);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (609, 29);
INSERT INTO public.activity (id_activity, id_type_activity) VALUES (610, 29);


--
-- TOC entry 3752 (class 0 OID 24666)
-- Dependencies: 201
-- Data for Name: activity_researcher; Type: TABLE DATA; Schema: public; Owner: hceres
--

INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (56, 19);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (21, 19);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (214, 454);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (13, 454);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (188, 24);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (5, 24);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (188, 25);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (5, 25);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (46, 7);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (201, 211);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (21, 4);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (147, 9);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (76, 10);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (76, 17);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (171, 21);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (112, 21);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (160, 27);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (210, 27);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (213, 27);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (57, 27);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 27);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (111, 12);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (12, 6);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (108, 6);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (33, 13);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (162, 13);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (97, 13);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (76, 13);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (56, 13);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (183, 20);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (134, 20);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (13, 20);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (21, 20);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (160, 28);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (210, 28);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (213, 28);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 28);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (188, 30);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (136, 30);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (208, 30);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (5, 30);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (201, 228);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (75, 228);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (195, 228);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (175, 228);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 228);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (49, 229);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (191, 229);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (33, 229);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (97, 229);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (216, 230);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (182, 230);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (129, 230);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 230);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (147, 230);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 231);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (108, 232);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 236);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (108, 237);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (57, 237);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 237);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (93, 253);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (54, 254);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 254);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (152, 465);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (214, 465);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 465);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (115, 233);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (111, 60);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 60);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (152, 234);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (45, 234);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (129, 234);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (166, 234);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (171, 420);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (211, 420);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (192, 420);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (28, 420);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (30, 420);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 420);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (112, 420);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (129, 420);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (76, 420);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (58, 420);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (12, 11);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (213, 11);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (108, 11);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (183, 63);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (191, 63);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (33, 63);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (134, 63);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (164, 63);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (119, 63);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (13, 63);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (21, 63);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (13, 69);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (97, 66);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (215, 35);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (33, 35);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (13, 70);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 256);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (9, 297);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (152, 297);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (11, 389);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (76, 406);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (116, 67);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (171, 67);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (112, 67);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (129, 67);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (21, 3);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (188, 37);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (97, 347);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 38);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (97, 68);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (162, 68);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (136, 96);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (188, 96);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (208, 96);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (57, 96);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (188, 106);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (136, 106);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (58, 259);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (25, 259);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 259);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (12, 279);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (159, 279);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (16, 279);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (135, 279);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (57, 279);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (108, 279);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (97, 39);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (162, 39);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (210, 88);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (188, 107);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (28, 95);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (76, 95);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (119, 102);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (164, 102);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (52, 102);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (214, 102);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (13, 102);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (201, 104);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (136, 109);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (188, 109);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (208, 109);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (86, 109);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (5, 110);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (166, 257);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (214, 257);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (76, 257);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (54, 258);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (69, 258);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (212, 258);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (82, 258);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 258);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (188, 99);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (188, 100);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (136, 100);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 115);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 116);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (154, 121);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (127, 121);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (218, 121);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (194, 121);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (31, 121);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (129, 121);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (3, 121);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (128, 123);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (171, 130);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (112, 130);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (154, 131);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (129, 131);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (92, 132);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (44, 132);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (163, 132);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (58, 132);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (175, 132);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 132);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (47, 135);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (201, 137);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (75, 137);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (114, 137);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (11, 118);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (114, 128);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (159, 199);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (46, 124);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (192, 114);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (93, 114);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (43, 119);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (44, 119);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (194, 119);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 119);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (3, 119);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (22, 158);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (57, 159);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (214, 161);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (76, 162);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (201, 166);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (97, 144);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (191, 144);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 144);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (49, 144);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (97, 146);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (127, 177);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (31, 177);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (3, 177);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (210, 178);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (213, 178);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (160, 178);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (166, 179);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (60, 180);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (85, 180);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (160, 174);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (210, 174);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (213, 174);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 174);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (160, 176);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (210, 176);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (213, 176);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (214, 176);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 176);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (216, 52);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (149, 52);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (147, 52);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (57, 468);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 200);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (76, 472);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (40, 50);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (66, 51);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (58, 51);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (97, 51);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (114, 51);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 51);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (160, 240);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (210, 240);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (60, 240);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (213, 240);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 240);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (11, 206);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (20, 213);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 214);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (94, 220);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (147, 220);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (216, 220);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (12, 241);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 241);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (108, 241);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (40, 208);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (160, 242);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (210, 242);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (213, 242);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (105, 242);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (75, 242);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (214, 242);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 242);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (182, 216);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (214, 224);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (13, 224);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (33, 243);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (21, 243);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (160, 244);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (40, 209);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (166, 238);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 239);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (49, 204);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (97, 204);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (54, 212);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (66, 212);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (47, 212);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 212);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (92, 249);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (163, 249);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 249);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (58, 249);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (214, 251);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (25, 260);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (46, 260);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 260);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (25, 261);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (71, 261);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (46, 261);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (69, 261);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (82, 261);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 261);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (212, 262);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (54, 262);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 262);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (114, 263);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (66, 263);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 263);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (54, 264);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (44, 264);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (60, 264);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (43, 264);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (215, 264);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (58, 264);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (47, 264);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (97, 264);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 264);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (214, 235);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (190, 265);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (160, 247);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (213, 247);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 247);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (210, 247);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (22, 269);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (171, 269);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (192, 269);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (112, 269);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (129, 269);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (22, 387);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (171, 387);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (200, 387);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (192, 387);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (112, 387);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (129, 387);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (152, 248);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (147, 41);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (160, 383);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 383);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (127, 383);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (111, 383);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (129, 383);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (21, 44);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (191, 44);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (134, 44);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (13, 44);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (33, 44);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (137, 45);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (137, 46);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (137, 47);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (44, 48);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (54, 48);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 48);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (40, 49);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 57);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 272);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (58, 272);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (201, 382);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (119, 382);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (164, 382);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 382);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (13, 382);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (47, 382);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (98, 392);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (76, 393);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (12, 397);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (213, 397);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (108, 397);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (71, 398);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (65, 398);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (69, 398);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (54, 398);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (44, 398);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (25, 398);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (58, 398);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (97, 398);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 398);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (97, 399);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (54, 400);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (44, 400);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (71, 400);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (97, 400);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 400);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (97, 401);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (44, 402);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (97, 402);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 402);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 403);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (215, 404);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (212, 404);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (33, 404);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (76, 404);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (76, 405);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (80, 317);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (188, 317);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (136, 317);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (159, 317);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (5, 317);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (57, 317);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (86, 317);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 56);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (166, 304);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (96, 305);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (191, 305);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (40, 305);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (179, 306);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (54, 320);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (97, 320);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (58, 320);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 320);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (47, 320);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (96, 302);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (40, 302);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (42, 307);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (48, 307);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (111, 307);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (57, 308);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (171, 309);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (192, 309);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (76, 309);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (112, 309);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (96, 310);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (40, 310);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (166, 311);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (189, 312);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (210, 312);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 312);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (136, 313);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (208, 313);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (188, 313);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (5, 313);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (199, 314);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (25, 314);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 314);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (188, 318);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (5, 318);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (86, 318);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (215, 413);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (21, 413);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (48, 413);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (43, 413);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (119, 413);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (164, 413);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (191, 413);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (214, 413);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (13, 413);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (216, 54);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (147, 54);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 55);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (128, 412);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (211, 412);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (54, 412);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (60, 412);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (155, 412);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (97, 412);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 412);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (58, 412);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (137, 322);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (147, 407);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (93, 205);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (44, 205);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (97, 205);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 205);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (156, 266);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (63, 266);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (93, 266);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (110, 266);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (216, 266);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (147, 266);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (11, 266);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (58, 267);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 267);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (163, 325);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (219, 326);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (163, 326);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (149, 329);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (135, 331);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (57, 331);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (97, 414);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (40, 414);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (33, 366);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (134, 366);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (56, 366);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (13, 366);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (97, 366);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (215, 366);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (21, 366);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (60, 366);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (191, 366);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (97, 348);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (108, 359);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (12, 359);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 359);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (97, 361);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 363);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (70, 364);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (213, 364);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (155, 364);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (52, 364);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (191, 364);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (13, 364);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (214, 364);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (28, 415);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (25, 365);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (54, 365);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (71, 365);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (69, 365);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (82, 365);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (212, 365);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (66, 271);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (54, 271);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (44, 271);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (47, 271);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (97, 271);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 271);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 276);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 367);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (92, 273);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (111, 74);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (56, 74);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (215, 274);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (13, 274);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (214, 274);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (81, 182);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (134, 362);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (191, 362);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (21, 362);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (33, 362);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (97, 226);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (211, 268);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (128, 268);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (54, 268);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (30, 268);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (28, 268);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (97, 268);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (92, 268);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 268);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (58, 268);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (147, 183);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (182, 184);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 185);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (64, 288);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (198, 288);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (96, 290);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (40, 290);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (214, 293);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (166, 299);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (160, 299);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (210, 299);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (81, 299);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 299);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (129, 299);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (108, 299);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 59);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (210, 186);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (106, 186);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (90, 186);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (129, 285);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (138, 289);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (83, 289);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (152, 289);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (182, 289);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (129, 289);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (13, 291);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (22, 291);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (200, 291);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (129, 291);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (214, 291);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (119, 295);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (164, 295);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (215, 295);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (13, 295);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (214, 295);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 298);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (71, 416);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (54, 416);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (128, 416);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (25, 416);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (69, 416);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (211, 416);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (82, 416);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (212, 416);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (58, 416);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (97, 64);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (22, 187);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (129, 187);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (147, 287);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (12, 294);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (155, 294);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 294);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (108, 294);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (214, 283);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (70, 292);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (122, 292);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (213, 292);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (44, 292);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 292);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 292);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (45, 292);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (96, 189);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (40, 189);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (166, 282);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (13, 190);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (49, 202);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (97, 203);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (45, 281);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (210, 286);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (108, 286);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (217, 286);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (43, 286);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (22, 286);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (129, 286);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 286);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (210, 396);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 396);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (44, 411);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (163, 411);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (66, 411);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (43, 411);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (70, 411);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (97, 411);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (58, 411);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (45, 411);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 411);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (76, 8);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (97, 65);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (147, 408);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (76, 408);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (215, 409);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (66, 410);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (44, 410);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (58, 410);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (97, 410);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 410);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (163, 77);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (144, 77);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (219, 77);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (137, 77);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (212, 427);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (21, 78);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (97, 79);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (210, 433);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 433);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (75, 80);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (201, 80);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (155, 80);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (47, 80);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (40, 81);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (219, 418);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (216, 424);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 425);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (81, 426);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (12, 426);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 426);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (108, 426);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (219, 419);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (163, 419);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (54, 421);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 421);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (58, 422);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (30, 422);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (137, 422);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (128, 429);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (54, 429);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (119, 429);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (164, 429);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (172, 429);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (155, 429);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 429);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (58, 429);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (13, 429);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (214, 429);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (40, 430);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (12, 439);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (210, 439);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (213, 439);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (191, 439);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 439);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (108, 439);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 83);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 86);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (214, 278);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (13, 438);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (92, 438);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (214, 438);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (212, 2);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (82, 2);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (25, 2);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (54, 2);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (71, 2);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (69, 2);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 2);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (97, 33);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (97, 36);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (135, 432);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (159, 432);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (188, 432);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (81, 432);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (136, 432);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (5, 432);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (86, 432);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (54, 440);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (22, 440);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (155, 440);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (96, 440);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (129, 440);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 440);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (13, 440);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (214, 440);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (182, 460);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (162, 40);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (97, 40);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (86, 445);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (57, 245);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 270);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (175, 270);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (114, 270);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (216, 441);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (149, 141);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (111, 215);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (42, 296);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (154, 296);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (115, 296);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (129, 296);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (219, 442);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (86, 444);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (47, 446);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (12, 84);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (210, 84);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (191, 84);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (70, 84);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (160, 84);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (161, 84);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (45, 84);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (108, 84);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 84);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (21, 380);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (191, 380);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (164, 380);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (119, 380);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (214, 380);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (13, 380);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 380);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (46, 381);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (44, 381);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (97, 381);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (92, 386);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (66, 386);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (167, 386);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (135, 386);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (219, 386);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 386);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (163, 386);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (57, 386);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (58, 386);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (11, 386);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (92, 385);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (167, 385);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (66, 385);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (114, 385);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (163, 385);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (219, 385);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 447);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 448);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (116, 449);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (22, 449);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (78, 449);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (46, 449);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (129, 449);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 371);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (66, 372);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (44, 372);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (191, 372);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (56, 372);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (97, 372);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 372);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (58, 373);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 374);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (43, 375);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (44, 375);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (30, 375);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (66, 375);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (215, 375);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (58, 375);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (54, 375);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (97, 375);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 375);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (212, 376);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (54, 376);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 376);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (215, 377);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (48, 377);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (21, 377);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (119, 377);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (164, 377);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (191, 377);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (214, 377);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (13, 377);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (21, 378);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (40, 378);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (164, 378);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (119, 378);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (191, 378);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (214, 378);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (13, 378);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (71, 379);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (58, 379);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 379);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (216, 450);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (147, 450);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (94, 450);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (63, 450);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (211, 369);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (97, 369);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 369);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (58, 369);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (194, 464);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (127, 464);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (165, 464);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (83, 464);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (218, 464);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (182, 464);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (152, 87);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (216, 90);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (48, 91);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 91);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (115, 91);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (195, 92);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (201, 92);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (75, 92);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (149, 391);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (57, 436);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (28, 452);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (76, 452);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (214, 456);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 457);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (47, 457);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 458);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (22, 93);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (129, 93);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (189, 390);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (214, 390);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (13, 390);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 390);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 462);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (57, 463);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (166, 173);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (45, 173);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (129, 173);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (152, 173);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (76, 459);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (147, 142);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (85, 246);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (33, 171);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (219, 471);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (183, 58);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (13, 58);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (76, 94);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (128, 113);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (147, 113);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (152, 461);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (98, 461);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (45, 461);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (214, 461);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (13, 461);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (129, 461);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (166, 461);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (54, 136);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (28, 136);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 136);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (40, 136);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (212, 169);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 169);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (21, 172);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (57, 218);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (76, 349);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 284);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (92, 333);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 333);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 334);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (214, 335);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (175, 335);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (12, 337);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (16, 337);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (135, 337);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (159, 337);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (155, 337);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (52, 337);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (57, 337);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 337);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (108, 337);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (214, 338);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (158, 339);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (111, 339);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (76, 342);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (147, 343);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (216, 343);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (161, 344);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (76, 344);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (147, 345);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (114, 341);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (5, 353);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 388);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (111, 140);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (97, 149);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 149);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (215, 143);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (162, 143);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (97, 143);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (13, 143);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (56, 143);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (215, 355);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (76, 355);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (49, 437);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (201, 437);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (75, 437);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (195, 437);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (175, 437);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 437);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (97, 437);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (114, 437);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (40, 437);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 150);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (166, 151);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (13, 151);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (215, 152);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (13, 152);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (46, 356);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 356);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (71, 357);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (25, 357);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 357);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (96, 358);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (40, 358);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (85, 139);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (60, 139);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 139);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (147, 351);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (215, 145);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (21, 145);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (56, 145);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (97, 147);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (56, 147);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (192, 148);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (97, 148);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (147, 352);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (214, 360);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (92, 156);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (163, 156);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (219, 156);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 156);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (58, 156);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (149, 434);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (216, 434);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (166, 473);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (129, 473);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (22, 473);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (13, 473);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (195, 157);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (201, 157);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (75, 157);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (175, 157);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (66, 157);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (26, 157);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (96, 346);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (97, 346);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (40, 346);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (182, 222);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (76, 350);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (214, 368);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (13, 368);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (13, 506);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (13, 507);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (13, 508);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (14, 509);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (15, 510);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (12, 511);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (12, 512);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (12, 518);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (12, 519);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (12, 520);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (12, 521);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (12, 522);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (10, 525);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (10, 526);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (10, 527);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (10, 528);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (12, 529);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (10, 533);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (10, 534);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (9, 535);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (10, 536);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (8, 537);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (10, 538);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (20, 539);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (12, 540);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (10, 541);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (10, 542);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (12, 545);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (10, 546);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (10, 547);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (10, 548);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (10, 549);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (10, 554);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (10, 557);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (10, 558);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (13, 561);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (11, 568);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (10, 569);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (10, 570);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (7, 571);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 572);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (18, 573);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 574);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (10, 575);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (7, 576);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (4, 577);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (6, 578);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (5, 579);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (5, 580);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (10, 581);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (10, 582);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (3, 583);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (3, 584);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (5, 585);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (4, 586);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (8, 588);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (20, 589);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (5, 590);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (5, 591);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (5, 592);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (4, 593);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (10, 594);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (10, 595);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (7, 596);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (7, 597);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (10, 598);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (4, 599);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (10, 600);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 601);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (4, 602);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 603);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 604);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (3, 605);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (41, 606);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (4, 607);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (5, 608);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (2, 609);
INSERT INTO public.activity_researcher (researcher_id, id_activity) VALUES (17, 610);


--
-- TOC entry 3753 (class 0 OID 24669)
-- Dependencies: 202
-- Data for Name: activity_team; Type: TABLE DATA; Schema: public; Owner: hceres
--



--
-- TOC entry 3754 (class 0 OID 24672)
-- Dependencies: 203
-- Data for Name: admin; Type: TABLE DATA; Schema: public; Owner: hceres
--



--
-- TOC entry 3755 (class 0 OID 24675)
-- Dependencies: 204
-- Data for Name: belongs_team; Type: TABLE DATA; Schema: public; Owner: hceres
--

INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5682, 9, 1, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5683, 15, 1, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5684, 22, 1, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5685, 23, 1, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5686, 37, 1, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5687, 38, 1, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5688, 42, 1, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5689, 45, 1, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5690, 48, 1, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5691, 51, 1, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5692, 53, 1, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5693, 59, 1, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5694, 61, 1, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5695, 64, 1, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5696, 78, 1, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5697, 83, 1, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5698, 100, 1, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5699, 111, 1, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5700, 116, 1, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5701, 126, 1, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5702, 129, 1, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5703, 138, 1, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5704, 152, 1, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5705, 154, 1, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5706, 158, 1, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5707, 161, 1, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5708, 165, 1, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5709, 166, 1, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5710, 173, 1, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5711, 179, 1, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5712, 182, 1, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5713, 192, 1, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5714, 198, 1, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5715, 200, 1, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5716, 205, 1, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5717, 206, 1, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5718, 209, 1, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5719, 1, 2, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5720, 2, 2, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5721, 5, 2, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5722, 8, 2, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5723, 12, 2, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5724, 16, 2, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5725, 32, 2, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5726, 33, 2, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5727, 57, 2, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5728, 60, 2, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5729, 80, 2, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5730, 81, 2, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5731, 85, 2, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5732, 86, 2, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5733, 87, 2, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5734, 90, 2, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5735, 98, 2, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5736, 103, 2, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5737, 105, 2, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5738, 108, 2, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5739, 120, 2, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5740, 123, 2, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5741, 132, 2, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5742, 135, 2, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5743, 136, 2, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5744, 150, 2, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5745, 159, 2, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5746, 160, 2, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5747, 174, 2, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5748, 176, 2, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5749, 184, 2, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5750, 188, 2, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5751, 189, 2, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5752, 193, 2, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5753, 208, 2, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5754, 210, 2, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5755, 213, 2, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5756, 217, 2, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5757, 10, 3, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5758, 13, 3, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5759, 21, 3, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5760, 28, 3, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5761, 41, 3, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5762, 52, 3, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5763, 67, 3, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5764, 76, 3, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5765, 99, 3, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5766, 115, 3, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5767, 119, 3, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5768, 122, 3, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5769, 134, 3, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5770, 155, 3, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5771, 164, 3, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5772, 170, 3, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5773, 214, 3, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5774, 215, 3, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5775, 6, 4, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5776, 19, 4, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5777, 24, 4, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5778, 26, 4, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5779, 30, 4, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5780, 34, 4, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5781, 35, 4, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5782, 40, 4, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5783, 43, 4, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5784, 44, 4, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5785, 46, 4, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5786, 47, 4, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5787, 54, 4, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5788, 56, 4, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5789, 58, 4, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5790, 66, 4, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5791, 69, 4, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5792, 82, 4, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5793, 92, 4, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5794, 96, 4, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5795, 97, 4, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5796, 102, 4, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5797, 112, 4, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5798, 114, 4, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5799, 131, 4, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5800, 139, 4, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5801, 141, 4, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5802, 144, 4, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5803, 148, 4, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5804, 156, 4, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5805, 162, 4, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5806, 167, 4, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5807, 169, 4, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5808, 171, 4, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5809, 172, 4, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5810, 190, 4, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5811, 191, 4, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5812, 197, 4, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5813, 199, 4, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5814, 204, 4, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5815, 207, 4, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5816, 211, 4, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5817, 212, 4, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5818, 220, 4, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5819, 11, 5, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5820, 137, 5, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5821, 175, 5, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5822, 4, 6, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5823, 39, 6, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5824, 63, 6, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5825, 68, 6, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5826, 74, 6, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5827, 95, 6, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5828, 101, 6, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5829, 147, 6, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5830, 157, 6, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5831, 168, 6, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5832, 196, 6, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5833, 202, 6, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5834, 216, 6, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5835, 3, 7, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5836, 20, 7, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5837, 31, 7, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5838, 36, 7, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5839, 50, 7, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5840, 88, 7, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5841, 127, 7, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5842, 142, 7, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5843, 194, 7, NULL, NULL);
INSERT INTO public.belongs_team (id_belongs_team, researcher_id, team_id, onboarding_date, leaving_date) VALUES (5844, 218, 7, NULL, NULL);


--
-- TOC entry 3757 (class 0 OID 24680)
-- Dependencies: 206
-- Data for Name: book; Type: TABLE DATA; Schema: public; Owner: hceres
--

INSERT INTO public.book (id_activity, publication_date, title, editor, nb_page, authors, language_id) VALUES (483, '2019-01-01', '"Focus sur les lymphocytes CD8 dans la physiopathologie de la SEP" in  La Sclérose en plaques, Historique, épidémiologie et pathogénie.', 'Elsevier Masson', NULL, 'D. Laplaud', 1);
INSERT INTO public.book (id_activity, publication_date, title, editor, nb_page, authors, language_id) VALUES (484, '2019-01-01', 'Delphine Kervella, Simon Ville, Gilles Blancho. "Transplantation rénale : aspects immunologiques", in Encyclopédie Médicale Continue Néphrologie, 10/04/2019, Elsevier Masson', 'Elsevier Masson', NULL, 'D. Kervella, S. Ville, G. Blancho', 1);
INSERT INTO public.book (id_activity, publication_date, title, editor, nb_page, authors, language_id) VALUES (485, '2019-01-01', 'Diego Cantarovich, Delphine Kervella, Julien Branchereau, Georges Karam. Failure of the pancreas allograft in Transplantation, Bioengineering, and Regeneration of the Endocrine Pancreas 1st Edition.1st November 2019, Elsevier', 'Giuseppe Orlando', NULL, 'D. Kervella, J. Branchereau', 2);
INSERT INTO public.book (id_activity, publication_date, title, editor, nb_page, authors, language_id) VALUES (495, '2016-01-01', 'Evaluating embryo development stages using time-lapse microscopy. In "Time-lapse microscopy in In-Vitro Fertilization"', 'Marcos Meseguer, Cambridge University Press', NULL, 'T. Fréour', 2);
INSERT INTO public.book (id_activity, publication_date, title, editor, nb_page, authors, language_id) VALUES (496, '2017-01-01', '"ICSI", In Standard Operational Procedures in Reproductive Medicine Laboratory and Clinical Practice. Taylor & Francis group', 'Informa Press, Rizk and Montag (eds)', NULL, 'T. Fréour', 2);
INSERT INTO public.book (id_activity, publication_date, title, editor, nb_page, authors, language_id) VALUES (497, '2020-01-01', '"Time-lapse microscopy for embryo culture", In Manual of Embryo Culture in Human Assisted Reproduction', 'Cambridge University Press, Lundin and Ahlstrom (eds)', NULL, 'T. Fréour', 2);
INSERT INTO public.book (id_activity, publication_date, title, editor, nb_page, authors, language_id) VALUES (499, '2020-01-01', 'Insuffisance ante-hypophysaire et surrénalienne " dysthyroidies in Traité d''anesthésie et de réanimation " 4ème édition', 'Edition Lavoisier', NULL, 'A. Roquilly', 1);
INSERT INTO public.book (id_activity, publication_date, title, editor, nb_page, authors, language_id) VALUES (475, '2018-01-01', 'Charreau B.L. (2018) SH2B Adapter Protein 3 (SH2B3). In: Choi S. (eds) Encyclopedia of Signaling Molecules. pages 492-4933, Springer, Cham', 'Springer', NULL, 'B. Charreau', 2);
INSERT INTO public.book (id_activity, publication_date, title, editor, nb_page, authors, language_id) VALUES (476, '2018-01-01', 'Danger R and Brouard S; Gene expression technology applied to kidney transplantation, in Kidney Transplantation, Bioengineering and Regeneration. Giuseppe Orlando, Giuseppe Remuzzi, David F Williams, Eds. Associated Press, NY, USA.', 'Eds. Associated Press', NULL, 'S. Brouard', 2);
INSERT INTO public.book (id_activity, publication_date, title, editor, nb_page, authors, language_id) VALUES (477, '2018-01-01', 'Markers of acute and chronic rejection in renal transplantation. Chapter for Bentham E-Book entitled "Clinical chemistry and Nephrology: the essential link". Degauque N. Brouard S. (editor: Pierre Delanaye; ; eISBN: 978-1-60805-333-9).', 'Pierre Delanaye', NULL, 'S. Brouard', 2);
INSERT INTO public.book (id_activity, publication_date, title, editor, nb_page, authors, language_id) VALUES (478, '2019-01-01', 'Bressollette-Bodin C, Imbert-Marcille B.M. Infections virales et immunodépression. Traité de Virologie Médicale. Société Française de Microbiologie. 2e édition, 2019.', NULL, NULL, 'C. Bressollette - Bodin', 1);
INSERT INTO public.book (id_activity, publication_date, title, editor, nb_page, authors, language_id) VALUES (479, '2016-01-01', 'Carretero-Iglesia L, Hill M, Cuturi MC. Generation and Characterization of Mouse Regulatory Macrophages. in Methods Mol Biol. 2016;1371:89-100.', NULL, NULL, 'MC Cuturi', 2);
INSERT INTO public.book (id_activity, publication_date, title, editor, nb_page, authors, language_id) VALUES (486, '2019-01-01', '"Prélèvement des reins sur patient décédé après arrêt cardiaque" in Encyclopédie Médico-chirurgicale', NULL, NULL, 'J. Branchereau', 1);
INSERT INTO public.book (id_activity, publication_date, title, editor, nb_page, authors, language_id) VALUES (487, '2019-01-01', '"Prélèvement des reins sur patient décédé après arrêt cardiaque", "Complications urologiques de la transplantation " in Encyclopédie Médico-chirurgicale', NULL, NULL, 'J. Branchereau', 1);
INSERT INTO public.book (id_activity, publication_date, title, editor, nb_page, authors, language_id) VALUES (490, '2017-01-01', 'European Textbook on Kidney Transplantation - European Association of Urology 2017', NULL, NULL, 'J. Branchereau', 2);
INSERT INTO public.book (id_activity, publication_date, title, editor, nb_page, authors, language_id) VALUES (491, '2019-01-01', 'Les mécanismes de l''alloréactivité , des rejets de greffe et de la GvH in Immunologie fondamentale et immunopathologie- DFGSM2-3 Médecine. Collège des enseignants d''immunologie,', NULL, NULL, 'G. Blancho', 1);
INSERT INTO public.book (id_activity, publication_date, title, editor, nb_page, authors, language_id) VALUES (480, '2016-01-01', 'Martin JC, Bériou G, Josien R. Dextran Sulfate Sodium (DSS)-Induced Acute Colitis in the Rat. Methods Mol Biol. 2016;1371:197-203', NULL, NULL, 'R. Josien', 2);
INSERT INTO public.book (id_activity, publication_date, title, editor, nb_page, authors, language_id) VALUES (481, '2016-01-01', 'Suppression and regulation of immunes responses. Volume II. Editors : Cuturi MC and Anegon I . Series : Methods in Molecular Biology ; Editorial : Human Press, USA. 2016', 'Human Press', NULL, 'MC Cuturi', 2);
INSERT INTO public.book (id_activity, publication_date, title, editor, nb_page, authors, language_id) VALUES (492, '2019-01-01', 'Les cibles et mécanismes d''action des immunosuppresseurs in Immunologie fondamentale et immunopathologie- DFGSM2-3 Médecine. Collège des enseignants d''immunologie, Elsevier Masson', 'Elsevier Masson', NULL, 'G. Blancho', 1);
INSERT INTO public.book (id_activity, publication_date, title, editor, nb_page, authors, language_id) VALUES (493, '2015-01-01', 'Suppression and regulation of immunes responses. Volume II. Editors : Cuturi MC and Anegon I . Series : Methods in Molecular Biology', 'Editorial : Human Press, USA. 2016', NULL, 'I. Anegon', 2);
INSERT INTO public.book (id_activity, publication_date, title, editor, nb_page, authors, language_id) VALUES (482, '2018-01-01', 'Immuno-Guided Laser-Capture Microdissection of Glial Cells for mRNA Analysis. In: Murray G. (eds) Laser Capture Microdissection. Methods in Molecular Biology, vol 1723. Humana Press, New York, NY.', 'Humana Press', NULL, 'A. Nicot', 2);
INSERT INTO public.book (id_activity, publication_date, title, editor, nb_page, authors, language_id) VALUES (494, '2019-01-01', 'HIV pharmacogenetics and pharmacogenomics: from bench to bedside. In: Genomic and Personalized Medicine, 3rd edition, Elsevier, Ginsburg GS, Willard HF, Tsalik EL, Woods CW (Eds.), 2019', 'Human Press', NULL, 'S. Limou', 2);
INSERT INTO public.book (id_activity, publication_date, title, editor, nb_page, authors, language_id) VALUES (488, '2019-01-01', '"Rein et machine de perfusion" in Encyclopédie Médico-chirurgicale', NULL, NULL, 'T. Prudhomme, J. Branchereau', 1);
INSERT INTO public.book (id_activity, publication_date, title, editor, nb_page, authors, language_id) VALUES (489, '2015-01-01', 'Adaptation et traduction des guidelines de l''European Association of Urology sur la transplantation rénale', NULL, NULL, 'J. Branchereau', 1);
INSERT INTO public.book (id_activity, publication_date, title, editor, nb_page, authors, language_id) VALUES (498, '2019-01-01', 'Giraud M, Peterson P. The autoimmune regulator (AIRE) gene, the master activator of self-antigen expression in the thymus. In: Passos GA, editor. Chapter 7 Thymus Transcriptome and Cell Biology. Cham: Springer Nature (2019). pp. 318.', 'Springer Nature', NULL, 'M. Giraud', 2);
INSERT INTO public.book (id_activity, publication_date, title, editor, nb_page, authors, language_id) VALUES (500, '2019-01-01', 'Neuroendocrine Dysfunction in the critically ill patients in Metabolic disorders and critically ill patients', 'Edition Springer', NULL, 'A. Roquilly, K. Asehnoune', 2);
INSERT INTO public.book (id_activity, publication_date, title, editor, nb_page, authors, language_id) VALUES (501, '2020-01-01', 'Linking traumatic brain injury and nosocomial infections in Neuroscience Of Traumatic Brian Injury', 'Edition Science Direct', NULL, 'A. Roquilly, K. Asehnoune, M. Bouras', 2);


--
-- TOC entry 3758 (class 0 OID 24686)
-- Dependencies: 207
-- Data for Name: book_chapter; Type: TABLE DATA; Schema: public; Owner: hceres
--



--
-- TOC entry 3761 (class 0 OID 24696)
-- Dependencies: 210
-- Data for Name: company; Type: TABLE DATA; Schema: public; Owner: hceres
--



--
-- TOC entry 3762 (class 0 OID 24699)
-- Dependencies: 211
-- Data for Name: company_creation; Type: TABLE DATA; Schema: public; Owner: hceres
--



--
-- TOC entry 3763 (class 0 OID 24703)
-- Dependencies: 212
-- Data for Name: connection; Type: TABLE DATA; Schema: public; Owner: hceres
--

INSERT INTO public.connection (connection_code, connection_login, connection_expire, researcher_id, connection_status) VALUES ('HYWTI!20211126050706ACZ', 'admin', '2021-11-26 17:37:11.17', NULL, 1);


--
-- TOC entry 3764 (class 0 OID 24710)
-- Dependencies: 213
-- Data for Name: contract; Type: TABLE DATA; Schema: public; Owner: hceres
--



--
-- TOC entry 3765 (class 0 OID 24713)
-- Dependencies: 214
-- Data for Name: contract_type; Type: TABLE DATA; Schema: public; Owner: hceres
--



--
-- TOC entry 3766 (class 0 OID 24716)
-- Dependencies: 215
-- Data for Name: editorial_activity; Type: TABLE DATA; Schema: public; Owner: hceres
--

INSERT INTO public.editorial_activity (id_activity, journal_id, start_date, end_date, impact_factor, function_editorial_activity_id) VALUES (595, 1, '2022-03-27', '2022-03-30', 10, 3);
INSERT INTO public.editorial_activity (id_activity, journal_id, start_date, end_date, impact_factor, function_editorial_activity_id) VALUES (598, 1, '2022-03-27', '2022-03-27', 10, 4);


--
-- TOC entry 3767 (class 0 OID 24722)
-- Dependencies: 216
-- Data for Name: education; Type: TABLE DATA; Schema: public; Owner: hceres
--

INSERT INTO public.education (id_activity, education_course_name, education_completion, education_description, education_level_id, education_formation, education_involvment_id) VALUES (575, 'qsf', '2022-03-26', 'qsf', 8, 'fsq', 8);
INSERT INTO public.education (id_activity, education_course_name, education_completion, education_description, education_level_id, education_formation, education_involvment_id) VALUES (603, 'qsf', '2022-03-31', 'qsf', 12, 'fsq', 12);
INSERT INTO public.education (id_activity, education_course_name, education_completion, education_description, education_level_id, education_formation, education_involvment_id) VALUES (607, 'qsf', '2022-04-15', 'qsf', 13, 'fsq', 13);
INSERT INTO public.education (id_activity, education_course_name, education_completion, education_description, education_level_id, education_formation, education_involvment_id) VALUES (608, 'qsf', '2022-04-15', 'qsf', 14, 'fsq', 14);


--
-- TOC entry 3768 (class 0 OID 24728)
-- Dependencies: 217
-- Data for Name: education_involvment; Type: TABLE DATA; Schema: public; Owner: hceres
--

INSERT INTO public.education_involvment (education_involvment_id, education_involvment_name) VALUES (8, 'cqs');
INSERT INTO public.education_involvment (education_involvment_id, education_involvment_name) VALUES (12, 'cqs');
INSERT INTO public.education_involvment (education_involvment_id, education_involvment_name) VALUES (13, 'fsq');
INSERT INTO public.education_involvment (education_involvment_id, education_involvment_name) VALUES (14, 'cqs');


--
-- TOC entry 3769 (class 0 OID 24731)
-- Dependencies: 218
-- Data for Name: education_level; Type: TABLE DATA; Schema: public; Owner: hceres
--

INSERT INTO public.education_level (education_level_id, education_level_name) VALUES (8, 'dsfd');
INSERT INTO public.education_level (education_level_id, education_level_name) VALUES (12, '1');
INSERT INTO public.education_level (education_level_id, education_level_name) VALUES (13, '1');
INSERT INTO public.education_level (education_level_id, education_level_name) VALUES (14, '1');


--
-- TOC entry 3770 (class 0 OID 24734)
-- Dependencies: 219
-- Data for Name: employer; Type: TABLE DATA; Schema: public; Owner: hceres
--



--
-- TOC entry 3772 (class 0 OID 24739)
-- Dependencies: 221
-- Data for Name: evaluation_thesis; Type: TABLE DATA; Schema: public; Owner: hceres
--



--
-- TOC entry 3773 (class 0 OID 24742)
-- Dependencies: 222
-- Data for Name: evaluation_thesis_role; Type: TABLE DATA; Schema: public; Owner: hceres
--



--
-- TOC entry 3775 (class 0 OID 24747)
-- Dependencies: 224
-- Data for Name: function_editorial_activity; Type: TABLE DATA; Schema: public; Owner: hceres
--

INSERT INTO public.function_editorial_activity (function_editorial_activity_id, function_editorial_activity_name) VALUES (3, 'Abdelhafid SAOUD');
INSERT INTO public.function_editorial_activity (function_editorial_activity_id, function_editorial_activity_name) VALUES (4, 'fF');


--
-- TOC entry 3776 (class 0 OID 24750)
-- Dependencies: 225
-- Data for Name: funder; Type: TABLE DATA; Schema: public; Owner: hceres
--



--
-- TOC entry 3777 (class 0 OID 24756)
-- Dependencies: 226
-- Data for Name: incoming_mobility; Type: TABLE DATA; Schema: public; Owner: hceres
--

INSERT INTO public.incoming_mobility (id_activity, name_senior_scientist, arrival_date, departure_date, duration, nationality, original_lab_name, origina_lab_location, pi_partner, project_title, associated_funding, publication_reference, strategic_recurring_collab, active_project, umr_coordinated, agreement_signed) VALUES (525, 'testName', '2022-03-02', '2022-03-26', 24, 'france', NULL, 'labTest', '1554', 'testTitle', 'associ', '1546', false, true, true, false);
INSERT INTO public.incoming_mobility (id_activity, name_senior_scientist, arrival_date, departure_date, duration, nationality, original_lab_name, origina_lab_location, pi_partner, project_title, associated_funding, publication_reference, strategic_recurring_collab, active_project, umr_coordinated, agreement_signed) VALUES (526, 'testName2', '2022-03-02', '2022-03-26', 24, 'france', NULL, 'labTest2', '2564', 'testTitle2', 'associ2', '1524', false, true, true, true);
INSERT INTO public.incoming_mobility (id_activity, name_senior_scientist, arrival_date, departure_date, duration, nationality, original_lab_name, origina_lab_location, pi_partner, project_title, associated_funding, publication_reference, strategic_recurring_collab, active_project, umr_coordinated, agreement_signed) VALUES (527, 'testName3', '2022-03-02', '2022-03-26', 24, 'france', NULL, 'labTest3', '2564', 'testTitle3', 'associ3', '1524', false, true, true, true);
INSERT INTO public.incoming_mobility (id_activity, name_senior_scientist, arrival_date, departure_date, duration, nationality, original_lab_name, origina_lab_location, pi_partner, project_title, associated_funding, publication_reference, strategic_recurring_collab, active_project, umr_coordinated, agreement_signed) VALUES (528, 'testName4', '2022-03-02', '2022-03-26', 24, 'france', 'TestNameLab', 'labTest4', '2564', 'testTitle4', 'associ4', '1524', false, true, true, true);
INSERT INTO public.incoming_mobility (id_activity, name_senior_scientist, arrival_date, departure_date, duration, nationality, original_lab_name, origina_lab_location, pi_partner, project_title, associated_funding, publication_reference, strategic_recurring_collab, active_project, umr_coordinated, agreement_signed) VALUES (554, 'hsh', '2022-03-05', '2022-03-14', 12, 'fsd', 'qs', 'CSQ', '145', 'hhdhj', 'qsc', '485', true, true, true, true);
INSERT INTO public.incoming_mobility (id_activity, name_senior_scientist, arrival_date, departure_date, duration, nationality, original_lab_name, origina_lab_location, pi_partner, project_title, associated_funding, publication_reference, strategic_recurring_collab, active_project, umr_coordinated, agreement_signed) VALUES (592, 'hsh', '2022-03-28', '2022-03-28', 12, 'fsd', 'sdqS', 'qd', 'QSD', 'ds', 'DDD', 'DD', true, true, true, true);
INSERT INTO public.incoming_mobility (id_activity, name_senior_scientist, arrival_date, departure_date, duration, nationality, original_lab_name, origina_lab_location, pi_partner, project_title, associated_funding, publication_reference, strategic_recurring_collab, active_project, umr_coordinated, agreement_signed) VALUES (602, 'cd', '2022-03-26', '2022-03-27', 12, 'ccc', 'cqsc', 'cqsc', 'csq', 'csc', 'csq', 'csq', true, true, true, true);


--
-- TOC entry 3778 (class 0 OID 24762)
-- Dependencies: 227
-- Data for Name: institution; Type: TABLE DATA; Schema: public; Owner: hceres
--

INSERT INTO public.institution (institution_id, institution_name) VALUES (1, 'CNRS');
INSERT INTO public.institution (institution_id, institution_name) VALUES (2, 'INSERM');
INSERT INTO public.institution (institution_id, institution_name) VALUES (3, 'INRIA');


--
-- TOC entry 3779 (class 0 OID 24765)
-- Dependencies: 228
-- Data for Name: institutional_comitee; Type: TABLE DATA; Schema: public; Owner: hceres
--



--
-- TOC entry 3780 (class 0 OID 24768)
-- Dependencies: 229
-- Data for Name: invited_seminar; Type: TABLE DATA; Schema: public; Owner: hceres
--



--
-- TOC entry 3781 (class 0 OID 24774)
-- Dependencies: 230
-- Data for Name: journal; Type: TABLE DATA; Schema: public; Owner: hceres
--

INSERT INTO public.journal (journal_id, journal_name) VALUES (1, 'monde');


--
-- TOC entry 3782 (class 0 OID 24777)
-- Dependencies: 231
-- Data for Name: labcom_creation; Type: TABLE DATA; Schema: public; Owner: hceres
--



--
-- TOC entry 3783 (class 0 OID 24783)
-- Dependencies: 232
-- Data for Name: laboratory; Type: TABLE DATA; Schema: public; Owner: hceres
--

INSERT INTO public.laboratory (laboratory_id, laboratory_name, laboratory_acronym, institution_id) VALUES (1, 'Centre de Recherche en Transplantation et Immunologie', 'CRTI', 2);


--
-- TOC entry 3784 (class 0 OID 24786)
-- Dependencies: 233
-- Data for Name: laboratory_evaluation; Type: TABLE DATA; Schema: public; Owner: hceres
--



--
-- TOC entry 3785 (class 0 OID 24789)
-- Dependencies: 234
-- Data for Name: laboratory_evaluation_role; Type: TABLE DATA; Schema: public; Owner: hceres
--



--
-- TOC entry 3786 (class 0 OID 24792)
-- Dependencies: 235
-- Data for Name: language; Type: TABLE DATA; Schema: public; Owner: hceres
--

INSERT INTO public.language (language_id, language_name) VALUES (1, 'Français');
INSERT INTO public.language (language_id, language_name) VALUES (2, 'English');


--
-- TOC entry 3787 (class 0 OID 24795)
-- Dependencies: 236
-- Data for Name: learned_scientific_society; Type: TABLE DATA; Schema: public; Owner: hceres
--



--
-- TOC entry 3788 (class 0 OID 24798)
-- Dependencies: 237
-- Data for Name: learned_scientific_society_role; Type: TABLE DATA; Schema: public; Owner: hceres
--



--
-- TOC entry 3789 (class 0 OID 24801)
-- Dependencies: 238
-- Data for Name: mail_activity; Type: TABLE DATA; Schema: public; Owner: hceres
--



--
-- TOC entry 3790 (class 0 OID 24804)
-- Dependencies: 239
-- Data for Name: mail_template; Type: TABLE DATA; Schema: public; Owner: hceres
--



--
-- TOC entry 3791 (class 0 OID 24810)
-- Dependencies: 240
-- Data for Name: meeting; Type: TABLE DATA; Schema: public; Owner: hceres
--

INSERT INTO public.meeting (meeting_id, neeting_name, meeting_year, meeting_location, meeting_start, meeting_end) VALUES (1, 'VDSV', -4, 'Dv', '2022-03-13', '2022-03-30');
INSERT INTO public.meeting (meeting_id, neeting_name, meeting_year, meeting_location, meeting_start, meeting_end) VALUES (2, 'VDSV', -4, 'Dv', '2022-03-13', '2022-03-30');
INSERT INTO public.meeting (meeting_id, neeting_name, meeting_year, meeting_location, meeting_start, meeting_end) VALUES (3, 'VDSV', -1, 'Dv', '2022-03-27', '2022-03-28');
INSERT INTO public.meeting (meeting_id, neeting_name, meeting_year, meeting_location, meeting_start, meeting_end) VALUES (4, 'VDSV', -1, 'Dv', '2022-03-25', '2022-03-25');


--
-- TOC entry 3792 (class 0 OID 24816)
-- Dependencies: 241
-- Data for Name: meeting_congress_org; Type: TABLE DATA; Schema: public; Owner: hceres
--



--
-- TOC entry 3793 (class 0 OID 24819)
-- Dependencies: 242
-- Data for Name: national_international_collaboration; Type: TABLE DATA; Schema: public; Owner: hceres
--

INSERT INTO public.national_international_collaboration (id_activity, type_collab_id, date_project_start, partner_entity, country_state_city, pi_partners, mail_partners, projetc_title, strategic_recurring_collab, active_project, associated_funding, number_resulting_publications, ref_joint_publication, umr_coordinated, agreement_signed) VALUES (593, 2, '2022-03-27', 'df', 'vsv', '1', 'qv', 'sq', false, false, 'qsx', -1, 'qsc', false, false);


--
-- TOC entry 3794 (class 0 OID 24825)
-- Dependencies: 243
-- Data for Name: nationality; Type: TABLE DATA; Schema: public; Owner: hceres
--

INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (1, 'Afghan');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (2, 'Albanais');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (3, 'Algerien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (4, 'Allemand');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (5, 'Americain');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (6, 'Andorran');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (7, 'Angolais');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (8, 'Antigua');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (9, 'Antillais');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (10, 'Apatride');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (11, 'Arabe');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (12, 'Argentin');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (13, 'Armenien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (14, 'Australien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (15, 'Autre Nationalite');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (16, 'Autrichien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (17, 'Azerbaïdjanais');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (18, 'Bahaméen');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (19, 'Bahrein');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (20, 'Barbade');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (21, 'Belaruss');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (22, 'Belge');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (23, 'Belize');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (24, 'Bengladeshi');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (25, 'Beninois');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (26, 'Bhoutanais');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (27, 'Birman');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (28, 'Bolivien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (29, 'Bosniaque');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (30, 'Botswanais');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (31, 'Bresilien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (32, 'Britannique');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (33, 'Brunei Darussalam');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (34, 'Bulgare');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (35, 'Burkinabé');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (36, 'Burundais');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (37, 'Cambodgien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (38, 'Camerounais');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (39, 'Canadien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (40, 'Capverdien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (41, 'Centrafricai');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (42, 'Chilien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (43, 'Chinois');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (44, 'Chypriote');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (45, 'Colombien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (46, 'Comorien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (47, 'Congolais');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (48, 'Costa Ricai');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (49, 'Croate');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (50, 'Cubain');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (51, 'Danois');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (52, 'Djiboutien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (53, 'Dominicai');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (54, 'Dominicain');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (55, 'Egyptien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (56, 'Equato-guineen');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (57, 'Equatorien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (58, 'Erytreen');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (59, 'Espagnole');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (60, 'Estonien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (61, 'Ethiopien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (62, 'Etranger sans autre indication');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (63, 'Fidjien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (64, 'Finlandais');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (65, 'Français');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (66, 'Gabonais');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (67, 'Gambien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (68, 'Georgien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (69, 'Ghanéen');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (70, 'Gibraltar');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (71, 'Grecque');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (72, 'Grenade');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (73, 'Grenadin');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (74, 'Groenlandais');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (75, 'Guatémaltèque');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (76, 'Guineen');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (77, 'Guyanais');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (78, 'Haïtien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (79, 'Hondurien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (80, 'Hongrois');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (81, 'Indien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (82, 'Indonésien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (83, 'Irakien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (84, 'Iranien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (85, 'Irlandais');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (86, 'Islandais');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (87, 'Israëlien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (88, 'Italien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (89, 'Ivoirien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (90, 'Jamaicai');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (91, 'Japonais');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (92, 'Jordanien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (93, 'Kazaque');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (94, 'Kenya');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (95, 'Kirghis');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (96, 'Kiribati');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (97, 'Kosovar');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (98, 'Koweitien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (99, 'Laotien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (100, 'Lesotho');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (101, 'Letto');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (102, 'Libanais');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (103, 'Libérien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (104, 'Libyen');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (105, 'Liechtensteinien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (106, 'Lithuanien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (107, 'Luxembourgeois');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (108, 'Malaisien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (109, 'Malawien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (110, 'Maldivais');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (111, 'Malgache');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (112, 'Malien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (113, 'Maltais');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (114, 'Marocain');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (115, 'Mauricien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (116, 'Mauritanien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (117, 'Mexicain');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (118, 'Moldave');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (119, 'Monegasque');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (120, 'Mongole');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (121, 'Montenegro');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (122, 'Mozambicai');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (123, 'Namibien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (124, 'Nauru');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (125, 'Neerlandais');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (126, 'Neozelandais');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (127, 'Nepalais');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (128, 'Nicaraguayen');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (129, 'Nigeria');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (130, 'Nigérien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (131, 'Nord-Coréen');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (132, 'Norvegien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (133, 'Omanais');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (134, 'Ougandais');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (135, 'Ouzbèque');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (136, 'Pakistanais');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (137, 'Palestinien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (138, 'Panaméen');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (139, 'Papoue');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (140, 'Paraguayen');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (141, 'Peruvien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (142, 'Philippin');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (143, 'Polonais');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (144, 'Portugais');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (145, 'Qatari');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (146, 'Roumain');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (147, 'Russe');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (148, 'Rwandais');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (149, 'Sainte Helenite');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (150, 'Sainte Lucien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (151, 'Salomon');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (152, 'Salvadorien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (153, 'Samoen');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (154, 'San-Marinais');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (155, 'Sao Toméen');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (156, 'Senegalais');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (157, 'Séoudien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (158, 'Serbe');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (159, 'Seychellois');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (160, 'Sierra-leonais');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (161, 'Singapourien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (162, 'Slovaque');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (163, 'Slovene');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (164, 'Somalien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (165, 'Soudanais');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (166, 'Sri-Lankais');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (167, 'Sud-Africain');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (168, 'Sud-Coréen');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (169, 'Suedois');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (170, 'Suisse');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (171, 'Surinamien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (172, 'Swaeiland');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (173, 'Syrien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (174, 'Tadjique');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (175, 'Taiwanais');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (176, 'Tanzanien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (177, 'Tchadien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (178, 'Tcheque');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (179, 'Thaïlandais');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (180, 'Togolais');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (181, 'Tongéen');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (182, 'Trinideen');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (183, 'Tunisien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (184, 'Turkme');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (185, 'Turque');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (186, 'Tuvalu');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (187, 'Ukrainien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (188, 'Uruguayen');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (189, 'Vanuatu');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (190, 'Vatican');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (191, 'Vénézuélien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (192, 'Vietnamien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (193, 'Yemenite');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (194, 'Yougoslave');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (195, 'Zambien');
INSERT INTO public.nationality (nationality_id, nationality_name) VALUES (196, 'Zimbabwen');


--
-- TOC entry 3795 (class 0 OID 24828)
-- Dependencies: 244
-- Data for Name: network; Type: TABLE DATA; Schema: public; Owner: hceres
--

INSERT INTO public.network (id_activity, start_date, name_network, active_network, associated_funding, nb_resulting_publications, ref_resulting_publications, umr_coordinated, agreement_signed) VALUES (512, '2022-02-27', 'new', false, 'test', 5, 'hceres', false, false);


--
-- TOC entry 3796 (class 0 OID 24834)
-- Dependencies: 245
-- Data for Name: oral_communication; Type: TABLE DATA; Schema: public; Owner: hceres
--

INSERT INTO public.oral_communication (id_activity, oral_communication_title, type_oral_communication_id, oral_communication_dat, meeting_id, authors) VALUES (579, ' wdc', 1, '2022-03-27', 1, 'vqDV');
INSERT INTO public.oral_communication (id_activity, oral_communication_title, type_oral_communication_id, oral_communication_dat, meeting_id, authors) VALUES (580, ' wdc', 2, '2022-03-27', 2, 'vqDV');
INSERT INTO public.oral_communication (id_activity, oral_communication_title, type_oral_communication_id, oral_communication_dat, meeting_id, authors) VALUES (585, ' wdc', 3, '2022-03-27', 3, 'vqDV');
INSERT INTO public.oral_communication (id_activity, oral_communication_title, type_oral_communication_id, oral_communication_dat, meeting_id, authors) VALUES (606, ' wdc', 4, '2022-03-31', 4, 'vqDV');


--
-- TOC entry 3797 (class 0 OID 24840)
-- Dependencies: 246
-- Data for Name: outgoing_mobility; Type: TABLE DATA; Schema: public; Owner: hceres
--



--
-- TOC entry 3798 (class 0 OID 24846)
-- Dependencies: 247
-- Data for Name: parameter; Type: TABLE DATA; Schema: public; Owner: hceres
--

INSERT INTO public.parameter (parameter_id, parameter_name, parameter_value) VALUES (1, 'loadCsv', 'true');


--
-- TOC entry 3799 (class 0 OID 24852)
-- Dependencies: 248
-- Data for Name: patent; Type: TABLE DATA; Schema: public; Owner: hceres
--



--
-- TOC entry 3800 (class 0 OID 24861)
-- Dependencies: 249
-- Data for Name: phd_associated_company; Type: TABLE DATA; Schema: public; Owner: hceres
--



--
-- TOC entry 3801 (class 0 OID 24864)
-- Dependencies: 250
-- Data for Name: phd_student; Type: TABLE DATA; Schema: public; Owner: hceres
--



--
-- TOC entry 3802 (class 0 OID 24871)
-- Dependencies: 251
-- Data for Name: phd_type; Type: TABLE DATA; Schema: public; Owner: hceres
--

INSERT INTO public.phd_type (phd_type_id, phd_type_name) VALUES (1, 'Academic');
INSERT INTO public.phd_type (phd_type_id, phd_type_name) VALUES (2, 'CIFRE');


--
-- TOC entry 3803 (class 0 OID 24874)
-- Dependencies: 252
-- Data for Name: platform; Type: TABLE DATA; Schema: public; Owner: hceres
--

INSERT INTO public.platform (id_activity, creation_date, description, managers, affiliation, labellisation, open_private_researchers) VALUES (541, '2022-03-05', 'test', 'test2', 'test1', 'hsg', false);
INSERT INTO public.platform (id_activity, creation_date, description, managers, affiliation, labellisation, open_private_researchers) VALUES (542, '2022-03-05', 'test', 'test2', 'test1', 'hsg', false);
INSERT INTO public.platform (id_activity, creation_date, description, managers, affiliation, labellisation, open_private_researchers) VALUES (546, '2022-03-05', NULL, NULL, NULL, NULL, false);
INSERT INTO public.platform (id_activity, creation_date, description, managers, affiliation, labellisation, open_private_researchers) VALUES (547, '2022-03-05', NULL, NULL, NULL, NULL, false);
INSERT INTO public.platform (id_activity, creation_date, description, managers, affiliation, labellisation, open_private_researchers) VALUES (548, '2022-03-05', NULL, NULL, NULL, NULL, false);
INSERT INTO public.platform (id_activity, creation_date, description, managers, affiliation, labellisation, open_private_researchers) VALUES (549, '2022-03-05', NULL, NULL, NULL, NULL, false);
INSERT INTO public.platform (id_activity, creation_date, description, managers, affiliation, labellisation, open_private_researchers) VALUES (581, '2022-03-27', 'test', 'test2', 'test1', 'hsg', false);
INSERT INTO public.platform (id_activity, creation_date, description, managers, affiliation, labellisation, open_private_researchers) VALUES (582, '2022-03-27', 'test', 'test2', 'test1', 'hsg', false);
INSERT INTO public.platform (id_activity, creation_date, description, managers, affiliation, labellisation, open_private_researchers) VALUES (583, '2022-03-30', 'test', 'test2', 'test1', 'hsg', false);
INSERT INTO public.platform (id_activity, creation_date, description, managers, affiliation, labellisation, open_private_researchers) VALUES (584, '2022-03-30', 'qcdC', 'test2', 'hhhh', 'hsg', false);
INSERT INTO public.platform (id_activity, creation_date, description, managers, affiliation, labellisation, open_private_researchers) VALUES (596, '2022-03-27', 'hg', 'sdjsdc', 'scdj', 'hqSDJ', false);
INSERT INTO public.platform (id_activity, creation_date, description, managers, affiliation, labellisation, open_private_researchers) VALUES (597, '2022-03-27', 'hg', 'sdjsdc', 'scdj', 'hqSDJ', false);
INSERT INTO public.platform (id_activity, creation_date, description, managers, affiliation, labellisation, open_private_researchers) VALUES (605, '2022-03-31', 'test', 'sdjsdc', 'test1', 'hsg', false);


--
-- TOC entry 3804 (class 0 OID 24880)
-- Dependencies: 253
-- Data for Name: post_doc; Type: TABLE DATA; Schema: public; Owner: hceres
--

INSERT INTO public.post_doc (id_activity, name_post_doc, name_supervisor, arrival_date, departure_date, duration, nationality, original_lab, associated_funding, associated_publi_ref) VALUES (576, 'test 1', 'sup1', '2022-03-15', '2022-03-07', 15, 'nat1', 'lab1', NULL, 'vv');


--
-- TOC entry 3805 (class 0 OID 24886)
-- Dependencies: 254
-- Data for Name: project_evaluation; Type: TABLE DATA; Schema: public; Owner: hceres
--



--
-- TOC entry 3806 (class 0 OID 24892)
-- Dependencies: 255
-- Data for Name: project_evaluation_category; Type: TABLE DATA; Schema: public; Owner: hceres
--



--
-- TOC entry 3807 (class 0 OID 24895)
-- Dependencies: 256
-- Data for Name: project_evaluation_role; Type: TABLE DATA; Schema: public; Owner: hceres
--



--
-- TOC entry 3808 (class 0 OID 24898)
-- Dependencies: 257
-- Data for Name: public_outreach; Type: TABLE DATA; Schema: public; Owner: hceres
--



--
-- TOC entry 3809 (class 0 OID 24901)
-- Dependencies: 258
-- Data for Name: public_outreach_type; Type: TABLE DATA; Schema: public; Owner: hceres
--



--
-- TOC entry 3810 (class 0 OID 24904)
-- Dependencies: 259
-- Data for Name: publication; Type: TABLE DATA; Schema: public; Owner: hceres
--

INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (210, 'Pharmacological Induction of Heme Oxygenase-1 Impairs Nuclear Accumulation ofHerpes Simplex Virus Capsids upon Infection', 'Ibáñez FJ, Farías MA, Retamal-Díaz A, Espinoza JA, Kalergis AM, González PA', 'Front Microbiol', '0017-01-01', 1, '29163402', 4.259);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (19, 'Transplant nephrectomy after graft failure: is it so risky? Impact on morbidity, mortality and alloimmunization', 'Chowaniec Y, Luyckx F, Karam G, Glemain P, Dantal J, Rigaud J, Branchereau J', 'Int Urol Nephrol', '0018-01-01', 1, '30120679', 1.596);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (454, 'Rituximab-based first line treatment for chronic GVHD after allogeneicSCT: results of a phase 2 study', 'Malard F, Labopin M, Yakoub-Agha I, Chantepie S, Guillaume T, Blaise D,Tabrizi R, Magro L, Vanhove B, Blancho G, Moreau P, Gaugler B, Chevallier P,Mohty M', 'Blood', '0017-01-01', 1, '28864814', 16.562);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (24, 'A pilot study comparing corifollitropin alfa associated with hp-HMG versus highdose rFSH antagonist protocols for ovarian stimulation in poor responders', 'Mendret-Pellerin S, Leperlier F, Reignier A, Lefebvre T, Barrière P, Freour T', 'HUM FERTIL', '0018-01-01', 1, '30129813', 1.803);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (25, 'Should artificial shrinkage be performed prior to blastocyst vitrification? A systematic review of the literature and meta-analysis.', 'Boyard J, Reignier A, Chtourou S, Lefebvre T, Barrière P, Fréour T.', 'Hum FertIL', '0020-01-01', 1, '31973647', 1.803);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (455, 'Modulation of HostImmunity by the Human Metapneumovirus', 'Céspedes PF, Palavecino CE, Kalergis AM, Bueno SM', 'Clin Microbiol Rev', '0016-01-01', 1, '27413096', 17.75);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (7, '[Update in severe asthma physiopathology and treatments]', 'Hassoun D, Moui A, Colas L, Blanc FX, Magnan A', 'Rev Med Interne', '0019-01-01', 1, '31128859', 0.81);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (14, 'The autoimmune concept of multiplesclerosis', 'Nicol B, Salou M, Laplaud DA, Wekerle H', 'Presse Med', '0015-01-01', 1, '25813101', 1.167);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (26, 'Embryo development, fetal growthand postnatal phenotype of eGFP lambs generated by lentiviral transgenesis', 'Crispo M, Vilariño M, dos Santos-Neto PC, Núñez-Olivera R, Cuadro F, Barrera N, Mulet AP, Nguyen TH, Anegón I, Menchaca A', 'Transgenic Res', '0015-01-01', 1, '25048992', 1.817);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (211, 'Extracellular hemoglobincombined with an O(2) -generating material overcomes O(2) limitation in thebioartificial pancreas', 'Mouré A, Bacou E, Bosch S, Jegou D, Salama A, Riochet D, Gauthier O, BlanchoG, Soulillou JP, Poncelet D, Olmos E, Bach JM, Mosser M', 'Biotechnol Bioeng', '0018-01-01', 1, '30593660', 4.26);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (453, 'Larger number of invariant natural killer T cells in PBSCallografts correlates with improved GVHD-free and progression-free survival', 'Malard F, Labopin M, Chevallier P, Guillaume T, Duquesne A, Rialland F,Derenne S, Peterlin P, Leauté AG, Brissot E, Gregoire M, Moreau P, Saas P,Gaugler B, Mohty M', 'Blood', '0016-01-01', 1, '26903546', 16.562);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (15, 'Multiple sclerosis: From new concepts to updates on management', 'Laplaud DA', 'Presse Med', '0015-01-01', 1, '25823830', 1.167);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (4, '[Renal transplantation on vascular prosthesis]', 'Nédélec M, Glémain P, Rigaud J, Karam G, Thuret R, Badet L, Kleinclauss F, Timsit MO, Branchereau J', 'Prog Urol', '0019-01-01', 1, '31447181', 0.586);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (9, 'Balancing the genetic risk of APOL1 kidney diseasevariants', 'Kaboré NF, Limou S', 'Nephrol Ther', '0019-01-01', 1, '30981400', 0.812);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (10, '[Clinical approach to primary membranoproliferativeglomerulonephritis]', 'Fakhouri F', 'Nephrol Ther', '0016-01-01', 1, '26972096', 0.812);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (16, 'Understanding Lung Immunopathology Caused by the Human Metapneumovirus:Implications for Rational Vaccine Design', 'Palavecino CE, Cespedes PF, Lay MK, Riedel CA, Kalergis AM, Bueno SM', 'Crit Rev Immunol', '0015-01-01', 1, '26559227', 1.191);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (17, 'Pregnancy-related thrombotic microangiopathies: Clues fromcomplement biology', 'Fakhouri F', 'Transfus Apher Sci', '0016-01-01', 1, '27158062', 1.412);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (21, 'Inflammatory optic neuropathy in granulomatosis with polyangiitis can mimick isolated idiopathic optic neuritis', 'Clément M, Néel A, Toulgoat F, Weber M, Godmer P, Hutin P, Hamidou M, Lebranchu P', 'Eur J Ophthalmol', '0019-01-01', 1, '31744325', 1.716);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (22, 'Immediate Loading of Two Unsplinted Implants in Edentulous Patients with Mandibular Overdentures: A 10-year Retrospective Review of Patients from a Previously Conducted 1-year Cohort Study', 'Rignon-Bret C, Wulfman C, Hadida A, Renouard F, Gourraud PA, Naveau A.', 'INT J ORAL MAX IMPL', '0019-01-01', 1, '30695092', 1.734);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (23, 'Can we extrapolate from a Cmah (-/-) Ldlr (-/-) mouse model a susceptibility for atherosclerosis in humans?', 'Soulillou JP, Cozzi E, Galli C, Bach JM.', 'P NATL ACAD SCI USA', '0020-01-01', 1, '31964838', 1.803);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (27, 'Transgenic animals and genetic engineering techniques Nantes, France, 2-3 July, 2015', 'Ménoret S, Tesson L, Remy S, Usal C, Ouisse LH, Brusselle L, Chenouard V,Nguyen TH, David L, Anegon I', 'Transgenic Res', '0015-01-01', 1, '26358113', 1.817);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (5, '[Next generation of anti-immune checkpoints antibodies].', 'Bonnefoy N, Olive D, Vanhove B.', 'M S-MED SCI', '0019-01-01', 1, '31903901', 0.661);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (12, 'Differentiation of human dendritic cell subsets forimmune tolerance induction', 'Deluce-Kakwata-Nkor N, Lamendour L, Chabot V, Héraud A, Ivanovic Z, Halary F,Dehaut F, Velge-Roussel F', 'Transfus Clin Biol', '0018-01-01', 1, '28967606', 1.029);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (6, '[Key role of allopeptide-specificCD8(+) Tregs in transplantation]', 'Picarda É, Ossart J, Bézie S, Guillonneau C', 'M S-MED SCI', '0015-01-01', 1, '25658725', 0.661);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (13, 'Early and irreversible recurrenceMPO-ANCA-positive glomerulonephritis after renal transplantation', 'Le Berre L, Dufay A, Cantarovich D, Meurette A, Audrain M, Giral M, BlanchoG, Fakhouri F, Hourmant M, Dantal J', 'Clin Nephrol', '0015-01-01', 1, '25345380', 1.079);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (18, 'Study of the impacts of patient-educators on the course of basic sciences in dental studies', 'Renard E, Alliot-Licht B, Gross O, Roger-Leroi V, Marchand C', 'Eur J Dent Educ', '0015-01-01', 1, '24628743', 1.531);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (20, 'Living-donor kidney transplantation: comparison of sequential and simultaneous surgical organizations', 'Prudhomme T, Benoit T, Mittal S, Roumiguié M, Mesnard B, Broudeur L, Kervella D, Sallusto F, Doumerc N, Binhazzaa M, Iborra F, Soulié M, Blancho G, Kamar N, Thuret R, Karam G, Gamé X, Branchereau J', 'Int Urol Nephrol', '0020-01-01', 1, '31894558', 1.596);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (28, 'Advances in transgenic animal models and techniques', 'Ménoret S, Tesson L, Remy S, Usal C, Ouisse LH, Brusselle L, Chenouard V, Anegon I', 'Transgenic Res', '0017-01-01', 1, '28780744', 1.817);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (29, 'Automated and manual sperm analysis: united we stand, divided wefall', 'Freour T', 'ANDROLOGIA', '0015-01-01', 1, '26234376', 1.84);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (30, 'Sperm cryopreservation and assisted reproductive technology outcome in patients with spinal cord injury', 'Reignier A, Lammers J, Splingart C, Redhead D, Labat JJ, Mirallié S, Barrière P, Freour T', 'Andrologia', '0017-01-01', 1, '28718894', 1.84);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (227, 'The Medawar Prize Acceptance Speech 2016', 'Soulillou JP', 'Transplantation', '0016-01-01', 1, '27820778', 4.593);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (31, 'An R(2) -curve for evaluating the accuracyof dynamic predictions', 'Fournier MC, Dantan E, Blanche P', 'Stat Med', '0017-01-01', 1, '29205452', 1.847);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (32, 'Inverse probability weighting tocontrol confounding in an illness-death model for interval-censored data', 'Gillaizeau F, Sénage T, Le Borgne F, Le Tourneau T, Roussel JC, Leffondrè K,Porcher R, Giraudeau B, Dantan E, Foucher Y', 'Stat Med', '0018-01-01', 1, '29205409', 1.847);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (467, 'Multiple sclerosis genomic map implicates peripheral immune cells and microglia in susceptibility', 'International Multiple Sclerosis Genetics Consortium', 'Science', '0019-01-01', 1, '31604244', 41.037);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (228, 'Anti-Gal and anti-Neu5Gc responses innonimmunosuppressed patients following treatment with rabbit anti-thymocytepolyclonal IgGs', 'Salama A, Evanno G, Lim N, Rousse J, Le Berre L, Nicot A, Brouard S, HarrisKM, Ehlers MR, Gitelman SE, Soulillou JP', 'Transplantation', '0017-01-01', 1, '28198767', 4.593);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (229, 'Differential modulation of donor-specific antibodiesafter B-cell depleting therapies to cure chronic antibody mediated rejection', 'Touzot M, Couvrat-Desvergnes G, Castagnet S, Cesbron A, Renaudin K,Cantarovich D, Giral M', 'Transplantation', '0015-01-01', 1, '25029384', 4.593);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (230, '23rd NantesActualités Transplantation: "Genomics and Immunogenetics of Kidney andInflammatory Diseases - Lessons for Transplantation"', 'Vince N, Poschmann J, Josien R, Anegon I, Limou S, Gourraud PA', 'Transplantation', '0019-01-01', 1, '30399125', 4.593);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (231, 'New humanized mouse model of bronchiolitis obliterans syndrome', 'Anegon I', 'Transplantation', '0015-01-01', 1, '25695785', 4.593);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (232, 'Efficacy of Myeloid Derived Suppressor Cells on TransplantSurvival', 'Guillonneau C', 'Transplantation', '0015-01-01', 1, '26270450', 4.593);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (236, '21st Nantes Actualités Transplantation: "When Stem Cells Meet Immunology"', 'Anegon I, Nguyen TH', 'Transplantation', '0017-01-01', 1, '27653295', 4.593);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (237, 'Improved Analyses of CD8+ T CellSpecificities Using Multimers of Peptide MHC Complexes Coupled to DNA Barcodes', 'Guillonneau C, David L, Anegon I', 'Transplantation', '0017-01-01', 1, '28118315', 4.593);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (252, 'Impactof pre-transplant diffusion lung capacity for nitric oxide (DLNO) and ofDLNO/pre-transplant diffusion lung capacity for carbon monoxide (DLNO/DLCO) ratioon pulmonary outcomes in adults receiving allogeneic stem cell transplantationfor hematological diseases', 'Le Bourgeois A, Malard F, Chevallier P, Urbistandoy G, Guillaume T, Delaunay J, Peterlin P, Lemarchand P, Germaud P, Mohty M, Moreau P, Chambellan A', 'BONE MARROW TRANSPL', '0016-01-01', 1, '26595083', 4.674);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (253, 'Deconditioning, fatigue and impaired quality of life in long-term survivors after allogeneic hematopoietic stem cell transplantation', 'Dirou S, Chambellan A, Chevallier P, Germaud P, Lamirault G, Gourraud P-A, Perrot B, Delasalle B, Forestier B, Guillaume T, Peterlin P, Garnier A, Magnan A, Blanc F-X, Lemarchand P.', 'Bone Marrow Transplant', '0018-01-01', 1, '29269801', 4.674);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (254, 'Immune monitoring in renal transplantation:The search for biomarkers', 'Danger R, Sawitzki B, Brouard S', 'Eur J Immunol', '0016-01-01', 1, '27861809', 4.695);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (465, 'Targeting TMEM176B Enhances Antitumor Immunity and Augments the Efficacy of Immune Checkpoint Blockers by Unleashing Inflammasome Activation', 'Segovia M, Russo S, Jeldres M, Mahmoud YD, Perez V, Duhalde M, Charnet P, Rousset M, Victoria S, Veigas F, Louvet C, Vanhove B, Floto RA, Anegon I, Cuturi MC, Girotti MR, Rabinovich GA, Hill M', 'Cancer Cell', '0019-01-01', 1, '31085177', 23.916);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (233, 'Infectious Diseases in Transplantation--Report of the20th Nantes Actualités Transplantation Meeting', 'Haspot F, Halary FA', 'Transplantation', '0015-01-01', 1, '26627674', 4.593);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (60, 'Antigen-specific single Bcell sorting and expression-cloning from immunoglobulin humanized rats: a rapidand versatile method for the generation of high affinity and discriminative humanmonoclonal antibodies', 'Ouisse LH, Gautreau-Rolland L, Devilder MC, Osborn M, Moyon M, Visentin J,Halary F, Bruggemann M, Buelow R, Anegon I, Saulquin X', 'BMC Biotechnol', '0017-01-01', 1, '28081707', 2.303);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (234, 'Comparative Study of the Immunoregulatory Capacity of In Vitro Generated Tolerogenic Dendritic Cells,Suppressor Macrophages, and Myeloid-Derived Suppressor Cells', 'Carretero-Iglesia L, Bouchet-Delbos L, Louvet C, Drujont L, Segovia M, MerieauE, Chiffoleau E, Josien R, Hill M, Cuturi MC, Moreau A', 'Transplantation', '0016-01-01', 1, '27653226', 4.593);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (420, 'B cell depletion therapy dampens CD8+ T cell response in ANCA-associated vasculitis', 'Néel A, Bucchia M, Néel M, Tilly G, Caristan A, Yap M, Rimbert M, Bruneau S, Cadoux M, Agard C, Hourmant M, Godmer P, Brouard S, Bressollette C, Hamidou M, Josien R, Fakhouri F, Degauque N', 'Arthritis Rheumatol', '0019-01-01', 1, '30375745', 9.002);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (11, 'In Vitro and In Vivo Assessment of T, B andMyeloid Cells Suppressive Activity and Humoral Responses from TransplantRecipients', 'Bézie S, Usal C, Guillonneau C', 'J VISUAL-JAPAN', '0017-01-01', 1, '28829428', 0.879);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (63, 'Ex-situ hypothermic perfusion of non-human primate pancreas: A feasibility study', 'Prudhomme T, Renaudin K, Lo Faro L, Cantarovich D, Kervella D, Minault D, Hervouet J, Le Bas-Bernardet S, Karam G, Blancho G, Branchereau J', 'ARTIF ORGANS', '0020-01-01', 1, '', 2.379);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (69, 'A quick and robust MHC typing method forfree-ranging and captive primate species', 'de Groot N, Stanbury K, de Vos-Rouweler AJ, de Groot NG, Poirier N, Blancho G,de Luna C, Doxiadis GG, Bontrop RE', 'Immunogenetics', '0017-01-01', 1, '28084496', 2.492);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (255, 'Human metapneumovirus infection activates the TSLP pathwaythat drives excessive pulmonary inflammation and viral replication in mice', 'Lay MK, Céspedes PF, Palavecino CE, León MA, Díaz RA, Salazar FJ, Méndez GP, Bueno SM, Kalergis AM', 'Eur J Immunol', '0015-01-01', 1, '25763996', 4.695);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (354, 'Prospective evaluationof serum anti-Müllerian hormone dynamics in 250 women of reproductive age treatedwith chemotherapy for breast cancer', 'Dezellus A, Barriere P, Campone M, Lemanski C, Vanlemmens L, Mignot L,Delozier T, Levy C, Bendavid C, Debled M, Bachelot T, Jouannaud C, Loustalot C,Mouret-Reynier MA, Gallais-Umbert A, Masson D, Freour T', 'Eur J Cancer', '0017-01-01', 1, '28463758', 6.68);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (66, 'A multistate additive relativesurvival semi-Markov model', 'Gillaizeau F, Dantan E, Giral M, Foucher Y', 'Stat Methods Med Res', '0017-01-01', 1, '26056059', 2.388);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (35, 'IgG? light and heavy chain amyloidosis secondary to a B-cell lymphoproliferative disorder, whole picture on a renal biopsy', 'Ville S, Kandel C, Delaunay J, Cantarovich D', 'Nephrology', '0019-01-01', 1, '31726478', 1.913);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (70, 'MHC class I diversity of olive baboons (Papio anubis)unravelled by next-generation sequencing', 'van der Wiel MKH, Doxiadis GGM, de Groot N, Otting N, de Groot NG, Poirier N, Blancho G, Bontrop RE', 'Immunogenetics', '0018-01-01', 1, '29478145', 2.492);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (256, 'Carbon monoxide impairsmitochondria-dependent endosomal maturation and antigen presentation in dendriticcells', 'Riquelme SA, Pogu J, Anegon I, Bueno SM, Kalergis AM', 'Eur J Immunol', '0015-01-01', 1, '26461179', 4.695);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (297, 'Limited presence of IL-22 binding protein, a natural IL-22 inhibitor, strengthens psoriatic skin inflammation.', 'Martin JC, Wolk K, Beriou G, Abidi A, Witte-Händel E, Louvet C, Kokolakis G, Drujont L, Dumoutier L, Renauld JC, Sabat, R, Josien R.', 'J Immunol', '0017-01-01', 1, '28356382', 4.718);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (389, 'Recruitment of CXCR3(+) T cells into injured tissues in adult IgA vasculitis patients correlates with disease activity', 'Audemard-Verger A, Pillebout E, Jamin A, Berthelot L, Aufray C, Martin B,Sannier A, Daugas E, Déchanet-Merville J, Richard Y, Monteiro R, Lucas B', 'J Autoimmun', '0019-01-01', 1, '30745186', 7.543);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (406, 'Atypical hemolytic uremic syndrome and C3glomerulopathy: conclusions from a "Kidney Disease: Improving Global Outcomes"(KDIGO) Controversies Conference', 'Goodship TH, Cook HT, Fakhouri F, Fervenza FC, Frémeaux-Bacchi V, Kavanagh D, Nester CM, Noris M, Pickering MC, Rodríguez de Córdoba S, Roumenina LT, Sethi S, Smith RJ; Conference Participants', 'Kidney Int', '0017-01-01', 1, '27989322', 8.306);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (67, 'Clinical contribution of myositis-related antibodies detected byimmunoblot to idiopathic inflammatory myositis: A one-year retrospective study', 'Lecouffe-Desprets M, Hémont C, Néel A, Toquet C, Masseau A, Hamidou M, Josien R, Martin JC', 'Autoimmunity', '0018-01-01', 1, '29463118', 2.403);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (3, '[Pyelo-ureteral anastomosis, for stenosis of the kidney transplantureter, by laparoscopic approach with robotic assistance]', 'Hedhli O, Karam G, de Vergie S, Nedellec M, Lefevre M, Bouchot O, Rigaud J,Branchereau J', 'Prog Urol', '0018-01-01', 1, '30217430', 0.586);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (37, 'Association between early ?hCG kinetics, blastocyst morphology and pregnancyoutcome in a single-blastocyst transfer program', 'Girard JM, Simorre M, Leperlier F, Reignier A, Lefebvre T, Barriere P, Freour T', 'EUR J OBSTET GYN R B', '0018-01-01', 1, '29734084', 2.024);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (72, 'Modulating the function of the immune system by thyroidhormones and thyrotropin', 'Jara EL, Muñoz-Durango N, Llanos C, Fardella C, González PA, Bueno SM,Kalergis AM, Riedel CA', 'Immunol Lett', '0017-01-01', 1, '28216261', 2.552);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (347, 'Horizontal mixture model for competing risks: a method used inwaitlisted renal transplant candidates', 'Trébern-Launay K, Kessler M, Bayat-Makoei S, Quérard AH, Briançon S, Giral M, Foucher Y', 'Eur J Epidemiol', '0017-01-01', 1, '29086099', 6.529);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (38, 'The EKiTE network (epidemiology in kidney transplantation - a European validated database): an initiative epidemiological and translational European collaborative research', 'Lorent M, Foucher Y, Kerleau K, Brouard S, Baayen C, Lebouter S, Naesens M, Bestard Matamoros O, Åsberg A, Giral M; EKiTE consortium', 'BMC Nephrol', '0019-01-01', 1, '31601177', 2.088);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (73, 'The killerimmunoglobulin-like receptor KIR3DL1 in combination with HLA-Bw4 is protectiveagainst multiple sclerosis in African Americans', 'Hollenbach JA, Pando MJ, Caillier SJ, Gourraud PA, Oksenberg JR', 'Genes Immun', '0016-01-01', 1, '26866467', 2.631);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (68, 'Comparison of longitudinal quality of life outcomes in preemptive and dialyzed patients on waiting list for kidney transplantation', 'Auneau-Enjalbert L, Hardouin J-B, Blanchin M, Giral M, Morelon E, Cassuto E, Meurette A, Sébille V.', 'Qual Life Res', '0019-01-01', 1, '31784856', 2.488);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (96, 'Does sperm origin affect embryo morphokinetic parameters?', 'Lammers J, Reignier A, Splingart C, Catteau A, David L, Barriere P, Freour T', 'J ASSIST REPROD GEN', '0015-01-01', 1, '26109332', 2.82);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (105, 'Adverse pregnancy and neo-nataloutcomes after assisted reproductive treatment in patients with pelvicendometriosis: a case-control study', 'Jacques M, Freour T, Barriere P, Ploteau S', 'Reprod Biomed Online', '0016-01-01', 1, '27068240', 2.93);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (106, 'Can time-lapse parameters predictembryo ploidy? A systematic review', 'Reignier A, Lammers J, Barriere P, Freour T', 'Reprod Biomed Online', '0018-01-01', 1, '29398421', 2.93);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (259, 'Regulation of the Immune Response by theInflammatory Metabolic Microenvironment in the Context of Allotransplantation', 'Degauque N, Brosseau C, Brouard S', 'Front Immunol', '0018-01-01', 1, '29988548', 4.716);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (279, 'Ex Vivo Expanded Human Non-Cytotoxic CD8(+)CD45RC(low/-) Tregs Efficiently Delay Skin Graft Rejection and GVHD in Humanized Mice', 'Bézie S, Meistermann D, Boucault L, Kilens S, Zoppi J, Autrusseau E, DonnartA, Nerrière-Daguin V, Bellier-Waast F, Charpentier E, Duteille F, David L, AnegonI, Guillonneau C', 'Front Immunol', '0017-01-01', 1, '29445370', 4.716);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (330, 'The Rare IL22RA2 Signal Peptide Coding Variant rs28385692 Decreases Secretion of IL-22BP Isoform-1, -2 and -3 and Is Associated with Risk for Multiple Sclerosis', 'Gómez-Fernández P, Lopez de Lapuente Portilla A, Astobiza I, Mena J, Urtasun A, Altmann V, Matesanz F, Otaegui D, Urcelay E, Antigüedad A, Malhotra S, Montalban X, Castillo-Triviño T, Espino-Paisán L, Aktas O, Buttmann M, Chan A, Fontaine B, Gourraud PA, Hecker M, Hoffjan S, Kubisch C, Kümpfel T, Luessi F, Zettl UK, Zipp F, Alloza I, Comabella M, Lill CM, Vandenbroeck K', 'Cells', '0020-01-01', 1, '31936765', 5.656);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (39, 'Prospective, multicenter, controlledstudy of quality of life, psychological adjustment process and medical outcomesof patients receiving a preemptive kidney transplant compared to a similarpopulation of recipients after a dialysis period of less than three years--ThePreKit-QoL study protocol', 'Sébille V, Hardouin JB, Giral M, Bonnaud-Antignac A, Tessier P, Papuchon E,Jobert A, Faurel-Paul E, Gentile S, Cassuto E, Morélon E, Rostaing L, Glotz D,Sberro-Soussan R, Foucher Y, Meurette A', 'BMC Nephrol', '0016-01-01', 1, '26785745', 2.088);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (88, 'Efficient Generation ofMyostatin Knock-Out Sheep Using CRISPR/Cas9 Technology and Microinjection intoZygotes', 'Crispo M, Mulet AP, Tesson L, Barrera N, Cuadro F, dos Santos-Neto PC, Nguyen TH, Crénéguy A, Brusselle L, Anegón I, Menchaca A', 'PLoS One', '0015-01-01', 1, '26305800', 2.776);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (107, 'Ovarian reserve and response to stimulation in women undergoing fertility preservation according to malignancy type', 'Lefebvre T, Mirallié S, Leperlier F, Reignier A, Barriere P, Freour T', 'Reprod Biomed Online', '0018-01-01', 1, '29784618', 2.93);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (89, 'AnNS5A single optimized method to determine genotype, subtype and resistanceprofiles of Hepatitis C strains', 'Andre-Garnier E, Besse B, Rodallec A, Ribeyrol O, Ferre V, Luco C, Le Guen L,Bourgeois N, Gournay J, Billaud E, Raffi F, Coste-Burel M, Imbert-Marcille BM', 'PLoS One', '0017-01-01', 1, '28727784', 2.776);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (95, 'Translational implications of endothelial cell dysfunction inassociation with chronic allograft rejection', 'Bruneau S, Wedel J, Fakhouri F, Nakayama H, Boneschansker L, Irimia D, DalyKP, Briscoe DM', 'Pediatr Nephrol', '0016-01-01', 1, '25903640', 2.816);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (102, 'Selective CD28 antagonistprevents Aldara-induced skin inflammation in non-human primates', 'Poirier N, Chevalier M, Mary C, Hervouet J, Minault D, Le Bas-Bernardet S,Belarif L, Daguin V, Cassagnau E, Vanhove B, Blancho G', 'Exp Dermatol', '0016-01-01', 1, '26513536', 2.868);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (103, 'Hormonal Modulation ofDendritic Cells Differentiation, Maturation and Function: Implications for theInitiation and Progress of Systemic Autoimmunity', 'Mackern-Oberti JP, Jara EL, Riedel CA, Kalergis AM', 'ARCH IMMUNOL THER EX', '0017-01-01', 1, '27585815', 2.878);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (104, 'Characterization of N-glycosylation and amino acid sequencefeatures of immunoglobulins from swine', 'Lopez PG, Girard L, Buist M, de Oliveira AG, Bodnar E, Salama A, SoulillouJP, Perreault H', 'GLYCOCONJUGATE J', '0016-01-01', 1, '26586247', 2.926);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (108, 'Revisiting theassociation between smoking and female fertility using the oocyte donation model', 'Freour T, Massart P, García D, Vassena R, Rodríguez A', 'Reprod Biomed Online', '0018-01-01', 1, '30366838', 2.93);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (109, 'Morphokinetic parameters in chromosomal translocation carriers undergoingpreimplantation genetic testing', 'Lammers J, Reignier A, Splingart C, Moradkhani K, Barriere P, Fréour T', 'Reprod Biomed Online', '0018-01-01', 1, '30579822', 2.93);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (110, 'Patient perceptions and understanding of treatment instructions for ovarian stimulation during infertility treatment', 'Barrière P, Avril C, Benmahmoud-Zoubir A, Bénard N, Dejager S', 'Reprod Biomed Online', '0019-01-01', 1, '31993512', 2.93);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (257, 'Prevention of lupus nephritis development in NZB/NZW mice byselective blockade of CD28', 'Laurent L, Le Fur A, Bloas RL, Néel M, Mary C, Moreau A, Poirier N, Vanhove B,Fakhouri F', 'Eur J Immunol', '0017-01-01', 1, '28631301', 4.695);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (468, 'Cell competition during reprogramming gives rise to dominant clones', 'Shakiba N, Fahmy A, Jayakumaran G, McGibbon S, David L, Trcka D, Elbaz J, Puri MC, Nagy A, van der Kooy D, Goyal S, Wrana JL, Zandstra PW', 'Science', '0019-01-01', 1, '30898844', 41.037);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (258, 'Blood Gene Expression Predicts Bronchiolitis Obliterans Syndrome', 'Danger R, Royer PJ, Reboulleau D, Durand E, Loy J, Tissot A, Lacoste P, RouxA, Reynaud-Gaubert M, Gomez C, Kessler R, Mussot S, Dromer C, Brugière O, Mornex JF, Guillemain R, Dahan M, Knoop C, Botturi K, Foureau A, Pison C, Koutsokera A, Nicod LP, Brouard S, Magnan A; COLT and SysCLAD Consortia', 'Front Immunol', '0018-01-01', 1, '29375549', 4.716);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (97, 'PLC? sequence, protein levels, and distribution in human sperm do not correlate with semencharacteristics and fertilization rates after ICSI', 'Ferrer-Vaquer A, Barragan M, Freour T, Vernaeve V, Vassena R', 'J ASSIST REPROD GEN', '0016-01-01', 1, '27138933', 2.82);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (98, 'WBP2NL/PAWPmRNA and protein expression in sperm cells are not related to semen parameters,fertilization rate, or reproductive outcome', 'Freour T, Barragan M, Ferrer-Vaquer A, Rodríguez A, Vassena R', 'J ASSIST REPROD GEN', '0017-01-01', 1, '28444612', 2.82);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (99, 'Time-lapse imaging systems in IVFlaboratories: a French national survey', 'Boueilh T, Reignier A, Barriere P, Freour T', 'J ASSIST REPROD GEN', '0018-01-01', 1, '30187427', 2.82);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (100, 'Performance of Day 5 KIDScore™ morphokinetic prediction models of implantation and live birth after single blastocyst transfer', 'Reignier A, Girard JM, Lammers J, Chtourou S, Lefebvre T, Barriere P, Freour T', 'J ASSIST REPROD GEN', '0019-01-01', 1, '31444634', 2.82);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (101, 'Phenotypic analysis of immunocompetent cells inhealthy human dental pulp', 'Gaudin A, Renard E, Hill M, Bouchet-Delbos L, Bienvenu-Louvet G, Farges JC,Cuturi MC, Alliot-Licht B', 'J ENDODONT', '0015-01-01', 1, '25702858', 2.833);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (120, 'A tribute to Mohamed Daha', 'Soulillou JP', 'Mol Immunol', '0015-01-01', 1, '26597201', 3.064);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (115, 'FOCIS goes south: advances intranslational and clinical immunology', 'Kalergis AM, Anegon I, González PA', 'IMMUNOTHERAPY-UK', '0017-01-01', 1, '28877630', 3.028);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (125, 'Human odontoblast-like cells produce nitric oxide withantibacterial activity upon TLR2 activation', 'Farges JC, Bellanger A, Ducret M, Aubert-Foucher E, Richard B, Alliot-LichtB, Bleicher F, Carrouel F', 'Front Physiol', '0015-01-01', 1, '26157393', 3.201);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (116, 'Immunotherapies intransplantation and cancer: 22nd NAT meeting/2nd NAT LabEx IGO joint meeting; 1-2June 2017, Nantes, France', 'Simon S, Charpentier M, Anegon I, Labarriere N', 'IMMUNOTHERAPY-UK', '0017-01-01', 1, '29338607', 3.028);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (121, 'Interleukin-22 regulates interferon lambda expression in a mice model of pseudomonas aeruginosa pneumonia', 'Broquet A, Besbes A, Martin J, Jacqueline C, Vourc''h M, Roquilly A, Caillon J, Josien R, Asehnoune K', 'Mol Immunol', '0020-01-01', 1, '31855807', 3.064);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (117, 'Food antigens and Transglutaminase 2 in IgA nephropathy: Molecular links between gut and kidney.', 'Abbad L, Monteiro RC, Berthelot L.', 'Mol Immunol', '0020-01-01', 1, '32135400', 3.064);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (122, 'Elevated IL-3 and IL-12p40 levels in the lowerairway of infants with RSV-induced bronchiolitis correlate with recurrentwheezing', 'Bertrand P, Lay MK, Piedimonte G, Brockmann PE, Palavecino CE, Hernández J,León MA, Kalergis AM, Bueno SM', 'Cytokine', '0015-01-01', 1, '26299549', 3.078);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (123, 'Blood biomarkers of kidney transplant rejection, an endless search?', 'Jacquemont L, Soulillou JP, Degauque N.', 'Expert Rev Mol Diagn', '0017-01-01', 1, '28571481', 3.099);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (126, 'Manufacturing of dental pulpcell-based products from human third molars: current strategies and futureinvestigations', 'Ducret M, Fabre H, Degoul O, Atzeni G, McGuckin C, Forraz N, Alliot-Licht B, Mallein-Gerin F, Perrier-Groult E, Farges JC', 'Front Physiol', '0015-01-01', 1, '26300779', 3.201);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (130, 'Vasculitides induced by cocaine and/or levamisole', 'Néel A, Agard C, Hamidou M', 'Joint Bone Spine', '0018-01-01', 1, '28602438', 3.278);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (131, 'Essential role forCD103+ cells in the pathogenesis of spondyloarthritides', 'Berthelot JM, Le Goff B, Martin J, Maugars Y, Josien R', 'Joint Bone Spine', '0015-01-01', 1, '25241337', 3.278);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (132, 'Decreased Frequency of Circulating MyelinOligodendrocyte Glycoprotein B Lymphocytes in Patients with Relapsing-RemittingMultiple Sclerosis', 'Elong Ngono A, Lepetit M, Reindl M, Garcia A, Guillot F, Genty A, Chesneau M, Salou M, Michel L, Lefrere F, Schanda K, Imbert-Marcille BM, Degauque N, Nicot A,Brouard S, Laplaud DA, Soulillou JP', 'J Immunol Res', '0015-01-01', 1, '26090495', 3.404);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (135, 'Generation of cattle knockout for galactose-?1,3-galactose and N-glycolylneuraminic acid antigens', 'Perota A, Lagutina I, Duchi R, Zanfrini E, Lazzari G, Judor JP, Conchon S, Bach JM, Bottio T, Gerosa G, Costa C, Galiñanes M, Roussel JC, Padler-Karavani V, Cozzi E, Soulillou JP, Galli C', 'Xenotransplantation', '0019-01-01', 1, '31115108', 3.484);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (137, 'Potential deleterious role ofanti-Neu5Gc antibodies in xenotransplantation', 'Salama A, Evanno G, Harb J, Soulillou JP', 'Xenotransplantation', '0015-01-01', 1, '25308416', 3.484);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (138, 'Characterization of immunogenic Neu5Gc inbioprosthetic heart valves', 'Reuven EM, Leviatan Ben-Arye S, Marshanski T, Breimer ME, Yu H, Fellah-HebiaI, Roussel JC, Costa C, Galiñanes M, Mañez R, Le Tourneau T, Soulillou JP, Cozzi E, Chen X, Padler-Karavani V', 'Xenotransplantation', '0016-01-01', 1, '27610947', 3.484);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (118, 'Are the Decrease in Circulating anti-?1,3-Gal IgG and the Lower Content of Galactosyl Transferase A1 in the Microbiota of Patients With Multiple Sclerosis a Novel Environmental Risk Factor for the Disease?', 'Montassier E, Berthelot L , Soulillou J-P', 'Mol Immunol', '0018-01-01', 1, '29195140', 3.064);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (127, 'Immunophenotyping Reveals theDiversity of Human Dental Pulp Mesenchymal Stromal Cells In vivo and TheirEvolution upon In vitro Amplification', 'Ducret M, Fabre H, Degoul O, Atzeni G, McGuckin C, Forraz N, Mallein-Gerin F, Perrier-Groult E, Alliot-Licht B, Farges JC', 'Front Physiol', '0016-01-01', 1, '27877132', 3.201);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (128, 'Absolute Quantitation of Glycoforms of Two Human IgGSubclasses Using Synthetic Fc Peptides and Glycopeptides', 'Roy R, Ang E, Komatsu E, Domalaon R, Bosseboeuf A, Harb J, Hermouet S, KrokhinO, Schweizer F, Perreault H', 'J AM SOC MASS SPECTR', '0018-01-01', 1, '29796736', 3.202);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (192, 'Carbon monoxide down-modulates Toll-likereceptor 4/MD2 expression on innate immune cells and reduces endotoxic shocksusceptibility', 'Riquelme SA, Bueno SM, Kalergis AM', 'Immunology', '0015-01-01', 1, '25179131', 4.147);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (199, 'Maternal Protein Restriction in Rats Alters the Expression of Genes Involved in Mitochondrial Metabolism and Epitranscriptomics in Fetal Hypothalamus.', 'Frapin M, Guignard S, Meistermann D, Grit I, Moullé VS, Paillé V, Parnet P, Amarger V.', 'Nutrients', '0020-01-01', 1, '32438566', 4.171);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (124, 'Needs for Systems Approaches to Better Treat Individuals With Severe Asthma: Predicting Phenotypes and Responses to Treatments.', 'Colas L, Hassoun D, Magnan A.', 'Front Med', '0020-01-01', 1, '32296705', 3.113);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (114, 'Impact of stem cell graft on early viral infections and immune reconstitution after allogeneic transplantation in adults.', 'Illiaquer M, Imbert-Marcille BM, Guillaume T, Planche L, Rimbert M, Bressollette-Bodin C, Le Bourgeois A, Peterlin P, Garnier A, Le Houerou C, Moreau P, Mohty M, Chevallier P.', 'J Clin Virol', '0017-01-01', 1, '28601677', 3.02);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (119, 'Phenotype and functions of B cells in patients with acute braininjuries', 'Chenouard A, Chesneau M, Braza F, Dejoie T, Cinotti R, Roquilly A, Brouard S,Asehnoune K', 'Mol Immunol', '0015-01-01', 1, '26364142', 3.064);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (272, 'Targeting CD8 T-Cell Metabolism in Transplantation', 'Yap M, Brouard S, Pecqueur C, Degauque N', 'Front Immunol', '0015-01-01', 1, '26557123', 4.716);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (158, 'Standardized whole blood stimulationimproves immunomonitoring of induced immune responses in multi-center study', 'Duffy D, Rouilly V, Braudeau C, Corbière V, Djebali R, Ungeheuer MN, JosienR, LaBrie ST, Lantz O, Louis D, Martinez-Caceres E, Mascart F, Ruiz de MoralesJG, Ottone C, Redjah L, Guen NS, Savenay A, Schmolz M, Toubert A, Albert ML;Multinational FOCIS Centers of Excellence', 'Clin Immunol', '0017-01-01', 1, '28943400', 3.548);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (159, 'A dominant vimentin variant causes a rare syndrome with premature aging.', 'Cogné B, Bouameur JE, Hayot G, Latypova X, Pattabiraman S, Caillaud A, Si-Tayeb K, Besnard T, Küry S, Chariau C, Gaignerie A, David L, Bordure P, Kaganovich D, Bézieau S, Golzio C, Magin TM, Isidor B.', 'Eur J Hum Genet', '0020-01-01', 1, '32066935', 3.65);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (160, 'Carbonmonoxide inhibits T cell activation in target organs during systemic lupuserythematosus', 'Mackern-Oberti JP, Obreque J, Méndez GP, Llanos C, Kalergis AM', 'Clin Exp Immunol', '0015-01-01', 1, '26095291', 3.711);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (161, 'Clinical efficacy of a new CD28-targeting antagonist of T cell co-stimulation in a non-human primate model of collagen-induced arthritis', 'Vierboom MP, Breedveld E, Kap YS, Mary C, Poirier N, ''t Hart BA, Vanhove B', 'Clin Exp Immunol', '0016-01-01', 1, '26540618', 3.711);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (162, 'Anticomplement Treatment in Atypical and Typical Hemolytic Uremic Syndrome', 'Fakhouri F, Loirat C', 'Semin Hematol', '0018-01-01', 1, '30032752', 3.738);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (163, 'Modulation of Antiviral Immunity byHeme Oxygenase-1', 'Espinoza JA, González PA, Kalergis AM', 'Am J Pathol', '0017-01-01', 1, '28082120', 3.762);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (164, 'Looking for Missing Proteins in theProteome of Human Spermatozoa: An Update', 'Vandenbrouck Y, Lane L, Carapito C, Duek P, Rondel K, Bruley C, Macron C,Gonzalez de Peredo A, Couté Y, Chaoui K, Com E, Gateau A, Hesse AM, Marcellin M, Méar L, Mouton-Barbosa E, Robin T, Burlet-Schiltz O, Cianferani S, Ferro M,Freour T, Lindskog C, Garin J, Pineau C', 'J Proteome Res', '0016-01-01', 1, '27444420', 3.78);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (165, 'Validating Missing Proteins in Human Sperm Cells by Targeted Mass-Spectrometry- and Antibody-based Methods', 'Carapito C, Duek P, Macron C, Seffals M, Rondel K, Delalande F, Lindskog C,Freour T, Vandenbrouck Y, Lane L, Pineau C', 'J PROTEOME RES', '0017-01-01', 1, '28891297', 3.78);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (166, 'Characterization of immunoglobulins through analysisof N-glycopeptides by MALDI-TOF MS', 'Komatsu E, Buist M, Roy R, Gomes de Oliveira AG, Bodnar E, Salama A,Soulillou JP, Perreault H', 'Methods', '0016-01-01', 1, '26773578', 3.782);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (167, 'Excess iodideinduces an acute inhibition of the sodium/iodide symporter in thyroid male ratcells by increasing reactive oxygen species', 'Arriagada AA, Albornoz E, Opazo MC, Becerra A, Vidal G, Fardella C, Michea L, Carrasco N, Simon F, Elorza AA, Bueno SM, Kalergis AM, Riedel CA', 'Endocrinology', '0015-01-01', 1, '25594695', 3.8);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (201, 'MD1003 (High-Dose Pharmaceutical-Grade Biotin) for the Treatment of ChronicVisual Loss Related to Optic Neuritis in Multiple Sclerosis: A Randomized,Double-Blind, Placebo-Controlled Study', 'Tourbah A, Gout O, Vighetto A, Deburghgraeve V, Pelletier J, Papeix C,Lebrun-Frenay C, Labauge P, Brassat D, Toosy A, Laplaud DA, Outteryck O, MoreauT, Debouverie M, Clavelou P, Heinzlef O, De Sèze J, Defer G, Sedel F, Arndt C', 'CNS Drugs', '0018-01-01', 1, '29808469', 4.192);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (144, 'The 1-year RenalBiopsy Index (1-RBI): a scoring system to drive biopsy indication at 1-yearpost-kidney transplantation', 'Giral M, Renaudin K, Naesens M, Luning R, Anglicheau D, Morelon E, Huneau A,Paul C, Brouard S, Couvrat-Desvergnes G, Foucher Y, Dantan E', 'Transpl Int', '0018-01-01', 1, '29893433', 3.526);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (146, 'Comparison of survival outcomes between ExpandedCriteria Donor and Standard Criteria Donor kidney transplant recipients: asystematic review and meta-analysis', 'Querard AH, Foucher Y, Combescure C, Dantan E, Larmet D, Lorent M, PouteauLM, Giral M, Gillaizeau F', 'Transpl Int', '0016-01-01', 1, '26756928', 3.526);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (177, 'Interleulin-22 is negatively correlated with neutrophil recruitment in the lungs in a Pseudomonas aeruginosa pneumonia model.', 'Broquet A, Jacqueline C, Davieau M, Besbe A, Roquilly A, Martin J, Caillon J, Dumoutier L, Renauld JC, Heslan M, Josien R, Asehnoune K', 'SCI REP-UK', '0017-01-01', 1, '28887540', 4.011);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (178, 'Generation of gene-edited rats by delivery of CRISPR/Cas9 protein and donorDNA into intact zygotes using electroporation', 'Remy S, Chenouard V, Tesson L, Usal C, Ménoret S, Brusselle L, Heslan JM,Nguyen TH, Bellien J, Merot J, De Cian A, Giovannangeli C, Concordet JP, AnegonI', 'SCI REP-UK', '0017-01-01', 1, '29185448', 4.011);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (179, 'Galectin-1 is required for the regulatory function of Bcells', 'Alhabbab R, Blair P, Smyth LA, Ratnasothy K, Peng Q, Moreau A, Lechler R,Elgueta R, Lombardi G', 'SCI REP-UK', '0018-01-01', 1, '29426942', 4.011);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (180, 'Expansion of human primary hepatocytes in vitro through theiramplification as liver progenitors in a 3D organoid system', 'Garnier D, Li R, Delbos F, Fourrier A, Collet C, Guguen-Guillouzo C, Chesné C,Nguyen TH', 'SCI REP-UK', '0018-01-01', 1, '29844473', 4.011);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (181, 'Lipoxin A(4) Attenuates the InflammatoryResponse in Stem Cells of the Apical Papilla via ALX/FPR2', 'Gaudin A, Tolar M, Peters OA', 'SCI REP-UK', '0018-01-01', 1, '29892010', 4.011);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (174, 'Homology-directed repair inrodent zygotes using Cas9 and TALEN engineered proteins', 'Ménoret S, De Cian A, Tesson L, Remy S, Usal C, Boulé JB, Boix C, Fontanière S, Crénéguy A, Nguyen TH, Brusselle L, Thinard R, Gauguier D, Concordet JP,Cherifi Y, Fraichard A, Giovannangeli C, Anegon I', 'SCI REP-UK', '0015-01-01', 1, '26442875', 4.011);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (175, 'Comparative transcriptomic analysis of human and Drosophilaextracellular vesicles', 'Lefebvre FA, Benoit Bouvrette LP, Perras L, Blanchet-Cohen A, Garnier D, Rak J, Lécuyer É', 'SCI REP-UK', '0016-01-01', 1, '27282340', 4.011);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (176, 'Comparative Analysis of piggyBac,CRISPR/Cas9 and TALEN Mediated BAC Transgenesis in the Zygote for the Generation of Humanized SIRPA Rats', 'Jung CJ, Ménoret S, Brusselle L, Tesson L, Usal C, Chenouard V, Remy S, OuisseLH, Poirier N, Vanhove B, de Jong PJ, Anegon I', 'SCI REP-UK', '0016-01-01', 1, '27530248', 4.011);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (466, 'Low-Frequency and Rare-Coding Variation Contributes to Multiple Sclerosis Risk', 'International Multiple Sclerosis Genetics Consortium', 'Cell', '0018-01-01', 1, '30343897', 36.216);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (52, 'Multidimensional reduction of multicentric cohort heterogeneity: An alternativemethod to increase statistical power and robustness', 'Le Gall C, Laurent J, Vince N, Lizee A, Agrawal A, Walencik A, Rettman P,Gagne K, Retiere C, Hollenbach J, Cesbron A, Limou S, Gourraud PA', 'Hum Immunol', '0016-01-01', 1, '27262455', 2.202);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (194, 'Contributionof dendritic cells to the autoimmune pathology of systemic lupus erythematosus', 'Mackern-Oberti JP, Llanos C, Riedel CA, Bueno SM, Kalergis AM', 'Immunology', '0015-01-01', 1, '26173489', 4.147);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (195, 'Contribution of Fc? receptors to human respiratorysyncytial virus pathogenesis and the impairment of T-cell activation by dendriticcells', 'Gómez RS, Ramirez BA, Céspedes PF, Cautivo KM, Riquelme SA, Prado CE,González PA, Kalergis AM', 'Immunology', '0016-01-01', 1, '26451966', 4.147);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (196, 'Modulation of antigen processing byhaem-oxygenase 1 Implications on inflammation and tolerance', 'Riquelme SA, Carreño LJ, Espinoza JA, Mackern-Oberti JP, Alvarez-Lobos MM,Riedel CA, Bueno SM, Kalergis AM', 'Immunology', '0016-01-01', 1, '26938875', 4.147);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (197, 'Human neonatal hepatocyte transplantation induces long-termrescue of unconjugated hyperbilirubinemia in the Gunn rat', 'Tolosa L, López S, Pareja E, Donato MT, Myara A, Nguyen TH, Castell JV,Gómez-Lechón MJ', 'LIVER TRANSPLANT', '0015-01-01', 1, '25821167', 4.159);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (469, 'Microglial control of astrocytes in response to microbialmetabolites', 'Rothhammer V, Borucki DM, Tjon EC, Takenaka MC, Chao CC, Ardura-Fabregat A, deLima KA, Gutiérrez-Vázquez C, Hewson P, Staszewski O, Blain M, Healy L, NezirajT, Borio M, Wheeler M, Dragin LL, Laplaud DA, Antel J, Alvarez JI, Prinz M,Quintana FJ', 'Nature', '0018-01-01', 1, '29769726', 43.07);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (470, 'Pathological inflammation in patients with COVID-19: a key role for monocytes and macrophages', 'Merad M, Martin JC.', 'Nat Rev Immunol', '0020-01-01', 1, '32376901', 44.019);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (198, 'Improving hepatocyte engraftment following hepatocyte transplantationusing repeated reversible portal vein embolization in rats', 'Gaillard M, Tranchart H, Lainas P, Trassard O, Remy S, Dubart-Kupperschmitt A,Dagher I', 'LIVER TRANSPLANT', '0018-01-01', 1, '30358068', 4.159);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (200, 'Genetic Restoration of Heme Oxygenase-1 Expression Protects from Type 1 Diabetes in NOD Mice', 'Pogu J, Tzima S, Kollias G, Anegon I, Blancou P, Simon T', 'INT J MOL SCI', '0019-01-01', 1, '30987262', 4.183);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (472, 'Haemolytic uraemic syndrome', 'Fakhouri F, Zuber J, Frémeaux-Bacchi V, Loirat C', 'Lancet', '0017-01-01', 1, '28242109', 59.102);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (474, 'Prevention of Early Ventilator-Associated Pneumonia after Cardiac Arrest', 'François B, Cariou A, Clere-Jehl R, Dequin PF, Renon-Carron F, Daix T, Guitton C, Deye N, Legriel S, Plantefève G, Quenot JP, Desachy A, Kamel T, Bedon-Carte S, Diehl JL, Chudeau N, Karam E, Durand-Zaleski I, Giraudeau B, Vignon P, Le Gouge A; CRICS-TRIGGERSEP Network and the ANTHARTIC Study Group', 'NEW ENGL J MED', '0019-01-01', 1, '31693806', 70.67);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (50, 'Pathogenesis ofnon-HLA antibodies in solid organ transplantation: Where do we stand?', 'Delville M, Charreau B, Rabant M, Legendre C, Anglicheau D', 'Hum Immunol', '0016-01-01', 1, '27237040', 2.202);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (428, 'Genetic variants aremajor determinants of CSF antibody levels in multiple sclerosis', 'Goris A, Pauwels I, Gustavsen MW, van Son B, Hilven K, Bos SD, Celius EG,Berg-Hansen P, Aarseth J, Myhr KM, D''Alfonso S, Barizzone N, Leone MA, MartinelliBoneschi F, Sorosina M, Liberatore G, Kockum I, Olsson T, Hillert J, AlfredssonL, Bedri SK, Hemmer B, Buck D, Berthele A, Knier B, Biberacher V, van Pesch V,Sindic C, Bang Oturai A, Søndergaard HB, Sellebjerg F, Jensen PE, Comabella M,Montalban X, Pérez-Boza J, Malhotra S, Lechner-Scott J, Broadley S, Slee M,Taylor B, Kermode AG, Gourraud PA; International Multiple Sclerosis GeneticsConsortium, Sawcer SJ, Andreassen BK, Dubois B, Harbo HF', 'Brain', '0015-01-01', 1, '25616667', 11.814);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (51, 'Sialylation of antibodies in kidney recipients withde novo donor specific antibody, with or without antibody mediated rejection', 'Malard-Castagnet S, Dugast E, Degauque N, Pallier A, Soulillou JP, Cesbron A, Giral M, Harb J, Brouard S', 'Hum Immunol', '0016-01-01', 1, '26546874', 2.202);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (240, 'Generation ofimmunodeficient rats with Rag1 and Il2rg gene deletions and human tissue graftingmodels', 'Ménoret S, Ouisse LH, Tesson L, Delbos F, Garnier D, Remy S, Usal C, ConcordetJP, Giovannangeli C, Chenouard V, Brusselle L, Merieau E, Nerrière-Daguin V,Duteille F, Bellier-Waast F, Fraichard A, Nguyen TH, Anegon I', 'Transplantation', '0018-01-01', 1, '29688994', 4.593);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (206, 'Value of biomarkers for predicting immunoglobulin A vasculitisnephritis outcome in an adult prospective cohort', 'Berthelot L, Jamin A, Viglietti D, Chemouny JM, Ayari H, Pierre M, Housset P, Sauvaget V, Hurtado-Nedelec M, Vrtovsnik F, Daugas E; HSPrognosis Group, MonteiroRC, Pillebout E', 'NEPHROL DIAL TRANSPL', '0017-01-01', 1, '29126311', 4.198);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (207, 'Understanding and managing hypercalciuria in adults with nephrolithiasis: keys for nephrologists', 'Figueres L, Hourmant M, Lemoine S', 'NEPHROL DIAL TRANSPL', '0019-01-01', 1, '31219589', 4.198);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (213, 'Severe Symptomatic PrimaryHuman Cytomegalovirus Infection despite Effective Innate and Adaptive ImmuneResponses', 'Riou R, Bressollette-Bodin C, Boutoille D, Gagne K, Rodallec A, Lefebvre M,Raffi F, Senitzer D, Imbert-Marcille BM, Retière C', 'J Virol', '0017-01-01', 1, '28031361', 4.324);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (214, 'Comparison of Human and Experimental Pulmonary Veno-Occlusive Disease.', 'Manaud G, Nossent EJ, Lambert M, Ghigna MR, Boët A, Vinhas MC, Ranchoux B, Dumas SJ, Courboulin A, Girerd B, Soubrier F, Bignard J, Claude O, Lecerf F, Hautefort A, Florio M, Sun B, Nadaud S, Verleden SE, Remy S, Anegon I, Bogaard HJ, Mercier O, Fadel E, Simonneau G, Vonk Noordegraaf A, Grünberg K, Humbert M, Montani D, Dorfmüller P, Antigny F, Perros F', 'AM J RESP CELL MOL', '0020-01-01', 1, '32209028', 4.34);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (219, 'Integrated structure- and ligand-based in silicoapproach to predict inhibition of cytochrome P450 2D6', 'Martiny VY, Carbonell P, Chevillard F, Moroy G, Nicot AB, Vayer P,Villoutreix BO, Miteva MA', 'Bioinformatics', '0015-01-01', 1, '26315915', 4.531);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (220, 'Easy-HLA, a validated web application suite to reveal the full details of HLA typing', 'Geffard E, Limou S, Walencik A, Daya M, Watson H, Torgerson D, Barnes KC, Gautier AC, Gourraud PA, Vince N', 'Bioinformatics', '0019-01-01', 1, '31750874', 4.531);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (241, 'Advances on CD8+ Treg Cells and TheirPotential in Transplantation', 'Bézie S, Anegon I, Guillonneau C', 'Transplantation', '0018-01-01', 1, '29688996', 4.593);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (208, 'Additional Insights into Hypericum perforatum Content: Isolation, Total Synthesis, and Absolute Configuration of Hyperbiphenyls A and B from Immunomodulatory Root Extracts', 'Bréard D, Viault G, Mezier MC, Pagie S, Bruguière A, Richomme P, Charreau B, Derbré S', 'J Nat Prod', '0018-01-01', 1, '30024167', 4.257);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (242, 'In vivo analysis of human immune responses in immunodeficient rats', 'Ménoret S, Ouisse LH, Tesson L, Remy S, Usal C, Guiffes A, Chenouard V, Royer PJ, Evanno G, Vanhove B, Piaggio E, Anegon I', 'Transplantation', '0019-01-01', 1, '31764762', 4.593);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (34, '[Extra-oral signs to look for in patients exhibiting oral warningsigns of genetic diseases]', 'Alliot-Licht B, Lusson C, Hyon I, Dajean-Trutaud S, Le Caignec C,Lopez-Cazaux S', 'CR BIOL', '0015-01-01', 1, '25528675', 1.867);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (216, 'Development and application of a transcriptional sensor for detection of heterologous acrylic acid production in E coli', 'Raghavan SS, Chee S, Li J, Poschmann J, Nagarajan N, Jia Wei S, Verma CS, Ghadessy FJ', 'Microb Cell Fact', '0019-01-01', 1, '31426802', 4.402);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (217, 'High-AccuracyHLA Type Inference from Whole-Genome Sequencing Data Using Population ReferenceGraphs', 'Dilthey AT, Gourraud PA, Mentzer AJ, Cereb N, Iqbal Z, McVean G', 'PLoS Comput Biol', '0016-01-01', 1, '27792722', 4.428);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (224, 'Selective Costimulation Blockade With Antagonist Anti-CD28 Therapeutics in Transplantation', 'Vanhove B, Poirier N, Soulillou JP, Blancho G', 'Transplantation', '0019-01-01', 1, '30951014', 4.593);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (243, 'Successful percutaneous thrombolysis and aspiration thrombectomy for graft salvage after pancreas transplant venous thrombosis', 'David A, Frampas E, Perret C, Douane F, Cantarovich D, Karam G, Branchereau J', 'Transplantation', '0019-01-01', 1, '31335782', 4.593);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (244, 'Humanization of Immunodeficient Animals for the Modeling of Transplantation, Graft Versus Host Disease and Regenerative Medicine.', 'Adigbli G, Ménoret S, Cross AR, Hester J, Issa F, Anegon I.', 'Transplantation', '0020-01-01', 1, '32068660', 4.593);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (53, 'The TRANSPLANTEX initiative', 'Bahram S, Carapito R, Gourraud PA, Charron D', 'Hum Immunol', '0016-01-01', 1, '27881245', 2.202);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (209, 'Lepidotol A from Mesua lepidota Inhibits Inflammatory and ImmuneMediators in Human Endothelial Cells', 'Rouger C, Derbré S, Charreau B, Pabois A, Cauchy T, Litaudon M, Awang K,Richomme P', 'J Nat Prod', '0015-01-01', 1, '26301802', 4.257);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (238, 'DHRS9 Is a Stable Marker of Human RegulatoryMacrophages', 'Riquelme P, Amodio G, Macedo C, Moreau A, Obermajer N, Brochhausen C, AhrensN, Kekarainen T, Fändrich F, Cuturi C, Gregori S, Metes D, Schlitt HJ, ThomsonAW, Geissler EK, Hutchinson JA', 'Transplantation', '0017-01-01', 1, '28594751', 4.593);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (239, 'A New Marker for Regulatory Macrophages', 'Anegon I', 'Transplantation', '0017-01-01', 1, '28650423', 4.593);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (204, 'Dynamic predictions of long-term kidney graft failure: an information tool promoting patient-centred care', 'Fournier MC, Foucher Y, Blanche P, Legendre C, Girerd S, Ladrière M, Morelon E, Buron F, Rostaing L, Kamar N, Mourad G, Garrigue V, Couvrat-Desvergnes G, Giral M, Dantan E; DIVAT Consortium', 'NEPHROL DIAL TRANSPL', '0019-01-01', 1, '30859193', 4.198);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (212, 'Deciphering the role ofTRIB1 in regulatory T-cells', 'Danger R, Dugast E, Braza F, Conchon S, Brouard S', 'BIOCHEM SOC T', '0015-01-01', 1, '26517926', 4.291);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (249, 'Expanded CD8 T-cell sharing between periphery and CNS in multiple sclerosis', 'Salou M, Garcia A, Michel L, Gainche-Salmon A, Loussouarn D, Nicol B, Guillot F, Hulin P, Nedellec S, Baron D, Ramstein G, Soulillou JP, Brouard S, Nicot AB,Degauque N, Laplaud DA', 'ANN CLIN TRANSL NEUR', '0015-01-01', 1, '26125037', 4.656);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (250, 'Novel MS vital sign: multi-sensor captures upper and lower limb dysfunction', 'Akhbardeh A, Arjona JK, Krysko KM, Nourbakhsh B, Gourraud PA, Graves JS', 'Ann Clin Transl Neurol', '0020-01-01', 1, '32101388', 4.656);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (251, 'Local control of thehost immune response performed with mesenchymal stem cells: perspectives forfunctional intracerebral xenotransplantation', 'Lévêque X, Mathieux E, Nerrière-Daguin V, Thinard R, Kermarrec L, Durand T,Haudebourg T, Vanhove B, Lescaudron L, Neveu I, Naveilhan P', 'J Cell Mol Med', '0015-01-01', 1, '25310920', 4.658);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (260, 'CD9 Tetraspanin: A New Pathway forthe Regulation of Inflammation?', 'Brosseau C, Colas L, Magnan A, Brouard S', 'Front Immunol', '0018-01-01', 1, '30356731', 4.716);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (261, 'CD9(+) Regulatory B Cells Induce T CellApoptosis via IL-10 and Are Reduced in Severe Asthmatic Patients', 'Brosseau C, Durand M, Colas L, Durand E, Foureau A, Cheminant MA, Bouchaud G, Castan L, Klein M, Magnan A, Brouard S', 'Front Immunol', '0018-01-01', 1, '30622536', 4.716);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (262, 'Early Identification of Chronic Lung Allograft Dysfunction: The Need of Biomarkers', 'Tissot A, Danger R, Claustre J, Magnan A, Brouard S', 'Front Immunol', '0019-01-01', 1, '31379869', 4.716);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (263, 'Highly Variable Sialylation Status of Donor-Specific Antibodies Does Not Impact Humoral Rejection Outcomes', 'Barba T, Harb J, Ducreux S, Koenig A, Mathias V, Rabeyrin M, Pouliquen E, Sicard A, Chartoire D, Dugast E, Defrance T, Morelon E, Brouard S, Dubois V, Thaunat O', 'Front Immunol', '0019-01-01', 1, '30949173', 4.716);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (264, 'CXCR5(+)PD1(+)ICOS(+) Circulating T Follicular Helpers Are Associated With de novo Donor-Specific Antibodies After Renal Transplantation', 'Danger R, Chesneau M, Delbos F, Le Bot S, Kerleau C, Chenouard A, Ville S, Degauque N, Conchon S, Cesbron A, Giral M, Brouard S', 'Front Immunol', '0019-01-01', 1, '31552030', 4.716);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (235, 'PreclinicalTesting of Antihuman CD28 Fab'' Antibody in a Novel Nonhuman Primate Small Animal Rodent Model of Xenogenic Graft-Versus-Host Disease', 'Hippen KL, Watkins B, Tkachev V, Lemire AM, Lehnen C, Riddle MJ, Singh K,Panoskaltsis-Mortari A, Vanhove B, Tolar J, Kean LS, Blazar BR', 'Transplantation', '0016-01-01', 1, '27861291', 4.593);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (265, 'FB5P-seq: FACS-Based 5-Prime End Single-Cell RNA-seq for Integrative Analysis of Transcriptome and Antigen Receptor Repertoire in B and T Cells.', 'Attaf N, Cervera-Marzal I, Dong C, Gil L, Renand A, Spinelli L, Milpied P', 'Front Immunol', '0020-01-01', 1, '32194545', 4.716);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (247, 'A Rapid and Cost-Effective Method for GenotypingGenome-Edited Animals: A Heteroduplex Mobility Assay Using Microfluidic CapillaryElectrophoresis', 'Chenouard V, Brusselle L, Heslan JM, Remy S, Ménoret S, Usal C, Ouisse LH,NGuyen TH, Anegon I, Tesson L', 'J Genet Genomics', '0016-01-01', 1, '27209567', 4.65);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (269, 'Dysregulated Responsiveness of Circulating Dendritic Cells to Toll-Like Receptorsin ANCA-Associated Vasculitis', 'Braudeau C, Néel A, Amouriaux K, Martin JC, Rimbert M, Besançon A, Giraudet S,Terrien C, Aliaga M, Salabert-Le Guen N, Hemont C, Hamidou M, Josien R', 'Front Immunol', '0017-01-01', 1, '28232832', 4.716);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (387, 'Persistent deficiency of circulatingmucosal-associated invariant T (MAIT) cells in ANCA-associated vasculitis', 'Braudeau C, Amouriaux K, Néel A, Herbreteau G, Salabert N, Rimbert M, MartinJC, Hemont C, Hamidou M, Josien R', 'J Autoimmun', '0016-01-01', 1, '27102145', 7.543);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (248, 'Generation of a Double KO Mouse by Simultaneous Targeting of the Neighboring Genes Tmem176a and Tmem176bUsing CRISPR/Cas9: Key Steps from Design to Genotyping', 'Lemoine A, Chauveau-Le Friec G, Langa F, Louvet C', 'J Genet Genomics', '0016-01-01', 1, '27234594', 4.65);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (41, 'Chronic kidney disease and HIV in the era of antiretroviral treatment: findings from a 10-year cohort study in a west African setting', 'Kaboré NF, Poda A, Zoungrana J, Da O, Ciaffi L, Semdé A, Yaméogo I, Sawadogo AB, Delaporte E, Meda N, Limou S, Cournil A', 'BMC Nephrol', '0019-01-01', 1, '31064340', 2.088);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (42, 'Subclinical Saccadic Eye Movement Dysfunction in Pediatric Multiple Sclerosis', 'Yousef A, Devereux M, Gourraud PA, Jonzzon S, Suleiman L, Waubant E, Green A, Graves JS', 'J Child Neurol', '0018-01-01', 1, '30463467', 2.092);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (383, 'IL-22BP is produced by eosinophils in human gut and blocks IL-22protective actions during colitis', 'Martin JC, Bériou G, Heslan M, Bossard C, Jarry A, Abidi A, Hulin P, Ménoret S, Thinard R, Anegon I, Jacqueline C, Lardeux B, Halary F, Renauld JC, BourreilleA, Josien R', 'Mucosal Immunol', '0016-01-01', 1, '26329427', 7.352);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (43, 'Is therean association between PAWP/WBP2NL sequence, expression, and distribution insperm cells and fertilization failures in ICSI cycles?', 'Freour T, Barragan M, Torra-Massana M, Ferrer-Vaquer A, Vassena R', 'Mol Reprod Dev', '0017-01-01', 1, '29271520', 2.124);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (44, 'Hypothermic pulsatile perfusion of human pancreas: Preliminarytechnical feasibility study based on histology', 'Branchereau J, Renaudin K, Kervella D, Bernadet S, Karam G, Blancho G,Cantarovich D', 'Cryobiology', '0018-01-01', 1, '30292812', 2.141);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (45, 'Targeted clinical audits immediately following the establishment of clinicalpractice guidelines for multiple sclerosis in 17 neurology departments: Apragmatic and collaborative study', 'Lairy G, Zephir H, Ouallet JC, Le Page E, Laplaud D, Bensa C, De Seze J', 'REV NEUROL-FRANCE', '0015-01-01', 1, '25912471', 2.177);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (46, 'Can we discontinue disease-modifying treatments in multiplesclerosis patients? Yes', 'Laplaud D', 'REV NEUROL-FRANCE', '0017-01-01', 1, '27955826', 2.177);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (47, 'Is the Choosing Wisely(®) campaign model applicable to the management of multiplesclerosis in France? A GRESEP pilot study', 'Trumbic B, Zéphir H, Ouallet JC, Le Page E, Laplaud D, Bensa C, de Sèze J', 'REV NEUROL-FRANCE', '0017-01-01', 1, '29128151', 2.177);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (48, 'B cells in operationaltolerance', 'Chesneau M, Danger R, Soulillou JP, Brouard S', 'Hum Immunol', '0018-01-01', 1, '29458071', 2.202);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (49, 'Expression of MHC classI-related molecules MICA, HLA-E and EPCR shape endothelial cells with uniquefunctions in innate and adaptive immunity', 'Gavlovsky PJ, Tonnerre P, Guitton C, Charreau B', 'Hum Immunol', '0016-01-01', 1, '26916837', 2.202);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (57, '"My Life Needs Editing" (Mort Sahl) and Genome EditingNeeds Ethics', 'Anegon I, Nguyen TH', 'Curr Gene Ther', '0016-01-01', 1, '26844694', 2.218);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (382, 'Neu5Gc and ?1-3 GAL Xenoantigen Knockout Does Not Affect GlycemiaHomeostasis and Insulin Secretion in Pigs', 'Salama A, Mosser M, Lévêque X, Perota A, Judor JP, Danna C, Pogu S, Mouré A,Jégou D, Gaide N, Abadie J, Gauthier O, Concordet JP, Le Bas-Bernardet S, RiochetD, Le Berre L, Hervouet J, Minault D, Weiss P, Guicheux J, Brouard S, Bosch S,Lagutina I, Duchi R, Lazzari G, Cozzi E, Blancho G, Conchon S, Galli C, SoulillouJP, Bach JM', 'Diabetes', '0017-01-01', 1, '28082457', 7.199);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (384, 'Translational opportunities fortargeting the Th17 axis in acute graft-vs-host disease', 'Malard F, Gaugler B, Lamarthee B, Mohty M', 'Mucosal Immunol', '0016-01-01', 1, '26813345', 7.352);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (392, 'Aire-dependent genes undergo Clp1-mediated 3''UTR shortening associated with higher transcript stability in the thymus', 'Guyon C, Jmari N, Padonou F, Li YC, Ucar O, Fujikado N, Coulpier F, Blanchet C, Root DE, Giraud M', 'Elife', '0020-01-01', 1, '32338592', 7.551);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (393, 'Impact of hypertensive emergency and complement rare variants on presentation and outcome of atypical hemolytic uremic syndrome', 'El Karoui K, Boudhabhay I, Petitprez F, Vieira-Martins P, Fakhouri F, Zuber J, Aulagnon F, Matignon M, Rondeau E, Mesnard L, Halimi JM, Frémeaux-Bacchi V', 'Haematologica', '0019-01-01', 1, '30890598', 7.57);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (395, 'Role of dendritic cells in the initiation, progress and modulationof systemic autoimmune diseases', 'Mackern-Oberti JP, Llanos C, Vega F, Salazar-Onfray F, Riedel CA, Bueno SM,Kalergis AM', 'Autoimmun Rev', '0015-01-01', 1, '25449681', 7.716);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (397, 'Cross-Reactive Donor-Specific CD8(+) Tregs Efficiently Prevent Transplant Rejection', 'Picarda E, Bézie S, Usero L, Ossart J, Besnard M, Halim H, Echasserieau K, Usal C, Rossjohn J, Bernardeau K, Gras S, Guillonneau C', 'Cell Rep', '0019-01-01', 1, '3187553', 7.815);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (398, 'Increased degradation of ATP is driven by memory regulatory T cells in kidneytransplantation tolerance', 'Durand M, Dubois F, Dejou C, Durand E, Danger R, Chesneau M, Brosseau C,Guerif P, Soulillou JP, Degauque N, Eliaou JF, Giral M, Bonnefoy N, Brouard S', 'Kidney Int', '0018-01-01', 1, '29455908', 8.306);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (399, 'Analyses of the short-and long-term graft survival after kidney transplantation in Europe between 1986 and 2015', 'Coemans M, Süsal C, Döhler B, Anglicheau D, Giral M, Bestard O, Legendre C,Emonds MP, Kuypers D, Molenberghs G, Verbeke G, Naesens M', 'Kidney Int', '0018-01-01', 1, '30049474', 8.306);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (400, 'A composite score associated with spontaneous operational tolerance in kidney transplantrecipients', 'Danger R, Chesneau M, Paul C, Guérif P, Durand M, Newell KA, Kanaparthi S,Turka LA, Soulillou JP, Houlgatte R, Giral M, Ramstein G, Brouard S', 'Kidney Int', '0017-01-01', 1, '28242033', 8.306);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (401, 'Each additional hour of coldischemia time significantly increases the risk of graft failure and mortalityfollowing renal transplantation', 'Debout A, Foucher Y, Trébern-Launay K, Legendre C, Kreis H, Mourad G,Garrigue V, Morelon E, Buron F, Rostaing L, Kamar N, Kessler M, Ladrière M,Poignas A, Blidi A, Soulillou JP, Giral M, Dantan E', 'Kidney Int', '0015-01-01', 1, '25229341', 8.306);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (402, 'A common gene signature across multiple studies relatebiomarkers and functional regulation in tolerance to renal allograft', 'Baron D, Ramstein G, Chesneau M, Echasseriau Y, Pallier A, Paul C, DegauqueN, Hernandez-Fuentes MP, Sanchez-Fueyo A, Newell KA, Giral M, Soulillou JP,Houlgatte R, Brouard S', 'Kidney Int', '0015-01-01', 1, '25629549', 8.306);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (403, 'The Author Replies', 'Brouard S', 'Kidney Int', '0015-01-01', 1, '26649667', 8.306);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (404, 'Shiga toxin-producing Escherichia coli-associated hemolytic uremic syndrome in solid organ transplant recipients', 'Ville S, Ydee A, Garandeau C, Canet E, Tissot A, Cantarovich D, Frémeaux-Bacchi V, Mariani-Kurkdjian P, Provôt F, Fakhouri F', 'Kidney Int', '0019-01-01', 1, '31759490', 8.306);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (405, 'The authors reply', 'Le Clech A, Frémeaux-Bacchi V, Fakhouri F', 'Kidney Int', '0019-01-01', 1, '31331469', 8.306);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (317, 'Development of automated annotation software for human embryo morphokinetics.', 'Feyeux M, Reignier A, Mocaer M, Lammers J, Meistermann D, Barrière P, Paul-Gilloteaux P, David L, Fréour T', 'Hum Reprod', '0020-01-01', 1, '32163566', 5.506);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (56, 'CFTRinactivation by lentiviral vector-mediated RNA interference and CRISPR-Cas9genome editing in human airway epithelial cells', 'Bellec J, Bacchetta M, Losa D, Anegon I, Chanson M, Nguyen TH', 'Curr Gene Ther', '0015-01-01', 1, '26264708', 2.218);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (301, 'Aberrant T cell immunity triggered by human Respiratory Syncytial Virus and human Metapneumovirus infection', 'González AE, Lay MK, Jara EL, Espinoza JA, Gómez RS, Soto J, Rivera CA, AbarcaK, Bueno SM, Riedel CA, Kalergis AM', 'Virulence', '0017-01-01', 1, '27911218', 4.775);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (304, 'Role of myeloid regulatorycells (MRCs) in maintaining tissue homeostasis and promoting tolerance inautoimmunity, inflammatory disease and transplantation', 'Amodio G, Cichy J, Conde P, Matteoli G, Moreau A, Ochando J, Oral BH, PekarovaM, Ryan EJ, Roth J, Sohrabi Y, Cuturi MC, Gregori S', 'CANCER IMMUNOL IMMUN', '0019-01-01', 1, '30357490', 4.9);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (305, 'MICA Mutant A5 1 Influences BK Polyomavirus Reactivation and Associated Nephropathy After KidneyTransplantation', 'Tonnerre P, Gérard N, Gavlovsky PJ, Mazalrey S, Hourmant M, Cheneau ML,Cesbron-Gautier A, Renaudin K, Bressollette-Bodin C, Charreau B', 'J Infect Dis', '0016-01-01', 1, '27130430', 5.045);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (306, 'Host-range shift between emerging P[8]-4 rotavirus and common P[8] and P[4] strains.', 'Khachou A, Le Moullac-Vaidye B, Peltier C, Breiman A, Imbert-Marcille BM, Ruvoen-Clouet N, Aouni M, Mastouri M, Chouchane S, Le Pendu J', 'J Infect Dis', '0020-01-01', 1, '32188998', 5.045);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (320, 'Peripheralphenotype and gene expression profiles of combined liver-kidney transplantpatients', 'Dumontet E, Danger R, Vagefi PA, Londoño MC, Pallier A, Lozano JJ, Giral M,Degauque N, Soulillou JP, Martínez-Llordella M, Lee H, Latournerie M, Boudjema K,Dulong J, Tarte K, Sanchez-Fueyo A, Feng S, Brouard S, Conchon S', 'Liver Int', '0016-01-01', 1, '26193627', 5.542);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (302, 'Notch signaling mediates crosstalk between endothelialcells and macrophages via Dll4 and IL6 in cardiac microvascular inflammation', 'Pabois A, Pagie S, Gérard N, Laboisse C, Pattier S, Hulin P, Nedellec S,Toquet C, Charreau B', 'Biochem Pharmacol', '0016-01-01', 1, '26826491', 4.825);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (307, 'Fine-mapping theinteraction between DC-SIGN and the cytomegalovirus envelope glycoprotein B', 'Chéneau C, Coulon F, Porkolab V, Fieschi F, Laurant S, Razanajaona-Doll D, PinJJ, Borst EM, Messerle M, Bressollette-Bodin C, Halary F', 'J Infect Dis', '0018-01-01', 1, '29648611', 5.045);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (308, 'Molecular Mechanisms of Stem Cell Pluripotencyand Cell Fate Specification', 'Findlay GM, David L, Beyer TA', 'J Mol Biol', '0017-01-01', 1, '28302388', 5.067);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (309, 'Bronchiectasis is highly prevalent in anti-MPO ANCA-associated vasculitis and is associated with a distinct diseasepresentation', 'Néel A, Espitia-Thibault A, Arrigoni PP, Volteau C, Rimbert M, Masseau A,Agard C, Fakhouri F, Liberge R, Hamidou M', 'SEMIN ARTHRITIS RHEU', '0017-01-01', 1, '29336783', 5.072);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (310, 'Notch signaling triggered via the ligand DLL4impedes M2 macrophage differentiation and promotes their apoptosis', 'Pagie S, Gérard N, Charreau B', 'Cell Commun Signal', '0018-01-01', 1, '29321062', 5.111);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (311, 'Immune Cells and Molecular Networks in Experimentally InducedPulpitis', 'Renard E, Gaudin A, Bienvenu G, Amiaud J, Farges JC, Cuturi MC, Moreau A,Alliot-Licht B', 'J Dent Res', '0016-01-01', 1, '26472753', 5.125);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (281, 'C-Type Lectin-Like Receptors As Emerging Orchestrators of Sterile Inflammation Represent Potential Therapeutic Targets', 'Chiffoleau E', 'Front Immunol', '0018-01-01', 1, '29497419', 4.716);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (312, 'Ceruloplasmin deficiency does not induce macrophagic iron overload: lessons from a new rat model of hereditary aceruloplasminemia', 'Kenawi M, Rouger E, Island ML, Leroyer P, Robin F, Rémy S, Tesson L, Anegon I, Nay K, Derbré F, Brissot P, Ropert M, Cavey T, Loréal O', 'FASEB J', '0019-01-01', 1, '31560858', 5.391);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (313, 'xternal validation of a time-lapse prediction model', 'Freour T, Le Fleuter N, Lammers J, Splingart C, Reignier A, Barrière P', 'Fertil Steril', '0015-01-01', 1, '25624197', 5.411);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (314, 'Role of JAK inhibitors and immune cells in transplantation', 'Sailliet N, Brosseau C, Robert JM, Brouard S', 'CYTOKINE GROWTH F R', '0019-01-01', 1, '31133508', 5.458);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (315, 'Opposing roles of IL-10 in acutebacterial infection', 'Peñaloza HF, Schultz BM, Nieto PA, Salazar GA, Suazo I, Gonzalez PA, RiedelCA, Alvarez-Lobos MM, Kalergis AM, Bueno SM', 'CYTOKINE GROWTH F R', '0016-01-01', 1, '27522641', 5.458);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (316, 'HumanInduced Pluripotent Stem Cell-Derived Astrocytes Are Differentially Activated by Multiple Sclerosis-Associated Cytokines', 'Perriot S, Mathias A, Perriard G, Canales M, Jonkmans N, Merienne N, MeunierC, El Kassar L, Perrier AL, Laplaud DA, Schluep M, Déglon N, Du Pasquier R', 'STEM CELL REP', '0018-01-01', 1, '30409508', 5.499);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (318, 'Female obesity does not impact live birth rate after frozen-thawed blastocyst transfer.', 'Prost E, Reignier A, Leperlier F, Caillet P, Barrière P, Fréour T, Lefebvre T', 'Hum Reprod', '0020-01-01', 1, '32170315', 5.506);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (319, 'Time-lapse in the IVF lab: howshould we assess potential benefit?', 'Basile N, Barriere P, Meseguer M, Freour T', 'Hum Reprod', '0015-01-01', 1, '25750207', 5.506);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (321, 'Liver regeneration following repeatedreversible portal vein embolization in an experimental model', 'Tranchart H, Koffi GM, Gaillard M, Lainas P, Poüs C, Gonin P, Nguyen TH,Dubart-Kupperschmitt A, Dagher I', 'BRIT J SURG', '0016-01-01', 1, '27256140', 5.586);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (413, 'Anti-CD28 Antibody and Belatacept ExertDifferential Effects on Mechanisms of Renal Allograft Rejection', 'Ville S, Poirier N, Branchereau J, Charpy V, Pengam S, Nerriere-Daguin V, LeBas-Bernardet S, Coulon F, Mary C, Chenouard A, Hervouet J, Minault D, NedellecS, Renaudin K, Vanhove B, Blancho G', 'J Am Soc Nephrol', '0016-01-01', 1, '27160407', 8.547);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (54, 'Genetic screening of male patients with primaryhypogammaglobulinemia can guide diagnosis and clinical management', 'Vince N, Mouillot G, Malphettes M, Limou S, Boutboul D, Guignet A, Bertrand V,Pellet P, Gourraud PA, Debré P, Oksenhendler E, Théodorou I, Fieschi C; DEFIStudy Group', 'Hum Immunol', '0018-01-01', 1, '29709555', 2.202);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (55, 'Preface Genes don''t care', 'Anegon I, Nguyen TH', 'Curr Gene Ther', '0015-01-01', 1, '25632944', 2.218);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (412, 'Terminally Differentiated Effector Memory CD8(+) T Cells Identify Kidney Transplant Recipients at High Risk of Graft Failure.', 'Jacquemont L, Tilly G, Yap M, Doan-Ngoc TM, Danger R, Guérif P, Delbos F, Martinet B, Giral M, Foucher Y, Brouard S, Degauque N', 'J Am Soc Nephrol', '0020-01-01', 1, '32165419', 8.547);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (322, 'Chitinase 3-like proteins asdiagnostic and prognostic biomarkers of multiple sclerosis', 'Hinsinger G, Galéotti N, Nabholz N, Urbach S, Rigau V, Demattei C, Lehmann S,Camu W, Labauge P, Castelnovo G, Brassat D, Loussouarn D, Salou M, Laplaud D,Casez O, Bockaert J, Marin P, Thouvenot E', 'MULT SCLER J', '0015-01-01', 1, '25698171', 5.649);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (407, 'APOL1 nephropathy risk variants do not associate with subclinical atherosclerosis or left ventricular mass in middle-aged black adults', 'Gutiérrez OM, Limou S, Lin F, Peralta CA, Kramer HJ, Carr JJ, Bibbins-Domingo K, Winkler CA, Lewis CE, Kopp JB.', 'Kidney Int', '0018-01-01', 1, '29042080', 8.306);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (205, 'The DESCARTES-Nantes survey of kidney transplant recipients displaying clinical operational tolerance identifies35 new tolerant patients and 34 almost tolerant patients', 'Massart A, Pallier A, Pascual J, Viklicky O, Budde K, Spasovski G, Klinger M,Sever MS, Sørensen SS, Hadaya K, Oberbauer R, Dudley C, De Fijter JW, Yussim A,Hazzan M, Wekerle T, Berglund D, De Biase C, Pérez-Sáez MJ, Mühlfeld A, OrlandoG, Clemente K, Lai Q, Pisani F, Kandus A, Baas M, Bemelman F, Ponikvar JB, MazouzH, Stratta P, Subra JF, Villemain F, Hoitsma A, Braun L, Cantarell MC, Colak H,Courtney A, Frasca GM, Howse M, Naesens M, Reischig T, Serón D, Seyahi N, Tugmen C, Alonso Hernandez A, Be?a L, Biancone L, Cuna V, Díaz-Corte C, Dufay A,Gaasbeek A, Garnier A, Gatault P, Gentil Govantes MA, Glowacki F, Gross O,Hurault de Ligny B, Huynh-Do U, Janbon B, Jiménez Del Cerro LA, Keller F, LaManna G, Lauzurica R, Le Monies De Sagazan H, Thaiss F, Legendre C, Martin S,Moal MC, Noël C, Pillebout E, Piredda GB, Puga AR, Sulowicz W, Tuglular S,Prokopova M, Chesneau M, Le Moine A, Guérif P, Soulillou JP, Abramowicz M, Giral M, Racapé J, Maggiore U, Brouard S, Abramowicz D', 'NEPHROL DIAL TRANSPL', '0016-01-01', 1, '26763669', 4.198);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (266, 'Distribution of Bacterial ?1,3-Galactosyltransferase Genes in the Human Gut Microbiome', 'Montassier E, Al-Ghalith GA, Mathé C, Le Bastard Q, Douillard V, Garnier A, Guimon R, Raimondeau B, Touchefeu Y, Duchalais E, Vince N, Limou S, Gourraud PA, Laplaud DA, Nicot AB, Soulillou JP, Berthelot L', 'Front Immunol', '0020-01-01', 1, '31998300', 4.716);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (267, 'Cross-Reactivity of TCR Repertoire:Current Concepts, Challenges, and Implication for Allotransplantation', 'Degauque N, Brouard S, Soulillou JP', 'Front Immunol', '0016-01-01', 1, '27047489', 4.716);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (325, 'Effect of assisted reproductive technology on multiple sclerosis relapses: Case series and meta-analysis', 'Bove R, Rankin K, Lin C, Zhao C, Correale J, Hellwig K, Michel L, Laplaud DA, Chitnis T', 'MULT SCLER J', '0019-01-01', 1, '31368394', 5.649);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (326, 'High-dose biotin in progressive multiple sclerosis: A prospective study of 178 patients in routine clinical practice', 'Couloume L, Barbin L, Leray E, Wiertlewski S, Le Page E, Kerbrat A, Ory S, Le Port D, Edan G, Laplaud DA, Michel L', 'MULT SCLER J', '0019-01-01', 1, '31845825', 5.649);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (329, 'Harnessing electronic medical records to advance research on multiple sclerosis', 'Damotte V, Lizee A, Tremblay M, Agrawal A, Khankhanian P, Santaniello A, Gomez R, Lincoln R, Tang W, Chen T, Lee N, Villoslada P, Hollenbach JA, Bevan CD, Graves J, Bove R, Goodin DS, Green AJ, Baranzini SE, Cree BA, Henry RG, Hauser SL, Gelfand JM, Gourraud P-A.', 'MULT SCLER J', '0019-01-01', 1, '29310490', 5.649);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (331, 'NOTO Transcription Factor Directs Human Induced Pluripotent Stem Cell-Derived Mesendoderm Progenitors to a Notochordal Fate. Cells.', 'Colombier P, Halgand B, Chédeville C, Chariau C, François-Campion V, Kilens S, Vedrenne N, Clouet J, David L, Guicheux J, Camus A.', 'Cells', '0020-01-01', 1, '32102328', 5.656);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (414, 'Early Acute Microvascular Kidney Transplant Rejection in the Absence of Anti-HLA Antibodies Is Associated with Preformed IgG Antibodies against Diverse Glomerular Endothelial Cell Antigens', 'Delville M, Lamarthée B, Pagie S, See SB, Rabant M, Burger C, Gatault P, Giral M, Thaunat O, Arzouk N, Hertig A, Hazzan M, Matignon M, Mariat C, Caillard S, Kamar N, Sayegh J, Westeel PF, Garrouste C, Ladrière M, Vuiblet V, Rivalan J, Merville P, Bertrand D, Le Moine A, Duong Van Huyen JP, Cesbron A, Cagnard N, Alibeu O, Satchell SC, Legendre C, Zorn E, Taupin JL, Charreau B, Anglicheau D', 'J Am Soc Nephrol', '0019-01-01', 1, '30850439', 8.547);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (366, 'Tacrolimus- versus Sirolimus-based immunosuppression after simultaneous pancreas and kidney transplantation: 5 years results of a randomised trial', 'Cantarovich D, Kervella D, Karam G, Dantal J, Blancho G, Giral M, Garandeau C, Houzet A, Ville S, Branchereau J, Delbos F, Guillot-Gueguen C, Volteau C, Leroy M, Renaudin K, Soulillou JP, Hourmant M.', 'Am J Transplant', '0020-01-01', 1, '32022990', 7.163);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (348, 'A joint modelfor longitudinal and time-to-event data to better assess the specific role ofdonor and recipient factors on long-term kidney transplantation outcomes', 'Fournier MC, Foucher Y, Blanche P, Buron F, Giral M, Dantan E', 'Eur J Epidemiol', '0016-01-01', 1, '26832337', 6.529);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (359, 'Immunoregulatory properties of the cytokine IL-34', 'Guillonneau C, Bézie S, Anegon I', 'Cell Mol Life Sci', '0017-01-01', 1, '28258292', 7.014);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (361, 'Propensityscore-based comparison of the graft failure risk between kidney transplantrecipients of standard and expanded criteria donor grafts: towards increasing thepool of marginal donors', 'Querard AH, Le Borgne F, Dion A, Giral M, Mourad G, Garrigue V, Rostaing L,Kamar N, Loupy A, Legendre C, Morelon E, Buron F, Foucher Y, Dantan E', 'Am J Transplant', '0018-01-01', 1, '29316230', 7.163);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (363, 'Neutrophils cause a "NET" increase in skin allograft allogenicity', 'Brouard S, Mooney N', 'Am J Transplant', '0019-01-01', 1, '31846552', 7.163);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (364, 'SIRP?/CD47 axis controls the maintenance of transplant tolerance sustained by Myeloid Derived-Suppressor Cells', 'Pengam S, Durand J, Usal C, Gauttier V, Dilek N, Martinet B, Daguin V, Mary C, Thepenier V, Teppaz G, Renaudin K, Blancho G, Vanhove B, Poirier N', 'Am J Transplant', '0019-01-01', 1, '31207067', 7.163);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (415, 'A FamilialC3GN Secondary to Defective C3 Regulation by Complement Receptor 1 and ComplementFactor H', 'Chauvet S, Roumenina LT, Bruneau S, Marinozzi MC, Rybkine T, Schramm EC, JavaA, Atkinson JP, Aldigier JC, Bridoux F, Touchard G, Fremeaux-Bacchi V', 'J Am Soc Nephrol', '0016-01-01', 1, '26471127', 8.547);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (365, 'Blood CD9(+) B Cell, a biomarker of bronchiolitis obliterans syndrome after lung transplantation', 'Brosseau C, Danger R, Durand M, Durand E, Foureau A, Lacoste P, Tissot A, Roux A, Reynaud-Gaubert M, Kessler R, Mussot S, Dromer C, Brugière O, Mornex JF, Guillemain R, Claustre J, Magnan A, Brouard S; COLT and SysCLAD Consortia', 'Am J Transplant', '0019-01-01', 1, '31305014', 7.163);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (271, 'Broad Impairment of Natural Killer Cells from Operationally Tolerant KidneyTransplanted Patients', 'Dugast E, David G, Oger R, Danger R, Judor JP, Gagne K, Chesneau M, DegauqueN, Paul P, Picard C, Guerif P, Conchon S, Giral M, Gervois N, Retière C, Brouard S', 'Front Immunol', '0017-01-01', 1, '29312288', 4.716);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (275, 'A Potential Role of SalmonellaInfection in the Onset of Inflammatory Bowel Diseases', 'Schultz BM, Paduro CA, Salazar GA, Salazar-Echegarai FJ, Sebastián VP, Riedel CA, Kalergis AM, Alvarez-Lobos M, Bueno SM', 'Front Immunol', '0017-01-01', 1, '28293241', 4.716);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (276, 'Heme-Oxygenase-1 Expression Contributes to theImmunoregulation Induced by Fasciola hepatica and Promotes Infection', 'Carasi P, Rodríguez E, da Costa V, Frigerio S, Brossard N, Noya V, Robello C,Anegon I, Freire T', 'Front Immunol', '0017-01-01', 1, '28798750', 4.716);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (367, 'Distinct peripheral blood molecular signature emerges with successful tacrolimus withdrawal in kidney transplant recipients', 'Cravedi P, Fribourg M, Zhang W, Yi Z, Zaslavsky E, Nudelman G, Anderson L, Hartzell S, Brouard S, Heeger PS', 'Am J Transplant', '0020-01-01', 1, '32459070', 7.163);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (273, 'Involvement of CD8(+) T Cells inMultiple Sclerosis', 'Salou M, Nicol B, Garcia A, Laplaud DA', 'Front Immunol', '0015-01-01', 1, '26635816', 4.716);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (277, 'A Herpes Simplex VirusType 2 Deleted for Glycoprotein D Enables Dendritic Cells to Activate CD4(+) and CD8(+) T Cells', 'Retamal-Díaz AR, Kalergis AM, Bueno SM, González PA', 'Front Immunol', '0017-01-01', 1, '28848543', 4.716);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (74, 'Anew protoparvovirus in human fecal samples and cutaneous T cell lymphomas(mycosis fungoides)', 'Phan TG, Dreno B, da Costa AC, Li L, Orlandi P, Deng X, Kapusinszky B,Siqueira J, Knol AC, Halary F, Dantal J, Alexander KA, Pesavento PA, Delwart E', 'Virology', '0016-01-01', 1, '27393975', 2.657);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (274, 'Co-Stimulatory Blockade of the CD28/CD80-86/CTLA-4 Balance in Transplantation: Impact on Memory T Cells?', 'Ville S, Poirier N, Blancho G, Vanhove B', 'Front Immunol', '0015-01-01', 1, '26322044', 4.716);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (182, 'Urine-derived cells provide a readily accessible cell type for feeder-free mRNA reprogramming', 'Gaignerie A, Lefort N, Rousselle M, Forest-Choquet V, Flippe L, Francois-Campion V, Girardeau A, Caillaud A, Chariau C, Francheteau Q, Derevier A, Chaubron F, Knöbel S, Gaborit N, Si-Tayeb K, David L.', 'SCI REP-UK', '0018-01-01', 1, '30254308', 4.011);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (362, 'Remission of type 1 diabetes mellitusrecurrence 6 years after simultaneous pancreas and kidney transplantation', 'Kervella D, Scharbarg E, Mahot-Moreau P, Renaudin K, Branchereau J, Karam G,Chaillous L, Bach K, Cantarovich D', 'Am J Transplant', '0018-01-01', 1, '29745003', 7.163);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (223, 'estational Hypothyroxinemia Affects Glutamatergic Synaptic Protein Distribution and Neuronal Plasticity Through Neuron-Astrocyte Interplay', 'Cisternas P, Louveau A, Bueno SM, Kalergis AM, Boudin H, Riedel CA', 'Mol Neurobiol', '0016-01-01', 1, '26687181', 4.586);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (225, 'Induction therapy in elderly kidney transplant recipients with low immunological risk', 'Masset C, Boucquemont J, Garandeau C, Buron F, Morelon E, Girerd S, Ladrière M, Mourad G, Garrigue V, Cassuto E, Albano L, Foucher Y, Dantal J; DIVAT Consortium', 'Transplantation', '0019-01-01', 1, '31283665', 4.593);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (226, 'External Validation of the DynPG for Kidney Transplant Recipients.', 'Lenain R, Dantan E, Giral M, Foucher Y, Asar Ö, Naesens M, Hazzan M, Fournier MC.', 'Transplantation', '0020-01-01', 1, '32108750', 4.593);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (268, 'IL-15 Harnesses Pro-inflammatory Function of TEMRA CD8 in Kidney-Transplant Recipients.', 'Tilly G, Doan-Ngoc TM, Yap M, Caristan A, Jacquemont L, Danger R, Cadoux M, Bruneau S, Giral M, Guerif P, Nicol B, Garcia A, Laplaud DA, Brouard S, Pecqueur Hellman C, Degauque N', 'Front Immunol', '0017-01-01', 1, '28713392', 4.716);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (183, 'Contribution of SLC22A12 on hypouricemia and its clinical significance for screening purposes', 'Cha DH, Gee HY, Cachau R, Choi JM, Park D, Jee SH, Ryu S, Kim KK, Won HH, Limou S, Myung W, Winkler CA, Cho SK', 'SCI REP-UK', '0019-01-01', 1, '31591475', 4.011);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (184, 'Resistin expression in human monocytes is controlled by two linked promoter SNPs mediating NFKB p50/p50 binding and C-methylation', 'Kumar D, Lee B, Puan KJ, Lee W, Luis BS, Yusof N, Andiappan AK, Del Rosario R, Poschmann J, Kumar P, DeLibero G, Singhal A, Prabhakar S, De Yun W, Poidinger M, Rötzschke O', 'SCI REP-UK', '0019-01-01', 1, '31645609', 4.011);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (185, 'Role of indoleamine 2,3-dioxygenase in testicular immune-privilege', 'Gualdoni GS, Jacobo PV, Sobarzo CM, Pérez CV, Matzkin ME, Höcht C, Frungieri MB, Hill M, Anegon I, Lustig L, Guazzone VA', 'SCI REP-UK', '0019-01-01', 1, '31685866', 4.011);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (288, 'C-Type Lectin-Like Receptors: Head or Tail in Cell Death Immunity.', 'Drouin M, Saenz J, Chiffoleau E.', 'Front Immunol', '0020-01-01', 1, '32133013', 4.716);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (290, 'Alternative Splice Transcripts for MHC Class I-like MICA Encode NovelNKG2D Ligands with Agonist or Antagonist Functions', 'Gavlovsky PJ, Tonnerre P, Gérard N, Nedellec S, Daman AW, McFarland BJ,Charreau B', 'J Immunol', '0016-01-01', 1, '27342847', 4.718);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (293, 'Selective blockade of CD28-mediated T cell costimulation protects rhesus monkeys against acute fatal experimentalautoimmune encephalomyelitis', 'Haanstra KG, Dijkman K, Bashir N, Bauer J, Mary C, Poirier N, Baker P,Crossan CL, Scobie L, ''t Hart BA, Vanhove B', 'J Immunol', '0015-01-01', 1, '25589073', 4.718);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (113, 'Renal cortical volume: High correlation with pre- and post-operative renal function in living kidney donors', 'Gardan E, Jacquemont L, Perret C, Heudes PM, Gourraud PA, Hourmant M, Frampas E, Limou S', 'Eur J Radiol', '0018-01-01', 1, '29362141', 2.948);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (299, 'Breakdown of Immune Tolerance in AIRE-Deficient Rats Induces a Severe Autoimmune Polyendocrinopathy-Candidiasis-Ectodermal Dystrophy-like Autoimmune Disease', 'Ossart J, Moreau A, Autrusseau E, Ménoret S, Martin JC, Besnard M, Ouisse LH, Tesson L, Flippe L, Kisand K, Peterson P, Hubert FX, Anegon I, Josien R, Guillonneau C', 'J Immunol', '0018-01-01', 1, '29959280', 4.718);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (59, 'New insights andcurrent tools for genetically engineered (GE) sheep and goats', 'Menchaca A, Anegon I, Whitelaw CB, Baldassarre H, Crispo M', 'Theriogenology', '0016-01-01', 1, '27155732', 2.299);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (300, 'Targeting the interleukin-7 receptor alpha by an anti-CD127 monoclonal antibody improves allergic airway inflammation in mice.', 'Le Mai H, Van Ha Nguyen T, Bouchaud G, Henrio K, Cheminant MA, Magnan A, Brouard S.', 'Clin Exp Allergy', '0020-01-01', 1, '32418317', 4.741);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (186, 'Otoferlin gene editing in sheep via CRISPR-assisted ssODN-mediated Homology Directed Repair', 'Menchaca A, Dos Santos-Neto PC, Souza-Neves M, Cuadro F, Mulet AP, Tesson L, Chenouard V, Guiffès A, Heslan JM, Gantier M, Anegón I, Crispo M.', 'SCI REP-UK', '0020-01-01', 1, '32265471', 4.011);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (285, 'Dendritic Cell Activating Receptor 1 (DCAR1) Associates With Fc?RI? and Is Expressed by Myeloid Cell Subsets in the Rat', 'Daws MR, Nakken B, Lobato-Pascual A, Josien R, Dissen E, Fossum S', 'Front Immunol', '0019-01-01', 1, '31134097', 4.716);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (289, 'Characterization of Rat ILCs Reveals ILC2 as the Dominant Intestinal Subset.', 'Abidi A, Laurent T, Bériou G, Bouchet-Delbos L, Fourgeux C, Louvet C, Triki-Marrakchi R, Poschmann J, Josien R, Martin J.', 'Front Immunol', '0020-01-01', 1, '32140157', 4.716);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (291, 'First-in-Human Study in Healthy Subjects with FR104, a Pegylated Monoclonal Antibody Fragment Antagonist of CD28', 'Poirier N, Blancho G, Hiance M, Mary C, Van Assche T, Lempoels J, Ramael S,Wang W, Thepenier V, Braudeau C, Salabert N, Josien R, Anderson I, Gourley I,Soulillou JP, Coquoz D, Vanhove B', 'J Immunol', '0016-01-01', 1, '27849166', 4.718);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (295, 'Selective CD28 Antagonist Blunts Memory Immune Responses and Promotes Long-TermControl of Skin Inflammation in Nonhuman Primates', 'Poirier N, Chevalier M, Mary C, Hervouet J, Minault D, Baker P, Ville S, LeBas-Bernardet S, Dilek N, Belarif L, Cassagnau E, Scobie L, Blancho G, Vanhove B', 'J Immunol', '0016-01-01', 1, '26597009', 4.718);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (298, 'Heme Oxygenase-1 Modulates Human Respiratory SyncytialVirus Replication and Lung Pathogenesis during Infection', 'Espinoza JA, León MA, Céspedes PF, Gómez RS, Canedo-Marroquín G, Riquelme SA, Salazar-Echegarai FJ, Blancou P, Simon T, Anegon I, Lay MK, González PA, RiedelCA, Bueno SM, Kalergis AM', 'J Immunol', '0017-01-01', 1, '28566367', 4.718);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (324, 'MD1003 (high-dose biotin)for the treatment of progressive multiple sclerosis: A randomised, double-blind, placebo-controlled study', 'Tourbah A, Lebrun-Frenay C, Edan G, Clanet M, Papeix C, Vukusic S, De Sèze J, Debouverie M, Gout O, Clavelou P, Defer G, Laplaud DA, Moreau T, Labauge P,Brochet B, Sedel F, Pelletier J; MS-SPI study group', 'MULT SCLER J', '0016-01-01', 1, '27589059', 5.649);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (416, 'High circulatingCD4(+)CD25(hi)FOXP3(+) T-cell sub-population early after lung transplantation is associated with development of bronchiolitis obliterans syndrome', 'Durand M, Lacoste P, Danger R, Jacquemont L, Brosseau C, Durand E, Tilly G,Loy J, Foureau A, Royer PJ, Tissot A, Roux A, Reynaud-Gaubert M, Kessler R,Mussot S, Dromer C, Brugière O, Mornex JF, Guillemain R, Claustre J, Degauque N, Magnan A, Brouard S; COLT and SysCLAD Consortia', 'J HEART LUNG TRANSPL', '0018-01-01', 1, '29571601', 8.578);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (417, '?? T-cell receptors from multiple sclerosis brain lesionsshow MAIT cell-related features', 'Held K, Bhonsle-Deeng L, Siewert K, Sato W, Beltrán E, Schmidt S, Rühl G, NgJK, Engerer P, Moser M, Klinkert WE, Babbe H, Misgeld T, Wekerle H, Laplaud DA,Hohlfeld R, Dornmair K', 'Neurology', '0015-01-01', 1, '25977934', 8.689);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (64, 'Standardized and weighted time-dependent receiver operatingcharacteristic curves to evaluate the intrinsic prognostic capacities of a markerby taking into account confounding factors', 'Le Borgne F, Combescure C, Gillaizeau F, Giral M, Chapal M, Giraudeau B,Foucher Y', 'Stat Methods Med Res', '0017-01-01', 1, '28633603', 2.388);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (187, 'Involvement of the CX3CL1(fractalkine)/CX3CR1 pathway in the pathogenesis of acute graft-versus-hostdisease', 'Brissot E, Bossard C, Malard F, Braudeau C, Chevallier P, Guillaume T,Delaunay J, Josien R, Gregoire M, Gaugler B, Mohty M', 'J LEUKOCYTE BIOL', '0015-01-01', 1, '25420917', 4.012);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (188, 'Novel therapies and vaccines against the humanrespiratory syncytial virus', 'Rivera CA, Gómez RS, Díaz RA, Céspedes PF, Espinoza JA, González PA, RiedelCA, Bueno SM, Kalergis AM', 'EXPERT OPIN INV DRUG', '0015-01-01', 1, '26457559', 4.031);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (287, 'Impact of APOL1 Genetic Variants on HIV-1 Infection and Disease Progression', 'An P, Kirk GD, Limou S, Binns-Roemer E, Kopp JB, Winkler CA', 'Front Immunol', '0019-01-01', 1, '30733721', 4.716);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (294, 'Compensatory Regulatory Networks between CD8 T, B, and Myeloid Cells in OrganTransplantation Tolerance', 'Bézie S, Picarda E, Ossart J, Martinet B, Anegon I, Guillonneau C', 'J Immunol', '0015-01-01', 1, '26553075', 4.718);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (283, 'CD28 Costimulation of T Helper 1 Cells Enhances Cytokine Release In Vivo', 'Langenhorst D, Haack S, Göb S, Uri A, Lühder F, Vanhove B, Hünig T, Beyersdorf N', 'Front Immunol', '0018-01-01', 1, '29868020', 4.716);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (292, 'Regulatory B Cells with a Partial Defect inCD40 Signaling and Overexpressing Granzyme B Transfer Allograft Tolerance inRodents', 'Durand J, Huchet V, Merieau E, Usal C, Chesneau M, Remy S, Heslan M, Anegon I,Cuturi MC, Brouard S, Chiffoleau E', 'J Immunol', '0015-01-01', 1, '26432892', 4.718);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (189, 'Cytomegalovirus-Infected Primary Endothelial Cells TriggerNKG2C+ Natural Killer Cells', 'Djaoud Z, Riou R, Gavlovsky PJ, Mehlal S, Bressollette C, Gérard N, Gagne K,Charreau B, Retière C', 'J Innate Immun', '0016-01-01', 1, '27116381', 4.085);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (282, 'Tolerogenic Dendritic Cells in Solid OrganTransplantation: Where Do We Stand?', 'Marín E, Cuturi MC, Moreau A', 'Front Immunol', '0018-01-01', 1, '29520275', 4.716);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (190, 'Inhibition of complement improves graft outcomein a pig model of kidney autotransplantation', 'Delpech PO, Thuillier R, SaintYves T, Danion J, Le Pape S, van Amersfoort ES, Oortwijn B, Blancho G, Hauet T', 'J Transl Med', '0016-01-01', 1, '27663514', 4.098);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (191, 'Newborn Screening for Severe Combined Immunodeficiency: Analytic and Clinical Performance of the T Cell Receptor Excision Circle Assay in France (DEPISTREC Study)', 'Audrain MAP, Léger AJC, Hémont CAF, Mirallié SM, Cheillan D, Rimbert MGM, Le Thuaut AM, Sébille-Rivain VA, Prat A, Pinel EMQ, Divry E, Dert CGL, Fournier MAG, Thomas CJC', 'J Clin Immunol', '0018-01-01', 1, '30251145', 4.128);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (202, 'Comparison of graft and patient survival according to thetransplantation centre policy for 1-year screening biopsy among stable kidneyrecipients: a propensity score-based study', 'Couvrat-Desvergnes G, Foucher Y, Le Borgne F, Dion A, Mourad G, Garrigue V,Legendre C, Rostaing L, Kamar N, Kessler M, Ladrière M, Morelon E, Buron F, GiralM, Dantan E', 'NEPHROL DIAL TRANSPL', '0018-01-01', 1, '30060106', 4.198);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (203, 'Lackof impact of pre-emptive deceased-donor kidney transplantation on graft outcomes:a propensity score-based study', 'Foucher Y, Le Borgne F, Legendre C, Morelon E, Buron F, Girerd S, Ladrière M, Mourad G, Garrigue V, Glotz D, Lefaucheur C, Cassuto E, Albano L, Giral M', 'NEPHROL DIAL TRANSPL', '0018-01-01', 1, '30325453', 4.198);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (286, 'Immunophenotype of a Rat Model of Duchenne''s Disease and Demonstration of Improved Muscle Strength After Anti-CD45RC Antibody Treatment', 'Ouisse LH, Remy S, Lafoux A, Larcher T, Tesson L, Chenouard V, Guillonneau C, Brusselle L, Vimond N, Rouger K, Péréon Y, Chenouard A, Gras-Le Guen C, Braudeau C, Josien R, Huchet C, Anegon I', 'Front Immunol', '0019-01-01', 1, '31552055', 4.716);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (396, 'Improved Genome Editing Efficiency and Flexibility Using ModifiedOligonucleotides with TALEN and CRISPR-Cas9 Nucleases', 'Renaud JB, Boix C, Charpentier M, De Cian A, Cochennec J, Duvernois-Berthet E,Perrouault L, Tesson L, Edouard J, Thinard R, Cherifi Y, Menoret S, Fontanière S,de Crozé N, Fraichard A, Sohm F, Anegon I, Concordet JP, Giovannangeli C', 'Cell Rep', '0016-01-01', 1, '26923600', 7.815);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (411, 'Tolerant Kidney Transplant Patients Produce B Cells with RegulatoryProperties', 'Chesneau M, Michel L, Dugast E, Chenouard A, Baron D, Pallier A, Durand J,Braza F, Guerif P, Laplaud DA, Soulillou JP, Giral M, Degauque N, Chiffoleau E,Brouard S', 'J Am Soc Nephrol', '0015-01-01', 1, '25644114', 8.547);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (1, '[Learning pathologic anatomy during medicalformation: Understanding the contribution of the motivation]', 'Toquet C, Normand A, Guihard G', 'Ann Pathol', '0018-01-01', 1, '29843971', 0.415);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (8, '[Retroperitoneal fibrosis in adults:Main characteristics and relevance of the diagnostic procedures based on aretrospective multicenter study on 77 cases]', 'Lioger B, Yahiaoui Y, Kahn JE, Fakhouri F, Belenfant X, Papo T, Magnant J,Maillot F, Vordos D, Godeau B, Michel M', 'Rev Med Interne', '0016-01-01', 1, '26415922', 0.81);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (65, 'Optimal threshold estimatorof a prognostic marker by maximizing a time-dependent expected utility functionfor a patient-centered stratified medicine', 'Dantan E, Foucher Y, Lorent M, Giral M, Tessier P', 'Stat Methods Med Res', '0016-01-01', 1, '28937334', 2.388);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (221, 'Hepatic lentiviral gene transfer prevents thelong-term onset of hepatic tumours of glycogen storage disease type 1a in mice', 'Clar J, Mutel E, Gri B, Creneguy A, Stefanutti A, Gaillard S, Ferry N, Beuf O,Mithieux G, Nguyen TH, Rajas F', 'Hum Mol Genet', '0015-01-01', 1, '25561689', 4.544);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (408, 'Atypical and secondary hemolyticuremic syndromes have a distinct presentation and no common genetic risk factors', 'Le Clech A, Simon-Tillaux N, Provôt F, Delmas Y, Vieira-Martins P, Limou S,Halimi JM, Le Quintrec M, Lebourg L, Grangé S, Karras A, Ribes D, Jourde-ChicheN, Rondeau E, Frémeaux-Bacchi V, Fakhouri F', 'Kidney Int', '0019-01-01', 1, '30982675', 8.306);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (409, 'Minimal change disease with pulmonary embolism and a kidney lesion', 'Ronsin C, Meyer J, Ville S', 'Kidney Int', '0019-01-01', 1, '31122710', 8.306);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (75, 'New insights about excisable pathogenicityislands in Salmonella and their contribution to virulence', 'Nieto PA, Pardo-Roa C, Salazar-Echegarai FJ, Tobar HE, Coronado-Arrázola I,Riedel CA, Kalergis AM, Bueno SM', 'Microbes Infect', '0016-01-01', 1, '26939722', 2.669);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (76, 'Contribution of autophagy to antiviral immunity', 'Rey-Jurado E, Riedel CA, González PA, Bueno SM, Kalergis AM', 'FEBS Lett', '0015-01-01', 1, '26297829', 2.675);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (410, 'Central Role of CD45RA- Foxp3hi Memory Regulatory T Cells inClinical Kidney Transplantation Tolerance', 'Braza F, Dugast E, Panov I, Paul C, Vogt K, Pallier A, Chesneau M, Baron D,Guerif P, Lei H, Laplaud DA, Volk HD, Degauque N, Giral M, Soulillou JP, SawitzkiB, Brouard S', 'J Am Soc Nephrol', '0015-01-01', 1, '25556168', 8.547);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (77, 'Predictive medicine in multiple sclerosis: A systematic review', 'Havas J, Leray E, Rollot F, Casey R, Michel L, Lejeune F, Wiertlewski S, Laplaud D, Foucher Y', 'MULT SCLER RELAT DIS', '0020-01-01', 1, '32004856', 2.725);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (427, 'Impaired efferocytosis and neutrophil extracellular traps clearance by macrophages in ARDS', 'Grégoire M, Uhel F, Lesouhaitier M, Gacouin A, Guirriec M, Mourcin F, Dumontet E, Chalin A, Samson M, Berthelot LL, Tissot A, Kerjouan M, Jouneau S, Le Tulzo Y, Tarte K, Zmijewski JW, Tadié JM', 'Eur Respir J', '0018-01-01', 1, '29946009', 11.807);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (78, 'Feasibility and safety of laparoscopic living donor nephrectomy in case of right kidney and multiple-renal artery kidney: a systematic review of the literature', 'Broudeur L, Karam G, Chelghaf I, De Vergie S, Rigaud J, Perrouin Verbe MA, Branchereau J', 'World J Urol', '0019-01-01', 1, '31129713', 2.761);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (79, 'Mortality Prediction after the First Year of Kidney Transplantation: An Observational Study on Two European Cohorts', 'Lorent M, Giral M, Pascual M, Koller MT, Steiger J, Trébern-Launay K, LegendreC, Kreis H, Mourad G, Garrigue V, Rostaing L, Kamar N, Kessler M, Ladrière M,Morelon E, Buron F, Golshayan D, Foucher Y', 'PLoS One', '0016-01-01', 1, '27152510', 2.776);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (433, 'CtIP fusion to Cas9 enhances transgene integration by homology-dependent repair', 'Charpentier M, Khedher AHY, Menoret S, Brion A, Lamribet K, Dardillac E, Boix C, Perrouault L, Tesson L, Geny S, De Cian A, Itier JM, Anegon I, Lopez B, Giovannangeli C, Concordet JP', 'Nat Commun', '0018-01-01', 1, '29556040', 11.878);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (80, 'Anti-EBOVGP IgGs Lacking ?1-3-Galactose and Neu5Gc Prolong Survival and Decrease BloodViral Load in EBOV-Infected Guinea Pigs', 'Reynard O, Jacquot F, Evanno G, Mai HL, Salama A, Martinet B, Duvaux O, Bach JM, Conchon S, Judor JP, Perota A, Lagutina I, Duchi R, Lazzari G, Le Berre L,Perreault H, Lheriteau E, Raoul H, Volchkov V, Galli C, Soulillou JP', 'PLoS One', '0016-01-01', 1, '27280712', 2.776);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (81, 'PrenylatedPolyphenols from Clusiaceae and Calophyllaceae with Immunomodulatory Activity on Endothelial Cells', 'Rouger C, Pagie S, Derbré S, Le Ray AM, Richomme P, Charreau B', 'PLoS One', '0016-01-01', 1, '27907087', 2.776);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (418, 'Comparative efficacy of fingolimod vs natalizumab: A Frenchmulticenter observational study', 'Barbin L, Rousseau C, Jousset N, Casey R, Debouverie M, Vukusic S, De Sèze J, Brassat D, Wiertlewski S, Brochet B, Pelletier J, Vermersch P, Edan G,Lebrun-Frenay C, Clavelou P, Thouvenot E, Camdessanché JP, Tourbah A, Stankoff B,Al Khedr A, Cabre P, Papeix C, Berger E, Heinzlef O, Debroucker T, Moreau T, GoutO, Bourre B, Créange A, Labauge P, Magy L, Defer G, Foucher Y, Laplaud DA; CFSEP and OFSEP groups', 'Neurology', '0016-01-01', 1, '26826205', 8.689);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (424, 'Genome-wide Association Study Identifies HLA-DPB1 as a Significant Risk Factor for Severe Aplastic Anemia', 'Savage SA, Viard M, O''hUigin C, Zhou W, Yeager M, Li SA, Wang T, Ramsuran V, Vince N, Vogt A, Hicks B, Burdett L, Chung C, Dean M, de Andrade KC, Freedman ND, Berndt SI, Rothman N, Lan Q, Cerhan JR, Slager SL, Zhang Y, Teras LR, Haagenson M, Chanock SJ, Spellman SR, Wang Y, Willis A, Askar M, Lee SJ, Carrington M, Gadalla SM', 'Am J Hum Genet', '0020-01-01', 1, '32004448', 9.924);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (425, 'Successful correction of hemophilia by CRISPR/Cas9 genomeediting in vivo: delivery vector and immune responses are the key to success', 'Nguyen TH, Anegon I', 'EMBO Mol Med', '0016-01-01', 1, '27138565', 10.624);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (426, 'Future prospects for CD8(+) regulatory T cells in immune tolerance', 'Flippe L, Bézie S, Anegon I, Guillonneau C', 'Immunol Rev', '0019-01-01', 1, '31593314', 11.292);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (419, 'Comparative effectiveness of teriflunomide vs dimethyl fumarate in multiple sclerosis', 'Laplaud DA, Casey R, Barbin L, Debouverie M, De Sèze J, Brassat D, Wiertlewski S, Brochet B, Pelletier J, Vermersch P, Edan G, Lebrun-Frenay C, Clavelou P, Thouvenot E, Camdessanché JP, Tourbah A, Stankoff B, Al Khedr A, Cabre P, Lubetzki C, Papeix C, Berger E, Heinzlef O, Debroucker T, Moreau T, Gout O, Bourre B, Wahab A, Labauge P, Magy L, Defer G, Guennoc AM, Maubeuge N, Labeyrie C, Patry I, Nifle C, Casez O, Michel L, Rollot F, Leray E, Vukusic S, Foucher Y; SFSEP and OFSEP groups', 'Neurology', '0019-01-01', 1, '31300547', 8.689);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (421, 'Molecular Pathways Underlying Adaptive Repair of the Injured Kidney: Novel Donation After Cardiac Death and Acute Kidney Injury Platforms', 'Orlando G, Danger R, Okut H, Edgar L, Bussolati B, Gall E, Bergman CR,Tamburrini R, Gazia C, Farney AC, Freedman BI, McPherson G, Rogers J, Stratta RJ,Brouard S, Walker SJ', 'Ann Surg', '0018-01-01', 1, '30048305', 9.476);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (422, 'Cytotoxic CD8(+) T lymphocytes expressing ALS-causing SOD1 mutant selectively trigger death of spinal motoneurons', 'Coque E, Salsac C, Espinosa-Carrasco G, Varga B, Degauque N, Cadoux M, CrabéR, Virenque A, Soulard C, Fierle JK, Brodovitch A, Libralato M, Végh AG, VenteoS, Scamps F, Boucraut J, Laplaud D, Hernandez J, Gergely C, Vincent T, Raoul C', 'P NATL ACAD SCI USA', '0019-01-01', 1, '30674678', 9.58);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (429, 'IL-7 receptor blockade blunts antigen-specific memory T cell responsesand chronic inflammation in primates', 'Belarif L, Mary C, Jacquemont L, Mai HL, Danger R, Hervouet J, Minault D,Thepenier V, Nerrière-Daguin V, Nguyen E, Pengam S, Largy E, Delobel A, Martinet B, Le Bas-Bernardet S, Brouard S, Soulillou JP, Degauque N, Blancho G, Vanhove B,Poirier N', 'Nat Commun', '0018-01-01', 1, '30367166', 11.878);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (430, 'Missing self triggers NK cell-mediated chronic vascular rejection of solid organ transplants', 'Koenig A, Chen CC, Marçais A, Barba T, Mathias V, Sicard A, Rabeyrin M, Racapé M, Duong-Van-Huyen JP, Bruneval P, Loupy A, Dussurgey S, Ducreux S, Meas-Yedid V, Olivo-Marin JC, Paidassi H, Guillemain R, Taupin JL, Callemeyn J, Morelon E, Nicoletti A, Charreau B, Dubois V, Naesens M, Walzer T, Defrance T, Thaunat O', 'Nat Commun', '0019-01-01', 1, '31767837', 11.878);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (439, 'IL-34 is a Treg-specific cytokine and mediates transplanttolerance', 'Bézie S, Picarda E, Ossart J, Tesson L, Usal C, Renaudin K, Anegon I,Guillonneau C', 'J Clin Invest', '0015-01-01', 1, '26389674', 12.282);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (443, 'Systematic review on clinicaloutcomes following selection of human preimplantation embryos with time-lapsemonitoring', 'Freour T, Basile N, Barriere P, Meseguer M', 'Hum Reprod Update', '0015-01-01', 1, '25293345', 12.878);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (82, 'Sequential Targeting of CD52 and TNF Allows Early Minimization Therapy in Kidney Transplantation: From a Biomarker to Targeting in a Proof-Of-Concept Trial', 'Viklicky O, Hruba P, Tomiuk S, Schmitz S, Gerstmayer B, Sawitzki B, Miqueu P, Mrazova P, Tycova I, Svobodova E, Honsova E, Janssen U, Volk HD, Reinke P', 'PLoS One', '0017-01-01', 1, '28085915', 2.776);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (83, 'Bone marrow cell extract promotes the regeneration of irradiatedbone', 'Michel G, Blery P, Henoux M, Guicheux J, Weiss P, Brouard S, Malard O,Espitalier F', 'PLoS One', '0017-01-01', 1, '28542343', 2.776);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (85, 'Biomarkers of IgAvasculitis nephritis in children', 'Pillebout E, Jamin A, Ayari H, Housset P, Pierre M, Sauvaget V, Viglietti D,Deschenes G, Monteiro RC, Berthelot L; HSPrognosis group', 'PLoS One', '0017-01-01', 1, '29190714', 2.776);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (86, 'Characterization of brain dystrophins absence and impact in dystrophin-deficient Dmdmdx rat model.', 'Caudal D, François V, Lafoux A, Ledevin M, Anegon I, Le Guiner C, Larcher T, Huchet C', 'PLoS One', '0020-01-01', 1, '32160266', 2.776);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (435, 'A systems biology approach uncovers cell-specific gene regulatory effects of genetic associations in multiple sclerosis', 'International Multiple Sclerosis Genetics Consortium', 'Nat Commun', '0019-01-01', 1, '31110181', 11.878);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (278, 'CD28 Blockade Ex Vivo Induces Alloantigen-Specific Immune Tolerance but Preserves T-Cell Pathogen Reactivity', 'Dillinger B, Ahmadi-Erber S, Soukup K, Halfmann A, Schrom S, Vanhove B,Steinberger P, Geyeregger R, Ladisch S, Dohnal AM', 'Front Immunol', '0017-01-01', 1, '28979262', 4.716);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (423, 'Multicentric standardized flow cytometry routine assessment of septic patient to predictclinical worsening', 'Daix T, Guerin E, Tavernier E, Mercier E, Gissot V, Hérault O, Mira JP, Dumas F, Chapuis N, Guitton C, Béné MC, Quenot JP, Tissier C, Guy J, Piton G, Roggy A, Muller G, Legac É, de Prost N, Khellaf M, Wagner-Ballon O, Coudroy R, DindinaudE, Uhel F, Roussel M, Lafon T, Jeannet R, Vargas F, Fleureau C, Roux M, Allou K, Vignon P, Feuillard J, François B; Septiflux trial Group', 'Chest', '0018-01-01', 1, '29705219', 9.657);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (438, 'CD28 blockade controls T cell activation toprevent graft-versus-host disease in primates', 'Watkins BK, Tkachev V, Furlan SN, Hunt DJ, Betz K, Yu A, Brown M, Poirier N,Zheng HB, Taraseviciute A, Colonna L, Mary C, Blancho G, Soulillou JP,Panoskaltsis-Mortari A, Sharma P, Garcia A, Strobert E, Hamby K, Garrett A, DeaneT, Blazar BR, Vanhove B, Kean LS', 'J Clin Invest', '0018-01-01', 1, '30102255', 12.282);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (2, '[COLT: Ten years of research in lung transplantation, results andperspectives]', 'Tissot A, Foureau A, Brosseau C, Danger R, Roux A, Bernasconi E, Gomez C,Durand M, Picard BR, Le Pavec J, Claustre J, Lacoste P, Benmerad M, Pain M,Siroux V, Royer PJ, Mordant P, Reynaud-Gaubert M, Kessler R, Brugière O, MornexJF, Dromer C, Dahan M, Knoop C, Boussaud V, Koutsokera A, Botturi-Cavaillès K,Durand E, Loy J, Nicod L, Pison C, Brouard S, Blanc FX, Magnan A; consortiumCOLT', 'Rev Mal Respir', '0018-01-01', 1, '30100530', 0.545);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (33, 'Comparisons of the performance of different statistical tests for time-to-event analysis withconfounding factors: practical illustrations in kidney transplantation', 'Le Borgne F, Giraudeau B, Querard AH, Giral M, Foucher Y', 'Stat Med', '0015-01-01', 1, '26514380', 1.847);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (36, 'PREventing Delayed GraftFunction by Driving Immunosuppressive InduCtion Treatment (PREDICT-DGF): studyprotocol for a randomized controlled trial', 'Chapal M, Foucher Y, Marguerite M, Neau K, Papuchon E, Daguin P, Morélon E,Mourad G, Cassuto E, Ladrière M, Legendre C, Giral M', 'Trials', '0015-01-01', 1, '26099226', 1.975);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (431, 'CD8(+) T cell-mediated endotheliopathy is a targetable mechanism of neuro-inflammation in Susac syndrome', 'Gross CC, Meyer C, Bhatia U, Yshii L, Kleffner I, Bauer J, Tröscher AR, Schulte-Mecklenbeck A, Herich S, Schneider-Hohendorf T, Plate H, Kuhlmann T, Schwaninger M, Brück W, Pawlitzki M, Laplaud DA, Loussouarn D, Parratt J, Barnett M, Buckland ME, Hardy TA, Reddel SW, Ringelstein M, Dörr J, Wildemann B, Kraemer M, Lassmann H, Höftberger R, Beltrán E, Dornmair K, Schwab N, Klotz L, Meuth SG, Martin-Blondel G, Wiendl H, Liblau R', 'Nat Commun', '0019-01-01', 1, '31852955', 11.878);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (432, 'Parallel derivation of isogenic human primed and naive induced pluripotent stem cells', 'Kilens S, Meistermann D, Moreno D, Chariau C, Gaignerie A, Reignier A,Lelièvre Y, Casanova M, Vallot C, Nedellec S, Flippe L, Firmin J, Song J,Charpentier E, Lammers J, Donnart A, Marec N, Deb W, Bihouée A, Le Caignec C,Pecqueur C, Redon R, Barrière P, Bourdon J, Pasque V, Soumillon M, Mikkelsen TS, Rougeulle C, Fréour T, David L; Milieu Intérieur Consortium', 'Nat Commun', '0018-01-01', 1, '29367672', 11.878);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (440, 'IL-7 receptor influences anti-TNF responsiveness and T cell gut homing in inflammatory bowel disease', 'Belarif L, Danger R, Kermarrec L, Nerrière-Daguin V, Pengam S, Durand T, Mary C, Kerdreux E, Gauttier V, Kucik A, Thepenier V, Martin JC, Chang C, Rahman A, Guen NS, Braudeau C, Abidi A, David G, Malard F, Takoudju C, Martinet B, Gérard N, Neveu I, Neunlist M, Coron E, MacDonald TT, Desreumaux P, Mai HL, Le Bas-Bernardet S, Mosnier JF, Merad M, Josien R, Brouard S, Soulillou JP, Blancho G, Bourreille A, Naveilhan P, Vanhove B, Poirier N', 'J CLIN INVEST', '0019-01-01', 1, '30939120', 12.282);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (460, 'A histone acetylome-wide association study of Alzheimer''s disease identifiesdisease-associated H3K27ac differences in the entorhinal cortex', 'Marzi SJ, Leung SK, Ribarska T, Hannon E, Smith AR, Pishva E, Poschmann J,Moore K, Troakes C, Al-Sarraj S, Beck S, Newman S, Lunnon K, Schalkwyk LC, MillJ', 'Nat Neurosci', '0018-01-01', 1, '30349106', 21.126);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (40, 'A personalized follow-up of kidney transplant recipients using video conferencingbased on a 1-year scoring system predictive of long term graft failure (TELEGRAFTstudy): protocol for a randomized controlled trial', 'Foucher Y, Meurette A, Daguin P, Bonnaud-Antignac A, Hardouin JB, Chailan S, Neau K, Papuchon E, Gaboriau S, Legendre C, Morélon E, Tessier P, Giral M', 'BMC Nephrol', '0015-01-01', 1, '25631635', 2.088);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (445, 'Female obesity is negatively associated with live birth rate following IVF: a systematic review and meta-analysis', 'Sermondade N, Huberlant S, Bourhis-Lefebvre V, Arbo E, Gallot V, Colombani M, Fréour T', 'Hum Reprod Update', '0019-01-01', 1, '30941397', 12.878);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (112, 'A standardized flow cytometry procedure for the monitoring of regulatory T cells in clinical trials', 'Fabien P, Michèle B, Guillaume M, Cécile B, Pierre P, Isabelle P, Jacques T,Myriam L, David K, Michelle R', 'CYTOM PART B-CLIN CY', '0018-01-01', 1, '29316248', 2.938);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (129, 'A single, low dose of a cGMP recombinant BCG vaccine elicitsprotective T cell immunity against the human respiratory syncytial virusinfection and prevents lung pathology in mice', 'Céspedes PF, Rey-Jurado E, Espinoza JA, Rivera CA, Canedo-Marroquín G, BuenoSM, Kalergis AM', 'Vaccine', '0017-01-01', 1, '28065474', 3.269);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (170, 'Patients with ANCA-associated vasculitis admitted to the intensive care unit with acute vasculitis manifestations: a retrospective and comparativemulticentric study', 'Demiselle J, Auchabie J, Beloncle F, Gatault P, Grangé S, Du Cheyron D,Dellamonica J, Boyer S, Beauport DT, Piquilloud L, Letheulle J, Guitton C,Chudeau N, Geri G, Fourrier F, Robert R, Guérot E, Boisramé-Helms J, Galichon P, Dequin PF, Lautrette A, Bollaert PE, Meziani F, Guillevin L, Lerolle N, AugustoJF', 'Ann Intensive Care', '0017-01-01', 1, '28382598', 3.931);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (245, 'Human serum and platelet lysate areappropriate xeno-free alternatives for clinical-grade production of human MuStem cell batches', 'Saury C, Lardenois A, Schleder C, Leroux I, Lieubeau B, David L, Charrier M,Guével L, Viau S, Delorme B, Rouger K', 'Stem Cell Res Ther', '0018-01-01', 1, '29720259', 4.627);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (270, 'Pro-inflammatory State in MonoclonalGammopathy of Undetermined Significance and in Multiple Myeloma Is Characterized by Low Sialylation of Pathogen-Specific and Other Monoclonal Immunoglobulins', 'Bosseboeuf A, Allain-Maillet S, Mennesson N, Tallet A, Rossi C, Garderet L,Caillot D, Moreau P, Piver E, Girodon F, Perreault H, Brouard S, Nicot A,Bigot-Corbel E, Hermouet S, Harb J', 'Front Immunol', '0017-01-01', 1, '29098000', 4.716);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (323, 'Observatoire Français de la Sclérose en Plaques (OFSEP): A unique multimodalnationwide MS registry in France', 'Vukusic S, Casey R, Rollot F, Brochet B, Pelletier J, Laplaud DA, De Sèze J,Cotton F, Moreau T, Stankoff B, Fontaine B, Guillemin F, Debouverie M, Clanet M', 'MULT SCLER J', '0018-01-01', 1, '30541380', 5.649);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (441, 'Killer cell immunoglobulin-like receptor3DL1 variation modifies HLA-B*57 protection against HIV-1', 'Martin MP, Naranbhai V, Shea PR, Qi Y, Ramsuran V, Vince N, Gao X, Thomas R,Brumme ZL, Carlson JM, Wolinsky SM, Goedert JJ, Walker BD, Segal FP, Deeks SG,Haas DW, Migueles SA, Connors M, Michael N, Fellay J, Gostick E, Llewellyn-Lacey S, Price DA, Lafont BA, Pymm P, Saunders PM, Widjaja J, Wong SC, Vivian JP,Rossjohn J, Brooks AG, Carrington M', 'J Clin Invest', '0018-01-01', 1, '29461980', 12.282);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (193, 'Interleukin-10 plays a keyrole in the modulation of neutrophils recruitment and lung inflammation duringinfection by Streptococcus pneumoniae', 'Peñaloza HF, Nieto PA, Muñoz-Durango N, Salazar-Echegarai FJ, Torres J, PargaMJ, Alvarez-Lobos M, Riedel CA, Kalergis AM, Bueno SM', 'Immunology', '0015-01-01', 1, '26032199', 4.147);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (141, 'Significant variation between SNP-based HLA imputations indiverse populations: the last mile is the hardest', 'Pappas DJ, Lizee A, Paunic V, Beutner KR, Motyer A, Vukcevic D, Leslie S,Biesiada J, Meller J, Taylor KD, Zheng X, Zhao LP, Gourraud PA, Hollenbach JA,Mack SJ, Maiers M', 'Pharmacogenomics J', '0017-01-01', 1, '28440342', 3.503);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (61, 'Rapid and reliable diagnosisof Wilson disease using X-ray fluorescence', 'Kaš?áková S, Kewish CM, Rouzière S, Schmitt F, Sobesky R, Poupon J, Sandt C, Francou B, Somogyi A, Samuel D, Jacquemin E, Dubart-Kupperschmitt A, Nguyen TH,Bazin D, Duclos-Vallée JC, Guettier C, Le Naour F', 'J CLIN PATHOL', '0016-01-01', 1, '27499926', 2.346);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (168, 'Gestational Hypothyroidism Improves the Ability of the Female Offspring to ClearStreptococcus pneumoniae Infection and to Recover From Pneumococcal Pneumonia', 'Nieto PA, Peñaloza HF, Salazar-Echegarai FJ, Castellanos RM, Opazo MC,Venegas L, Padilla O, Kalergis AM, Riedel CA, Bueno SM', 'Endocrinology', '0016-01-01', 1, '27035652', 3.8);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (215, 'Unprecedented Thiacalixarene Fucoclusters as Strong Inhibitors of Ebola cis-Cell Infection and HCMV-gB Glycoprotein/DC-SIGN C-type Lectin Interaction', 'Taouai M, Porkolab V, Chakroun K, Cheneau C, Luczkowiak J, Abidi R, Lesur D, Cragg PJ, Halary F, Delgado R, Fieschi F, Benazza M', 'BIOCONJUGATE CHEM', '0019-01-01', 1, '30912645', 4.349);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (296, 'Functional Langerinhigh-Expressing Langerhans-like Cells Can Arise from CD14highCD16- Human Blood Monocytes in Serum-Free Condition', 'Picarda G, Chéneau C, Humbert JM, Bériou G, Pilet P, Martin J, Duteille F,Perrot P, Bellier-Waast F, Heslan M, Haspot F, Guillon F, Josien R, Halary FA', 'J Immunol', '0016-01-01', 1, '27016604', 4.718);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (442, 'Progressive Multifocal Leukoencephalopathy Incidence and Risk Stratification Among Natalizumab Users in France', 'Vukusic S, Rollot F, Casey R, Pique J, Marignier R, Mathey G, Edan G, Brassat D, Ruet A, De Sèze J, Maillart E, Zéphir H, Labauge P, Derache N, Lebrun-Frenay C, Moreau T, Wiertlewski S, Berger E, Moisset X, Rico-Lamy A, Stankoff B, Bensa C, Thouvenot E, Heinzlef O, Al-Khedr A, Bourre B, Vaillant M, Cabre P, Montcuquet A, Wahab A, Camdessanché JP, Tourbah A, Guennoc AM, Hankiewicz K, Patry I, Nifle C, Maubeuge N, Labeyrie C, Vermersch P, Laplaud DA; OFSEP Investigators', 'JAMA Neurol', '0019-01-01', 1, '31479149', 12.321);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (444, 'Leptin andits potential interest in assisted reproduction cycles', 'Catteau A, Caillon H, Barriere P, Denis MG, Masson D, Fréour T', 'Hum Reprod Update', '0016-01-01', 1, '26663219', 12.878);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (446, 'Biomimetic Glyconanoparticle Vaccine for Cancer Immunotherapy', 'Reuven EM, Leviatan Ben-Arye S, Yu H, Duchi R, Perota A, Conchon S, Bachar Abramovitch S, Soulillou JP, Galli C, Chen X, Padler-Karavani V', 'ACS Nano', '0019-01-01', 1, '30840433', 13.903);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (84, 'Fibrinogen-like protein2/fibroleukin induces long-term allograft survival in a rat model throughregulatory B cells', 'Bézie S, Picarda E, Tesson L, Renaudin K, Durand J, Ménoret S, Mérieau E,Chiffoleau E, Guillonneau C, Caron L, Anegon I', 'PLoS One', '0015-01-01', 1, '25763980', 2.776);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (111, 'Real-world effectiveness of Fertistartkit® treatment in women undergoing ART in French clinical practice: a retrospective multicentre study.', 'Languille S, Massin N, Santulli P, Ozanon C, Kazdar N, Lechat X, Soriano E, Frantz-Blancpain S, Callec R, Guerif F, Anahory T, Rongières C, Chevalier N, Barriere P', 'Reprod Biomed Online', '0020-01-01', 1, '32201114', 2.93);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (451, 'Open-label, multicentre,dose-escalating phase II clinical trial on the safety and efficacy of tadekinigalfa (IL-18BP) in adult-onset Still''s disease', 'Gabay C, Fautrel B, Rech J, Spertini F, Feist E, Kötter I, Hachulla E, MorelJ, Schaeverbeke T, Hamidou MA, Martin T, Hellmich B, Lamprecht P, Schulze-KoopsH, Courvoisier DS, Sleight A, Schiffrin EJ', 'Ann Rheum Dis', '0018-01-01', 1, '29472362', 14.299);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (380, 'Interleukin-7 Receptor Blockade by an Anti-CD127 Monoclonal Antibody in Non-Human Primate Kidney Transplantation', 'Mai HL, Van Ha Nguyen T, Branchereau J, Poirier N, Renaudin K, Mary C, Belarif L, Minault D, Hervouet J, Le Bas-Berdardet S, Soulillou JP, Vanhove B, Blancho G, Brouard S', 'Am J Transplant', '0019-01-01', 1, '31344323', 7.163);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (381, 'Unique and specific Proteobacteria diversity in urinary microbiota of tolerant kidney transplanted recipients', 'Colas L, Mongodin EF, Montassier E, Chesneau M, Guerif P, Hittle L, Giral M, Bromberg JS, Brouard S; DIVAT Consortium', 'Am J Transplant', '0019-01-01', 1, '31374143', 7.163);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (386, 'An intermediate level of CD161 expression defines anovel activated, inflammatory, and pathogenic subset of CD8(+) T cells involvedin multiple sclerosis', 'Nicol B, Salou M, Vogel I, Garcia A, Dugast E, Morille J, Kilens S,Charpentier E, Donnart A, Nedellec S, Jacq-Foucher M, Le Frère F, Wiertlewski S, Bourreille A, Brouard S, Michel L, David L, Gourraud PA, Degauque N, Nicot AB,Berthelot L, Laplaud DA', 'J Autoimmun', '0018-01-01', 1, '29054368', 7.543);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (385, 'Gut bacteria Akkermansia elicit a specific IgG response in CSF of patients with MS.', 'Vallino A, Dos Santos A, Mathé CV, Garcia A, Morille J, Dugast E, Shah SP, Héry-Arnaud G, Guilloux CA, Gleeson PJ, Monteiro RC, Soulillou JP, Harb J, Bigot-Corbel E, Michel L, Wiertlewski S, Nicot AB, Laplaud DA, Berthelot L.', 'Neurol Neuroimmunol Neuroinflamm', '0020-01-01', 1, '32123045', 7.353);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (447, 'Prime role of IL-17A in neutrophilia and airwaysmooth muscle contraction in a house dust mite-induced allergic asthma model', 'Chesné J, Braza F, Chadeuf G, Mahay G, Cheminant MA, Loy J, Brouard S,Sauzeau V, Loirand G, Magnan A', 'J ALLERGY CLIN IMMUN', '0015-01-01', 1, '25649077', 14.11);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (448, 'Prevention of allergic asthma through Der p 2 peptide vaccination', 'Bouchaud G, Braza F, Chesné J, Lair D, Chen KW, Rolland-Debord C, Hassoun D, Roussey-Bihouée T, Cheminant MA, Brouard S, Bodinier M, Vrtala S, Magnan A', 'J ALLERGY CLIN IMMUN', '0015-01-01', 1, '25680456', 14.11);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (449, 'Thymic stromallymphopoietin does not activate human basophils', 'Salabert-Le Guen N, Hémont C, Delbove A, Poli C, Braudeau C, Fantou A,Amouriaux K, Bériou G, Martin JC, Colas L, Soumelis V, Josien R', 'J ALLERGY CLIN IMMUN', '0017-01-01', 1, '29208546', 14.11);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (371, 'The Leuven immunomodulatory protocol promotes T-regulatory cells and substantially prolongs survival after first intestinal transplantation', 'Ceulemans LJ, Braza F, Monbaliu D, Jochmans I, De Hertogh G, Du Plessis J,Emonds MP, Kitade H, Kawai M, Li Y, Xiangdong Z, Koshiba T, Sprangers B, Brouard S, Waer M, Pirenne J', 'Am J Transplant', '0016-01-01', 1, '27037650', 7.163);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (372, 'Failure of Calcineurin Inhibitor (Tacrolimus) Weaning Randomized Trial in Long-Term StableKidney Transplant Recipients', 'Dugast E, Soulillou JP, Foucher Y, Papuchon E, Guerif P, Paul C, Riochet D,Chesneau M, Cesbron A, Renaudin K, Dantal J, Giral M, Brouard S', 'Am J Transplant', '0016-01-01', 1, '27367750', 7.163);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (373, 'Fate of transplanted lungs is controlled by immune cells encounterwithin pulmonary allografts', 'Degauque N', 'Am J Transplant', '0018-01-01', 1, '28887863', 7.163);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (374, 'Synthetic fusion protein CAR technology to redirect Tcell antigen specificity to promote organ transplant tolerance', 'Brouard S, Mooney N', 'Am J Transplant', '0017-01-01', 1, '28117926', 7.163);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (375, 'Renal Operational Tolerance Is Associated With a Defect of BloodTfh Cells That Exhibit Impaired B Cell Help', 'Chenouard A, Chesneau M, Bui Nguyen L, Le Bot S, Cadoux M, Dugast E, Paul C,Malard-Castagnet S, Ville S, Guérif P, Soulillou JP, Degauque N, Danger R, Giral M, Brouard S', 'Am J Transplant', '0017-01-01', 1, '27888555', 7.163);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (376, 'T Cells Promote Bronchial Epithelial Cell Secretion ofMatrix Metalloproteinase-9 via a C-C Chemokine Receptor Type 2 Pathway:Implications for Chronic Lung Allograft Dysfunction', 'Pain M, Royer PJ, Loy J, Girardeau A, Tissot A, Lacoste P, Roux A,Reynaud-Gaubert M, Kessler R, Mussot S, Dromer C, Brugière O, Mornex JF,Guillemain R, Dahan M, Knoop C, Botturi K, Pison C, Danger R, Brouard S, MagnanA; COLT Consortium', 'Am J Transplant', '0017-01-01', 1, '27982503', 7.163);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (377, 'FR104, an antagonist anti-CD28 monovalent fab'' antibody, prevents alloimmunization and allows calcineurin inhibitor minimizationin nonhuman primate renal allograft', 'Poirier N, Dilek N, Mary C, Ville S, Coulon F, Branchereau J, Tillou X,Charpy V, Pengam S, Nerriere-Daguin V, Hervouet J, Minault D, Le Bas-Bernardet S,Renaudin K, Vanhove B, Blancho G', 'Am J Transplant', '0015-01-01', 1, '25488654', 7.163);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (378, 'Bortezomib,C1-inhibitor and plasma exchange do not prolong the survival of multi-transgenic GalT-KO pig kidney xenografts in baboons', 'Le Bas-Bernardet S, Tillou X, Branchereau J, Dilek N, Poirier N, Châtelais M,Charreau B, Minault D, Hervouet J, Renaudin K, Crossan C, Scobie L, Takeuchi Y,Diswall M, Breimer ME, Klar N, Daha MR, Simioni P, Robson SC, Nottle MB, SalvarisEJ, Cowan PJ, d''Apice AJ, Sachs DH, Yamada K, Lagutina I, Duchi R, Perota A,Lazzari G, Galli C, Cozzi E, Soulillou JP, Vanhove B, Blancho G', 'Am J Transplant', '0015-01-01', 1, '25612490', 7.163);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (379, 'Regulatory T Cells in Kidney Transplantation: New Directions?', 'Braza F, Durand M, Degauque N, Brouard S', 'Am J Transplant', '0015-01-01', 1, '26234373', 7.163);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (450, 'Association of HLA-DRB1*09:01 with tIgE levels among African ancestry individuals with asthma', 'Vince N, Limou S, Daya M, Morii W, Rafaels N, Geffard E, Douillard V, Walencik A, Boorgula MP, Chavan S, Vergara C, Ortega VE, Wilson JG, Lange LA, Watson H, Nicolae DL, Meyers DA, Hansel NN, Ford JG, Faruque MU, Bleecker ER, Campbell M, Beaty TH, Ruczinski I, Mathias RA, Taub MA, Ober C, Noguchi E, Barnes KC, Torgerson D, Gourraud PA; CAAPA', 'J ALLERGY CLIN IMMUN', '0020-01-01', 1, '31981624', 14.11);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (369, 'Benefits of Using CD45RA and CD28 to Investigate CD8 Subsets in Kidney Transplant Recipients', 'Yap M, Tilly G, Giral M, Brouard S, Degauque N', 'Am J Transplant', '0016-01-01', 1, '26820487', 7.163);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (370, 'Impact of Early BloodTransfusion After Kidney Transplantation on the Incidence of Donor-SpecificAnti-HLA Antibodies', 'Ferrandiz I, Congy-Jolivet N, Del Bello A, Debiol B, Trébern-Launay K,Esposito L, Milongo D, Dörr G, Rostaing L, Kamar N', 'Am J Transplant', '0016-01-01', 1, '26998676', 7.163);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (464, 'Alveolar macrophages are epigenetically altered after inflammation, leading to long-term lung immunoparalysis.', 'Roquilly A, Jacqueline C, Davieau M, Mollé A, Sadek A, Fourgeux C, Rooze P, Broquet A, Misme-Aucouturier B, Chaumette T, Vourc''h M, Cinotti R, Marec N, Gauttier V, McWilliam HEG, Altare F, Poschmann J, Villadangos JA, Asehnoune K.', 'Nat Immunol', '0020-01-01', 1, '32424365', 23.53);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (87, 'Combining ?-Radioimmunotherapy and Adoptive T Cell Therapy toPotentiate Tumor Destruction', 'Ménager J, Gorin JB, Maurel C, Drujont L, Gouard S, Louvet C, Chérel M,Faivre-Chauvet A, Morgenstern A, Bruchertseifer F, Davodeau F, Gaschet J,Guilloux Y', 'PLoS One', '0015-01-01', 1, '26098691', 2.776);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (90, 'Highly conserved extendedhaplotypes of the major histocompatibility complex and their relationship tomultiple sclerosis susceptibility', 'Goodin DS, Khankhanian P, Gourraud PA, Vince N', 'PLoS One', '0018-01-01', 1, '29438392', 2.776);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (91, 'Multiplex CRISPR/Cas9system impairs HCMV replication by excising an essential viral gene', 'Gergen J, Coulon F, Creneguy A, Elain-Duret N, Gutierrez A, Pinkenburg O,Verhoeyen E, Anegon I, Nguyen TH, Halary FA, Haspot F', 'PLoS One', '0018-01-01', 1, '29447206', 2.776);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (92, 'Quantitative and qualitative changes in anti-Neu5Gc antibodyresponse following rabbit anti-thymocyte IgG induction in kidney allograftrecipients', 'Rousse J, Salama A, Leviatan Ben-Arye S, Hruba P, Slatinska J, Evanno G,Duvaux O, Blanchard D, Yu H, Chen X, Bach JM, Padler-Karavani V, Viklicky O,Soulillou JP', 'Eur J Clin Invest', '0019-01-01', 1, '30620396', 2.784);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (391, 'Systematic integration of biomedical knowledgeprioritizes drugs for repurposing', 'Himmelstein DS, Lizee A, Hessler C, Brueggeman L, Chen SL, Hadley D, Green A, Khankhanian P, Baranzini SE', 'Elife', '0017-01-01', 1, '28936969', 7.551);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (394, 'Inflammatory damage on respiratory and nervous systems due to hRSVinfection', 'Bohmwald K, Espinoza JA, Becerra D, Rivera K, Lay MK, Bueno SM, Riedel CA,Kalergis AM', 'Curr Opin Immunol', '0015-01-01', 1, '26026788', 7.667);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (436, 'STING-dependent paracriny shapes apoptotic priming of breast tumors in response to anti-mitotic treatment.', 'Lohard S, Bourgeois N, Maillet L, Gautier F, Fétiveau A, Lasla H, Nguyen F, Vuillier C, Dumont A, Moreau-Aubry A, Frapin M, David L, Loussouarn D, Kerdraon O, Campone M, Jézéquel P, Juin PP, Barillé-Nion S.', 'Nat Commun', '0020-01-01', 1, '31937780', 11.878);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (452, 'Loss of DGK? induces endothelial cell activation and deathindependently of complement activation', 'Bruneau S, Néel M, Roumenina LT, Frimat M, Laurent L, Frémeaux-Bacchi V,Fakhouri F', 'Blood', '0015-01-01', 1, '25498910', 16.562);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (456, 'Dynamic human immune and tumour cells cross-talk inPDX-humanised mice warrants checkpoint inhibitor cancer immunotherapiesassessment', 'Poirier N, Vanhove B', 'Gut', '0018-01-01', 1, '29700013', 17.943);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (457, 'Alloantigen gene transfer to hepatocytes promotes tolerance topancreatic islet graft by inducing CD8(+) regulatory T cells', 'Le Guen V, Judor JP, Boeffard F, Gauttier V, Ferry N, Soulillou JP, Brouard S,Conchon S', 'J Hepatol', '0017-01-01', 1, '27914923', 18.946);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (458, 'Role of TLRs and DAMPs inallograft inflammation and transplant outcomes', 'Braza F, Brouard S, Chadban S, Goldstein DR', 'Nat Rev Nephrol', '0016-01-01', 1, '27026348', 19.684);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (93, 'Receptor activating NF-?B ligand (RANKL) is a constitutiveintracellular protein in resting human basophils and is strongly induced on theirsurface by interleukin 3', 'Poli C, Martin JC, Braudeau C, Bériou G, Hemont C, Charrier C, Guérin S,Heslan M, Josien R', 'Immunobiology', '0015-01-01', 1, '25433635', 2.798);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (390, 'Inhibition of effectorantigen-specific T cells by intradermal administration of heme oxygenase-1inducers', 'Simon T, Pogu J, Rémy S, Brau F, Pogu S, Maquigneau M, Fonteneau JF, PoirierN, Vanhove B, Blancho G, Piaggio E, Anegon I, Blancou P', 'J Autoimmun', '0017-01-01', 1, '28342735', 7.543);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (462, 'Endothelial-to-mesenchymal transition in pulmonary hypertension', 'Ranchoux B, Antigny F, Rucker-Martin C, Hautefort A, Péchoux C, Bogaard HJ,Dorfmüller P, Remy S, Lecerf F, Planté S, Chat S, Fadel E, Houssaini A, Anegon I,Adnot S, Simonneau G, Humbert M, Cohen-Kaminsky S, Perros F', 'Circulation', '0015-01-01', 1, '25593290', 23.054);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (463, 'RRAD mutation causes electrical and cytoskeletal defects in cardiomyocytes derived from a familial case of Brugada syndrome', 'Belbachir N, Portero V, Al Sayed ZR, Gourraud JB, Dilasser F, Jesel L, Guo H, Wu H, Gaborit N, Guilluy C, Girardeau A, Bonnaud S, Simonet F, Karakachoff M, Pattier S, Scott C, Burel S, Marionneau C, Chariau C, Gaignerie A, David L, Genin E, Deleuze JF, Dina C, Sauzeau V, Loirand G, Baró I, Schott JJ, Probst V, Wu JC, Redon R, Charpentier F, Le Scouarnec S', 'Eur Heart J', '0019-01-01', 1, '31114854', 23.239);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (173, 'ROR?t+ cells selectively express redundantcation channels linked to the Golgi apparatus', 'Drujont L, Lemoine A, Moreau A, Bienvenu G, Lancien M, Cens T, Guillot F,Bériou G, Bouchet-Delbos L, Fehling HJ, Chiffoleau E, Nicot AB, Charnet P, MartinJC, Josien R, Cuturi MC, Louvet C', 'SCI REP-UK', '0016-01-01', 1, '27009467', 4.011);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (134, 'Imprinting of maternal thyroidhormones in the offspring', 'Opazo MC, Haensgen H, Bohmwald K, Venegas LF, Boudin H, Elorza AA, Simon F,Fardella C, Bueno SM, Kalergis AM, Riedel CA', 'Int Rev Immunol', '0017-01-01', 1, '28272924', 3.481);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (459, 'Endothelium structure and function in kidney health and disease', 'Jourde-Chiche N, Fakhouri F, Dou L, Bellien J, Burtey S, Frimat M, Jarrot PA, Kaplanski G, Le Quintrec M, Pernin V, Rigothier C, Sallée M, Fremeaux-Bacchi V,Guerrot D, Roumenina LT', 'Nat Rev Nephrol', '0019-01-01', 1, '30607032', 19.684);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (71, 'Genetic overlap between autoimmune diseases and non-Hodgkin lymphoma subtypes', 'Din L, Sheikh M, Kosaraju N, Smedby KE, Bernatsky S, Berndt SI, Skibola CF, Nieters A, Wang S, McKay JD, Cocco P, Maynadié M, Foretová L, Staines A, Mack TM, de Sanjosé S, Vyse TJ, Padyukov L, Monnereau A, Arslan AA, Moore A, Brooks-Wilson AR, Novak AJ, Glimelius B, Birmann BM, Link BK, Stewart C, Vajdic CM, Haioun C, Magnani C, Conti DV, Cox DG, Casabonne D, Albanes D, Kane E, Roman E, Muzi G, Salles G, Giles GG, Adami HO, Ghesquières H, De Vivo I, Clavel J, Cerhan JR, Spinelli JJ, Hofmann J, Vijai J, Curtin K, Costenbader KH, Onel K, Offit K, Teras LR, Morton L, Conde L, Miligi L, Melbye M, Ennas MG, Liebow M, Purdue MP, Glenn M, Southey MC, Din M, Rothman N, Camp NJ, Wong Doo N, Becker N, Pradhan N, Bracci PM, Boffetta P, Vineis P, Brennan P, Kraft P, Lan Q, Severson RK, Vermeulen RCH, Milne RL, Kaaks R, Travis RC, Weinstein SJ, Chanock SJ, Ansell SM, Slager SL, Zheng T, Zhang Y, Benavente Y, Taub Z, Madireddy L, Gourraud PA, Oksenberg JR, Cozen W, Hjalgrim H, Khankhanian P', 'Genet Epidemiol', '0019-01-01', 1, '31407831', 2.5);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (142, 'Large-Scale "OMICS" Studies to Explore the Physiopatholgy of HIV-1 Infection', 'Le Clerc S, Limou S, Zagury JF', 'Front Genet', '0019-01-01', 1, '31572435', 3.517);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (246, 'Low-density lipoprotein receptor-deficient hepatocytes differentiated from induced pluripotent stem cells allow familial hypercholesterolemia modeling, CRISPR/Cas-mediated genetic correction, and productive hepatitis C virus infection', 'Caron J, Pène V, Tolosa L, Villaret M, Luce E, Fourrier A, Heslan JM, Saheb S, Bruckert E, Gómez-Lechón MJ, Nguyen TH, Rosenberg AR, Weber A, Dubart-Kupperschmitt A', 'Stem Cell Res Ther', '0019-01-01', 1, '31358055', 4.627);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (171, 'Liraglutide in whole-pancreas transplant patients with impaired glucose homoeostasis: A case series', 'Cariou B, Bernard C, Cantarovich D', 'Diabetes Metab', '0015-01-01', 1, '25457472', 4.008);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (471, 'Oral versus intravenous high-dosemethylprednisolone for treatment of relapses in patients with multiple sclerosis (COPOUSEP): a randomised, controlled, double-blind, non-inferiority trial', 'Le Page E, Veillard D, Laplaud DA, Hamonic S, Wardi R, Lebrun C, Zagnoli F,Wiertlewski S, Deburghgraeve V, Coustans M, Edan G; COPOUSEP investigators;WestNetwork for Excellence in Neuroscience', 'Lancet', '0015-01-01', 1, '26135706', 59.102);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (58, 'Benign Prostatic Hyperplasia Endoscopic Surgical Procedures in Kidney Transplant Recipients: A Comparison Between Holmium Laser Enucleation of the Prostate, GreenLight Photoselective Vaporization of the Prostate, and Transurethral Resection of the Prostate.', 'Prudhomme T, Marquette T, Péré M, Patard PM, Michiels C, Sallusto F, Rigaud J, Glémain P, Kamar N, Blancho G, Soulié M, Rischmann P, Karam G, Gamé X, Robert G, Branchereau J.', 'J Endourol', '0018-01-01', 1, '31588793', 2.267);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (94, 'An international consensus approach to the management ofatypical hemolytic uremic syndrome in children', 'Loirat C, Fakhouri F, Ariceta G, Besbas N, Bitzan M, Bjerre A, Coppo R, Emma F, Johnson S, Karpman D, Landau D, Langman CB, Lapeyraque AL, Licht C, Nester C, Pecoraro C, Riedl M, van de Kar NC, Van de Walle J, Vivarelli M, Frémeaux-Bacchi V; HUS International', 'Pediatr Nephrol', '0016-01-01', 1, '25859752', 2.816);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (461, 'Human Tolerogenic Dendritic Cells Regulate Immune Responses through Lactate Synthesis', 'Marín E, Bouchet-Delbos L, Renoult O, Louvet C, Nerriere-Daguin V, Managh AJ, Even A, Giraud M, Vu Manh T-P, Aguesse A, Bériou G, Chiffoleau E, Alliot-Licht B, Prieur X, Croyal M, Hutchinson JA, Obermajer N, Geissler EK, Vanhove B, Blancho G, Dalod M, Josien R, Pecqueur C, Cuturi MC, Moreau A', 'Cell Metab', '0019-01-01', 1, '31801055', 22.415);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (133, 'Current challenges in human tooth revitalization', 'Ducret M, Fabre H, Celle A, Mallein-Gerin F, Perrier-Groult E, Alliot-Licht B,Farges JC', 'BIOMED MATER', '0017-01-01', 1, '28372291', 3.44);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (136, 'Elicited and pre-existing anti-Neu5Gc antibodies differentially affect human endothelial cells transcriptome', 'Le Berre L, Danger R, Mai HL, Amon R, Leviatan Ben-Arye S, Bruneau S, Senage T, Perreault H, Teraiya M, Nguyen TVH, Le Tourneau T, Yu H, Chen X, Galli C, Roussel JC, Manez R, Costa C, Brouard S, Galinanes M, Harris KM, Gitelman S, Cozzi E, Charreau B, Padler-Karavani V, Soulillou JP', 'Xenotransplantation', '0019-01-01', 1, '31293002', 3.484);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (169, 'TLR3 promotes MMP-9 production in primaryhuman airway epithelial cells through Wnt/?-catenin signaling', 'Royer PJ, Henrio K, Pain M, Loy J, Roux A, Tissot A, Lacoste P, Pison C,Brouard S, Magnan A; COLT consortium', 'RESP RES', '0017-01-01', 1, '29237464', 3.829);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (172, 'Indications for islet or pancreatic transplantation: Statement of the TREPID Working Group onbehalf of the Société Francophone du Diabète (SFD), Société Francaised''Endocrinologie (SFE), Société Francophone de Transplantation (SFT) and Société Française de Néphrologie-Dialyse-Transplantation (SFNDT)', 'Wojtusciszyn A, Branchereau J, Esposito L, Badet L, Buron F, Chetboun M,Kessler L, Morelon E, Berney T, Pattou F, Benhamou PY, Vantyghem MC', 'Diabetes Metab', '0019-01-01', 1, '30223084', 4.008);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (218, 'Design and characterization of a chitosan-enriched fibrin hydrogel for human dental pulp regeneration', 'Ducret M, Montembault A, Josse J, Pasdeloup M, Celle A, Benchrih R, Mallein-Gerin F, Alliot-Licht B, David L, Farges J-C.', 'Dent Mater', '0019-01-01', 1, '30712823', 4.44);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (349, 'Eculizumab for treatment of rapidlyprogressive C3 glomerulopathy', 'Le Quintrec M, Lionet A, Kandel C, Bourdon F, Gnemmi V, Colombat M, GoujonJM, Frémeaux-Bacchi V, Fakhouri F', 'Am J Kidney Dis', '0015-01-01', 1, '25530108', 6.653);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (284, 'Multi specific Antibody DevelopmentPlatform Based on Human Heavy Chain Antibodies', 'Clarke SC, Ma B, Trinklein ND, Schellenberger U, Osborn MJ, Ouisse LH,Boudreau A, Davison LM, Harris KE, Ugamraj HS, Balasubramani A, Dang KH,Jorgensen B, Ogana HAN, Pham DT, Pratap PP, Sankaran P, Anegon I, van SchootenWC, Brüggemann M, Buelow R, Force Aldred S', 'Front Immunol', '0019-01-01', 1, '30666250', 4.716);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (328, 'Harnessing electronic medical records to advanceresearch on multiple sclerosis', 'Damotte V, Lizée A, Tremblay M, Agrawal A, Khankhanian P, Santaniello A, GomezR, Lincoln R, Tang W, Chen T, Lee N, Villoslada P, Hollenbach JA, Bevan CD,Graves J, Bove R, Goodin DS, Green AJ, Baranzini SE, Cree BA, Henry RG, HauserSL, Gelfand JM, Gourraud PA', 'MULT SCLER J', '0019-01-01', 1, '29310490', 5.649);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (332, 'New insights on the viraland host factors contributing to the airway pathogenesis caused by therespiratory syncytial virus', 'Lay MK, Bueno SM, Gálvez N, Riedel CA, Kalergis AM', 'Crit Rev Microbiol', '0016-01-01', 1, '26119025', 5.697);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (333, 'Transcriptanalysis of laser capture microdissected white matter astrocytes and higherphenol sulfotransferase 1A1 expression during autoimmune neuroinflammation', 'Guillot F, Garcia A, Salou M, Brouard S, Laplaud DA, Nicot AB', 'J NEUROINFLAMM', '0015-01-01', 1, '26141738', 5.7);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (334, 'Genome Editing and DialogicResponsibility: "What''s in a Name?"', 'Blasimme A, Anegon I, Concordet JP, De Vos J, Dubart-Kupperschmitt A, FellousM, Fouchet P, Frydman N, Giovannangeli C, Jouannet P, Serre JL, Steffann J,Rial-Sebbag E, Thomsen M, Cambon-Thomsen A', 'AM J BIOETHICS', '0015-01-01', 1, '26632366', 5.786);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (335, 'Targeting the CD80/CD86 costimulatory pathway with CTLA4-Ig directsmicroglia toward a repair phenotype and promotes axonal outgrowth', 'Louveau A, Nerrière-Daguin V, Vanhove B, Naveilhan P, Neunlist M, Nicot A,Boudin H', 'Glia', '0015-01-01', 1, '26212105', 5.829);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (336, 'Monoclonal IgG in MGUS and multiple myeloma target infectious pathogens', 'Adrien Bosseboeuf, Delphine Feron, Anne Tallet, Cédric Rossi, Cathy Charlier, Laurent Garderet, Denis Caillot, Philippe Moreau, Marina Cardó-Vila, Renata Pasqualini,Wadih Arap, Alfreda Destea, Nelson, Bridget S. Wilson, Hélène Perreault, EricPiver, Pierre Weigel, François Girodon, Jean Harb, Edith Bigot-Corbel and Sylvie Hermouet', 'JCI Insight', '0017-01-01', 1, '28978808', 6.014);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (337, 'Transient antibody targeting of CD45RC induces transplant tolerance and potentantigen-specific regulatory T cells', 'Picarda E, Bézie S, Boucault L, Autrusseau E, Kilens S, Meistermann D,Martinet B, Daguin V, Donnart A, Charpentier E, David L, Anegon I, Guillonneau C', 'JCI Insight', '0017-01-01', 1, '28194440', 6.014);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (338, 'Selective blockade of CD28 on human T cells facilitates regulation of alloimmune responses', 'Zaitsu M, Issa F, Hester J, Vanhove B, Wood KJ', 'JCI Insight', '0017-01-01', 1, '28978798', 6.014);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (339, 'Intra-patient viral evolution in polyomavirus-related diseases', 'McIlroy D, Halary F, Bressollette-Bodin C', 'PHILOS T R SOC B', '0019-01-01', 1, '30955497', 6.139);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (340, 'No Increase in Colon Cancer Risk Following Induction with Neu5Gc-Bearing Rabbit Anti-T Cell IgG (ATG) in Recipients of Kidney Transplants', 'Soulillou JP, Süsal C, Döhler B, Opelz G', 'Cancers (Basel)', '0018-01-01', 1, '30213027', 6.162);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (342, 'Pathogenic Variants in Complement Genesand Risk of Atypical Hemolytic Uremic Syndrome Relapse after EculizumabDiscontinuation', 'Fakhouri F, Fila M, Provôt F, Delmas Y, Barbet C, Châtelet V, Rafat C,Cailliez M, Hogan J, Servais A, Karras A, Makdassi R, Louillet F, Coindre JP,Rondeau E, Loirat C, Frémeaux-Bacchi V', 'CLIN J AM SOC NEPHRO', '0017-01-01', 1, '27799617', 6.243);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (343, 'Lessons from CKD-Related Genetic AssociationStudies-Moving Forward', 'Limou S, Vince N, Parsa A', 'CLIN J AM SOC NEPHRO', '0018-01-01', 1, '29242368', 6.243);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (344, 'Etiology and Outcomes of Thrombotic Microangiopathies', 'Bayer G, von Tokarski F, Thoreau B, Bauvois A, Barbet C, Cloarec S, Mérieau E, Lachot S, Garot D, Bernard L, Gyan E, Perrotin F, Pouplard C, Maillot F, Gatault P, Sautenet B, Rusch E, Buchler M, Vigneau C, Fakhouri F, Halimi JM', 'CLIN J AM SOC NEPHRO', '0019-01-01', 1, '30862697', 6.243);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (345, 'APOL1 Nephropathy Risk Alleles and Risk of Sepsis in Blacks', 'Chaudhary NS, Moore JX, Zakai NA, Judd SE, Naik RP, Limou S, Cushman M, Lange LA, Wang HE, Winkler CA, Irvin MR, Kopp JB, Gutiérrez OM', 'CLIN J AM SOC NEPHRO', '0019-01-01', 1, '31704668', 6.243);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (280, 'Minimum Information aboutT Regulatory Cells: A Step toward Reproducibility and Standardization', 'Fuchs A, Gliwi?ski M, Grageda N, Spiering R, Abbas AK, Appel S, Bacchetta R,Battaglia M, Berglund D, Blazar B, Bluestone JA, Bornhäuser M, Ten Brinke A,Brusko TM, Cools N, Cuturi MC, Geissler E, Giannoukakis N, Go?ab K, Hafler DA,van Ham SM, Hester J, Hippen K, Di Ianni M, Ilic N, Isaacs J, Issa F,Iwaszkiewicz-Grze? D, Jaeckel E, Joosten I, Klatzmann D, Koenen H, van Kooten C, Korsgren O, Kretschmer K, Levings M, Marek-Trzonkowska NM, Martinez-Llordella M, Miljkovic D, Mills KHG, Miranda JP, Piccirillo CA, Putnam AL, Ritter T, RoncaroloMG, Sakaguchi S, Sánchez-Ramón S, Sawitzki B, Sofronic-Milosavljevic L, Sykes M, Tang Q, Vives-Pi M, Waldmann H, Witkowski P, Wood KJ, Gregori S, Hilkens CMU,Lombardi G, Lord P, Martinez-Caceres EM, Trzonkowski P', 'Front Immunol', '0018-01-01', 1, '29379498', 4.716);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (327, 'Neuraxial analgesia is not associated with an increased risk of post-partum relapses in MS', 'Lavie C, Rollot F, Durand-Dubief F, Marignier R, Ionescu I, Casey R, Moreau T, Tourniaire P, Hutchinson M, D''Hooghe MB, Laplaud DA, Clavelou P, De Sèze J, Debouverie M, Brassat D, Pelletier J, Lebrun-Frenay C, Le Page E, Castelnovo G, Berger E, Hautecoeur P, Heinzlef O, Durelli L, Clerico M, Trojano M, Patti F, Vukusic S; PRIMS and POPARTMUS investigators', 'MULT SCLER J', '0019-01-01', 1, '31081475', 5.649);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (341, 'Characteristics of MGUS and Multiple Myeloma According to the Target of Monoclonal Immunoglobulins, Glucosylsphingosine, or Epstein-Barr Virus EBNA-1.', 'Bosseboeuf A, Mennesson N, Allain-Maillet S, Tallet A, Piver E, Decaux O, Moreau C, Moreau P, Lehours P, Mégraud F, Salle V, Bigot-Corbel E, Harb J, Hermouet S.', 'Cancers', '0020-01-01', 1, '32429322', 6.162);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (353, 'Anti-müllerian hormone levels and evolutionin women of reproductive age with breast cancer treated with chemotherapy', 'Freour T, Barrière P, Masson D', 'Eur J Cancer', '0017-01-01', 1, '28135602', 6.68);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (388, 'BOB1 controls memory B-cell fate in the germinal center reaction', 'Levels MJ, Fehres CM, van Baarsen LGM, van Uden NOP, Germar K, O''Toole TG, Blijdorp ICJ, Semmelink JF, Doorenspleet ME, Bakker AQ, Krasavin M, Tomilin A, Brouard S, Spits H, Baeten DLP, Yeremenko NG', 'J Autoimmun', '0019-01-01', 1, '31053401', 7.543);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (140, 'Polymeric mannosides prevent DC-SIGN-mediated cell-infection by cytomegalovirus', 'Brument S, Cheneau C, Brissonnet Y, Deniaud D, Halary F, Gouin SG', 'ORG BIOMOL CHEM', '0017-01-01', 1, '28871303', 3.49);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (149, 'Reconsidering the detection of tolerance toindividualize immunosuppression minimization and to improve long-term kidneygraft outcomes', 'Baron D, Giral M, Brouard S', 'Transpl Int', '0015-01-01', 1, '25851900', 3.526);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (143, 'Impact of antiviralprophylaxis in adults EBV seronegative kidney recipients on early and late PTLDonset: a retrospective cohort study', 'Ville S, Imbert-Marcille BM, Coste-Burel M, Garandeau C, Meurette A,Cantarovitch D, Giral M, Hourmant M, Blancho G, Dantal J', 'Transpl Int', '0018-01-01', 1, '29057508', 3.526);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (355, 'C3 glomerulonephritis in a patient treated with anti-PD-1 antibody', 'Ville S, Kandel-Aznar C, Frémeaux-Bacchi V, Fakhouri F', 'Eur J Cancer', '0019-01-01', 1, '31838404', 6.68);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (437, 'Rabbit antithymocyte globulin-induced serum sickness disease andhuman kidney graft survival', 'Couvrat-Desvergnes G, Salama A, Le Berre L, Evanno G, Viklicky O, Hruba P,Vesely P, Guerif P, Dejoie T, Rousse J, Nicot A, Bach JM, Ang E, Foucher Y,Brouard S, Castagnet S, Giral M, Harb J, Perreault H, Charreau B, Lorent M,Soulillou JP', 'J Clin Invest', '0015-01-01', 1, '26551683', 12.282);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (150, 'Current status of immunosuppressive minimization andtolerance strategies', 'Brouard S, Budde K', 'Transpl Int', '0015-01-01', 1, '26178312', 3.526);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (151, 'Tolerogenic dendritic celltherapy in organ transplantation', 'Moreau A, Alliot-Licht B, Cuturi MC, Blancho G', 'Transpl Int', '0017-01-01', 1, '27864897', 3.526);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (152, 'An extension of the RITUX-ERAH study, multicenter randomized clinical trial comparing rituximab to placebo in acute antibody-mediated rejection after renal transplantation.', 'Bailly E, Ville S, Blancho G, Morelon E, Bamoulid J, Caillard S, Chatelet V, Malvezzi P, Tourret J, Vuiblet V, Anglicheau D, Bertrand D, Grimbert P, Haidar F, Hazzan M, Kamar N, Merville P, Mousson C, Pernin V, Pouteil-Noble C, Purgus R, Sayegh J, Westeel PF, Sautenet B, Gatault P, Büchler M.', 'Transpl Int', '0020-01-01', 1, '32279367', 3.526);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (356, 'Foodallergen-sensitized CCR9(+) lymphocytes enhance airways allergic inflammation in mice', 'Castan L, Cheminant MA, Colas L, Brouard S, Magnan A, Bouchaud G', 'Allergy', '0018-01-01', 1, '29315632', 6.771);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (357, 'A regulatory CD9(+) B-cell subset inhibits HDM-inducedallergic airway inflammation', 'Braza F, Chesne J, Durand M, Dirou S, Brosseau C, Mahay G, Cheminant MA,Magnan A, Brouard S', 'Allergy', '0015-01-01', 1, '26194936', 6.771);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (358, 'An early increase in endothelial protein C receptor is associated with excess mortality in pneumococcal pneumonia with septic shock in the ICU', 'Chapelet A, Foucher Y, Gérard N, Rousseau C, Zambon O, Bretonnière C, Mira JP, Charreau B, Guitton C', 'Crit Care', '0018-01-01', 1, '30290852', 6.959);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (139, 'Regenerative cell therapy for the treatment of hyperbilirubinemic Gunn rats with fresh and frozen human induced pluripotent stem cells-derived hepatic stem cells', 'Fourrier A, Delbos F, Menoret S, Collet C, Thi Thuy LT, Myara A, Petit F, Tolosa L, Laplanche S, Gómez-Lechón MJ, Labrune P, Anegon I, Vallier L, Garnier D, Nguyen TH', 'Xenotransplantation', '0019-01-01', 1, '31342573', 3.484);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (351, 'APOL1-Associated Nephropathy: A KeyContributor to Racial Disparities in CKD', 'Freedman BI, Limou S, Ma L, Kopp JB', 'Am J Kidney Dis', '0018-01-01', 1, '30343724', 6.653);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (145, 'The weekend effect in kidney transplantation outcomes: a French cohort-based study.', 'Ville S, Branchereau J, Cornuaud A, Dantal J, Legendre C, Buron F, Morelon E, Garrigue V, Lequentrec M, Albano L, Cassuto E, Girerd S, Ladrière M, Glotz D, Lefaucher C, Kerleau C, Foucher Y, Giral M; DIVAT consortium.', 'Transpl Int', '0020-01-01', 1, '32428980', 3.526);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (147, 'Vitamin D deficiency is an independent risk factor for PTDM afterkidney transplantation', 'Le Fur A, Fournier MC, Gillaizeau F, Masson D, Giral M, Cariou B, CantarovichD, Dantal J', 'Transpl Int', '0016-01-01', 1, '26426441', 3.526);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (148, 'Ispre-transplant sensitization against angiotensin II type 1 receptor still a risk factor of graft and patient outcome in kidney transplantation in the anti-HLALuminex era? A retrospective study', 'Deltombe C, Gillaizeau F, Anglicheau D, Morelon E, Trébern-Launay K, LeBorgne F, Rimbert M, Guérif P, Malard-Castagnet S, Foucher Y, Giral M', 'Transpl Int', '0017-01-01', 1, '28686316', 3.526);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (352, 'APOL1 Nephropathy Risk Alleles and Mortality in African American Adults: A Cohort Study', 'Gutiérrez OM, Irvin MR, Zakai NA, Naik RP, Chaudhary NS, Estrella MM, Limou S, Judd SE, Cushman M, Kopp JB, Winkler CA.', 'Am J Kidney Dis', '0020-01-01', 1, '31563468', 6.653);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (360, 'Aselective CD28 antagonist and rapamycin synergise to protect against spontaneous autoimmune diabetes in NOD mice', 'Besançon A, Goncalves T, Valette F, Mary C, Vanhove B, Chatenoud L, You S', 'Diabetologia', '0018-01-01', 1, '29845333', 7.113);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (156, 'Neuropathologic,phenotypic and functional analyses of Mucosal Associated Invariant T cells inMultiple Sclerosis', 'Salou M, Nicol B, Garcia A, Baron D, Michel L, Elong-Ngono A, Hulin P,Nedellec S, Jacq-Foucher M, Le Frère F, Jousset N, Bourreille A, Wiertlewski S,Soulillou JP, Brouard S, Nicot AB, Degauque N, Laplaud DA', 'Clin Immunol', '0016-01-01', 1, '27050759', 3.548);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (303, 'Highly efficient in vitro and invivo delivery of functional RNAs using new versatile MS2-chimeric retrovirus-likeparticles', 'Prel A, Caval V, Gayon R, Ravassard P, Duthoit C, Payen E, Maouche-ChretienL, Creneguy A, Nguyen TH, Martin N, Piver E, Sevrain R, Lamouroux L, Leboulch P, Deschaseaux F, Bouillé P, Sensébé L, Pagès JC', 'MOL THER-METH CLIN D', '0015-01-01', 1, '26528487', 4.875);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (434, 'Association study in African-admixed populations across the Americas recapitulates asthma risk loci in non-African populations', 'Daya M, Rafaels N, Brunetti TM, Chavan S, Levin AM, Shetty A, Gignoux CR, Boorgula MP, Wojcik G, Campbell M, Vergara C, Torgerson DG, Ortega VE, Doumatey A, Johnston HR, Acevedo N, Araujo MI, Avila PC, Belbin G, Bleecker E, Bustamante C, Caraballo L, Cruz A, Dunston GM, Eng C, Faruque MU, Ferguson TS, Figueiredo C, Ford JG, Gan W, Gourraud PA, Hansel NN, Hernandez RD, Herrera-Paz EF, Jiménez S, Kenny EE, Knight-Madden J, Kumar R, Lange LA, Lange EM, Lizee A, Maul P, Maul T, Mayorga A, Meyers D, Nicolae DL, O''Connor TD, Oliveira RR, Olopade CO, Olopade O, Qin ZS, Rotimi C, Vince N, Watson H, Wilks RJ, Wilson JG, Salzberg S, Ober C, Burchard EG, Williams LK, Beaty TH, Taub MA, Ruczinski I, Mathias RA, Barnes KC; CAAPA', 'Nat Commun', '0019-01-01', 1, '30787307', 11.878);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (473, 'Regulatory cell therapy in kidney transplantation (The ONE Study): a harmonised design and analysis of seven non-randomised, single-arm, phase 1/2A trials.', 'Sawitzki B, Harden PN, Reinke P, Moreau A, Hutchinson JA, Game DS, Tang Q, Guinan EC, Battaglia M, Burlingham WJ, Roberts ISD, Streitz M, Josien R, Böger CA, Scottà C, Markmann JF, Hester JL, Juerchott K, Braudeau C, James B, Contreras-Ruiz L, van der Net JB, Bergler T, Caldara R, Petchey W, Edinger M, Dupas N, Kapinsky M, Mutzbauer I, Otto NM, Öllinger R, Hernandez-Fuentes MP, Issa F, Ahrens N, Meyenberg C, Karitzky S, Kunzendorf U, Knechtle SJ, Grinyó J, Morris PJ, Brent L, Bushell A, Turka LA, Bluestone JA, Lechler RI, Schlitt HJ, Cuturi MC, Schlickeiser S, Friend PJ, Miloud T, Scheffold A, Secchi A, Crisalli K, Kang SM, Hilton R, Banas B, Blancho G, Volk HD, Lombardi G, Wood KJ, Geissler EK.', 'Lancet', '0020-01-01', 1, '32446407', 59.102);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (62, 'Minimum information about tolerogenicantigen-presenting cells (MITAP): a first step towards reproducibility andstandardisation of cellular therapies', 'Lord P, Spiering R, Aguillon JC, Anderson AE, Appel S, Benitez-Ribas D, TenBrinke A, Broere F, Cools N, Cuturi MC, Diboll J, Geissler EK, Giannoukakis N,Gregori S, van Ham SM, Lattimer S, Marshall L, Harry RA, Hutchinson JA, IsaacsJD, Joosten I, van Kooten C, Lopez Diaz de Cerio A, Nikolic T, Oral HB,Sofronic-Milosavljevic L, Ritter T, Riquelme P, Thomson AW, Trucco M, Vives-Pi M,Martinez-Caceres EM, Hilkens CM', 'PeerJ', '0016-01-01', 1, '27635311', 2.353);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (153, 'Transcriptomics analysis and human preimplantationdevelopment', 'Freour T, Vassena R', 'J Proteomics', '0017-01-01', 1, '27765633', 3.537);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (157, 'Decrease of blood anti-?1,3 Galactose Abs levels in multiple sclerosis (MS) andclinically isolated syndrome (CIS) patients', 'Le Berre L, Rousse J, Gourraud PA, Imbert-Marcille BM, Salama A, Evanno G,Semana G, Nicot A, Dugast E, Guérif P, Adjaoud C, Freour T, Brouard S, AgbalikaF, Marignier R, Brassat D, Laplaud DA, Drouet E, Van Pesch V, Soulillou JP', 'Clin Immunol', '0017-01-01', 1, '28506921', 3.548);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (346, 'HCMV triggers frequent and persistent UL40-specific unconventional HLA-E-restricted CD8 T-cell responses with potential autologous and allogeneic peptide recognition', 'Jouand N, Bressollette-Bodin C, Gérard N, Giral M, Guérif P, Rodallec A, Oger R, Parrot T, Allard M, Cesbron-Gautier A, Gervois N, Charreau B', 'PLoS Pathog', '0018-01-01', 1, '29709038', 6.463);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (154, 'Evasion of early antiviral responses by herpes simplex viruses', 'Suazo PA, Ibañez FJ, Retamal-Díaz AR, Paz-Fiblas MV, Bueno SM, Kalergis AM,González PA', 'MEDIAT INFLAMM', '0015-01-01', 1, '25918478', 3.545);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (222, 'Genome-wide DNA methylation profiling identifies convergent molecular signatures associated with idiopathic and syndromic autism in post-mortem human brain tissue', 'Wong CCY, Smith RG, Hannon E, Ramaswami G, Parikshak NN, Assary E, Troakes C, Poschmann J, Schalkwyk LC, Sun W, Prabhakar S, Geschwind DH, Mill J', 'Hum Mol Genet', '0019-01-01', 1, '31220268', 4.544);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (350, 'Terminal Complement Inhibitor Eculizumab in Adult Patients With Atypical Hemolytic Uremic Syndrome: A Single-Arm, Open-Label Trial', 'Fakhouri F, Hourmant M, Campistol JM, Cataland SR, Espinosa M, Gaber AO, MenneJ, Minetti EE, Provôt F, Rondeau E, Ruggenenti P, Weekers LE, Ogawa M, Bedrosian CL, Legendre CM', 'Am J Kidney Dis', '0016-01-01', 1, '27012908', 6.653);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (368, 'Cell Therapy for Parkinson''s Disease: A Translational Approach to Assess the Role of Local andSystemic Immunosuppression', 'Aron Badin R, Vadori M, Vanhove B, Nerriere-Daguin V, Naveilhan P, Neveu I,Jan C, Lévèque X, Venturi E, Mermillod P, Van Camp N, Dollé F, Guillermier M,Denaro L, Manara R, Citton V, Simioni P, Zampieri P, D''avella D, Rubello D, FanteF, Boldrin M, De Benedictis GM, Cavicchioli L, Sgarabotto D, Plebani M, StefaniAL, Brachet P, Blancho G, Soulillou JP, Hantraye P, Cozzi E', 'Am J Transplant', '0016-01-01', 1, '26749114', 7.163);
INSERT INTO public.publication (id_activity, title, authors, source, publication_date, publication_type_id, pmid, impact_factor) VALUES (155, 'ental Pulp Defence and Repair Mechanisms in Dental Caries', 'Farges JC, Alliot-Licht B, Renard E, Ducret M, Gaudin A, Smith AJ, Cooper PR', 'MEDIAT INFLAMM', '0015-01-01', 1, '26538821', 3.545);


--
-- TOC entry 3811 (class 0 OID 24910)
-- Dependencies: 260
-- Data for Name: publication_statistics; Type: TABLE DATA; Schema: public; Owner: hceres
--



--
-- TOC entry 3812 (class 0 OID 24916)
-- Dependencies: 261
-- Data for Name: publication_type; Type: TABLE DATA; Schema: public; Owner: hceres
--

INSERT INTO public.publication_type (publication_type_id, publication_type_name) VALUES (1, 'Publication');


--
-- TOC entry 3813 (class 0 OID 24919)
-- Dependencies: 262
-- Data for Name: research_contract_funded_public_charitable_inst; Type: TABLE DATA; Schema: public; Owner: hceres
--



--
-- TOC entry 3814 (class 0 OID 24925)
-- Dependencies: 263
-- Data for Name: researcher; Type: TABLE DATA; Schema: public; Owner: hceres
--

INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password)
VALUES (1, 'Ahmil', 'Ghenima', 'Ghemina.Ahmil@univ-nantes.fr', NULL, 'admin', '$2a$10$tR4NMaRiVG.QZdXoCsmEUuDltA7Siy0kisCbUwT3p3P3s9wQWdySi');
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password)
VALUES (2, 'Anegon', 'Ignacio', 'Ignacio.Anegon@univ-nantes.fr', NULL, 'user', '$2a$10$nbNEAKss3/jeNdOPfCqel.cLltnDIfE15jpGFEo7rZw1aY/5nAbzi');
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (3, 'Asehnoune', 'K.', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (4, 'Ba', 'Rokhaya', 'rokhaya.ba@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (5, 'Barrière', 'Paul', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (6, 'Bellague', 'Nail', 'nail.benallegue@etu.univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (7, 'Ben Abid', 'Lina', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (8, 'Benallegue', 'Naïl', 'nail.benallegue@etu.univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (9, 'Beriou', 'Gaëlle', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (10, 'Bernardet', 'Stéphanie', 'Stephanie.Bernardet@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (11, 'Berthelot', 'Laureline', 'laureline.berthelot@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (12, 'Bézie', 'Séverine', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (13, 'Blancho', 'Gilles', 'gilles.blancho@chu-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (14, 'Blineau', 'Serge', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (15, 'Boucard', 'Eléa', 'elea.boucard@etu.univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (16, 'Boucault', 'Laetitia', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (17, 'Boulard', 'Chloé', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (18, 'Bouras', 'M.', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (19, 'Boussamet', 'Léo', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (20, 'Boutoille', 'D.', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (21, 'Branchereau', 'Julien', 'Julien.BRANCHEREAU@chu-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (22, 'Braudeau', 'Cécile', 'Cecile.BRAUDEAU@chu-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (23, 'Bressollette - Bodin', 'Céline', 'celine.bressollette@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (24, 'Brinas', 'François', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (25, 'Brosseau', 'Carole', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (26, 'Brouard', 'Sophie', 'sophie.brouard@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (27, 'Brugière', 'Antoine', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (28, 'Bruneau', 'Sarah', 'sarah.bruneau@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (29, 'Buteau', 'Nabila', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (30, 'Cadoux', 'Marion', 'marion.cadoux@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (31, 'Caillon', 'J.', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (32, 'Campion', 'Valentin', 'valentin.francois-campion@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (33, 'Cantarovich', 'Diego', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (34, 'Cappelier', 'Laura', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (35, 'Cardon', 'Anaïs', 'anais.cardon@etu.univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (36, 'Caroff', 'N.', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (37, 'Castain', 'Louise', 'louise.castain@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (38, 'Chapelle', 'Nicolas', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (39, 'Charles', 'Irène', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (40, 'Charreau', 'Béatrice', 'Beatrice.Charreau@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (41, 'Chauveau', 'Christine', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (42, 'Chéneau', 'Coraline', 'Coraline.Cheneau@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (43, 'Chenouard', 'Alexis', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (44, 'Chesneau', 'Mélanie', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (45, 'Chiffoleau', 'Elise', 'Elise.Chiffoleau@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (46, 'Colas', 'Luc', 'luc.colas@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (47, 'Conchon', 'Sophie', 'Sophie.Conchon@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (48, 'Coulon', 'Flora', 'flora.coulon@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (49, 'Couvrat-Desvergnes', 'Grégoire', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (50, 'Crémet', 'L.', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (51, 'Cuturi', 'Maria Cristina', 'Maria-Cristina.Cuturi@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (52, 'Daguin', 'Véronique', 'Veronique.Daguin@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (53, 'Damodar Rajan', 'Vivek', 'vivekdamodar.ranjan@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (54, 'Danger', 'Richard', 'richard.danger@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (55, 'Daniel', 'Malo', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (56, 'Dantal', 'Jacques', 'jacques.dantal@chu-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (57, 'David', 'Laurent', 'laurent.david@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (58, 'Degauque', 'Nicolas', 'nicolas.degauque@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (59, 'Delage', 'Wesley', 'wesley.delage@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (60, 'Delbos', 'Frédéric', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (61, 'Delbos', 'Laurence', 'Laurence.Delbos@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (62, 'Doan-Ngoc', 'Tra-My', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (63, 'Douillard', 'Venceslas', 'venceslas.douillard@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (64, 'Drouin', 'Marion', 'marion.drouin@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (65, 'Dubois', 'Florian', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (66, 'Dugast', 'Emilie', 'emilie.dugast@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (67, 'Duplouye', 'Pierre', 'pierre.duplouye@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (68, 'Durand', 'Axelle', 'axelle.durand@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (69, 'Durand', 'Eugénie', 'eugenie.durand@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (70, 'Durand', 'Justine', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (71, 'Durand', 'Maxim', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (72, 'Durand-Perdriel', 'Flavie', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (73, 'Dutra Azevedo', 'Ana', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (74, 'Ed-Driouch', 'Chadia', 'chadia.ed-driouch@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (75, 'Evanno', 'Gwénaëlle', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (76, 'Fakhouri', 'Fadi', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (77, 'Falkenreck', 'Dina', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (78, 'Fantou', 'Aurélie', 'aurelie.fantou@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (79, 'Feseha', 'Yodit', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (80, 'Feyeux', 'Magalie', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (81, 'Flippe', 'Léa', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (82, 'Foureau', 'Aurore', 'Aurore.FOUREAU@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (83, 'Fourgeux', 'Cynthia', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (84, 'Fournol', 'Laurence', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (85, 'Fourrier', 'Angélique', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (86, 'Fréour', 'Thomas', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (87, 'Freuchet', 'Antoine', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (88, 'Gaborit', 'B.', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (89, 'Gaisne', 'Raphaël', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (90, 'Gantier', 'Malika', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (91, 'Gantier', 'Malika', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (92, 'Garcia', 'Alexandra', 'alexandra.garcia@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (93, 'Garnier', 'Abel', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (94, 'Geffard', 'Estelle', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (95, 'Gélin', 'Morgane', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (96, 'Gérard', 'Nathalie', 'Nathalie.Gerard@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (97, 'Giral', 'Magali', 'magali.giral@chu-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (98, 'Giraud', 'Matthieu', 'matthieu.giraud@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (99, 'Glemain', 'Alexandre', 'alexandre.gleamain@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (100, 'Gourain', 'Victor', 'Victor.Gourain@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (101, 'Gourraud', 'Pierre-Antoine', 'pierre-antoine.gourraud@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (102, 'Gravoueille', 'Hermelyne', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (103, 'Greig', 'Jenny', 'jenny.greig@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (104, 'Gueno', 'Lucile', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (105, 'Guiffes', 'Aude', 'aude.guiffes@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (106, 'Guiffès', 'Aude', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (107, 'Guillerm', 'Lucie', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (108, 'Guillonneau', 'Carole', 'Carole.Guillonneau@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (109, 'Guillout', 'Maëlle', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (110, 'Guimon', 'Rémi', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (111, 'Halary', 'Franck', 'Franck.Halary@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (112, 'Hamidou', 'Mohamed', 'mohamed.hamidou@chu-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (113, 'Hamon', 'Yveline', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (114, 'Harb', 'Jean', 'jean.harb@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (115, 'Haspot', 'Fabienne', 'fabienne.haspot@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (116, 'Hémont', 'Caroline', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (117, 'Hermet', 'Léo', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (118, 'Hervé', 'Corentin', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (119, 'Hervouet', 'Jérémie', 'jeremy.hervouet@chu-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (120, 'Heslan', 'Jean-Marie', 'Jean-Marie.Heslan@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (121, 'Hoang', 'Kevin', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (122, 'Huchet', 'Virginie', 'virginie.huchet@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (123, 'Humeau', 'Romain', 'romain.humeau@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (124, 'Hysaj', 'Elgeta', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (125, 'Ianniello', 'Ayan', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (126, 'Imbert-Marcille', 'Berthe-Marie', 'berthe-marie.imbert@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (127, 'Jacqueline', 'C.', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (128, 'Jacquemont', 'Lola', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (129, 'Josien', 'Régis', 'Regis.Josien@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (130, 'Jourdan', 'Angélina', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (131, 'Judor', 'Jean-Paul', 'jean-paul.judor@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (132, 'Jullien', 'Jerome', 'jerome.jullien@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (133, 'Kérandel', 'Céline', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (134, 'Kervella', 'Delphine', 'delphine.kervella@etu.univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (135, 'Kilens', 'Stéphanie', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (136, 'Lammers', 'Jenna', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (137, 'Laplaud', 'David', 'david.laplaud@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (138, 'Laurent', 'Thomas', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (139, 'Le Berre', 'Ludmilla', 'Ludmilla.Leberre@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (140, 'Le Bihan', 'Sylvie', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (141, 'Lê Hoa', 'Mai', 'le.hoa-mai@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (142, 'Le Mabecque', 'V.', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (143, 'Lecerf-Defer', 'Amandine', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (144, 'Lejeune', 'Flora', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (145, 'Leman', 'Claire', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (146, 'Letertre', 'Laurence', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (147, 'Limou', 'Sophie', 'Sophie.Limou@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (148, 'Lionnet', 'Arthur', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (149, 'Lizee', 'Antoine', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (150, 'Lopez Robles', 'Maria-Dolores', 'maria-dolores.lopez-robles@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (151, 'Lorant', 'Judith', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (152, 'Louvet', 'C.', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (153, 'Marin', 'Eros', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (154, 'Martin', 'Jérôme', 'Jerome.Martin@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (155, 'Martinet', 'Bernard', 'bernard.martinet@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (156, 'Mathé', 'Camille', 'Camille.Mathe@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (157, 'Mauduit', 'Vincent', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (158, 'McIlroy', 'Dorian', 'dorian.mcilroy@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (159, 'Meistermann', 'Dimitri', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (160, 'Ménoret', 'Séverine', 'severine.menoret@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (161, 'Mérieau', 'Emmanuel', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (162, 'Meurette', 'Aurélie', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (163, 'Michel', 'Laure', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (164, 'Minault', 'David', 'david.minault@chu-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (165, 'Mollé', 'Alice', 'alice.molle@etu.univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (166, 'Moreau', 'Aurélie', 'aurelie.moreau@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (167, 'Morille', 'Jérémy', 'jeremy.morille1@etu.univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (168, 'Morin', 'Martin', 'martin.morin@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (169, 'Mosnier', 'Jean-François', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (170, 'Neel', 'Mélanie', 'melanie.neel@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (171, 'Néel', 'Antoine', 'antoine.neel@chu-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (172, 'Nguyen', 'Elisabeth', 'elisabeth.nguyen@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (173, 'Nguyen', 'Khanh', 'ngoc-khanh.nguyen@etu.univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (174, 'Nguyen', 'Tuan Huy', 'tuan.nguyen@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (175, 'Nicot', 'Arnaud', 'arnaud.nicot@inserm.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (176, 'Ouisse', 'Laure-Hélène', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (177, 'Ouro-Agouda', 'Nabilah', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (178, 'Pajot', 'Pierre', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (179, 'Peltier', 'Cécile', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (180, 'Peynaud', 'François', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (181, 'Picquet', 'Camille', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (182, 'Poschmann', 'Jeremie', 'jeremie.poschmann@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (183, 'Prudhomme', 'T.', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (184, 'Quillaud-Chenouard', 'Vanessa', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (185, 'Rambeau', 'Justine', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (186, 'Rasolofoniaina', 'Haritiana', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (187, 'Redon', 'Valentin', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (188, 'Reignier', 'Arnaud', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (189, 'Rémy', 'Séverine', 'severine.remy@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (190, 'Renand', 'Amédée', 'amedee.renand@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (191, 'Renaudin', 'Karine', 'karine.renaudin@chu-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (192, 'Rimbert', 'Marie', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (193, 'Rispal', 'Raphael', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (194, 'Roquilly', 'A.', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (195, 'Rousse', 'Juliette', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (196, 'Rousseau', 'Olivia', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (197, 'Rousselière', 'Amélie', 'amelie.rousseliere@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (198, 'Saenz', 'Javier', 'Javier.Saenz@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (199, 'Sailliet', 'Nicolas', 'nicolas.sailliet@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (200, 'Salabert', 'Nina', 'nina.salabert@chu-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (201, 'Salama', 'Apolline', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (202, 'Sayadi', 'Sirine', 'sirine.sayadi@imt-atlantique.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (203, 'Scherdel', 'Pauline', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (204, 'Shah', 'Sita', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (205, 'Sinha', 'Debajyoti', 'Debajyoti.Sinha@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (206, 'Sorin', 'Marie', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (207, 'Soulillou', 'Jean-Paul', 'Jean-Paul.Soulillou@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (208, 'Splingart', 'Carole', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (209, 'Suuring', 'Maaike', 'maaike.suuring@etu.univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (210, 'Tesson', 'Laurent', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (211, 'Tilly', 'Gaëlle', 'gaelle.tilly@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (212, 'Tissot', 'Adrien', 'adrien.tissot@chu-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (213, 'Usal', 'Claire', 'claire.usal@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (214, 'Vanhove', 'B.', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (215, 'Ville', 'Simon', 'simon.ville@chu-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (216, 'Vince', 'Nicolas', 'nicolas.vince@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (217, 'Vimond', 'Nadège', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (218, 'Vourc''h', 'M.', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (219, 'Wiertlewski', 'Sandrine', '', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (220, 'Yeremenko', 'Nataliya', 'nataliya.yeremenko@univ-nantes.fr', NULL, NULL, NULL);
INSERT INTO public.researcher (researcher_id, researcher_surname, researcher_name, researcher_email, researcher_orcid, researcher_login, researcher_password) VALUES (224, 'abdo', 'saoud', 'fsf', NULL, NULL, NULL);


--
-- TOC entry 3815 (class 0 OID 24931)
-- Dependencies: 264
-- Data for Name: researcher_nationality; Type: TABLE DATA; Schema: public; Owner: hceres
--



--
-- TOC entry 3816 (class 0 OID 24934)
-- Dependencies: 265
-- Data for Name: reviewing_journal_articles; Type: TABLE DATA; Schema: public; Owner: hceres
--



--
-- TOC entry 3817 (class 0 OID 24940)
-- Dependencies: 266
-- Data for Name: scientific_expertise; Type: TABLE DATA; Schema: public; Owner: hceres
--

INSERT INTO public.scientific_expertise (id_activity, scientific_expertise_type_id, start_date, end_date, description) VALUES (559, 20, '2022-03-10', '2022-03-10', 'sqnhcfb');
INSERT INTO public.scientific_expertise (id_activity, scientific_expertise_type_id, start_date, end_date, description) VALUES (560, 21, '2022-03-10', '2022-03-10', 'jqsdG');
INSERT INTO public.scientific_expertise (id_activity, scientific_expertise_type_id, start_date, end_date, description) VALUES (562, 22, '2022-03-10', '2022-03-10', 'qcdC');
INSERT INTO public.scientific_expertise (id_activity, scientific_expertise_type_id, start_date, end_date, description) VALUES (563, 23, '2022-03-10', '2022-03-10', 'def');
INSERT INTO public.scientific_expertise (id_activity, scientific_expertise_type_id, start_date, end_date, description) VALUES (564, 24, '2022-03-10', '2022-03-10', 'dejh');
INSERT INTO public.scientific_expertise (id_activity, scientific_expertise_type_id, start_date, end_date, description) VALUES (565, 25, '2022-03-14', '2022-03-23', 'test');
INSERT INTO public.scientific_expertise (id_activity, scientific_expertise_type_id, start_date, end_date, description) VALUES (566, 26, '2022-03-14', '2022-03-23', 'test');
INSERT INTO public.scientific_expertise (id_activity, scientific_expertise_type_id, start_date, end_date, description) VALUES (568, 28, '2022-03-14', '2022-03-23', 'test');
INSERT INTO public.scientific_expertise (id_activity, scientific_expertise_type_id, start_date, end_date, description) VALUES (570, 29, '2022-03-15', '2022-03-17', 'test');
INSERT INTO public.scientific_expertise (id_activity, scientific_expertise_type_id, start_date, end_date, description) VALUES (588, 30, '2022-03-26', '2022-03-29', 'scQC');
INSERT INTO public.scientific_expertise (id_activity, scientific_expertise_type_id, start_date, end_date, description) VALUES (599, 31, '2022-03-26', '2022-03-26', 'dd');


--
-- TOC entry 3818 (class 0 OID 24946)
-- Dependencies: 267
-- Data for Name: scientific_expertise_type; Type: TABLE DATA; Schema: public; Owner: hceres
--

INSERT INTO public.scientific_expertise_type (scientific_expertise_type_id, name_choice) VALUES (6, 'Expertise test 1');
INSERT INTO public.scientific_expertise_type (scientific_expertise_type_id, name_choice) VALUES (7, 'Expertise test 1');
INSERT INTO public.scientific_expertise_type (scientific_expertise_type_id, name_choice) VALUES (8, 'Expertise test 1');
INSERT INTO public.scientific_expertise_type (scientific_expertise_type_id, name_choice) VALUES (9, 'Expertise test 1');
INSERT INTO public.scientific_expertise_type (scientific_expertise_type_id, name_choice) VALUES (10, 'Expertise test 1');
INSERT INTO public.scientific_expertise_type (scientific_expertise_type_id, name_choice) VALUES (11, 'Expertise test 1');
INSERT INTO public.scientific_expertise_type (scientific_expertise_type_id, name_choice) VALUES (12, 'Expertise test 1');
INSERT INTO public.scientific_expertise_type (scientific_expertise_type_id, name_choice) VALUES (13, 'Expertise test 1');
INSERT INTO public.scientific_expertise_type (scientific_expertise_type_id, name_choice) VALUES (14, 'Expertise test 1');
INSERT INTO public.scientific_expertise_type (scientific_expertise_type_id, name_choice) VALUES (15, 'Expertise test 1');
INSERT INTO public.scientific_expertise_type (scientific_expertise_type_id, name_choice) VALUES (16, 'Expertise test 1');
INSERT INTO public.scientific_expertise_type (scientific_expertise_type_id, name_choice) VALUES (17, 'Expertise test 1');
INSERT INTO public.scientific_expertise_type (scientific_expertise_type_id, name_choice) VALUES (18, 'QSD');
INSERT INTO public.scientific_expertise_type (scientific_expertise_type_id, name_choice) VALUES (19, 'QSD');
INSERT INTO public.scientific_expertise_type (scientific_expertise_type_id, name_choice) VALUES (20, 'sghqjh');
INSERT INTO public.scientific_expertise_type (scientific_expertise_type_id, name_choice) VALUES (21, 'hqssgf');
INSERT INTO public.scientific_expertise_type (scientific_expertise_type_id, name_choice) VALUES (22, 'sghqjh');
INSERT INTO public.scientific_expertise_type (scientific_expertise_type_id, name_choice) VALUES (23, 'abc');
INSERT INTO public.scientific_expertise_type (scientific_expertise_type_id, name_choice) VALUES (24, 'abcjhh');
INSERT INTO public.scientific_expertise_type (scientific_expertise_type_id, name_choice) VALUES (25, 'sghqjh');
INSERT INTO public.scientific_expertise_type (scientific_expertise_type_id, name_choice) VALUES (26, 'sghqjh');
INSERT INTO public.scientific_expertise_type (scientific_expertise_type_id, name_choice) VALUES (28, 'sghqjh');
INSERT INTO public.scientific_expertise_type (scientific_expertise_type_id, name_choice) VALUES (29, 'sghqjh');
INSERT INTO public.scientific_expertise_type (scientific_expertise_type_id, name_choice) VALUES (30, 'sghqjh');
INSERT INTO public.scientific_expertise_type (scientific_expertise_type_id, name_choice) VALUES (31, 'dsd');


--
-- TOC entry 3820 (class 0 OID 24951)
-- Dependencies: 269
-- Data for Name: sei_cifre_fellowship; Type: TABLE DATA; Schema: public; Owner: hceres
--



--
-- TOC entry 3821 (class 0 OID 24957)
-- Dependencies: 270
-- Data for Name: sei_clinical_trial; Type: TABLE DATA; Schema: public; Owner: hceres
--

INSERT INTO public.sei_clinical_trial (id_activity, start_date, coordinator_partner, title_clinical_trial, end_date, registration_nb, sponsor_name, included_patients_nb, funding, funding_amount) VALUES (520, '2022-02-28', true, 'test1', '2022-03-24', '1454', 'SponsorTest', 10, 'association', 100);
INSERT INTO public.sei_clinical_trial (id_activity, start_date, coordinator_partner, title_clinical_trial, end_date, registration_nb, sponsor_name, included_patients_nb, funding, funding_amount) VALUES (521, '2022-02-28', false, 'test1', '2022-03-24', '1454', 'SponsorTest', 10, 'association', 100);
INSERT INTO public.sei_clinical_trial (id_activity, start_date, coordinator_partner, title_clinical_trial, end_date, registration_nb, sponsor_name, included_patients_nb, funding, funding_amount) VALUES (522, '2022-02-28', false, 'test3', '2022-03-24', '1454554', 'SponsorTest3', 12, 'association2', 200);
INSERT INTO public.sei_clinical_trial (id_activity, start_date, coordinator_partner, title_clinical_trial, end_date, registration_nb, sponsor_name, included_patients_nb, funding, funding_amount) VALUES (529, '2022-03-02', true, 'test3', '2022-03-24', '1454554', 'SponsorTest4', 12, 'association4', 200);
INSERT INTO public.sei_clinical_trial (id_activity, start_date, coordinator_partner, title_clinical_trial, end_date, registration_nb, sponsor_name, included_patients_nb, funding, funding_amount) VALUES (557, '2022-03-05', false, 'DSC', '2022-03-16', '454', 'dvc', 85, 'Ccqs', 25);
INSERT INTO public.sei_clinical_trial (id_activity, start_date, coordinator_partner, title_clinical_trial, end_date, registration_nb, sponsor_name, included_patients_nb, funding, funding_amount) VALUES (558, '2022-03-05', true, 'DSC', '2022-03-16', '454', 'dvc', 85, 'Ccqs', 25);
INSERT INTO public.sei_clinical_trial (id_activity, start_date, coordinator_partner, title_clinical_trial, end_date, registration_nb, sponsor_name, included_patients_nb, funding, funding_amount) VALUES (589, '2022-03-07', false, 'DSC', '2022-03-23', '10', 'QSd', 10, 'dD', 10);
INSERT INTO public.sei_clinical_trial (id_activity, start_date, coordinator_partner, title_clinical_trial, end_date, registration_nb, sponsor_name, included_patients_nb, funding, funding_amount) VALUES (590, '2022-03-27', true, 'DSC', '2022-03-28', '10', 'SF', 23, 'ff', 21);
INSERT INTO public.sei_clinical_trial (id_activity, start_date, coordinator_partner, title_clinical_trial, end_date, registration_nb, sponsor_name, included_patients_nb, funding, funding_amount) VALUES (591, '2022-03-27', true, 'DSC', '2022-03-28', '10', 'SF', 23, 'ff', 21);
INSERT INTO public.sei_clinical_trial (id_activity, start_date, coordinator_partner, title_clinical_trial, end_date, registration_nb, sponsor_name, included_patients_nb, funding, funding_amount) VALUES (600, '2022-03-20', true, 'df', '2022-03-27', '10', 'fff', 12, 'fqd', 13);
INSERT INTO public.sei_clinical_trial (id_activity, start_date, coordinator_partner, title_clinical_trial, end_date, registration_nb, sponsor_name, included_patients_nb, funding, funding_amount) VALUES (601, '2022-03-20', true, 'DSC', '2022-03-06', '10', 'sdv', 12, 'qcd', 5);


--
-- TOC entry 3822 (class 0 OID 24963)
-- Dependencies: 271
-- Data for Name: sei_industrial_r_d_contract; Type: TABLE DATA; Schema: public; Owner: hceres
--

INSERT INTO public.sei_industrial_r_d_contract (id_activity, start_date, name_company_involved, project_title, agreement_amount, end_date, associated_publi_ref) VALUES (586, '2022-03-27', 'sdd', 'qD', -1, '2022-03-27', 'Fq');


--
-- TOC entry 3823 (class 0 OID 24969)
-- Dependencies: 272
-- Data for Name: sei_lead_consortium_industry; Type: TABLE DATA; Schema: public; Owner: hceres
--



--
-- TOC entry 3824 (class 0 OID 24975)
-- Dependencies: 273
-- Data for Name: sei_network_unit_creation; Type: TABLE DATA; Schema: public; Owner: hceres
--



--
-- TOC entry 3875 (class 0 OID 25096)
-- Dependencies: 324
-- Data for Name: sr_award; Type: TABLE DATA; Schema: public; Owner: hceres
--

INSERT INTO public.sr_award (id_activity, awardee_name, award_date, description) VALUES (504, 'new', '2022-02-27', 'new test');
INSERT INTO public.sr_award (id_activity, awardee_name, award_date, description) VALUES (505, 'new2', '2022-02-27', 'test 2');
INSERT INTO public.sr_award (id_activity, awardee_name, award_date, description) VALUES (506, 'new2', '2022-02-27', 'test 2');
INSERT INTO public.sr_award (id_activity, awardee_name, award_date, description) VALUES (507, 'new2', '2022-02-27', 'test 2');
INSERT INTO public.sr_award (id_activity, awardee_name, award_date, description) VALUES (508, 'test', '2022-02-27', 'new test');
INSERT INTO public.sr_award (id_activity, awardee_name, award_date, description) VALUES (509, 'test2', '2022-02-27', 'new test 2');
INSERT INTO public.sr_award (id_activity, awardee_name, award_date, description) VALUES (510, 'test3', '2022-02-27', 'new test 3');
INSERT INTO public.sr_award (id_activity, awardee_name, award_date, description) VALUES (545, 'test', '2022-03-15', 'hsgt');
INSERT INTO public.sr_award (id_activity, awardee_name, award_date, description) VALUES (561, 'newPrix', '2022-03-06', 'HDGFGH');
INSERT INTO public.sr_award (id_activity, awardee_name, award_date, description) VALUES (571, 'newPrix', '2022-03-14', 'wcvv');
INSERT INTO public.sr_award (id_activity, awardee_name, award_date, description) VALUES (572, 'newPrix', '2022-03-14', 'scC');
INSERT INTO public.sr_award (id_activity, awardee_name, award_date, description) VALUES (573, 'newPrix', '2022-03-30', 'vw<v');
INSERT INTO public.sr_award (id_activity, awardee_name, award_date, description) VALUES (574, 'test', '2022-03-23', 'dv');
INSERT INTO public.sr_award (id_activity, awardee_name, award_date, description) VALUES (577, 'newPrix', '2022-03-22', 'kjhgg');
INSERT INTO public.sr_award (id_activity, awardee_name, award_date, description) VALUES (578, 'test', '2022-03-22', 'sqx');
INSERT INTO public.sr_award (id_activity, awardee_name, award_date, description) VALUES (604, 'newPrix', '2022-03-14', 'khhh');
INSERT INTO public.sr_award (id_activity, awardee_name, award_date, description) VALUES (609, 'newPrix', '2022-04-11', 'qsqsFQ');
INSERT INTO public.sr_award (id_activity, awardee_name, award_date, description) VALUES (610, 'D', '2022-04-08', 'QD');


--
-- TOC entry 3853 (class 0 OID 25037)
-- Dependencies: 302
-- Data for Name: status; Type: TABLE DATA; Schema: public; Owner: hceres
--

INSERT INTO public.status (id_status, name_status) VALUES (1, 'Professeurs et assimilés');
INSERT INTO public.status (id_status, name_status) VALUES (2, 'Maîtres de conférences et assimilés');
INSERT INTO public.status (id_status, name_status) VALUES (3, 'Directeurs de recherche et assimilés');
INSERT INTO public.status (id_status, name_status) VALUES (4, 'Chargés de recherche et assimilés');
INSERT INTO public.status (id_status, name_status) VALUES (5, 'Conservateurs, cadres scientifiques EPIC, fondations, industries...');
INSERT INTO public.status (id_status, name_status) VALUES (6, 'Professeurs du secondaire détachés dans le supérieur');
INSERT INTO public.status (id_status, name_status) VALUES (7, 'ITA-BIATSS, autres personnels cadre et non cadre EPIC...');
INSERT INTO public.status (id_status, name_status) VALUES (8, 'Enseignants-chercheurs non titulaires, émérites et autres');
INSERT INTO public.status (id_status, name_status) VALUES (9, 'Chercheurs non titulaires, émérites et autres (excepté doctorants)');
INSERT INTO public.status (id_status, name_status) VALUES (10, 'Doctorants');
INSERT INTO public.status (id_status, name_status) VALUES (11, 'Autres personnels non titulaires');
INSERT INTO public.status (id_status, name_status) VALUES (12, 'Enseignants-chercheurs non titulaires, émérites et autres');


--
-- TOC entry 3855 (class 0 OID 25042)
-- Dependencies: 304
-- Data for Name: supervisor; Type: TABLE DATA; Schema: public; Owner: hceres
--



--
-- TOC entry 3857 (class 0 OID 25051)
-- Dependencies: 306
-- Data for Name: team; Type: TABLE DATA; Schema: public; Owner: hceres
--

INSERT INTO public.team (team_id, team_name, team_creation, team_end, team_last_report, laboratory_id) VALUES (1, 'Team1', NULL, NULL, NULL, 1);
INSERT INTO public.team (team_id, team_name, team_creation, team_end, team_last_report, laboratory_id) VALUES (2, 'Team2', NULL, NULL, NULL, 1);
INSERT INTO public.team (team_id, team_name, team_creation, team_end, team_last_report, laboratory_id) VALUES (3, 'Team3', NULL, NULL, NULL, 1);
INSERT INTO public.team (team_id, team_name, team_creation, team_end, team_last_report, laboratory_id) VALUES (4, 'Team4A', NULL, NULL, NULL, 1);
INSERT INTO public.team (team_id, team_name, team_creation, team_end, team_last_report, laboratory_id) VALUES (5, 'Team4B', NULL, NULL, NULL, 1);
INSERT INTO public.team (team_id, team_name, team_creation, team_end, team_last_report, laboratory_id) VALUES (6, 'Team5', NULL, NULL, NULL, 1);
INSERT INTO public.team (team_id, team_name, team_creation, team_end, team_last_report, laboratory_id) VALUES (7, 'Team6', NULL, NULL, NULL, 1);


--
-- TOC entry 3859 (class 0 OID 25056)
-- Dependencies: 308
-- Data for Name: team_referent; Type: TABLE DATA; Schema: public; Owner: hceres
--



--
-- TOC entry 3877 (class 0 OID 25104)
-- Dependencies: 326
-- Data for Name: tool_product; Type: TABLE DATA; Schema: public; Owner: hceres
--



--
-- TOC entry 3878 (class 0 OID 25110)
-- Dependencies: 327
-- Data for Name: tool_product_involvment; Type: TABLE DATA; Schema: public; Owner: hceres
--



--
-- TOC entry 3863 (class 0 OID 25066)
-- Dependencies: 312
-- Data for Name: tool_product_role; Type: TABLE DATA; Schema: public; Owner: hceres
--



--
-- TOC entry 3861 (class 0 OID 25061)
-- Dependencies: 310
-- Data for Name: tool_product_type; Type: TABLE DATA; Schema: public; Owner: hceres
--



--
-- TOC entry 3865 (class 0 OID 25071)
-- Dependencies: 314
-- Data for Name: type_activity; Type: TABLE DATA; Schema: public; Owner: hceres
--

INSERT INTO public.type_activity (id_type_activity, name_type) VALUES (1, 'Publication');
INSERT INTO public.type_activity (id_type_activity, name_type) VALUES (2, 'Book');
INSERT INTO public.type_activity (id_type_activity, name_type) VALUES (3, 'Book Chapter');
INSERT INTO public.type_activity (id_type_activity, name_type) VALUES (4, 'Patent Licence Invention Disclosure');
INSERT INTO public.type_activity (id_type_activity, name_type) VALUES (5, 'Editorial Activity');
INSERT INTO public.type_activity (id_type_activity, name_type) VALUES (6, 'Platform');
INSERT INTO public.type_activity (id_type_activity, name_type) VALUES (7, 'Tool Product Decision Support Tool');
INSERT INTO public.type_activity (id_type_activity, name_type) VALUES (8, 'Tool Product BioList');
INSERT INTO public.type_activity (id_type_activity, name_type) VALUES (9, 'Tool Product Software');
INSERT INTO public.type_activity (id_type_activity, name_type) VALUES (10, 'Tool Product Database');
INSERT INTO public.type_activity (id_type_activity, name_type) VALUES (11, 'Tool Product Cohort');
INSERT INTO public.type_activity (id_type_activity, name_type) VALUES (12, 'Educational Output');
INSERT INTO public.type_activity (id_type_activity, name_type) VALUES (13, 'National International Collaboration');
INSERT INTO public.type_activity (id_type_activity, name_type) VALUES (14, 'Network');
INSERT INTO public.type_activity (id_type_activity, name_type) VALUES (15, 'Invited Seminar');
INSERT INTO public.type_activity (id_type_activity, name_type) VALUES (16, 'Scientific Expertise');
INSERT INTO public.type_activity (id_type_activity, name_type) VALUES (17, 'Research Contract Funded Public Charitable Inst');
INSERT INTO public.type_activity (id_type_activity, name_type) VALUES (18, 'Training Thesis Publication');
INSERT INTO public.type_activity (id_type_activity, name_type) VALUES (19, 'Involvement Training M1 M2 Trainee Hosting');
INSERT INTO public.type_activity (id_type_activity, name_type) VALUES (20, 'Involvement Training Pedagogical Responsibility');
INSERT INTO public.type_activity (id_type_activity, name_type) VALUES (21, 'Post Doc');
INSERT INTO public.type_activity (id_type_activity, name_type) VALUES (22, 'Public Outreach');
INSERT INTO public.type_activity (id_type_activity, name_type) VALUES (23, 'Reviewing Journal Articles');
INSERT INTO public.type_activity (id_type_activity, name_type) VALUES (24, 'Project Evaluation Thesis');
INSERT INTO public.type_activity (id_type_activity, name_type) VALUES (25, 'Project Evaluation Grant');
INSERT INTO public.type_activity (id_type_activity, name_type) VALUES (26, 'Lab Evaluation');
INSERT INTO public.type_activity (id_type_activity, name_type) VALUES (27, 'Responsibility Institutional Comitee Jury');
INSERT INTO public.type_activity (id_type_activity, name_type) VALUES (28, 'Sr Responsibility Learned Scientific Society');
INSERT INTO public.type_activity (id_type_activity, name_type) VALUES (29, 'Sr Award');
INSERT INTO public.type_activity (id_type_activity, name_type) VALUES (30, 'Meeting Congress Org');
INSERT INTO public.type_activity (id_type_activity, name_type) VALUES (31, 'Invited Oral Communication');
INSERT INTO public.type_activity (id_type_activity, name_type) VALUES (32, 'Oral Communication Poster');
INSERT INTO public.type_activity (id_type_activity, name_type) VALUES (33, 'Outgoing Mobility');
INSERT INTO public.type_activity (id_type_activity, name_type) VALUES (34, 'Incoming Mobility');
INSERT INTO public.type_activity (id_type_activity, name_type) VALUES (35, 'Sei Cifre Fellowship');
INSERT INTO public.type_activity (id_type_activity, name_type) VALUES (36, 'Sei Labcom Creation');
INSERT INTO public.type_activity (id_type_activity, name_type) VALUES (37, 'Sei Network Unit Creation');
INSERT INTO public.type_activity (id_type_activity, name_type) VALUES (38, 'Sei Company Creation');
INSERT INTO public.type_activity (id_type_activity, name_type) VALUES (39, 'Sei Lead Consortium Industry');
INSERT INTO public.type_activity (id_type_activity, name_type) VALUES (40, 'Sei Industrial R D Contract');
INSERT INTO public.type_activity (id_type_activity, name_type) VALUES (41, 'Sei Clinical Trial');


--
-- TOC entry 3867 (class 0 OID 25076)
-- Dependencies: 316
-- Data for Name: type_collab; Type: TABLE DATA; Schema: public; Owner: hceres
--

INSERT INTO public.type_collab (type_collab_id, name_choice) VALUES (2, 'qsv');


--
-- TOC entry 3879 (class 0 OID 25116)
-- Dependencies: 328
-- Data for Name: type_consortium; Type: TABLE DATA; Schema: public; Owner: hceres
--



--
-- TOC entry 3869 (class 0 OID 25081)
-- Dependencies: 318
-- Data for Name: type_oral_communication; Type: TABLE DATA; Schema: public; Owner: hceres
--

INSERT INTO public.type_oral_communication (type_oral_communication_id, type_oral_communication_name) VALUES (1, 'vD');
INSERT INTO public.type_oral_communication (type_oral_communication_id, type_oral_communication_name) VALUES (2, 'vD');
INSERT INTO public.type_oral_communication (type_oral_communication_id, type_oral_communication_name) VALUES (3, 'vD');
INSERT INTO public.type_oral_communication (type_oral_communication_id, type_oral_communication_name) VALUES (4, 'vD');


--
-- TOC entry 3871 (class 0 OID 25086)
-- Dependencies: 320
-- Data for Name: type_patent; Type: TABLE DATA; Schema: public; Owner: hceres
--



--
-- TOC entry 3873 (class 0 OID 25091)
-- Dependencies: 322
-- Data for Name: type_research_contract; Type: TABLE DATA; Schema: public; Owner: hceres
--



--
-- TOC entry 3881 (class 0 OID 25121)
-- Dependencies: 330
-- Data for Name: type_thesis; Type: TABLE DATA; Schema: public; Owner: hceres
--



--
-- TOC entry 3931 (class 0 OID 0)
-- Dependencies: 205
-- Name: belongs_team_id_belongs_team_seq; Type: SEQUENCE SET; Schema: public; Owner: prweb
--

SELECT pg_catalog.setval('public.belongs_team_id_belongs_team_seq', 1, false);


--
-- TOC entry 3932 (class 0 OID 0)
-- Dependencies: 208
-- Name: choice_public_outreach_id_type_seq; Type: SEQUENCE SET; Schema: public; Owner: prweb
--

SELECT pg_catalog.setval('public.choice_public_outreach_id_type_seq', 1, false);


--
-- TOC entry 3933 (class 0 OID 0)
-- Dependencies: 209
-- Name: choice_type_collab_id_type_seq; Type: SEQUENCE SET; Schema: public; Owner: prweb
--

SELECT pg_catalog.setval('public.choice_type_collab_id_type_seq', 1, false);


--
-- TOC entry 3934 (class 0 OID 0)
-- Dependencies: 220
-- Name: employer_id_employer_seq; Type: SEQUENCE SET; Schema: public; Owner: prweb
--

SELECT pg_catalog.setval('public.employer_id_employer_seq', 1, false);


--
-- TOC entry 3935 (class 0 OID 0)
-- Dependencies: 223
-- Name: evaluation_thesis_role_evaluation_thesis_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hceres
--

SELECT pg_catalog.setval('public.evaluation_thesis_role_evaluation_thesis_role_id_seq', 1, false);


--
-- TOC entry 3936 (class 0 OID 0)
-- Dependencies: 268
-- Name: scientific_expertise_type_scientific_expertise_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hceres
--

SELECT pg_catalog.setval('public.scientific_expertise_type_scientific_expertise_type_id_seq', 31, true);


--
-- TOC entry 3937 (class 0 OID 0)
-- Dependencies: 274
-- Name: seq_activity; Type: SEQUENCE SET; Schema: public; Owner: hceres
--

SELECT pg_catalog.setval('public.seq_activity', 610, true);


--
-- TOC entry 3938 (class 0 OID 0)
-- Dependencies: 275
-- Name: seq_belongs_team; Type: SEQUENCE SET; Schema: public; Owner: hceres
--

SELECT pg_catalog.setval('public.seq_belongs_team', 5844, true);


--
-- TOC entry 3939 (class 0 OID 0)
-- Dependencies: 276
-- Name: seq_choice_publication; Type: SEQUENCE SET; Schema: public; Owner: hceres
--

SELECT pg_catalog.setval('public.seq_choice_publication', 1, true);


--
-- TOC entry 3940 (class 0 OID 0)
-- Dependencies: 277
-- Name: seq_company; Type: SEQUENCE SET; Schema: public; Owner: hceres
--

SELECT pg_catalog.setval('public.seq_company', 1, false);


--
-- TOC entry 3941 (class 0 OID 0)
-- Dependencies: 278
-- Name: seq_contract; Type: SEQUENCE SET; Schema: public; Owner: hceres
--

SELECT pg_catalog.setval('public.seq_contract', 1, false);


--
-- TOC entry 3942 (class 0 OID 0)
-- Dependencies: 279
-- Name: seq_contract_type; Type: SEQUENCE SET; Schema: public; Owner: hceres
--

SELECT pg_catalog.setval('public.seq_contract_type', 1, false);


--
-- TOC entry 3943 (class 0 OID 0)
-- Dependencies: 280
-- Name: seq_education_involvment; Type: SEQUENCE SET; Schema: public; Owner: hceres
--

SELECT pg_catalog.setval('public.seq_education_involvment', 14, true);


--
-- TOC entry 3944 (class 0 OID 0)
-- Dependencies: 281
-- Name: seq_education_level; Type: SEQUENCE SET; Schema: public; Owner: hceres
--

SELECT pg_catalog.setval('public.seq_education_level', 14, true);


--
-- TOC entry 3945 (class 0 OID 0)
-- Dependencies: 282
-- Name: seq_employer; Type: SEQUENCE SET; Schema: public; Owner: hceres
--

SELECT pg_catalog.setval('public.seq_employer', 1, false);


--
-- TOC entry 3946 (class 0 OID 0)
-- Dependencies: 283
-- Name: seq_function_editorial_activity; Type: SEQUENCE SET; Schema: public; Owner: hceres
--

SELECT pg_catalog.setval('public.seq_function_editorial_activity', 4, true);


--
-- TOC entry 3947 (class 0 OID 0)
-- Dependencies: 284
-- Name: seq_funder; Type: SEQUENCE SET; Schema: public; Owner: hceres
--

SELECT pg_catalog.setval('public.seq_funder', 1, false);


--
-- TOC entry 3948 (class 0 OID 0)
-- Dependencies: 285
-- Name: seq_institution; Type: SEQUENCE SET; Schema: public; Owner: hceres
--

SELECT pg_catalog.setval('public.seq_institution', 3, true);


--
-- TOC entry 3949 (class 0 OID 0)
-- Dependencies: 286
-- Name: seq_journal; Type: SEQUENCE SET; Schema: public; Owner: hceres
--

SELECT pg_catalog.setval('public.seq_journal', 1, true);


--
-- TOC entry 3950 (class 0 OID 0)
-- Dependencies: 287
-- Name: seq_laboratory; Type: SEQUENCE SET; Schema: public; Owner: hceres
--

SELECT pg_catalog.setval('public.seq_laboratory', 1, true);


--
-- TOC entry 3951 (class 0 OID 0)
-- Dependencies: 288
-- Name: seq_laboratory_evaluation_role; Type: SEQUENCE SET; Schema: public; Owner: hceres
--

SELECT pg_catalog.setval('public.seq_laboratory_evaluation_role', 1, false);


--
-- TOC entry 3952 (class 0 OID 0)
-- Dependencies: 289
-- Name: seq_language; Type: SEQUENCE SET; Schema: public; Owner: hceres
--

SELECT pg_catalog.setval('public.seq_language', 1, false);


--
-- TOC entry 3953 (class 0 OID 0)
-- Dependencies: 290
-- Name: seq_learned_scientific_society_role; Type: SEQUENCE SET; Schema: public; Owner: hceres
--

SELECT pg_catalog.setval('public.seq_learned_scientific_society_role', 1, false);


--
-- TOC entry 3954 (class 0 OID 0)
-- Dependencies: 291
-- Name: seq_mail_activity; Type: SEQUENCE SET; Schema: public; Owner: hceres
--

SELECT pg_catalog.setval('public.seq_mail_activity', 1, false);


--
-- TOC entry 3955 (class 0 OID 0)
-- Dependencies: 292
-- Name: seq_mail_template; Type: SEQUENCE SET; Schema: public; Owner: hceres
--

SELECT pg_catalog.setval('public.seq_mail_template', 1, false);


--
-- TOC entry 3956 (class 0 OID 0)
-- Dependencies: 293
-- Name: seq_meeting; Type: SEQUENCE SET; Schema: public; Owner: hceres
--

SELECT pg_catalog.setval('public.seq_meeting', 4, true);


--
-- TOC entry 3957 (class 0 OID 0)
-- Dependencies: 294
-- Name: seq_nationality; Type: SEQUENCE SET; Schema: public; Owner: hceres
--

SELECT pg_catalog.setval('public.seq_nationality', 196, true);


--
-- TOC entry 3958 (class 0 OID 0)
-- Dependencies: 295
-- Name: seq_parameter; Type: SEQUENCE SET; Schema: public; Owner: hceres
--

SELECT pg_catalog.setval('public.seq_parameter', 1, true);


--
-- TOC entry 3959 (class 0 OID 0)
-- Dependencies: 296
-- Name: seq_phd_student; Type: SEQUENCE SET; Schema: public; Owner: hceres
--

SELECT pg_catalog.setval('public.seq_phd_student', 1, false);


--
-- TOC entry 3960 (class 0 OID 0)
-- Dependencies: 297
-- Name: seq_phd_type; Type: SEQUENCE SET; Schema: public; Owner: hceres
--

SELECT pg_catalog.setval('public.seq_phd_type', 2, true);


--
-- TOC entry 3961 (class 0 OID 0)
-- Dependencies: 298
-- Name: seq_project_evaluation_category; Type: SEQUENCE SET; Schema: public; Owner: hceres
--

SELECT pg_catalog.setval('public.seq_project_evaluation_category', 1, false);


--
-- TOC entry 3962 (class 0 OID 0)
-- Dependencies: 299
-- Name: seq_project_evaluation_role; Type: SEQUENCE SET; Schema: public; Owner: hceres
--

SELECT pg_catalog.setval('public.seq_project_evaluation_role', 1, false);


--
-- TOC entry 3963 (class 0 OID 0)
-- Dependencies: 300
-- Name: seq_public_outreach_type; Type: SEQUENCE SET; Schema: public; Owner: hceres
--

SELECT pg_catalog.setval('public.seq_public_outreach_type', 1, false);


--
-- TOC entry 3964 (class 0 OID 0)
-- Dependencies: 301
-- Name: seq_researcher; Type: SEQUENCE SET; Schema: public; Owner: hceres
--

SELECT pg_catalog.setval('public.seq_researcher', 226, true);


--
-- TOC entry 3965 (class 0 OID 0)
-- Dependencies: 303
-- Name: seq_status; Type: SEQUENCE SET; Schema: public; Owner: hceres
--

SELECT pg_catalog.setval('public.seq_status', 12, true);


--
-- TOC entry 3966 (class 0 OID 0)
-- Dependencies: 305
-- Name: seq_supervisor_id; Type: SEQUENCE SET; Schema: public; Owner: hceres
--

SELECT pg_catalog.setval('public.seq_supervisor_id', 1, false);


--
-- TOC entry 3967 (class 0 OID 0)
-- Dependencies: 307
-- Name: seq_team; Type: SEQUENCE SET; Schema: public; Owner: hceres
--

SELECT pg_catalog.setval('public.seq_team', 7, true);


--
-- TOC entry 3968 (class 0 OID 0)
-- Dependencies: 309
-- Name: seq_team_referent; Type: SEQUENCE SET; Schema: public; Owner: hceres
--

SELECT pg_catalog.setval('public.seq_team_referent', 1, false);


--
-- TOC entry 3969 (class 0 OID 0)
-- Dependencies: 311
-- Name: seq_tool_product; Type: SEQUENCE SET; Schema: public; Owner: hceres
--

SELECT pg_catalog.setval('public.seq_tool_product', 1, false);


--
-- TOC entry 3970 (class 0 OID 0)
-- Dependencies: 313
-- Name: seq_tool_product_role; Type: SEQUENCE SET; Schema: public; Owner: hceres
--

SELECT pg_catalog.setval('public.seq_tool_product_role', 1, false);


--
-- TOC entry 3971 (class 0 OID 0)
-- Dependencies: 315
-- Name: seq_type_activity; Type: SEQUENCE SET; Schema: public; Owner: hceres
--

SELECT pg_catalog.setval('public.seq_type_activity', 1, false);


--
-- TOC entry 3972 (class 0 OID 0)
-- Dependencies: 317
-- Name: seq_type_collab; Type: SEQUENCE SET; Schema: public; Owner: hceres
--

SELECT pg_catalog.setval('public.seq_type_collab', 2, true);


--
-- TOC entry 3973 (class 0 OID 0)
-- Dependencies: 319
-- Name: seq_type_oral_communication; Type: SEQUENCE SET; Schema: public; Owner: hceres
--

SELECT pg_catalog.setval('public.seq_type_oral_communication', 4, true);


--
-- TOC entry 3974 (class 0 OID 0)
-- Dependencies: 321
-- Name: seq_type_patent; Type: SEQUENCE SET; Schema: public; Owner: hceres
--

SELECT pg_catalog.setval('public.seq_type_patent', 1, false);


--
-- TOC entry 3975 (class 0 OID 0)
-- Dependencies: 323
-- Name: seq_type_research; Type: SEQUENCE SET; Schema: public; Owner: hceres
--

SELECT pg_catalog.setval('public.seq_type_research', 1, false);


--
-- TOC entry 3976 (class 0 OID 0)
-- Dependencies: 325
-- Name: supervisor_id_supervisor_seq; Type: SEQUENCE SET; Schema: public; Owner: prweb
--

SELECT pg_catalog.setval('public.supervisor_id_supervisor_seq', 1, false);


--
-- TOC entry 3977 (class 0 OID 0)
-- Dependencies: 329
-- Name: type_consortium_type_consortium_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hceres
--

SELECT pg_catalog.setval('public.type_consortium_type_consortium_id_seq', 1, false);


--
-- TOC entry 3978 (class 0 OID 0)
-- Dependencies: 331
-- Name: type_thesis_type_thesis_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hceres
--

SELECT pg_catalog.setval('public.type_thesis_type_thesis_id_seq', 1, false);


--
-- TOC entry 3383 (class 2606 OID 25170)
-- Name: connection connection_pkey; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.connection
    ADD CONSTRAINT connection_pkey PRIMARY KEY (connection_code);


--
-- TOC entry 3365 (class 2606 OID 25172)
-- Name: activity pk_activity; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.activity
    ADD CONSTRAINT pk_activity PRIMARY KEY (id_activity);


--
-- TOC entry 3367 (class 2606 OID 25174)
-- Name: activity_researcher pk_activity_researcher; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.activity_researcher
    ADD CONSTRAINT pk_activity_researcher PRIMARY KEY (researcher_id, id_activity);


--
-- TOC entry 3369 (class 2606 OID 25176)
-- Name: activity_team pk_activity_team; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.activity_team
    ADD CONSTRAINT pk_activity_team PRIMARY KEY (id_activity, team_id);


--
-- TOC entry 3371 (class 2606 OID 25178)
-- Name: admin pk_admin; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT pk_admin PRIMARY KEY (researcher_id);


--
-- TOC entry 3373 (class 2606 OID 25180)
-- Name: belongs_team pk_belongs_team; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.belongs_team
    ADD CONSTRAINT pk_belongs_team PRIMARY KEY (id_belongs_team);


--
-- TOC entry 3375 (class 2606 OID 25182)
-- Name: book pk_book; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.book
    ADD CONSTRAINT pk_book PRIMARY KEY (id_activity);


--
-- TOC entry 3377 (class 2606 OID 25184)
-- Name: book_chapter pk_book_chapter; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.book_chapter
    ADD CONSTRAINT pk_book_chapter PRIMARY KEY (id_activity);


--
-- TOC entry 3379 (class 2606 OID 25186)
-- Name: company pk_company; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.company
    ADD CONSTRAINT pk_company PRIMARY KEY (company_id);


--
-- TOC entry 3381 (class 2606 OID 25188)
-- Name: company_creation pk_company_creation; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.company_creation
    ADD CONSTRAINT pk_company_creation PRIMARY KEY (id_activity);


--
-- TOC entry 3385 (class 2606 OID 25190)
-- Name: contract pk_contract; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.contract
    ADD CONSTRAINT pk_contract PRIMARY KEY (id_contract);


--
-- TOC entry 3387 (class 2606 OID 25192)
-- Name: contract_type pk_contract_type; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.contract_type
    ADD CONSTRAINT pk_contract_type PRIMARY KEY (id_contract_type);


--
-- TOC entry 3389 (class 2606 OID 25194)
-- Name: editorial_activity pk_editorial_activity; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.editorial_activity
    ADD CONSTRAINT pk_editorial_activity PRIMARY KEY (id_activity);


--
-- TOC entry 3391 (class 2606 OID 25196)
-- Name: education pk_education; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.education
    ADD CONSTRAINT pk_education PRIMARY KEY (id_activity);


--
-- TOC entry 3393 (class 2606 OID 25198)
-- Name: education_involvment pk_education_involvment; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.education_involvment
    ADD CONSTRAINT pk_education_involvment PRIMARY KEY (education_involvment_id);


--
-- TOC entry 3395 (class 2606 OID 25200)
-- Name: education_level pk_education_level; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.education_level
    ADD CONSTRAINT pk_education_level PRIMARY KEY (education_level_id);


--
-- TOC entry 3397 (class 2606 OID 25202)
-- Name: employer pk_employer; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.employer
    ADD CONSTRAINT pk_employer PRIMARY KEY (id_employer);


--
-- TOC entry 3399 (class 2606 OID 25204)
-- Name: evaluation_thesis pk_evaluation_thesis; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.evaluation_thesis
    ADD CONSTRAINT pk_evaluation_thesis PRIMARY KEY (id_activity);


--
-- TOC entry 3401 (class 2606 OID 25206)
-- Name: evaluation_thesis_role pk_evaluation_thesis_role; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.evaluation_thesis_role
    ADD CONSTRAINT pk_evaluation_thesis_role PRIMARY KEY (evaluation_thesis_role_id);


--
-- TOC entry 3403 (class 2606 OID 25208)
-- Name: function_editorial_activity pk_function_editorial_activity; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.function_editorial_activity
    ADD CONSTRAINT pk_function_editorial_activity PRIMARY KEY (function_editorial_activity_id);


--
-- TOC entry 3405 (class 2606 OID 25210)
-- Name: funder pk_funder; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.funder
    ADD CONSTRAINT pk_funder PRIMARY KEY (funder_id);


--
-- TOC entry 3407 (class 2606 OID 25212)
-- Name: incoming_mobility pk_incoming_mobility; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.incoming_mobility
    ADD CONSTRAINT pk_incoming_mobility PRIMARY KEY (id_activity);


--
-- TOC entry 3409 (class 2606 OID 25214)
-- Name: institution pk_institution; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.institution
    ADD CONSTRAINT pk_institution PRIMARY KEY (institution_id);


--
-- TOC entry 3411 (class 2606 OID 25216)
-- Name: institutional_comitee pk_institutional_comitee; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.institutional_comitee
    ADD CONSTRAINT pk_institutional_comitee PRIMARY KEY (id_activity);


--
-- TOC entry 3413 (class 2606 OID 25218)
-- Name: invited_seminar pk_invited_seminar; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.invited_seminar
    ADD CONSTRAINT pk_invited_seminar PRIMARY KEY (id_activity);


--
-- TOC entry 3415 (class 2606 OID 25220)
-- Name: journal pk_journal; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.journal
    ADD CONSTRAINT pk_journal PRIMARY KEY (journal_id);


--
-- TOC entry 3417 (class 2606 OID 25222)
-- Name: labcom_creation pk_labcom_creation; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.labcom_creation
    ADD CONSTRAINT pk_labcom_creation PRIMARY KEY (id_activity);


--
-- TOC entry 3419 (class 2606 OID 25224)
-- Name: laboratory pk_laboratory; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.laboratory
    ADD CONSTRAINT pk_laboratory PRIMARY KEY (laboratory_id);


--
-- TOC entry 3421 (class 2606 OID 25226)
-- Name: laboratory_evaluation pk_laboratory_evaluation; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.laboratory_evaluation
    ADD CONSTRAINT pk_laboratory_evaluation PRIMARY KEY (id_activity);


--
-- TOC entry 3423 (class 2606 OID 25228)
-- Name: laboratory_evaluation_role pk_laboratory_evaluation_role; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.laboratory_evaluation_role
    ADD CONSTRAINT pk_laboratory_evaluation_role PRIMARY KEY (laboratory_evaluation_role_id);


--
-- TOC entry 3425 (class 2606 OID 25230)
-- Name: language pk_language; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.language
    ADD CONSTRAINT pk_language PRIMARY KEY (language_id);


--
-- TOC entry 3427 (class 2606 OID 25232)
-- Name: learned_scientific_society pk_learned_scientific_society; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.learned_scientific_society
    ADD CONSTRAINT pk_learned_scientific_society PRIMARY KEY (id_activity);


--
-- TOC entry 3429 (class 2606 OID 25234)
-- Name: learned_scientific_society_role pk_learned_scientific_society_role; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.learned_scientific_society_role
    ADD CONSTRAINT pk_learned_scientific_society_role PRIMARY KEY (learned_scientific_society_role_id);


--
-- TOC entry 3431 (class 2606 OID 25236)
-- Name: mail_activity pk_mail_activity; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.mail_activity
    ADD CONSTRAINT pk_mail_activity PRIMARY KEY (mail_activity_id);


--
-- TOC entry 3433 (class 2606 OID 25238)
-- Name: mail_template pk_mail_template; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.mail_template
    ADD CONSTRAINT pk_mail_template PRIMARY KEY (mail_template_id);


--
-- TOC entry 3435 (class 2606 OID 25240)
-- Name: meeting pk_meeting; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.meeting
    ADD CONSTRAINT pk_meeting PRIMARY KEY (meeting_id);


--
-- TOC entry 3437 (class 2606 OID 25242)
-- Name: meeting_congress_org pk_meeting_congress_org; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.meeting_congress_org
    ADD CONSTRAINT pk_meeting_congress_org PRIMARY KEY (id_activity);


--
-- TOC entry 3439 (class 2606 OID 25244)
-- Name: national_international_collaboration pk_national_international_collaboration; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.national_international_collaboration
    ADD CONSTRAINT pk_national_international_collaboration PRIMARY KEY (id_activity);


--
-- TOC entry 3441 (class 2606 OID 25246)
-- Name: nationality pk_nationality; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.nationality
    ADD CONSTRAINT pk_nationality PRIMARY KEY (nationality_id);


--
-- TOC entry 3443 (class 2606 OID 25248)
-- Name: network pk_network; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.network
    ADD CONSTRAINT pk_network PRIMARY KEY (id_activity);


--
-- TOC entry 3445 (class 2606 OID 25250)
-- Name: oral_communication pk_oral_communication; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.oral_communication
    ADD CONSTRAINT pk_oral_communication PRIMARY KEY (id_activity);


--
-- TOC entry 3447 (class 2606 OID 25252)
-- Name: outgoing_mobility pk_outgoing_mobility; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.outgoing_mobility
    ADD CONSTRAINT pk_outgoing_mobility PRIMARY KEY (id_activity);


--
-- TOC entry 3449 (class 2606 OID 25254)
-- Name: parameter pk_parameter; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.parameter
    ADD CONSTRAINT pk_parameter PRIMARY KEY (parameter_id);


--
-- TOC entry 3451 (class 2606 OID 25256)
-- Name: patent pk_patent; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.patent
    ADD CONSTRAINT pk_patent PRIMARY KEY (id_activity);


--
-- TOC entry 3453 (class 2606 OID 25258)
-- Name: phd_associated_company pk_phd_associated_company; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.phd_associated_company
    ADD CONSTRAINT pk_phd_associated_company PRIMARY KEY (phd_student_id, company_id);


--
-- TOC entry 3455 (class 2606 OID 25260)
-- Name: phd_student pk_phd_student; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.phd_student
    ADD CONSTRAINT pk_phd_student PRIMARY KEY (phd_student_id);


--
-- TOC entry 3457 (class 2606 OID 25262)
-- Name: phd_type pk_phd_type; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.phd_type
    ADD CONSTRAINT pk_phd_type PRIMARY KEY (phd_type_id);


--
-- TOC entry 3459 (class 2606 OID 25264)
-- Name: platform pk_platform; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT pk_platform PRIMARY KEY (id_activity);


--
-- TOC entry 3461 (class 2606 OID 25266)
-- Name: post_doc pk_post_doc; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.post_doc
    ADD CONSTRAINT pk_post_doc PRIMARY KEY (id_activity);


--
-- TOC entry 3463 (class 2606 OID 25268)
-- Name: project_evaluation pk_project_evaluation; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.project_evaluation
    ADD CONSTRAINT pk_project_evaluation PRIMARY KEY (id_activity);


--
-- TOC entry 3465 (class 2606 OID 25270)
-- Name: project_evaluation_category pk_project_evaluation_category; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.project_evaluation_category
    ADD CONSTRAINT pk_project_evaluation_category PRIMARY KEY (project_evaluation_category_id);


--
-- TOC entry 3467 (class 2606 OID 25272)
-- Name: project_evaluation_role pk_project_evaluation_role; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.project_evaluation_role
    ADD CONSTRAINT pk_project_evaluation_role PRIMARY KEY (project_evaluation_role_id);


--
-- TOC entry 3469 (class 2606 OID 25274)
-- Name: public_outreach pk_public_outreach; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.public_outreach
    ADD CONSTRAINT pk_public_outreach PRIMARY KEY (id_activity);


--
-- TOC entry 3471 (class 2606 OID 25276)
-- Name: public_outreach_type pk_public_outreach_type; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.public_outreach_type
    ADD CONSTRAINT pk_public_outreach_type PRIMARY KEY (public_outreach_type_id);


--
-- TOC entry 3473 (class 2606 OID 25278)
-- Name: publication pk_publication; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.publication
    ADD CONSTRAINT pk_publication PRIMARY KEY (id_activity);


--
-- TOC entry 3475 (class 2606 OID 25280)
-- Name: publication_statistics pk_publication_statistics; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.publication_statistics
    ADD CONSTRAINT pk_publication_statistics PRIMARY KEY (team_id, publication_statistics_year);


--
-- TOC entry 3477 (class 2606 OID 25282)
-- Name: publication_type pk_publication_type; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.publication_type
    ADD CONSTRAINT pk_publication_type PRIMARY KEY (publication_type_id);


--
-- TOC entry 3479 (class 2606 OID 25284)
-- Name: research_contract_funded_public_charitable_inst pk_research_contract_funded_public_charitable_inst; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.research_contract_funded_public_charitable_inst
    ADD CONSTRAINT pk_research_contract_funded_public_charitable_inst PRIMARY KEY (id_activity);


--
-- TOC entry 3481 (class 2606 OID 25286)
-- Name: researcher pk_researcher; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.researcher
    ADD CONSTRAINT pk_researcher PRIMARY KEY (researcher_id);


--
-- TOC entry 3483 (class 2606 OID 25288)
-- Name: researcher_nationality pk_researcher_nationality; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.researcher_nationality
    ADD CONSTRAINT pk_researcher_nationality PRIMARY KEY (nationality_id, researcher_id);


--
-- TOC entry 3485 (class 2606 OID 25290)
-- Name: reviewing_journal_articles pk_reviewing_journal_articles; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.reviewing_journal_articles
    ADD CONSTRAINT pk_reviewing_journal_articles PRIMARY KEY (id_activity);


--
-- TOC entry 3487 (class 2606 OID 25292)
-- Name: scientific_expertise pk_scientific_expertise; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.scientific_expertise
    ADD CONSTRAINT pk_scientific_expertise PRIMARY KEY (id_activity);


--
-- TOC entry 3489 (class 2606 OID 25294)
-- Name: scientific_expertise_type pk_scientific_expertise_type; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.scientific_expertise_type
    ADD CONSTRAINT pk_scientific_expertise_type PRIMARY KEY (scientific_expertise_type_id);


--
-- TOC entry 3491 (class 2606 OID 25296)
-- Name: sei_cifre_fellowship pk_sei_cifre_fellowship; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.sei_cifre_fellowship
    ADD CONSTRAINT pk_sei_cifre_fellowship PRIMARY KEY (id_activity);


--
-- TOC entry 3493 (class 2606 OID 25298)
-- Name: sei_clinical_trial pk_sei_clinical_trial; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.sei_clinical_trial
    ADD CONSTRAINT pk_sei_clinical_trial PRIMARY KEY (id_activity);


--
-- TOC entry 3495 (class 2606 OID 25300)
-- Name: sei_industrial_r_d_contract pk_sei_industrial_r_d_contract; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.sei_industrial_r_d_contract
    ADD CONSTRAINT pk_sei_industrial_r_d_contract PRIMARY KEY (id_activity);


--
-- TOC entry 3497 (class 2606 OID 25302)
-- Name: sei_lead_consortium_industry pk_sei_lead_consortium_industry; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.sei_lead_consortium_industry
    ADD CONSTRAINT pk_sei_lead_consortium_industry PRIMARY KEY (id_activity);


--
-- TOC entry 3499 (class 2606 OID 25304)
-- Name: sei_network_unit_creation pk_sei_network_unit_creation; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.sei_network_unit_creation
    ADD CONSTRAINT pk_sei_network_unit_creation PRIMARY KEY (id_activity);


--
-- TOC entry 3523 (class 2606 OID 25306)
-- Name: sr_award pk_sr_award; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.sr_award
    ADD CONSTRAINT pk_sr_award PRIMARY KEY (id_activity);


--
-- TOC entry 3501 (class 2606 OID 25308)
-- Name: status pk_status; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.status
    ADD CONSTRAINT pk_status PRIMARY KEY (id_status);


--
-- TOC entry 3503 (class 2606 OID 25310)
-- Name: supervisor pk_supervisor; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.supervisor
    ADD CONSTRAINT pk_supervisor PRIMARY KEY (supervisor_id);


--
-- TOC entry 3505 (class 2606 OID 25312)
-- Name: team pk_team; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.team
    ADD CONSTRAINT pk_team PRIMARY KEY (team_id);


--
-- TOC entry 3507 (class 2606 OID 25314)
-- Name: team_referent pk_team_referent; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.team_referent
    ADD CONSTRAINT pk_team_referent PRIMARY KEY (team_referent_id);


--
-- TOC entry 3525 (class 2606 OID 25316)
-- Name: tool_product pk_tool_product; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.tool_product
    ADD CONSTRAINT pk_tool_product PRIMARY KEY (id_activity);


--
-- TOC entry 3527 (class 2606 OID 25318)
-- Name: tool_product_involvment pk_tool_product_involvment; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.tool_product_involvment
    ADD CONSTRAINT pk_tool_product_involvment PRIMARY KEY (id_activity, tool_product_role_id);


--
-- TOC entry 3511 (class 2606 OID 25320)
-- Name: tool_product_role pk_tool_product_role; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.tool_product_role
    ADD CONSTRAINT pk_tool_product_role PRIMARY KEY (tool_product_role_id);


--
-- TOC entry 3509 (class 2606 OID 25322)
-- Name: tool_product_type pk_tool_product_type; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.tool_product_type
    ADD CONSTRAINT pk_tool_product_type PRIMARY KEY (tool_product_type_id);


--
-- TOC entry 3513 (class 2606 OID 25324)
-- Name: type_activity pk_type_activity; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.type_activity
    ADD CONSTRAINT pk_type_activity PRIMARY KEY (id_type_activity);


--
-- TOC entry 3515 (class 2606 OID 25326)
-- Name: type_collab pk_type_collab; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.type_collab
    ADD CONSTRAINT pk_type_collab PRIMARY KEY (type_collab_id);


--
-- TOC entry 3529 (class 2606 OID 25328)
-- Name: type_consortium pk_type_consortium; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.type_consortium
    ADD CONSTRAINT pk_type_consortium PRIMARY KEY (type_consortium_id);


--
-- TOC entry 3517 (class 2606 OID 25330)
-- Name: type_oral_communication pk_type_oral_communication; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.type_oral_communication
    ADD CONSTRAINT pk_type_oral_communication PRIMARY KEY (type_oral_communication_id);


--
-- TOC entry 3519 (class 2606 OID 25332)
-- Name: type_patent pk_type_patent; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.type_patent
    ADD CONSTRAINT pk_type_patent PRIMARY KEY (type_patent_id);


--
-- TOC entry 3521 (class 2606 OID 25334)
-- Name: type_research_contract pk_type_research_contract; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.type_research_contract
    ADD CONSTRAINT pk_type_research_contract PRIMARY KEY (id_type);


--
-- TOC entry 3531 (class 2606 OID 25336)
-- Name: type_thesis pk_type_thesis; Type: CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.type_thesis
    ADD CONSTRAINT pk_type_thesis PRIMARY KEY (type_thesis_id);


--
-- TOC entry 3533 (class 2606 OID 25337)
-- Name: activity_researcher activity_activity_researcher_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.activity_researcher
    ADD CONSTRAINT activity_activity_researcher_fk FOREIGN KEY (id_activity) REFERENCES public.activity(id_activity);


--
-- TOC entry 3535 (class 2606 OID 25342)
-- Name: activity_team activity_activity_team_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.activity_team
    ADD CONSTRAINT activity_activity_team_fk FOREIGN KEY (id_activity) REFERENCES public.activity(id_activity);


--
-- TOC entry 3542 (class 2606 OID 25347)
-- Name: book_chapter activity_book_chapter_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.book_chapter
    ADD CONSTRAINT activity_book_chapter_fk FOREIGN KEY (id_activity) REFERENCES public.activity(id_activity);


--
-- TOC entry 3540 (class 2606 OID 25352)
-- Name: book activity_book_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.book
    ADD CONSTRAINT activity_book_fk FOREIGN KEY (id_activity) REFERENCES public.activity(id_activity);


--
-- TOC entry 3550 (class 2606 OID 25357)
-- Name: editorial_activity activity_editorial_activity_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.editorial_activity
    ADD CONSTRAINT activity_editorial_activity_fk FOREIGN KEY (id_activity) REFERENCES public.activity(id_activity);


--
-- TOC entry 3553 (class 2606 OID 25362)
-- Name: education activity_education_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.education
    ADD CONSTRAINT activity_education_fk FOREIGN KEY (id_activity) REFERENCES public.activity(id_activity);


--
-- TOC entry 3559 (class 2606 OID 25367)
-- Name: incoming_mobility activity_incoming_mobility_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.incoming_mobility
    ADD CONSTRAINT activity_incoming_mobility_fk FOREIGN KEY (id_activity) REFERENCES public.activity(id_activity);


--
-- TOC entry 3562 (class 2606 OID 25372)
-- Name: invited_seminar activity_invited_seminar_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.invited_seminar
    ADD CONSTRAINT activity_invited_seminar_fk FOREIGN KEY (id_activity) REFERENCES public.activity(id_activity);


--
-- TOC entry 3565 (class 2606 OID 25377)
-- Name: laboratory_evaluation activity_lab_evaluation_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.laboratory_evaluation
    ADD CONSTRAINT activity_lab_evaluation_fk FOREIGN KEY (id_activity) REFERENCES public.activity(id_activity);


--
-- TOC entry 3569 (class 2606 OID 25382)
-- Name: mail_activity activity_mail_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.mail_activity
    ADD CONSTRAINT activity_mail_fk FOREIGN KEY (id_activity) REFERENCES public.activity(id_activity);


--
-- TOC entry 3571 (class 2606 OID 25387)
-- Name: meeting_congress_org activity_meeting_congress_org_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.meeting_congress_org
    ADD CONSTRAINT activity_meeting_congress_org_fk FOREIGN KEY (id_activity) REFERENCES public.activity(id_activity);


--
-- TOC entry 3573 (class 2606 OID 25392)
-- Name: national_international_collaboration activity_national_international_collaboration_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.national_international_collaboration
    ADD CONSTRAINT activity_national_international_collaboration_fk FOREIGN KEY (id_activity) REFERENCES public.activity(id_activity);


--
-- TOC entry 3575 (class 2606 OID 25397)
-- Name: network activity_network_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.network
    ADD CONSTRAINT activity_network_fk FOREIGN KEY (id_activity) REFERENCES public.activity(id_activity);


--
-- TOC entry 3576 (class 2606 OID 25402)
-- Name: oral_communication activity_oral_communication_poster_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.oral_communication
    ADD CONSTRAINT activity_oral_communication_poster_fk FOREIGN KEY (id_activity) REFERENCES public.activity(id_activity);


--
-- TOC entry 3579 (class 2606 OID 25407)
-- Name: outgoing_mobility activity_outgoing_mobility_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.outgoing_mobility
    ADD CONSTRAINT activity_outgoing_mobility_fk FOREIGN KEY (id_activity) REFERENCES public.activity(id_activity);


--
-- TOC entry 3580 (class 2606 OID 25412)
-- Name: patent activity_patent_licence_invention_disclosure_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.patent
    ADD CONSTRAINT activity_patent_licence_invention_disclosure_fk FOREIGN KEY (id_activity) REFERENCES public.activity(id_activity);


--
-- TOC entry 3586 (class 2606 OID 25417)
-- Name: platform activity_platform_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT activity_platform_fk FOREIGN KEY (id_activity) REFERENCES public.activity(id_activity);


--
-- TOC entry 3587 (class 2606 OID 25422)
-- Name: post_doc activity_post_doc_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.post_doc
    ADD CONSTRAINT activity_post_doc_fk FOREIGN KEY (id_activity) REFERENCES public.activity(id_activity);


--
-- TOC entry 3588 (class 2606 OID 25427)
-- Name: project_evaluation activity_project_evaluation_grant_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.project_evaluation
    ADD CONSTRAINT activity_project_evaluation_grant_fk FOREIGN KEY (id_activity) REFERENCES public.activity(id_activity);


--
-- TOC entry 3556 (class 2606 OID 25432)
-- Name: evaluation_thesis activity_project_evaluation_thesis_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.evaluation_thesis
    ADD CONSTRAINT activity_project_evaluation_thesis_fk FOREIGN KEY (id_activity) REFERENCES public.activity(id_activity);


--
-- TOC entry 3592 (class 2606 OID 25437)
-- Name: public_outreach activity_public_outreach_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.public_outreach
    ADD CONSTRAINT activity_public_outreach_fk FOREIGN KEY (id_activity) REFERENCES public.activity(id_activity);


--
-- TOC entry 3594 (class 2606 OID 25442)
-- Name: publication activity_publication_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.publication
    ADD CONSTRAINT activity_publication_fk FOREIGN KEY (id_activity) REFERENCES public.activity(id_activity);


--
-- TOC entry 3597 (class 2606 OID 25447)
-- Name: research_contract_funded_public_charitable_inst activity_research_contract_funded_public_charitable_inst_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.research_contract_funded_public_charitable_inst
    ADD CONSTRAINT activity_research_contract_funded_public_charitable_inst_fk FOREIGN KEY (id_activity) REFERENCES public.activity(id_activity);


--
-- TOC entry 3560 (class 2606 OID 25452)
-- Name: institutional_comitee activity_responsibility_institutional_comitee_jury_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.institutional_comitee
    ADD CONSTRAINT activity_responsibility_institutional_comitee_jury_fk FOREIGN KEY (id_activity) REFERENCES public.activity(id_activity);


--
-- TOC entry 3601 (class 2606 OID 25457)
-- Name: reviewing_journal_articles activity_reviewing_journal_articles_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.reviewing_journal_articles
    ADD CONSTRAINT activity_reviewing_journal_articles_fk FOREIGN KEY (id_activity) REFERENCES public.activity(id_activity);


--
-- TOC entry 3603 (class 2606 OID 25462)
-- Name: scientific_expertise activity_scientific_expertise_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.scientific_expertise
    ADD CONSTRAINT activity_scientific_expertise_fk FOREIGN KEY (id_activity) REFERENCES public.activity(id_activity);


--
-- TOC entry 3605 (class 2606 OID 25467)
-- Name: sei_cifre_fellowship activity_sei_cifre_fellowship_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.sei_cifre_fellowship
    ADD CONSTRAINT activity_sei_cifre_fellowship_fk FOREIGN KEY (id_activity) REFERENCES public.activity(id_activity);


--
-- TOC entry 3606 (class 2606 OID 25472)
-- Name: sei_clinical_trial activity_sei_clinical_trial_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.sei_clinical_trial
    ADD CONSTRAINT activity_sei_clinical_trial_fk FOREIGN KEY (id_activity) REFERENCES public.activity(id_activity);


--
-- TOC entry 3544 (class 2606 OID 25477)
-- Name: company_creation activity_sei_company_creation_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.company_creation
    ADD CONSTRAINT activity_sei_company_creation_fk FOREIGN KEY (id_activity) REFERENCES public.activity(id_activity);


--
-- TOC entry 3607 (class 2606 OID 25482)
-- Name: sei_industrial_r_d_contract activity_sei_industrial_r_d_contract_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.sei_industrial_r_d_contract
    ADD CONSTRAINT activity_sei_industrial_r_d_contract_fk FOREIGN KEY (id_activity) REFERENCES public.activity(id_activity);


--
-- TOC entry 3563 (class 2606 OID 25487)
-- Name: labcom_creation activity_sei_labcom_creation_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.labcom_creation
    ADD CONSTRAINT activity_sei_labcom_creation_fk FOREIGN KEY (id_activity) REFERENCES public.activity(id_activity);


--
-- TOC entry 3608 (class 2606 OID 25492)
-- Name: sei_lead_consortium_industry activity_sei_lead_consortium_industry_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.sei_lead_consortium_industry
    ADD CONSTRAINT activity_sei_lead_consortium_industry_fk FOREIGN KEY (id_activity) REFERENCES public.activity(id_activity);


--
-- TOC entry 3610 (class 2606 OID 25497)
-- Name: sei_network_unit_creation activity_sei_network_unit_creation_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.sei_network_unit_creation
    ADD CONSTRAINT activity_sei_network_unit_creation_fk FOREIGN KEY (id_activity) REFERENCES public.activity(id_activity);


--
-- TOC entry 3616 (class 2606 OID 25502)
-- Name: sr_award activity_sr_award_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.sr_award
    ADD CONSTRAINT activity_sr_award_fk FOREIGN KEY (id_activity) REFERENCES public.activity(id_activity);


--
-- TOC entry 3567 (class 2606 OID 25507)
-- Name: learned_scientific_society activity_sr_responsibility_learned_scientific_society_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.learned_scientific_society
    ADD CONSTRAINT activity_sr_responsibility_learned_scientific_society_fk FOREIGN KEY (id_activity) REFERENCES public.activity(id_activity);


--
-- TOC entry 3617 (class 2606 OID 25512)
-- Name: tool_product activity_tool_product_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.tool_product
    ADD CONSTRAINT activity_tool_product_fk FOREIGN KEY (id_activity) REFERENCES public.activity(id_activity);


--
-- TOC entry 3589 (class 2606 OID 25517)
-- Name: project_evaluation category_grant_project_evaluation_grant_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.project_evaluation
    ADD CONSTRAINT category_grant_project_evaluation_grant_fk FOREIGN KEY (project_evaluation_category_id) REFERENCES public.project_evaluation_category(project_evaluation_category_id);


--
-- TOC entry 3611 (class 2606 OID 25522)
-- Name: supervisor chercheur_encadrant_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.supervisor
    ADD CONSTRAINT chercheur_encadrant_fk FOREIGN KEY (researcher_id) REFERENCES public.researcher(researcher_id);


--
-- TOC entry 3581 (class 2606 OID 25527)
-- Name: patent choice_patent_licence_invention_disclosure_patent_licence_in35; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.patent
    ADD CONSTRAINT choice_patent_licence_invention_disclosure_patent_licence_in35 FOREIGN KEY (type_patent_id) REFERENCES public.type_patent(type_patent_id);


--
-- TOC entry 3593 (class 2606 OID 25532)
-- Name: public_outreach choice_public_outreach_public_outreach_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.public_outreach
    ADD CONSTRAINT choice_public_outreach_public_outreach_fk FOREIGN KEY (public_outreach_type_id) REFERENCES public.public_outreach_type(public_outreach_type_id);


--
-- TOC entry 3598 (class 2606 OID 25537)
-- Name: research_contract_funded_public_charitable_inst choice_research_contract_funded_public_charitable_inst_resear51; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.research_contract_funded_public_charitable_inst
    ADD CONSTRAINT choice_research_contract_funded_public_charitable_inst_resear51 FOREIGN KEY (id_type) REFERENCES public.type_research_contract(id_type);


--
-- TOC entry 3604 (class 2606 OID 25542)
-- Name: scientific_expertise choice_scientific_expertise_scientific_expertise_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.scientific_expertise
    ADD CONSTRAINT choice_scientific_expertise_scientific_expertise_fk FOREIGN KEY (scientific_expertise_type_id) REFERENCES public.scientific_expertise_type(scientific_expertise_type_id);


--
-- TOC entry 3574 (class 2606 OID 25547)
-- Name: national_international_collaboration choice_type_collab_national_international_collaboration_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.national_international_collaboration
    ADD CONSTRAINT choice_type_collab_national_international_collaboration_fk FOREIGN KEY (type_collab_id) REFERENCES public.type_collab(type_collab_id);


--
-- TOC entry 3582 (class 2606 OID 25552)
-- Name: phd_associated_company company_phd_associated_company_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.phd_associated_company
    ADD CONSTRAINT company_phd_associated_company_fk FOREIGN KEY (company_id) REFERENCES public.company(company_id);


--
-- TOC entry 3546 (class 2606 OID 25557)
-- Name: contract contract_type_contract_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.contract
    ADD CONSTRAINT contract_type_contract_fk FOREIGN KEY (id_contract_type) REFERENCES public.contract_type(id_contract_type);


--
-- TOC entry 3554 (class 2606 OID 25562)
-- Name: education education_involvment_education_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.education
    ADD CONSTRAINT education_involvment_education_fk FOREIGN KEY (education_involvment_id) REFERENCES public.education_involvment(education_involvment_id);


--
-- TOC entry 3555 (class 2606 OID 25567)
-- Name: education education_level_education_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.education
    ADD CONSTRAINT education_level_education_fk FOREIGN KEY (education_level_id) REFERENCES public.education_level(education_level_id);


--
-- TOC entry 3547 (class 2606 OID 25572)
-- Name: contract employer_contract_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.contract
    ADD CONSTRAINT employer_contract_fk FOREIGN KEY (id_employer) REFERENCES public.employer(id_employer);


--
-- TOC entry 3551 (class 2606 OID 25577)
-- Name: editorial_activity function_electronic_tool_product_1_editorial_activity_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.editorial_activity
    ADD CONSTRAINT function_electronic_tool_product_1_editorial_activity_fk FOREIGN KEY (function_editorial_activity_id) REFERENCES public.function_editorial_activity(function_editorial_activity_id);


--
-- TOC entry 3590 (class 2606 OID 25582)
-- Name: project_evaluation funder_project_evaluation_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.project_evaluation
    ADD CONSTRAINT funder_project_evaluation_fk FOREIGN KEY (funder_id) REFERENCES public.funder(funder_id);


--
-- TOC entry 3564 (class 2606 OID 25587)
-- Name: laboratory institution_laboratory_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.laboratory
    ADD CONSTRAINT institution_laboratory_fk FOREIGN KEY (institution_id) REFERENCES public.institution(institution_id);


--
-- TOC entry 3552 (class 2606 OID 25592)
-- Name: editorial_activity journal_editorial_activity_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.editorial_activity
    ADD CONSTRAINT journal_editorial_activity_fk FOREIGN KEY (journal_id) REFERENCES public.journal(journal_id);


--
-- TOC entry 3602 (class 2606 OID 25597)
-- Name: reviewing_journal_articles journal_reviewing_journal_articles_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.reviewing_journal_articles
    ADD CONSTRAINT journal_reviewing_journal_articles_fk FOREIGN KEY (journal_id) REFERENCES public.journal(journal_id);


--
-- TOC entry 3613 (class 2606 OID 25602)
-- Name: team laboratory_team_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.team
    ADD CONSTRAINT laboratory_team_fk FOREIGN KEY (laboratory_id) REFERENCES public.laboratory(laboratory_id);


--
-- TOC entry 3543 (class 2606 OID 25607)
-- Name: book_chapter language_book_chapter_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.book_chapter
    ADD CONSTRAINT language_book_chapter_fk FOREIGN KEY (language_id) REFERENCES public.language(language_id);


--
-- TOC entry 3541 (class 2606 OID 25612)
-- Name: book language_book_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.book
    ADD CONSTRAINT language_book_fk FOREIGN KEY (language_id) REFERENCES public.language(language_id);


--
-- TOC entry 3570 (class 2606 OID 25617)
-- Name: mail_activity mail_template_mail_activity_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.mail_activity
    ADD CONSTRAINT mail_template_mail_activity_fk FOREIGN KEY (mail_template_id) REFERENCES public.mail_template(mail_template_id);


--
-- TOC entry 3572 (class 2606 OID 25622)
-- Name: meeting_congress_org meeting_meeting_congress_org_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.meeting_congress_org
    ADD CONSTRAINT meeting_meeting_congress_org_fk FOREIGN KEY (meeting_id) REFERENCES public.meeting(meeting_id);


--
-- TOC entry 3577 (class 2606 OID 25627)
-- Name: oral_communication meeting_oral_communication_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.oral_communication
    ADD CONSTRAINT meeting_oral_communication_fk FOREIGN KEY (meeting_id) REFERENCES public.meeting(meeting_id);


--
-- TOC entry 3599 (class 2606 OID 25632)
-- Name: researcher_nationality nationality_researcher_nationality_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.researcher_nationality
    ADD CONSTRAINT nationality_researcher_nationality_fk FOREIGN KEY (nationality_id) REFERENCES public.nationality(nationality_id);


--
-- TOC entry 3583 (class 2606 OID 25637)
-- Name: phd_associated_company phd_student_phd_associated_company_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.phd_associated_company
    ADD CONSTRAINT phd_student_phd_associated_company_fk FOREIGN KEY (phd_student_id) REFERENCES public.phd_student(phd_student_id);


--
-- TOC entry 3612 (class 2606 OID 25642)
-- Name: supervisor phd_student_supervisor_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.supervisor
    ADD CONSTRAINT phd_student_supervisor_fk FOREIGN KEY (phd_student_id) REFERENCES public.phd_student(phd_student_id);


--
-- TOC entry 3584 (class 2606 OID 25647)
-- Name: phd_student phd_type_phd_student_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.phd_student
    ADD CONSTRAINT phd_type_phd_student_fk FOREIGN KEY (phd_type_id) REFERENCES public.phd_type(phd_type_id);


--
-- TOC entry 3595 (class 2606 OID 25652)
-- Name: publication publication_type_publication_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.publication
    ADD CONSTRAINT publication_type_publication_fk FOREIGN KEY (publication_type_id) REFERENCES public.publication_type(publication_type_id);


--
-- TOC entry 3534 (class 2606 OID 25657)
-- Name: activity_researcher researcher_activity_researcher_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.activity_researcher
    ADD CONSTRAINT researcher_activity_researcher_fk FOREIGN KEY (researcher_id) REFERENCES public.researcher(researcher_id);


--
-- TOC entry 3537 (class 2606 OID 25662)
-- Name: admin researcher_admin_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT researcher_admin_fk FOREIGN KEY (researcher_id) REFERENCES public.researcher(researcher_id);


--
-- TOC entry 3538 (class 2606 OID 25667)
-- Name: belongs_team researcher_belongs_team_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.belongs_team
    ADD CONSTRAINT researcher_belongs_team_fk FOREIGN KEY (researcher_id) REFERENCES public.researcher(researcher_id);


--
-- TOC entry 3545 (class 2606 OID 25672)
-- Name: connection researcher_connection_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.connection
    ADD CONSTRAINT researcher_connection_fk FOREIGN KEY (researcher_id) REFERENCES public.researcher(researcher_id);


--
-- TOC entry 3548 (class 2606 OID 25677)
-- Name: contract researcher_contract_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.contract
    ADD CONSTRAINT researcher_contract_fk FOREIGN KEY (researcher_id) REFERENCES public.researcher(researcher_id);


--
-- TOC entry 3585 (class 2606 OID 25682)
-- Name: phd_student researcher_phd_student_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.phd_student
    ADD CONSTRAINT researcher_phd_student_fk FOREIGN KEY (researcher_id) REFERENCES public.researcher(researcher_id);


--
-- TOC entry 3600 (class 2606 OID 25687)
-- Name: researcher_nationality researcher_researcher_nationality_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.researcher_nationality
    ADD CONSTRAINT researcher_researcher_nationality_fk FOREIGN KEY (researcher_id) REFERENCES public.researcher(researcher_id);


--
-- TOC entry 3614 (class 2606 OID 25692)
-- Name: team_referent researcher_team_referent_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.team_referent
    ADD CONSTRAINT researcher_team_referent_fk FOREIGN KEY (researcher_id) REFERENCES public.researcher(researcher_id);


--
-- TOC entry 3591 (class 2606 OID 25697)
-- Name: project_evaluation role_pi_grant_project_evaluation_grant_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.project_evaluation
    ADD CONSTRAINT role_pi_grant_project_evaluation_grant_fk FOREIGN KEY (project_evaluation_role_id) REFERENCES public.project_evaluation_role(project_evaluation_role_id);


--
-- TOC entry 3566 (class 2606 OID 25702)
-- Name: laboratory_evaluation role_pi_lab_eval_lab_evaluation_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.laboratory_evaluation
    ADD CONSTRAINT role_pi_lab_eval_lab_evaluation_fk FOREIGN KEY (laboratory_evaluation_role_id) REFERENCES public.laboratory_evaluation_role(laboratory_evaluation_role_id);


--
-- TOC entry 3561 (class 2606 OID 25707)
-- Name: institutional_comitee role_pi_lab_eval_responsibility_institutional_comitee_jury_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.institutional_comitee
    ADD CONSTRAINT role_pi_lab_eval_responsibility_institutional_comitee_jury_fk FOREIGN KEY (laboratory_evaluation_role_id) REFERENCES public.laboratory_evaluation_role(laboratory_evaluation_role_id);


--
-- TOC entry 3568 (class 2606 OID 25712)
-- Name: learned_scientific_society role_pi_scientific_recognition_scientific_recognition_respon970; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.learned_scientific_society
    ADD CONSTRAINT role_pi_scientific_recognition_scientific_recognition_respon970 FOREIGN KEY (learned_scientific_society_role_id) REFERENCES public.learned_scientific_society_role(learned_scientific_society_role_id);


--
-- TOC entry 3557 (class 2606 OID 25717)
-- Name: evaluation_thesis role_pi_thesis_project_evaluation_thesis_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.evaluation_thesis
    ADD CONSTRAINT role_pi_thesis_project_evaluation_thesis_fk FOREIGN KEY (evaluation_thesis_role_id) REFERENCES public.evaluation_thesis_role(evaluation_thesis_role_id);


--
-- TOC entry 3549 (class 2606 OID 25722)
-- Name: contract status_contract_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.contract
    ADD CONSTRAINT status_contract_fk FOREIGN KEY (id_status) REFERENCES public.status(id_status);


--
-- TOC entry 3536 (class 2606 OID 25727)
-- Name: activity_team team_activity_team_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.activity_team
    ADD CONSTRAINT team_activity_team_fk FOREIGN KEY (team_id) REFERENCES public.team(team_id);


--
-- TOC entry 3539 (class 2606 OID 25732)
-- Name: belongs_team team_belongs_team_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.belongs_team
    ADD CONSTRAINT team_belongs_team_fk FOREIGN KEY (team_id) REFERENCES public.team(team_id);


--
-- TOC entry 3596 (class 2606 OID 25737)
-- Name: publication_statistics team_publication_statistics_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.publication_statistics
    ADD CONSTRAINT team_publication_statistics_fk FOREIGN KEY (team_id) REFERENCES public.team(team_id);


--
-- TOC entry 3615 (class 2606 OID 25742)
-- Name: team_referent team_team_referent_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.team_referent
    ADD CONSTRAINT team_team_referent_fk FOREIGN KEY (team_id) REFERENCES public.team(team_id);


--
-- TOC entry 3619 (class 2606 OID 25747)
-- Name: tool_product_involvment tool_product_role_tool_product_involvment_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.tool_product_involvment
    ADD CONSTRAINT tool_product_role_tool_product_involvment_fk FOREIGN KEY (tool_product_role_id) REFERENCES public.tool_product_role(tool_product_role_id);


--
-- TOC entry 3620 (class 2606 OID 25752)
-- Name: tool_product_involvment tool_product_tool_product_involvment_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.tool_product_involvment
    ADD CONSTRAINT tool_product_tool_product_involvment_fk FOREIGN KEY (id_activity) REFERENCES public.tool_product(id_activity);


--
-- TOC entry 3618 (class 2606 OID 25757)
-- Name: tool_product tool_product_type_tool_product_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.tool_product
    ADD CONSTRAINT tool_product_type_tool_product_fk FOREIGN KEY (tool_product_type_id) REFERENCES public.tool_product_type(tool_product_type_id);


--
-- TOC entry 3532 (class 2606 OID 25762)
-- Name: activity type_activite_activite_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.activity
    ADD CONSTRAINT type_activite_activite_fk FOREIGN KEY (id_type_activity) REFERENCES public.type_activity(id_type_activity);


--
-- TOC entry 3609 (class 2606 OID 25767)
-- Name: sei_lead_consortium_industry type_consortium_socio_economic_interaction_lead_consortium_i423; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.sei_lead_consortium_industry
    ADD CONSTRAINT type_consortium_socio_economic_interaction_lead_consortium_i423 FOREIGN KEY (type_consortium_id) REFERENCES public.type_consortium(type_consortium_id);


--
-- TOC entry 3578 (class 2606 OID 25772)
-- Name: oral_communication type_oral_communication_oral_communication_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.oral_communication
    ADD CONSTRAINT type_oral_communication_oral_communication_fk FOREIGN KEY (type_oral_communication_id) REFERENCES public.type_oral_communication(type_oral_communication_id);


--
-- TOC entry 3558 (class 2606 OID 25777)
-- Name: evaluation_thesis type_thesis_project_evaluation_thesis_fk; Type: FK CONSTRAINT; Schema: public; Owner: hceres
--

ALTER TABLE ONLY public.evaluation_thesis
    ADD CONSTRAINT type_thesis_project_evaluation_thesis_fk FOREIGN KEY (type_thesis_id) REFERENCES public.type_thesis(type_thesis_id);


-- Completed on 2022-04-01 14:49:46

--
-- PostgreSQL database dump complete
--

