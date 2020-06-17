function [W, S, p, P, f, loads] = join_prob(wind, wind_distr, c_p_net, ...
                                      snow_distr, mean_s, sigma_s, ...
                                      wind_start, wind_end, snow_start, ...
                                      snow_end, points, f)
%JOINED PROBABILITIES
%   This function uses the wind data(wind), the wind
%   distribution(wind_distr), the pressure parameter(c_p_net), the snow
%   distribution(snow_distr), the mean of the snow(mean_s), its standard
%   deviation(sigma_s), the start and end of the wind speed
%   space(wind_start, wind_end) and of the snow load(snow_start, snow_end),
%   the number of points to divide these spaces(points) and the index of 
%   the figures(f) in order to produce a grid of combinations for the
%   values of wind speed(W) and snow load(S) and the matrices of the joined
%   PDFs(p) and joined CDFs(P). The results are plotted. The new index of
%   the figures is also exported(f), as are the loads that are estimated
%   manually using the graph of the joined CDF.

pd_w = fitdist(wind, wind_distr);

params = zeros(2);
cov = sigma_s ./ mean_s;
params(2) = log(cov .^ 2 + 1);  params(2) = sqrt(params(2));
params(1) = log(mean_s) - 1 ./ 2 .* params(2) .^ 2;
pd_s = makedist(snow_distr, 'mu', params(1), 'sigma', params(2));

w = linspace(wind_start, wind_end, points);
s = linspace(snow_start, snow_end, points);

d = floor( (wind_end - wind_start) ./ 5);

p_w = pdf(pd_w, w);
p_s = pdf(pd_s, s);

%figure(f)
%set(gcf,'NumberTitle','off') %don't show the figure number
%set(gcf,'Name','PDFs')
%subplot(1, 2, 1)
%plot(w, p_w .* 100)
%title('PDF: Wind load')
%set(gca, 'XTick', 0:6:30)
%set(gca, 'XTickLabel', wind_load(wind_start:d:wind_end, c_p_net))
%xlabel('Wind load (kPa)');    ylabel('Probability (%)');

%subplot(1, 2, 2)
%plot(s, p_s .* 100)
%title('PDF: Snow load')
%xlabel('Snow load (kPa)');    ylabel('Probability (%)');
%f = f + 1;

P_w = cdf(pd_w, w);
P_s = cdf(pd_s, s);

%figure(f)
%set(gcf,'NumberTitle','off') %don't show the figure number
%set(gcf,'Name','CDFs')
%subplot(1, 2, 1)
%plot(w, P_w .* 100)
%title('CDF: Wind load')
%set(gca, 'XTick', 0:6:30)
%set(gca, 'XTickLabel', wind_load(wind_start:d:wind_end, c_p_net))
%xlabel('Wind load (kPa)');    ylabel('Probability (%)');

%subplot(1, 2, 2)
%plot(s, P_s .* 100)
%title('CDF: Snow load')
%xlabel('Snow load (kPa)');    ylabel('Probability (%)');
%f = f + 1;

[W,S] = meshgrid(w, s);
p = pdf(pd_w, W) .* pdf(pd_s, S);
val = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 0.95, 0.97, ...
       0.98, 0.99];
% val = [0.97, 0.98, 0.99];

P = cdf(pd_w, W) .* cdf(pd_s, S);

%figure(f)
%set(gcf,'NumberTitle','off') %don't show the figure number
%set(gcf,'Name','Joined PDF surface')
%surf(W, S, p .* 100);
%xlabel('Wind speed (km/h)');
%ylabel('Snow load (kPa)');      zlabel('Probability (%)');
%f = f + 1;

%figure(f)
%set(gcf,'NumberTitle','off') %don't show the figure number
%set(gcf,'Name','Joined PDF contour')
%contour(W, S, p, '-.', 'ShowText', 'on');
%xlabel('Wind speed (km/h)');    ylabel('Snow load (kPa)');
%f = f + 1;

%figure(f)
%set(gcf,'NumberTitle','off') %don't show the figure number
%set(gcf,'Name','Joined CDF surface')
%surf(W, S, P .* 100);
%xlabel('Wind speed (km/h)');
%ylabel('Snow load (kPa)');      zlabel('Probability (%)');
%f = f + 1;

figure(f)
hold on
set(gcf,'NumberTitle','off') %don't show the figure number
set(gcf,'Name','Joined CDF contour')
contour(W, S, P, val, '-.', 'ShowText', 'on');
xlabel('Wind speed (km/h)');    ylabel('Snow load (kPa)');


loads = graphical_var();
for i = 1:length(loads)
    plot(loads(i,1) .* ones(points), s, ':')
    plot(w, loads(i,2) .* ones(points), ':')
end
plot(loads(:,1), loads(:,2), 'ro')
hold off
f = f + 1;

loads = graphical_loads(c_p_net);

end

