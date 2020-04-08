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

drop role Government
create role Government

drop role Police
create role Police

drop role PoliceCaptain
create role PoliceCaptain

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

------Permissions->USP------
grant execute on schema :: dbo to SuperUser

grant execute on usp_AddActionToLog to Police
grant execute on usp_updateCameraMaintenance to Police

grant execute on usp_AddActionToLog to PoliceCaptain
grant execute on usp_deleteOldActionsLogs to PoliceCaptain
grant execute on usp_insertCamera to PoliceCaptain
grant execute on usp_updateCameraMaintenance to PoliceCaptain

grant execute on usp_insertCitizen to Government
grant execute on usp_MarkCitizen to Government
grant execute on usp_updateCitizenAddress to Government

------Permissions->Tables------

grant select, insert, update, delete  on schema :: dbo to SuperUser

------Permissions->Views------

grant select on vGendersPerOccupation to Government
grant select on vPopulationPerDistrict to Government
grant select on vScorePerDistrict to Government
grant select on vScorePerOccupation to Government

grant select on vActionsPerOccupation to Police, PoliceCaptain
grant select on vCitizensActions to Police, PoliceCaptain
grant select on vMostActionsPerCamera to Police, PoliceCaptain

------Permissions->Functions------
grant select on fCamerasToMaintain to Police, PoliceCaptain
grant select on fMostActionsBetweenDates to Police, PoliceCaptain





