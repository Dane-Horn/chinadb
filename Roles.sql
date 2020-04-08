use SurveillenceDB
go
setuser
-----------------------Users---------------------------
drop user Dane
create user Dane without login

drop user Keanu
create user Keanu without login

drop user Jono
create user Jono without login

drop user Brandon
create user Brandon without login

drop user Ian
create user Ian without login

drop user ElPresidente
create user ElPresidente without login
----------------------Roles---------------------------
drop role BasicUser
create role BasicUser

drop role Government
create role Government

drop role Police
create role Police

drop role PopulationControl
create role PopulationControl

drop role SuperUser
create role SuperUser

drop role GodUser
create role GodUser
----------------------Members-------------------------
alter role Government
add member Dane

alter role GodUser
add member ElPresidente
----------------------Permissions----------------------

grant control on DATABASE::SurveillenceDB to GodUser

grant select on fCamerasToMaintain to Government