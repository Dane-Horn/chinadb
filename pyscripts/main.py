from citizens import generateCitizens
from occupations import generateOccupations
from districts import generateDistricts
from cameras import generateCameras
from actionLogs import generateActionLogs
from insert import generateInsert
from actions import generateActions
districts = generateDistricts(15)
occupations = generateOccupations(50)
citizens = generateCitizens(100)
cameras = generateCameras(20)
actions = generateActions()
actionLogs = generateActionLogs(500)
generateInsert(districts, 'districts')
generateInsert(occupations, 'occupations')
generateInsert(cameras, 'cameras')
generateInsert(citizens, 'citizens', removeId=False)
generateInsert(actions, 'actions')
generateInsert(actionLogs, 'actionsLog', removeId=False)