import torch
from torch.autograd import Variable
from torch import nn
from torch.nn import init
import torch.utils.data as Data
import torch.nn.functional as F
import matplotlib.pyplot as plt
import numpy

N_SAMPLES = 2000
BATCH_SIZE = 64
EPOCH = 12
LR = 0.03
N_HIDDEN = 8
ACTIVATION = F.tanh

class Net(nn.Module):
    def __init__(self, batch_normalization = False):
        super(Net, self).__init__()
        self.do_bn = batch_normalization
        self.fcs = []
        self.bns = []

        for i in range(N_HIDDEN):
            input_size = 2 if i == 0 else 10
            fc = nn.Linear(input_size, 10)
            setattr(self, 'fc%i'%i, fc)
            self._set_init(fc)
            self.fcs.append(fc)
            if self.do_bn:
                bn = nn.BatchNorm1d(10, momentum=0.5)
                setattr(self, 'bn%i'%i, bn)
                self.bns.append(bn)

        self.predict = nn.Linear(10, 2)
        self._set_init(self.predict)

    def _set_init(self, layer):
        init.normal(layer.weight, mean=0, std = 1)

    def forward(self, x):
        for i in range(N_HIDDEN):
            x = self.fc[i](x)
            if self.do_bn: x = self.bns[i](x)
            x = ACTIVATION(x)
        out = self.predict(x)
        return out

net = Net(batch_normalization=True)
opt = torch.optim.Adam(net.parameters(), lr = LR)
loss_func = torch.nn.MSELoss()
losses = []
for epoch in range(EPOCH):
    print('EPOCH: ', epoch)
    for step, (b_x, b_y) in enumerate(train_loader):
        b_x, b_y = Variable(b_x), Variable(b_y)
        pred = net(b_x)
        loss = loss_func(pred, b_y)
        opt.zero_grad()
        loss.backward()
        opt.step()