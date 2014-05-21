from simpleai.search import SearchProblem, hill_climbing_random_restarts
import random

class TspProblem(SearchProblem):
	'''Traveling Sales person Problem'''
	
	def __init__(self, c, d):
	
		super(TspProblem, self).__init__(initial_state = [0, 4, 3, 2, 1, 8, 7, 6, 5, 11, 10, 9, 0])
		self.numCities = c
		self.distances = d
		
	def actions(self,s):
		actions = []
		a = random.randint(1,self.numCities-1)
		b = random.randint(1, self.numCities-1)
		while b == a:
			b = random.randint(1, self.numCities-1)
		x = min(a,b)
		y = max(a,b)
		
		tour = s[:x+1] + list(reversed(s[x+1:y])) + s[y:]
		actions.append( ('2-change at '+ str(x) + ' and ' + str(y), tour ) )
		return actions
		
	def result(self,s,a):
		return a[1]
	
	def value(self, s):
		return len(s)
		
	def generate_random_state(self):
		x = self.initial_state
		
		return [0] + random.sample(x, len(x)) + [0]
	
	def _tour_length(self,s):
		return len(s)
		
		
d = [ [0,   1,   2,  3,  4,  5,  6,  7,  8,  9, 10, 11], \
      [1,   0,  11,  4,  6,  8,  10, 3,  5,  7,  2,  9], \
      [2,  11,   0,  1,  5,  9,  3,  7,  4,  8,  6, 10], \
      [3,   4,   1,  0, 11,  7,  8,  5,  2, 10,  9,  6], \
      [4,   6,   5, 11,  0,  1,  2,  9,  7,  4,  8, 11], \
      [5,   8,   9,  7,  1,  0,  4,  2, 10,  6, 11,  3], \
      [6,  10,   3,  8,  2,  4,  0,  9,  7,  6,  5,  1], \
      [7,   3,   7,  5,  9,  2,  9,  0,  4,  1,  6, 10], \
      [8,   5,   4,  2,  7, 10,  7,  4,  0,  3,  1, 11], \
      [9,   7,   8, 10,  4,  6,  6,  1,  3,  0,  5,  9], \
      [10,  2,   6,  9,  8, 11,  5,  6,  1,  5,  0,  3], \
      [11,  9,  10,  6,  11, 3,  1, 10, 11,  9,  3,  0] ]	
	  
	  
problem = TspProblem(12, d)
result = hill_climbing_random_restarts(problem, restarts_limit=200)
for node in result.path():
	print node
