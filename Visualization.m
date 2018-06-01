clc, clear, close all

data = readtable('data/Xswitch.csv');
n_hops = 2;
counter = 0;

figure

for i=1:n_hops
    for j=1:n_hops
        counter = counter + 1;
        X = table2array(data(:, i));
        Y = table2array(data(:, j));
        %no_outliers = Y < 0.0010 & X < 0.001;
        %X = X(no_outliers);
        %Y = Y(no_outliers);
        
        sp = subplot(n_hops, n_hops, counter);

        if i == j
            histogram(X)
            title(sprintf('Histograma salto %d', i))
            xlabel('RTT (s)')
        else
            scatter(Y, X, 'filled')
            title(sprintf('Salto %d vs Salto %d', i, j))
        end
        set(sp,'FontSize',16);
    end
end

