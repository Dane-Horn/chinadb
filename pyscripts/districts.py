import random

district_pool = ["Eastwald",
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


def generateDistricts(n):
    district_names = random.sample(district_pool, k=n)
    district_sizes = [round(random.uniform(100.00, 10000.00), 2)
                      for _ in range(n)]
    entries = zip(district_names, district_sizes)
    output = f'''INSERT INTO [dbo].[Districts] (districtName, size)
    VALUES
    '''
    for entry in entries:
        output += f'\t{entry},\n'
    print(output[:-2])


generateDistricts(10)
