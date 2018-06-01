clc, clear, close all
file = "data/XrealT.csv";

data = readtable(file);
distros = ["Normal", "Lognormal", "GeneralizedExtremeValue", "Burr", "Stable"];%, "tLocationScale"];
nombres = ["Normal", "Lognormal", "GEV", "Burr", "\alpha-stable"];
n_params = [2, 2, 3, 3, 4];
whichmodels = [5];
distros = distros(whichmodels);
n_params = n_params(whichmodels);
nombres = nombres(whichmodels);
n_distros = length(distros);
n_hops = 2;
counter = 0;
gaps = [0.10, 0.04];
n_cols_subplot = 2;

xlabels = '\DeltaRTT (ms)';
for i=1:n_hops
    figure;
    
    counter = 0;
    X = 1000*table2array(data(:, i));
    x_values = linspace(min(X), max(X), 10000);
    histogram(X, 5000, 'Normalization', 'pdf')
    hold on;
    
    %X = X(1:1000);
    distro_c = 0;
    for distro_s = distros
        distro_c = distro_c + 1;
        counter = counter + 1;
        distro = char(distro_s);
        %% Fit a una alpha-stable
        pd = fitdist(X, distro);
        
        %% Histograma vs PDF
        
        y = pdf(pd,x_values);
        [M, i] = max(y);
        sprintf("%f", x_values(i))
        
        
        plot(x_values,y, 'LineWidth',3)
        
        %        title(sprintf('Histogram and PDF of %s model'  , distro))
        
        ylabel('f(x)')
        xlabel(xlabels)
        
    end
    legend(["Histogram", nombres])
    set(gca,'FontSize', 24);
    set(gca,'FontName', 'Times New Roman');
end



