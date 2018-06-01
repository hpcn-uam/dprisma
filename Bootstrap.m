clc, clear, close all

data = readtable('data/XrealT.csv');
distros = ["GeneralizedExtremeValue", "Stable"];
n_distros = length(distros);
n_hops = 2;
counter = 0;
n_samples = 100;
len_sample = 100;
for i=1:n_hops
    
    counter = 0;
    X = 1000*table2array(data(:, i));
    for distro_s = distros
        counter = 1;
        
        for n = 1:n_samples
            Y = X(randperm(length(X), len_sample));
            distro = char(distro_s);
            pd = fitdist(Y, distro);
            fitted{i, counter, n} = pd;
            if distro_s == "Stable"
                stable_alpha{i, counter, n} = pd.alpha;
                stable_beta{i, counter, n} = pd.beta;
                stable_gamma{i, counter, n} = pd.gam;
                stable_delta{i, counter, n} = pd.delta;
                [h,p,ksstat,cv] = kstest(Y, 'CDF', pd);
                stable_ks{i, counter, n} = ksstat;
            else
                gev_k{i, counter, n} = pd.k;
                gev_sigma{i, counter, n} = pd.sigma;
                gev_mu{i, counter, n} = pd.mu;
                [h,p,ksstat,cv] = kstest(Y, 'CDF', pd);
                gev_ks{i, counter, n} = ksstat;
            end
        end
    end
end

gev_k = cell2mat(gev_k);
gev_sigma = cell2mat(gev_sigma);
gev_mu = cell2mat(gev_mu);
gev_ks = cell2mat(gev_ks);


for i=1:n_hops
    i;
    'k'
    min(gev_k(i,1,:))
    mean(gev_k(i,1,:))
    max(gev_k(i,1,:))
    'sigma'
    min(gev_sigma(i,1,:))
    mean(gev_sigma(i,1,:))
    max(gev_sigma(i,1,:))
    'mu'
    min(gev_mu(i,1,:))
    mean(gev_mu(i,1,:))
    max(gev_mu(i,1,:))
end

%%

counter = 1;
figure;
M = 3;
for i=1:n_hops
    mu = (squeeze(gev_mu(i, 1, :)));
    sigma = (squeeze(gev_sigma(i, 1, :)));
    k = (squeeze(gev_k(i, 1, :)));
    ks = (squeeze(gev_ks(i, 1, :)));
    subplot(n_hops, M, counter)
    counter = counter + 1;
    
    histogram(k, 7, 'Normalization', 'pdf')
    hold on
    pd = fitdist(k,'Normal');
    x_values = linspace(min(k), max(k), 100);
    y = pdf(pd,x_values);
    plot(x_values,y, 'LineWidth', 2)
    
    title(['Distribución de k ' sprintf('(Salto %d)', i)])
    legend(["Empírico", "N" + sprintf('(%.2f, %.2f)', pd.mu, pd.sigma)],'Location','NorthEast')
    subplot(n_hops, M, counter)
    counter = counter + 1;
    
    
    histogram(sigma, 7, 'Normalization', 'pdf')
    hold on
    pd = fitdist(sigma,'Normal');
    x_values = linspace(min(sigma), max(sigma), 100);
    y = pdf(pd,x_values);
    
    plot(x_values,y, 'LineWidth', 2)
    title(['Distribución de \sigma ' sprintf('(Salto %d)', i)])
    legend(["Empírico", "N" + sprintf('(%.2f, %.2f)', pd.mu, pd.sigma)],'Location','NorthEast')
    
    subplot(n_hops, M, counter)
    counter = counter + 1;
    
    histogram(mu, 7, 'Normalization', 'pdf')
    hold on
    pd = fitdist(mu,'Normal');
    x_values = linspace(min(mu), max(mu), 100);
    y = pdf(pd,x_values);
    
    plot(x_values,y, 'LineWidth', 2)
    legend(["Empírico", "N" + sprintf('(%.2f, %.2f)', pd.mu, pd.sigma)],'Location','NorthEast')
    
    title(['Distribución de \mu ' sprintf('(Salto %d)', i)])
    
    subplot(n_hops, M, counter)
    %counter = counter + 1;
    
    %histogram(ks, 7, 'Normalization', 'pdf')
    hold on
    pd = fitdist(ks,'Normal');
    x_values = linspace(min(ks), max(ks), 100);
    y = pdf(pd,x_values);
    %plot(x_values,y, 'LineWidth', 2)
    
    title(['Distribución del est. de KS ' sprintf('(Salto %d)', i)])
    legend(["Empírico", "N" + sprintf('(%.2f, %.2f)', pd.mu, pd.sigma)],'Location','NorthEast')
end
suptitle('Parámetros de la distribución GEV')

%%

stable_alpha = cell2mat(stable_alpha);
stable_beta = cell2mat(stable_beta);
stable_gamma = cell2mat(stable_gamma);
stable_delta = cell2mat(stable_delta);
stable_ks = cell2mat(stable_ks);

%%
counter = 1;
figure;
M = 4;
for i=1:n_hops
    alpha = (squeeze(stable_alpha(i, 1, :)));
    beta = (squeeze(stable_beta(i, 1, :)));
    gamma = (squeeze(stable_gamma(i, 1, :)));
    delta = (squeeze(stable_delta(i, 1, :)));
    ks = (squeeze(stable_ks(i, 1, :)));
    
    subplot(n_hops, M, counter)
    counter = counter + 1;
    
    histogram(alpha, 7, 'Normalization', 'pdf')
    hold on
    pd = fitdist(alpha,'Normal');
    x_values = linspace(min(alpha), max(alpha), 100);
    y = pdf(pd,x_values);
    plot(x_values,y, 'LineWidth', 2)
    
    title(['Distribución de \alpha ' sprintf('(Salto %d)', i)])
    legend(["Empírico", "N" + sprintf('(%.2f, %.2f)', pd.mu, pd.sigma)],'Location','NorthEast')
    subplot(n_hops, M, counter)
    counter = counter + 1;
    
    
    histogram(beta, 7, 'Normalization', 'pdf')
    hold on
    pd = fitdist(beta,'Normal');
    x_values = linspace(min(beta), max(beta), 100);
    y = pdf(pd,x_values);
    
    plot(x_values,y, 'LineWidth', 2)
    title(['Distribución de \beta ' sprintf('(Salto %d)', i)])
    legend(["Empírico", "N" + sprintf('(%.2f, %.2f)', pd.mu, pd.sigma)],'Location','NorthEast')
    
    subplot(n_hops, M, counter)
    counter = counter + 1;
    
    histogram(delta, 7, 'Normalization', 'pdf')
    hold on
    pd = fitdist(delta,'Normal');
    x_values = linspace(min(delta), max(delta), 100);
    y = pdf(pd,x_values);
    
    plot(x_values,y, 'LineWidth', 2)
    legend(["Empírico", "N" + sprintf('(%.2f, %.2f)', pd.mu, pd.sigma)],'Location','NorthEast')
    
    title(['Distribución de \delta ' sprintf('(Salto %d)', i)])
    
    subplot(n_hops, M, counter)
    counter = counter + 1;
    
    histogram(gamma, 7, 'Normalization', 'pdf')
    hold on
    pd = fitdist(gamma,'Normal');
    x_values = linspace(min(gamma), max(gamma), 100);
    y = pdf(pd,x_values);
    
    plot(x_values,y, 'LineWidth', 2)
    legend(["Empírico", "N" + sprintf('(%.2f, %.2f)', pd.mu, pd.sigma)],'Location','NorthEast')
    
    title(['Distribución de \gamma ' sprintf('(Salto %d)', i)])
    
    subplot(n_hops, M, counter)
    %counter = counter + 1;
    %histogram(ks, 7, 'Normalization', 'pdf')
    hold on
    pd = fitdist(ks,'Normal');
    x_values = linspace(min(ks), max(ks), 100);
    y = pdf(pd,x_values);
    %plot(x_values,y, 'LineWidth', 2)
    
    title(['Distribución del est. de KS ' sprintf('(Salto %d)', i)])
    legend(["Empírico", "N" + sprintf('(%.2f, %.2f)', pd.mu, pd.sigma)],'Location','NorthEast')
end
suptitle('Parámetros de la distribución \alpha-stable')


%%
clear R, pd, i;
n_samples = 1000;
pd = makedist('GeneralizedExtremeValue', 'k', 0.7, 'mu', 24, 'sigma', 1);
R_gev = zeros(n_samples,1);
Rext_gev = zeros(n_samples, 1);

parfor n = 1:n_samples
    r = random(pd,len_sample,1);
    [h,p,ksstat,cv] = kstest(r, 'CDF', pd);
    R_gev(n) = ksstat;

    pde = fitdist(r, 'GeneralizedExtremeValue');
    
    [h,p,ksstat,cv] = kstest(r, 'CDF', pde);
    Rext_gev(n) = ksstat;
end

%%
mu_Rext_gev = mean(Rext_gev);
s_Rext_gev = std(Rext_gev);
s_R_gev = std(R_gev);
mu_R_gev = mean(R_gev);
figure;
histogram(R_gev, 8, 'Normalization', 'pdf')
hold on
histogram(Rext_gev, 8, 'Normalization', 'pdf')
histogram((Rext_gev-mu_Rext_gev)/s_Rext_gev*s_R_gev+mu_R_gev, 8, 'Normalization', 'pdf')

pd = fitdist(squeeze(R_gev),'Normal');
x_values = linspace(min(R_gev), max(R_gev), 100);
y = pdf(pd,x_values);
%plot(x_values,y, 'LineWidth', 2)

pd2 = fitdist(squeeze(Rext_gev),'Normal');
x_values = linspace(min(Rext_gev), max(Rext_gev), 100);
y = pdf(pd2,x_values);
%plot(x_values,y, 'LineWidth', 2)

legend(["Contra teorica", "Contra estimada", "Contra estimada (corregida)", "N" + sprintf('(%.2f, %.2f)', pd.mu, pd.sigma), "N" + sprintf('(%.2f, %.2f)', pd2.mu, pd2.sigma)],'Location','NorthEast')
title(['Distribución del est. de KS para GEV'])

%%
n_samples = 1000;
pd = makedist('Stable', 'alpha', 1.5, 'beta', .5, 'delta', 24, 'gam', 0.5);
R = zeros(n_samples,1);
Rext = zeros(n_samples, 1);
parfor n = 1:n_samples
    rng(n);
    r = random(pd,len_sample,1);
    [h,p,ksstat,cv] = kstest(r, 'CDF', pd);
    R(n) = ksstat;
    
    pde = fitdist(r, 'Stable');
    
    [h,p,ksstat,cv] = kstest(r, 'CDF', pde);
    Rext(n) = ksstat;
end

%%
mu_R = mean(R);
s_R = std(R);
mu_Rext = mean(Rext);
s_Rext = std(Rext);
figure;
histogram(R, 25, 'Normalization', 'pdf')
hold on
histogram(Rext, 25, 'Normalization', 'pdf')
histogram((Rext-mu_Rext)/s_Rext*s_R+mu_R, 25, 'Normalization', 'pdf')

pd = fitdist(squeeze(R),'Normal');
x_values = linspace(min(R), max(R), 100);
y = pdf(pd,x_values);
%plot(x_values,y, 'LineWidth', 2)

pd2 = fitdist(squeeze(Rext),'Normal');
x_values = linspace(min(Rext), max(Rext), 100);
y = pdf(pd2,x_values);
%plot(x_values,y, 'LineWidth', 2)

legend(["Contra teorica", "Contra estimada", "Contra estimada (corregida)", "N" + sprintf('(%.2f, %.2f)', pd.mu, pd.sigma), "N" + sprintf('(%.2f, %.2f)', pd2.mu, pd2.sigma)],'Location','NorthEast')
title(['Distribución del est. de KS para \alpha-estable'])

