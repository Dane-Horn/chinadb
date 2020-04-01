from faker import Faker
from actions import generateActions
from citizens import generateCitizens
from cameras import generateCameras
from random import choice, randint
actionsLogs = []
def generateActionLogs(n=100):
    if len(actionsLogs) > 0: return actionsLogs
    fake = Faker()
    actions = generateActions()
    actionIds = [choice(actions)['actionId'] for _ in range(n)]
    cameras = generateCameras()
    cameraIds = [choice(cameras)['cameraId'] for _ in range(n)]
    citizens = generateCitizens()
    citizenIds = [choice(citizens)['citizenId'] for _ in range(n)]
    accuracies = [randint(1, 100) for _ in range(n)]
    occurenceTimes = [fake.date_between(start_date='-10y', end_date='now').strftime('%Y-%m-%d') for _ in range(n)]
    for citizenId, actionId, cameraId, accuracy, occurenceTime in zip(citizenIds, actionIds, cameraIds, accuracies, occurenceTimes):
        actionsLogs.append({
            'citizenId':citizenId,
            'actionId':actionId,
            'cameraId':cameraId,
            'accuracy':accuracy,
            'occurenceTime':occurenceTime,
        })
    print(actionsLogs)
    return actionsLogs
