from occupations import generateOccupations
from districts import generateDistricts
from faker import Faker
import random

citizens = []


def generateCitizens(n=500):
    if len(citizens) == 0:
        fake = Faker()

        occupations = generateOccupations()
        districts = generateDistricts()

        citizen_ids = set()
        while(len(citizen_ids) < n):
            citizen_ids.add(random.randint(
                1_000_000_000_000, 9_999_999_999_999))

        citizen_firstNames = [fake.first_name() for _ in range(n)]
        citizen_lastNames = [fake.last_name() for _ in range(n)]
        citizen_dobs = [fake.date(pattern='%Y-%m-%d') for _ in range(n)]
        citizen_genders = [random.choice(('male', 'female')) for _ in range(n)]
        citizen_districtIds = [random.choice(
            districts)['districtId'] for _ in range(n)]
        citizen_occupationIds = [random.choice(
            occupations)['occupationId'] for _ in range(n)]
        citizen_addressLine1s = [fake.zipcode() for _ in range(n)]
        citizen_addressLine2s = [fake.street_name() for _ in range(n)]

        for id, firstName, lastName, dob, gender, districtId, occupationId, addressLine1, addressLine2 in zip(citizen_ids, citizen_firstNames, citizen_lastNames, citizen_dobs, citizen_genders, citizen_districtIds, citizen_occupationIds, citizen_addressLine1s, citizen_addressLine2s):
            citizens.append({
                'citizenId': id,
                'firstName': firstName,
                'lastName': lastName,
                'dateOfBirth': dob,
                'gender': gender,
                'districtId': districtId,
                'occupationId': occupationId,
                'markerID': 1,
                'addressLine1': addressLine1,
                'addressLine2': addressLine2,
                'score': 0
            })
    return citizens
