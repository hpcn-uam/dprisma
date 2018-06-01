clc, clear, close all
file = "data/Xcong2hopT.csv";

data = readtable(file);
distros = ["Normal", "Lognormal", "GeneralizedExtremeValue", "Burr", "Stable"];%, "tLocationScale"];
nombres = ["Normal", "Lognormal", "GEV", "Burr", "\alpha-stable"];
n_params = [2, 2, 3, 3, 4];
whichmodels = [3, 4, 5];
distros = distros(whichmodels);
n_params = n_params(whichmodels);
nombres = nombres(whichmodels);
n_distros = length(distros);
n_hops = 2;
counter = 0;
gaps = [0.10, 0.04];
n_cols_subplot = 2;

data_plot = [];
quantiles = [0.05, 0.5, 0.95];

xlabels = '\Delta (s)';
for i=1:n_hops
    figure;
    
    counter = 0;
    X = table2array(data(:, i));
    X = 1000*X;
    hold on;
    data_plot = X(1:100);
    %X = X(1:1000);
    distro_c = 0;
    for distro_s = distros
        distro_c = distro_c + 1;
        counter = counter + 1;
        distro = char(distro_s);
        %% Fit a una alpha-stable
        pd = fitdist(X, distro);
        
        %% Histograma vs PDF
        
        %loglog(quantile(X,0.01:0.01:0.99),icdf(pd, 0.01:0.01:0.99),'*');
        R = random(pd, size(X));
        
        data_plot = [data_plot R(1:100)];
        hold all
        
        %        title(sprintf('Histogram and PDF of %s model', distro))
        
        %ylabel('f(x)')
        %xlabel(xlabels)
        
    end
    rang = [0.5, length(distros)+1.5];
    for q=quantiles
        qq = quantile(X(1:100), q);
        fplot(@(x) qq, rang);
    end
  
    violinplot(data_plot, cellstr(["Sample", nombres]));
    set(gca,'FontSize', 24);
    set(gca, 'FontName', 'Times New Roman')
    ylabel('\DeltaRTT (ms)')
    box on
end



