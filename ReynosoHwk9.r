fis  <-  newFIS('loanrisk')

#  FOR input  'salary'    (input index 1)

fis <<- addVar(fis, 'input', 'salary', 0:150000)

mf1 <<-  gaussMF('low', 0:150000, c(17500, 25000, 1))
fis <<- addMF(fis, 'input', 1, mf1)

mf2 <<-  gaussMF('medium', 0:150000, c(17500, 75000, 1))
fis <<- addMF(fis, 'input', 1, mf2)

mf3 <<-  gaussMF('high', 0:150000, c(17500, 125000, 1))
fis <<- addMF(fis, 'input', 1, mf3)

# FOR  input  'stability'    (input index 2)

fis <<- addVar(fis, 'input', 'stability', 0:30)

mf4 <<-  trapMF('low', 0:30, c(1,3,7,11,1))
fis <<- addMF(fis, 'input', 2, mf4)

mf5 <<-  trapMF('medium', 0:30, c(10,13,17,21,1))
fis <<- addMF(fis, 'input', 2, mf5)

mf6 <<-  trapMF('high', 0:30, c(20,23,27,30,1))
fis <<- addMF(fis, 'input', 2, mf6)

# FOR output 'liquidity'   (output index 1; the only output actually)

fis <<- addVar(fis, 'output', 'liquidity', 0:100)

mf7 <<-  triMF('low', 0:100, c(1,16,34,1))
fis <<- addMF(fis, 'output', 1, mf7)

mf8 <<-  triMF('medium', 0:100, c(33,49,67,1))
fis <<- addMF(fis, 'output', 1, mf8)

mf9 <<-  triMF('high', 0:100, c(66,83,100,1))
fis <<- addMF(fis, 'output', 1, mf9)


#if salary is medium and stability is high then liquidity is high c(2,3,3,1,1)
#if salary is low and stability is high then liquidity is medium c(1,3,2,1,1)
#if salary is low and stability is low then liquidity is low c(1,1,1,1,1)
#if salary is high and stability is low then liquidity is med c(3,1,2,1,1)
#if salary is high and stability is medium then liquidity is high c(3,2,3,1,1)

rules= rbind(c(2,3,3,1,1), c(1,3,2,1,1), c(1,1,1,1,1), c(3,1,2,1,1), c(3,2,3,1,1))
fis= addRule(fis, rules)

#evalFIS(c(73000,26), fis)
#81.57467
#evalFIS(c(30000,28), fis)
#52.19248
#evalFIS(c(22000,7), fis)
#17.00089
#evalFIS(c(136000,4), fis)
#49.68475
#evalFIS(c(147000,16), fis)
#83

