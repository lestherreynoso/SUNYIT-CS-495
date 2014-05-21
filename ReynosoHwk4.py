from simpleai.search import SearchProblem, genetic
import random

class KpProblem(SearchProblem):
        '''KnapsackProblem'''
        
        def __init__(self, o, mW, w, v):
                super(KpProblem, self).__init__(initial_state = [0] * o)
                self.numObjects = o
                self.maxWeight = mW
                self.weights = w
                self.values = v
                
        def _weight(self, s):
                '''returns the total weight of the objects in the selected state'''
                sum = 0
                for i in range(0, len(s)):
                        if s[i] == 1:
                                sum += self.weights[i]
                return sum
                
        def _valid(self,s):
                '''returns true if the choice is valid'''
                if self._weight(s) <= self.maxWeight:
                        return True 
                else: 
                        return False
                
        def value(self, s):
                value = 0
                for i in range(0, len(s)): 
                        if s[i] == 1:
                                value += self.values[i]
                return value
                        
        def generate_random_state(self):
                '''returns valid random bit pattern corresponding to a
                subset of the objects to be carried.'''
                r = range(0, self.numObjects)   
                choice = [1] * self.numObjects
                while not self._valid(choice):
                        k = random.randint(1, self.numObjects-1 )  
                        x = random.sample(r, k)
                        for i in r:
                                if not i in x:
                                        choice[i] = 0      
                return choice
                
        def crossover(self, s, t):
                '''returns a valid crossover of s and t'''
                k = random.randint(1, self.numObjects - 1)
                count = 0
                y = [1] * self.numObjects
                while not self._valid(y):
                        k = random.randint(1, self.numObjects - 1)
                        y = s[:k] + t[k:]
                        count += 1
                        if count > self.numObjects:
                                return s
                return y
                
        def mutate(self, s):
                valid = False
                n = -1
                count = 0
                while not valid:
                        n = random.randint(0, self.numObjects -1)
                        
                        if not s[n]:            #s[n] = 0
                                s[n] = 1
                                valid = self._valid(s)
                        else:                           #s[n] = 1
                                s[n] = 0
                                k = random.randint(0, self.numObjects -1)
                                count = 0

                                while k == n or s[k] == 1:   #while s[n] and s[k] are equal or s[k] is already a 1 
                                        count += 1
                                        if count > self.numObjects: # if count has gone above numObjects 
                                                s = [0]*self.numObjects     #zero out state and break
                                                return s
                                        k = random.randint(1, self.numObjects -1) #else choose another random k
                                #s[k] is not a 1 or the same 1 we just changed
                                s[k] = 1                #change a random 0 somewhere else to 1
                                valid = self._valid(s)        
                return s
                        



o = 20
mw = 35         
w = [4, 6, 5, 5, 3, 2, 4, 8, 1, 5, 3, 7, 2, 5, 6, 3, 8, 4, 7, 2]                
v = [5, 6, 2, 8, 6, 5, 8, 2, 7, 6, 1, 3, 4, 4, 1, 5, 6, 2, 5, 3]                
                
problem = KpProblem(o, mw, w, v)
result = genetic(problem, iterations_limit=100, population_size=16, mutation_chance=0.10)
print result.path()
print 'Weight = ' + str(problem._weight(result.path()[0][1]))
print 'Value = ' + str(problem.value(result.path()[0][1]))

