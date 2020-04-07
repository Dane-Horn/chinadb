use SurveillenceDB
go
setuser
drop user police1
create user police1 without login

drop user maintainer1
create user maintainer1 without login


drop role Police
create role Police

drop role PopulationControl
create role PopulationControl

drop role Maintenance
create role Maintenance

alter role Police
add member police1

alter role Maintenance
add member maintainer1

grant select on Citizens to Maintenance;