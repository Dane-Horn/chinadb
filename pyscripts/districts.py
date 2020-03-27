import random

province_pool = ["Eastwald",
                 "Goldcrest",
                 "Wellwick",
                 "Newby",
                 "Mormead",
                 "Wellmage",
                 "Linville",
                 "Newmill",
                 "Southpine",
                 "Redlake",
                 "Woodgriffin",
                 "Norcliff",
                 "Raymere",
                 "Falconedge",
                 "Newcoast",
                 "Raymarsh",
                 "Oakbeach",
                 "Grasslyn",
                 "Coldmoor",
                 "Riverburn",
                 "Aelwynne",
                 "Mallowwood"]


def generateProvinces(n):
    province_names = random.sample(province_pool, k=n)
    province_sizes = [round(random.uniform(100.00, 10000.00), 2)
                      for _ in range(n)]
    entries = zip(province_names, province_sizes)
    output = f'''INSERT INTO [dbo].[Provinces] (provinceName, size)
    VALUES
    '''
    for entry in entries:
        output += f'\t{entry},\n'
    print(output[:-2])


generateProvinces(10)
