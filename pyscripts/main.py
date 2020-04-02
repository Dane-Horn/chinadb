from citizens import generateCitizens
from occupations import generateOccupations
from districts import generateDistricts
from cameras import generateCameras
from actionLogs import generateActionLogs
from insert import generateInsert
from actions import generateActions
districts = generateDistricts(50)
occupations = generateOccupations(100)
citizens = generateCitizens(1000)
cameras = generateCameras(200)
actions = generateActions()
actionLogs = generateActionLogs(10000)
generateInsert(districts, 'districts')
generateInsert(occupations, 'occupations')
generateInsert(cameras, 'cameras')
generateInsert(citizens, 'citizens', removeId=False)
generateInsert(actions, 'actions')
generateInsert(actionLogs, 'actionsLog', removeId=False)