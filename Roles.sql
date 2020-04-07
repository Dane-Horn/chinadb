use SurveillenceDB
go
setuser
drop user Dane
create user Dane without login


drop role Police
create role Police

drop role PopulationControl
create role PopulationControl

drop role Maintenance
create role Maintenance

alter role Maintenance
add member Dane

grant select on fCamerasToMaintain to Maintenance