import random

district_pool = ["Eastwald", "Goldcrest", "Wellwick", "Newby", "Mormead",
                 "Wellmage", "Linville", "Newmill", "Southpine", "Redlake",
                 "Woodgriffin", "Norcliff", "Raymere", "Falconedge", "Newcoast",
                 "Raymarsh", "Oakbeach", "Grasslyn", "Coldmoor", "Riverburn",
                 "Aelwynne", "Mallowwood", "Silverden", "West Island", "Rosslyn",
                 "Warfield", "Lee Hall", "Lexington", "Valley View", "Bayside",
                 "Passaic", "Nashua", "Tripoli", "Kingston", "Castries",
                 "Canarsie", "West Covina", "Merced", "Pasadena",
                 "Walker", "Atkinson", "Oranjestad", "Killearn Estates", "Tehran",
                 "Bujumbura", "Mesa", "Kettering", "Mentor", "Santa Barbara",
                 "Lincoln", "Johnson City", "Johnson Bayou", "Lake Ashby", "Port of Spain",
                 "Alexandria", "Freetown", "Avarua", "Johns Island", "Kabul",
                 "Oceana", "Brazzaville", "Delray Beach", "Battery Point", "Meriden",
                 "Clifton", "Harlem", "Burbank", "Walnut Creek", "Stewart"]

districts = []


def generateDistricts(n=15):
    if len(districts) == 0:
        district_names = random.sample(district_pool, k=n)
        district_sizes = [round(random.uniform(100.00, 10000.00), 2)
                          for _ in range(n)]
        district_ids = [x for x in range(1, n+1)]

        for id, name, size in zip(district_ids, district_names, district_sizes):
            districts.append(
                {'districtId': id, 'districtName': name, 'size': size})
    return districts
