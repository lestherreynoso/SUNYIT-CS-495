# -*- coding: utf-8 -*-
from pybrain.datasets import SupervisedDataSet
from pybrain.supervised.trainers import BackpropTrainer
from pybrain.tools.shortcuts import buildNetwork
from pybrain.structure.modules import TanhLayer

species = {
'unknown': 0.0,
'setosa': 1.0,
'versicolor': 2.0,
'virginica': 3.0
}

dataset = SupervisedDataSet(4, 1)

for line in open('C:\\cs495\\iris.csv', 'r').readlines():
    row = line.strip().split(',')
    attributes = row[:4]
    inputs = [float(x) for x in attributes if x != '']
    targets = row[4]
    output = species.get(targets[0], 0.0)
    dataset.addSample(inputs, [ output ])

nn = buildNetwork(4, 5,1, bias=True, hiddenclass=TanhLayer)
trainer = BackpropTrainer(nn, dataset)
for i in range(100):
    trainer.train()
    
print "After some training: "
out = nn.activate([5.6,2.6,5.0,2.5])
print 'Expect virginica = class 3:'
print out