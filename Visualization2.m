clc, clear, close all
files = ["Xswitch", "XswitchT", "Xrouter", "XrouterT", "Xcong2hop", "Xcong2hopT"'];
files = ["Xcong2hop", "Xcong2hopT"]
titulos = ["RTT - Topología con switches sin congestión",
    "\Delta - Topología con switches sin congestión",
    "RTT - Topología con routers sin congestión",
    "\Delta - Topología con routers sin congestión",
    "RTT - Topología con switches con congestión",
    "\Delta - Topología con switches con congestión"];

xlabels = fliplr(["Hop 1 - RTT (ms)", "Hop 1 - \DeltaRTT (ms)"]);
ylabels = fliplr(["Hop 2 - RTT (ms)", "Hop 2 - \DeltaRTT (ms)"]);

counter = 0;
for file = files
    data = readtable('data/'+file+'.csv');
    n_hops = 2;
    counter = counter + 1;

    figure
    X = 1000*table2array(data(:, 1));
    Y = 1000*table2array(data(:, 2));

    mode_X = HSM(sort(X), 1000, length(X)-1, .3);
    mode_Y = HSM(sort(Y), 1000, length(Y)-1, .3);
    h = scatterhist(X, Y, 'Direction','out');
    hold on
    plot(h(1), mode_X, mode_Y,'kx', 'MarkerSize', 24, 'LineWidth',4)
    xlabel(xlabels(mod(counter, 2)+1))
    ylabel(ylabels(mod(counter, 2)+1))
    %title(titulos(counter))
    set(gca,'FontSize',24);
    set(gca,'FontName','Times New Roman');
    savefig(file+'.fig')
    %print(file+'_scatter.eps', '-depsc')

end

%%
files = ["Xreal", "XrealT"];
titulos = ["RTT - Dataset 1",
    "\DeltaRTT - Dataset 1"];
counter = 0;
xlabels = fliplr(["Hop 1 - RTT (ms)", "Hop 1 - \DeltaRTT (ms)"]);
ylabels = fliplr(["Hop 2 - RTT (ms)", "Hop 2 - \DeltaRTT (ms)"]);
for file = files
    data = readtable('data/'+file+'.csv');
    n_hops = 2;
    counter = counter+1;

    figure
    X = table2array(data(:, 1));
    Y = table2array(data(:, 2));
    no_outliers = Y < 0.0010 & X < 0.001;
    X = 1000*X(no_outliers);
    Y = 1000*Y(no_outliers);
    mode_X = HSM(sort(X), 1000, length(X)-1, .3);
    mode_Y = HSM(sort(Y), 1000, length(Y)-1, .3);
    h = scatterhist(X, Y, 'Direction','out');
    hold on
    plot(h(1), mode_X, mode_Y,'x', 'MarkerSize', 24, 'LineWidth',4)

    xlabel(xlabels(mod(counter, 2)+1))
    ylabel(ylabels(mod(counter, 2)+1))
    %title(titulos(counter))
    set(gca,'FontSize',24);
    set(gca,'FontName','Times New Roman');

    savefig(file+'.fig')
    %print(file+'_scatter.eps', '-depsc')

end