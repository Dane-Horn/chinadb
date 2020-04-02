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
