#  comments to end of line, of course

#  load the two already installed libraries needed here
#  no double quotes

library(Rgraphviz)

library(gRain)



# remember that c() makes a vector

yn   <-   c("yes","no")



# create the conditional probability tables (CPT)
# for the example

b      <-   cptable(~BrokeElectionLaw, values=c(9,1),levels=yn)
m      <-   cptable(~PoliticallyMotivatedProsecutor, values=c(1,9),levels=yn)
i.mb   <-   cptable(~Indicated|PoliticallyMotivatedProsecutor:BrokeElectionLaw, values=c(9,0,5,0,5,0,1,0),levels=yn)
g.mib  <-   cptable(~Guilty|BrokeElectionLaw:Indicated:PoliticallyMotivatedProsecutor, values=c(90,10,80,20,0,100,0,100,20,80,10,90,0,100,0,100),levels=yn)
j.g    <-   cptable(~Jailed|Guilty, values=c(9,0,1,0),levels=yn)
# compile these CPT tables into a list

plist <- compileCPT(list(b, m, i.mb, g.mib, j.g))

#make a Bayesian network out of the compiled list

in1 <- grain(plist)

# display the Bayesian network object (display a summary of it)

in1

#  plot the directed graph of the Bayesian network, using Graphviz/RGraphviz

plot(in1)



