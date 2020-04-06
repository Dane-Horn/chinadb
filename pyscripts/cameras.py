from faker import Faker
from districts import generateDistricts
import random
cameras = []
def generateCameras(n=100):
    if len(cameras) > 0: return cameras
    fake = Faker()
    districts = generateDistricts()
    longitudes = [float(fake.longitude()) for _ in range(n)]
    latitudes = [float(fake.latitude()) for _ in range(n)]
    ids = [x for x in range(1, n+1)]
    maintenanceDates = [fake.date_between(start_date="-20y", end_date="today").strftime("%Y-%m-%d") for _ in range(n)]
    districtIds = [random.choice(districts)['districtId'] for _ in range(n)]

    for cameraId, districtId, latitude, longitude, lastMaintenanceDate in zip(ids, districtIds, latitudes, longitudes, maintenanceDates):
        cameras.append({
            'cameraId': cameraId,
            'districtId':districtId,
            'latitude':latitude,
            'longitude':longitude,
            'lastMaintenanceDate':lastMaintenanceDate,
        })
    return cameras
