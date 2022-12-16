alter table platform
    drop column open_private_researchers;
alter table platform
    add open_private_researchers bool;
alter table sei_clinical_trial
    drop column coordinator_partner;
alter table sei_clinical_trial
    add coordinator_partner bool;
alter table company_creation
    drop column company_creation_active;
alter table company_creation
    add column company_creation_active bool;
alter table incoming_mobility
    drop column strategic_recurring_collab;
alter table incoming_mobility
    add column strategic_recurring_collab bool;
alter table incoming_mobility
    drop column active_project;
alter table incoming_mobility
    add column active_project bool;
alter table incoming_mobility
    drop column umr_coordinated;
alter table incoming_mobility
    add column umr_coordinated bool;
alter table incoming_mobility
    drop column agreement_signed;
alter table incoming_mobility
    add column agreement_signed bool;
alter table national_international_collaboration
    drop column strategic_recurring_collab;
alter table national_international_collaboration
    add column strategic_recurring_collab bool;
alter table national_international_collaboration
    drop column active_project;
alter table national_international_collaboration
    add column active_project bool;
alter table national_international_collaboration
    drop column umr_coordinated;
alter table national_international_collaboration
    add column umr_coordinated bool;
alter table national_international_collaboration
    drop column agreement_signed;
alter table national_international_collaboration
    add column agreement_signed bool;
alter table network
    drop column active_network;
alter table network
    add column active_network bool;
alter table network
    drop column umr_coordinated;
alter table network
    add column umr_coordinated bool;
alter table network
    drop column agreement_signed;
alter table network
    add column agreement_signed bool;
alter table outgoing_mobility
    drop column agreement_signed;
alter table outgoing_mobility
    add column agreement_signed bool;
alter table patent
    drop column status;
alter table patent
    add column status bool;
alter table patent
    drop column pct_extension_obtained;
alter table patent
    add column pct_extension_obtained bool;
alter table patent
    drop column international_extension;
alter table patent
    add column international_extension bool;