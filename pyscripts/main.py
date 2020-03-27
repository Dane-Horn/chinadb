from faker import Faker
from faker.providers import address
fake = Faker()
for _ in range(10):
    print(fake.first_name(), fake.last_name())
    print(fake.street_address())
    print(fake.country())
    print("------------------------------------------")
