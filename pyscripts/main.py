from citizens import generateCitizens
from occupations import generateOccupations
from districts import generateDistricts
from insert import generateInsert
citizens = generateCitizens(10)
districts = generateDistricts()
occupations = generateOccupations()
generateInsert(citizens, 'citizens', removeId=False)
generateInsert(districts, 'districts')
generateInsert(occupations, 'occupations')
