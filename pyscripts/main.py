from citizens import generateCitizens
from occupations import generateOccupations
from districts import generateDistricts
from cameras import generateCameras
from actionLogs import generateActionLogs
from insert import generateInsert, generateCitizenInsert, generateActionLogInsert, generateDistrictInsert, generateOccupationInsert, generateCameraInsert, generateActionInsert
from actions import generateActions
districts = generateDistricts(50)
occupations = generateOccupations(500)
citizens = generateCitizens(5000)
cameras = generateCameras(400)
actions = generateActions()
actionLogs = generateActionLogs(50000)
generateDistrictInsert(districts)
generateOccupationInsert(occupations)
generateCameraInsert(cameras)
generateCitizenInsert(citizens)
generateActionInsert(actions)
generateActionLogInsert(actionLogs)