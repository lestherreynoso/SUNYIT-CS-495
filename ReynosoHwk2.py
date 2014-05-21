from time import time
from simpleai.search import SearchProblem, astar

class WaterJugsProblem(SearchProblem):
    '''Water jugs problem.'''

    def __init__(self, j1, j2):
                
        super(WaterJugsProblem, self).__init__(initial_state=(0,0))
        self.jug1 = j1
        self.jug2 = j2
        

    def heuristic(self,s):
        return 1

    def is_goal(self,s):
        if s[0] == 2:
            return True
        else:
            return False

    def result(self,s,a):
        return a[1]

    def actions(self,s):
        '''Returns the 8 allowable actions from state s'''
        actions = []

        '''a1 - fill first jug from pump'''
        if s[0] < self.jug1:   #self.jug1 is full to capacity
            actions.append( ('Fill up jug 1 from pump', (self.jug1, s[1]) ) )
        
        '''a2 - fill second jug from pump'''
        if s[1] < self.jug2:   #self.jug2 is full to capacity
            actions.append( ('Fill up jug 2 from pump', (s[0], self.jug2) ) )
            
        '''b1 - emptying first jug into the ground'''
        if s[0] > 0:         #first jug is not empty
            actions.append( ('Dump first jug', (0,s[1]) ) )
            
        '''b2 - emptying second jug into the ground'''
        if s[1] > 0:         #first jug is not empty
            actions.append( ('Dump second jug', (s[0],0) ) )
            
        '''c1 - pour all of first jug into the second'''
        if s[0] > 0 and s[0] + s[1] <= self.jug2:     #fist jug is not empty and second jug wont overflow
            actions.append( ('Pour all of first jug into second', (0,s[1]+s[0]) ) )

        '''c2 - pour all of second jug into the first'''
        if s[1] > 0 and s[0] + s[1] <= self.jug1:     #second jug is not empty and first jug wont overflow
            actions.append( ('Pour all of second jug into first', (s[1]+s[0], 0) ) )
                                
        '''d1 - pour first into second until latter is full'''
        if s[0] > 0 and s[1] != self.jug2:           #first jug is not empty and second jug is not full
            actions.append( ('Fill the second jug with whats in first', (s[0] - (self.jug2 - s[1]), self.jug2) ) ) 
                                
        '''d2 - pour second into first until latter is full'''
        if s[1] > 0 and s[0] != self.jug1:         #second jug is not empty and first jug is not full
            actions.append( ('Fill the first jug with whats in second', (self.jug1, s[1] - (self.jug1 - s[0])) ) ) 
        return actions
    
problem = WaterJugsProblem(4,3)  #.13 seconds
# problem = WaterJugsProblem(9,4)  took some time to print but processed in .45 seonds
# problem = WaterJugsProblem(11,4) sent my ram skyrocketing  
# problem = WaterJugsProblem(11,7) couldnt yeild a result
''' its weird cause i know the last two are solvable and in only a
handful of moves but the memory it takes up on my laptop just keeps
increasing and still no print outs. had to stop it because i only have
two gigs of ram on my laptop. '''
time()
result = astar(problem)
for node in result.path():
     print node
     print time()       
