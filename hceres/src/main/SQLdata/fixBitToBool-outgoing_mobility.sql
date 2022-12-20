alter table outgoing_mobility
    drop column strategic_recurring_collab;
alter table outgoing_mobility
    drop column active_project;
alter table outgoing_mobility
    drop column umr_coordinated;

alter table outgoing_mobility
    add column strategic_recurring_collab bool;
alter table outgoing_mobility
    add column active_project bool;
alter table outgoing_mobility
    add column umr_coordinated bool;