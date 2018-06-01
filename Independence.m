clc, clear, close all

data = readtable('data/XrealT.csv');
n_hops = 2;


params.sigx = 1;
params.sigy = 1;
params.shuff = 10;
counter = 0;
X = table2array(data(:, 1));
Y = table2array(data(:, 2));
[thresh,testStat] = hsicTestBoot(X,Y,0.05, params);
[thresh2,testStat2] = hsicTestGamma(X,Y,0.05, params);