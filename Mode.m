clc, clear, close all
ep = 20;
data = readtable('data/Xcong2hopT.csv');
n_hops = 2;
counter = 0;
n_samples = 500;
for i=1:n_hops
    counter = 0;
    X = sort(1000*table2array(data(:, i)));
    k = 0.9;
    mode = HSM(X, 1000, ceil(length(X)*k), k);
    pd = fitdist(X, 'Kernel');
    
    fig=figure; 
    hax=axes; 
    hold on;
    x_values = linspace(min(X)-ep, max(X)+ep, 10000);
    y = pdf(pd,x_values);
    [muda, mode_kde] = max(y);
    mode_kde = x_values(mode_kde);
    plot(x_values,y, 'LineWidth',3)
    line([mode mode],get(hax,'YLim'),'Color',[1 0 0])
    line([mode_kde mode_kde],get(hax,'YLim'),'Color',[0 1 0])
    legend(["Densidad (KDE)", "Moda (HSM)", "Moda (KDE)"])
    i
    mode, mode_kde
    mode_normal = mean(X)
    pd = fitdist(X, 'Burr');
    mode_burr = pd.alpha*((pd.c - 1)/(pd.k*pd.c+1))^(1/pd.c)
    
end



