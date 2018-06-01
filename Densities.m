clc, clear all, close all

alphas = [0.5:0.5:2];
x = [-5:0.01:5];
figure;
i = 1;
for alpha = alphas
    pd = makedist('Stable', 'alpha', alpha, 'beta', 0, 'delta', 0, 'gam', 1);
    y = pdf(pd, x);
    plot(x, y, 'LineWidth', 1.5)
    hold on;
    i = i + 1;
end
legend(["\alpha=0.5", "\alpha=1.0", "\alpha=1.5", "\alpha=2.0"]);
title("PDF de la distribución \alpha-estable para distintos valores de \alpha (\beta=\delta=0, \gamma=1)");
ylabel("PDF");
xlabel("x");
pd = makedist('Stable', 'alpha', 1.5, 'beta', 1, 'delta', 1, 'gam', 1);

%%
clc, clear all, close all

alphas = [0:0.5:1];
x = [-5:0.01:5];
figure;
i = 1;
for alpha = alphas
    pd = makedist('Stable', 'alpha', 1, 'beta', alpha, 'delta', 0, 'gam', 1);
    y = pdf(pd, x);
    plot(x, y, 'LineWidth', 1.5)
    hold on;
    i = i + 1;
end
legend([ "\beta=0.0", "\beta=0.5", "\beta=1.0"]);
title("PDF de la distribución \alpha-estable para distintos valores de \beta (\alpha=\gamma=1, \delta=0)");
ylabel("PDF");
xlabel("x");
pd = makedist('Stable', 'alpha', 1.5, 'beta', 1, 'delta', 1, 'gam', 1);



%%
clc, clear all, close all

eps = [-0.5:0.5:0.5];
x = [-5:0.01:5];
figure;
i = 1;
for epsilon = eps
    pd = makedist('GeneralizedExtremeValue', 'k', epsilon, 'mu', 0, 'sigma', 1);
    y = pdf(pd, x);
    plot(x, y, 'LineWidth', 1.5)
    hold on;
    i = i + 1;
end
legend([ "\xi=-0.5", "\xi=0.0", "\xi=0.5", "\xi=1.0"]);
title("PDF de la distribución GEV para distintos valores de \xi (\mu=0, \sigma=1)");
ylabel("PDF");
xlabel("x");
set(gca,'FontSize',16);

%%
clc, clear all, close all

sigmas = [0.5 1 2];
x = [-0.5:0.01:5];

f = figure;

i = 1;
for sigma = sigmas
    pd = makedist('Lognormal', 'mu', 0, 'sigma', sigma);
    y = pdf(pd, x);
    plot(x, y, 'LineWidth', 2);
    hold on;
    i = i + 1;
end
legend([ "\sigma=0.5", "\sigma=1.0", "\sigma=2"]);
title("PDF de la distribución lognormal para distintos valores de \sigma");
ylabel("PDF");
set(gca,'FontSize',16);

%%

clc, clear all, close all

eps = [0.7, 1, 2];
x = [-0.5:0.01:5];
figure;
i = 1;
for epsilon = eps
    pd = makedist('Burr', 'c', epsilon, 'k', 1, 'alpha', 1);
    y = pdf(pd, x);
    plot(x, y, 'LineWidth', 1.5)
    hold on;
    i = i + 1;
end
legend([ "c=0.7", "c=1.0", "c=2.0"]);
title("PDF de la distribución de Burr para distintos valores de c (k=1, \alpha=1)");
ylabel("PDF");
xlabel("x");
set(gca,'FontSize',16);

%%

clc, clear all, close all

eps = [0.7, 1, 2];
x = [-0.5:0.01:5];
figure;
i = 1;
for epsilon = eps
    pd = makedist('Burr', 'c', 2, 'k', epsilon, 'alpha', 1);
    y = pdf(pd, x);
    plot(x, y, 'LineWidth', 1.5)
    hold on;
    i = i + 1;
end
legend([ "k=0.7", "k=1.0", "k=2.0"]);
title("PDF de la distribución de Burr para distintos valores de k (c=2, \alpha=1)");
ylabel("PDF");
xlabel("x");
set(gca,'FontSize',16);