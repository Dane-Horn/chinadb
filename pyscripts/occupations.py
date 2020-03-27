from faker import Faker
import random


occupations = []


def generateOccupations(n=100):
    if len(occupations) == 0:
        fake = Faker()
        occupation_ids = [x for x in range(1, n+1)]
        occupation_scores = [random.randint(-10, 11) for _ in range(n)]
        occupation_names = set()
        occupation_descriptions = [
            fake.sentence(nb_words=10) for _ in range(n)]
        while(len(occupation_names) < n):
            occupation_names.add(fake.job())
        for id, score, name, description in zip(occupation_ids, occupation_scores, occupation_names, occupation_descriptions):
            occupations.append({
                'occupationId': id,
                'importance': score,
                'occupationName': name,
                'occupationDescription': description
            })
    return occupations
