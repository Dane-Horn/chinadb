from itertools import cycle


def generateInsert(entries, name, removeId=True):
    if removeId:
        for entry in entries:
            del entry[f'{name[:-1]}Id']
    for i in range(0, len(entries), 1000):
        output = f'''
        INSERT INTO [dbo].[{name.capitalize()}] ({', '.join(entries[0].keys())})
        VALUES
        '''
        for entry in entries[i:i+1000]:
            output += f"\t{ tuple(entry.values()) },\n"
        print(output[:-2])


def generateCitizenInsert(citizens):
    output = ""
    for citizen in citizens:
        output += f'EXEC usp_insertCitizen {str(tuple(citizen.values()))[1:-1]}\n'
    print(output[:-1])

def generateActionLogInsert(actionLogs):
    output = ""
    for actionLog in actionLogs:
        output += f'EXEC usp_AddActionToLog {str(tuple(actionLog.values()))[1:-1]}\n'
    print(output[:-1])