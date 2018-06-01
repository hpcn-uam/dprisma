clc, clear, close all
files = [%"data/XswitchT.csv",
    "data/Xcong2hopT.csv",
    %"data/XrealT.csv"
    ];
for file=transpose(files)
    data = readtable(char(file));
    distros = ["Normal", "Lognormal", "GeneralizedExtremeValue", "Burr", "Stable"];%, "tLocationScale"];
    n_params = [2, 2, 3, 3, 4];
    n_distros = length(distros);
    n_hops = 2;
    counter = 0;
    gaps = [0.10, 0.04];
    n_cols_subplot = 2;
    
    xlabels = '\Delta (s)';
    for i=1:n_hops
        figure;
        
        counter = 0;
        X = table2array(data(:, i));
        distro_c = 0;
        for distro_s = distros
            distro_c = distro_c + 1;
            counter = counter + 1;
            distro = char(distro_s);
            %% Fit a una alpha-stable
            pd = fitdist(X, distro);
            
            %% Histograma vs PDF
            x_values = linspace(min(X), max(X), 1000);
            y = pdf(pd,x_values);
            sp = subtightplot(n_distros, n_cols_subplot, counter, gaps);
            
            
            plot(x_values,y, 'LineWidth',3)
            hold on;
            histogram(X, 20, 'Normalization', 'pdf')
            title(sprintf('Histogram and PDF of %s model', distro))
            set(sp,'FontSize',11);
            legend('PDF', 'Histogram')
            ylabel('f(x)')
            xlabel(xlabels)
            %set(gca, 'XScale', 'log')
            
            %% ECDF vs CDF
            %         counter = counter + 1;
            %         sp = subtightplot(n_distros, n_cols_subplot, counter, gaps);
            %         x = x_values;
            %         cdf_x = cdf(pd,x);
            %         plot(x,cdf_x,'m')
            %         hold on;
            %         cdfplot(X)
            %         title(sprintf('ECDF y CDF de %s (Salto %d)', distro, i))
            %         set(gca, 'XScale', 'log')
            %         set(sp,'FontSize',11);
            %         legend('CDF', 'ECDF')
            %         xlabel(xlabels)
            %% QQ plot
            counter = counter + 1;
            sp = subtightplot(n_distros, n_cols_subplot, counter, gaps);
            QQ = X(randperm(length(X), 100));
            QQ = X;
            qq_x = linspace(0.0001, 0.9999, length(QQ));
            qq_y = icdf(pd, qq_x);
            qq_z = sort(QQ);
            mdl = fitlm((qq_z),(qq_y));
            qqplot(QQ, pd)
            set(gca, 'XScale', 'log')
            set(gca, 'YScale', 'log')
            ylabel('Quantiles of sample')
            xlabel('Quantiles of distribution')
            k = n_params(distro_c);
            logL = sum(log(pdf(pd, X)));
            AIC = 2*k - 2*logL;
            BIC = log(length(X))*k-2*logL;
            set(sp,'FontSize', 11);
            %title(sprintf('QQplot R2=%f R2adj=%f\n AIC=%f BIC=%f', mdl.Rsquared.Ordinary, mdl.Rsquared.Adjusted, AIC, BIC), 'FontSize', 12)
            title(sprintf('QQplot'), 'FontSize', 11);
            sprintf('file= %s Hop %d model=%s R2=%f R2adj=%f\n AIC=%f BIC=%f', file, i, distro, mdl.Rsquared.Ordinary, mdl.Rsquared.Adjusted, AIC, BIC)
            %set(gca,'YTickLabelRotation',65)
        end
    end
    
end

