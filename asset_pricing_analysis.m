%IMPORTANT: being the code very long, to avoid the overloading of the
%computer running it, once the plots start to be done, it's divided in more
%subsequence of code to run singularly and in order. These is the index of
%the parts to run, to make sure none is missed:

%row 1: exercises 1:15
%row 935: exercises 16-17-18-19
%row 1241: exercise 20-21
%row 1526: exercise 22
%row 1694: exercise 23-24
%row 1831: exercise 25

%IMPORTANT: READ ABOVE
%IMPORTANT: READ ABOVE
%IMPORTANT: READ ABOVE

%% Exercise 1a) nasdaq daily
%clean the environment
clc, clearvars, close all
set(groot,'defaultTextInterpreter', 'none');
set(groot,'defaultLegendInterpreter', 'none');
set(groot,'defaultAxesTickLabelInterpreter', 'none');
%import the tables
table_nas_daily = readtable('dataexam_jan26.xlsx','Sheet','nasdaq daily');
Nasdaq_daily = readmatrix('dataexam_jan26.xlsx','Sheet','nasdaq daily');

date_nas_daily = table_nas_daily{:,1};   % dates
Nasdaq_daily(:,1) = [];                  % remove dates from numeric matrix
table_nas_daily(:,1) = [];               % remove dates from table

% save the header of the stocks
header_nas = table_nas_daily.Properties.VariableNames;

%save the header of the stocks so i can use them later
header_nas = table_nas_daily.Properties.VariableNames;
%compute the returns
returns_nas_daily = diff(log(Nasdaq_daily));    % log return
%compute the matrix that will contain the data of each stock
n_columns = size(returns_nas_daily, 2);  table_parameters_nas_daily = zeros(6, n_columns); 
for col = 1:n_columns
    data = returns_nas_daily(:, col);
    table_parameters_nas_daily(2, col) = mean(data,'omitmissing');       % Media
    table_parameters_nas_daily(3, col) = var(data,'omitnan');        % Varianza
    table_parameters_nas_daily(4, col) = std(data,'omitnan');        % Deviazione standard
    table_parameters_nas_daily(5, col) = skewness(data);   % Skewness
    table_parameters_nas_daily(6, col) = kurtosis(data);   % Kurtosis
end

table_parameters_nas_daily = transpose(table_parameters_nas_daily);  table_parameters_nas_daily = array2table(table_parameters_nas_daily);
table_parameters_nas_daily = renamevars(table_parameters_nas_daily,["table_parameters_nas_daily1","table_parameters_nas_daily2","table_parameters_nas_daily3","table_parameters_nas_daily4","table_parameters_nas_daily5","table_parameters_nas_daily6"],["STOCK","MEAN","VARIANCE","STANDARD DEVIATION","SKEWNESS","KURTOSIS"]);
table_parameters_nas_daily.STOCK = header_nas';

%% Exercise 1b) nasdaq monthly
% import the tables
table_nas_monthly = readtable('dataexam_jan26.xlsx', 'Sheet', 'nasdaq monthly');
Nasdaq_monthly    = readmatrix('dataexam_jan26.xlsx', 'Sheet', 'nasdaq monthly');

% --- minimal cleaning for 2026 file 
% remove rows in the numeric matrix that are completely NaN 
Nasdaq_monthly(all(isnan(Nasdaq_monthly),2),:) = [];

% if the first numeric column is empty (all NaN), remove it
if all(isnan(Nasdaq_monthly(:,1)))
    Nasdaq_monthly(:,1) = [];
end

% remove the first column as it only includes the date
date_nas_monthly = table_nas_monthly{:,1};      % dates (from table)
Nasdaq_monthly(:,1) = [];                      % remove dates from numeric matrix
table_nas_monthly(:,1) = [];                   % remove dates from table

% save the header of the stocks
header_nas_monthly = table_nas_monthly.Properties.VariableNames;

% compute the returns
returns_nas_monthly = diff(log(Nasdaq_monthly));   % log return

% compute the matrix that will contain the data of each stock
n_columns = size(returns_nas_monthly, 2);
table_parameters_nas_monthly = zeros(6, n_columns);

for col = 1:n_columns
    data = returns_nas_monthly(:, col);
    table_parameters_nas_monthly(2, col) = mean(data, 'omitmissing');      % Mean
    table_parameters_nas_monthly(3, col) = var(data, 'omitnan');           % Variance
    table_parameters_nas_monthly(4, col) = std(data, 'omitnan');           % Std dev
    table_parameters_nas_monthly(5, col) = skewness(data);   % Skewness
    table_parameters_nas_monthly(6, col) = kurtosis(data);   % Kurtosis

end
% last aesthetic changes to the parameters table
table_parameters_nas_monthly = transpose(table_parameters_nas_monthly);
table_parameters_nas_monthly = array2table(table_parameters_nas_monthly);


table_parameters_nas_monthly(:,1) = [];

% set column names 
table_parameters_nas_monthly.Properties.VariableNames = ...
    {'MEAN','VARIANCE','STANDARDDEVIATION','SKEWNESS','KURTOSIS'};

% add stock names
table_parameters_nas_monthly.STOCK = header_nas_monthly';
table_parameters_nas_monthly = movevars(table_parameters_nas_monthly, "STOCK", "Before", 1);

%% Exercise 2.a) nyse daily 
% import the tables
table_nyse_daily = readtable('dataexam_jan26.xlsx', 'Sheet', 'nyse daily');
Nyse_daily       = readmatrix('dataexam_jan26.xlsx', 'Sheet', 'nyse daily');

% minimal cleaning 
% remove rows in the numeric matrix that are completely NaN
Nyse_daily(all(isnan(Nyse_daily),2),:) = [];


if ~isempty(Nyse_daily) && all(isnan(Nyse_daily(:,1)))
    Nyse_daily(:,1) = [];
end

% remove the first column as it only includes the date
date_nyse_daily = table_nyse_daily{:,1};     % dates (from table)
Nyse_daily(:,1) = [];                        % remove dates from numeric matrix
table_nyse_daily(:,1) = [];                  % remove dates from table

% save stock names
header_nyse_daily = table_nyse_daily.Properties.VariableNames;

% compute log-returns
returns_nyse_daily = diff(log(Nyse_daily));

% compute descriptive statistics
n_columns = size(returns_nyse_daily, 2);
table_parameters_nyse_daily = zeros(6, n_columns);

for col = 1:n_columns
    data = returns_nyse_daily(:, col);
    table_parameters_nyse_daily(2, col) = mean(data, 'omitnan');  % Mean
    table_parameters_nyse_daily(3, col) = var(data,  'omitnan');  % Variance
    table_parameters_nyse_daily(4, col) = std(data,  'omitnan');  % Std deviation
    table_parameters_nyse_daily(5, col) = skewness(data);         % Skewness
    table_parameters_nyse_daily(6, col) = kurtosis(data);         % Kurtosis
end


table_parameters_nyse_daily = transpose(table_parameters_nyse_daily);
table_parameters_nyse_daily = array2table(table_parameters_nyse_daily);


table_parameters_nyse_daily(:,1) = [];

% set column names 
table_parameters_nyse_daily.Properties.VariableNames = ...
    {'MEAN','VARIANCE','STANDARDDEVIATION','SKEWNESS','KURTOSIS'};

% add stock names as first column
table_parameters_nyse_daily.STOCK = header_nyse_daily';
table_parameters_nyse_daily = movevars(table_parameters_nyse_daily, "STOCK", "Before", 1);

%% Exercise 2.b) Nyse monthly 
% import the tables
table_nyse_monthly = readtable('dataexam_jan26.xlsx', 'Sheet', 'nyse monthly');
Nyse_monthly       = readmatrix('dataexam_jan26.xlsx', 'Sheet', 'nyse monthly');

% minimal cleaning 
% remove rows in the numeric matrix that are completely NaN
Nyse_monthly(all(isnan(Nyse_monthly),2),:) = [];

% if the first numeric column is empty (all NaN), remove it
if ~isempty(Nyse_monthly) && all(isnan(Nyse_monthly(:,1)))
    Nyse_monthly(:,1) = [];
end

% remove the first column as it only includes the date
date_nyse_monthly = table_nyse_monthly{:,1};  % dates (from table)
Nyse_monthly(:,1) = [];                       % remove dates from numeric matrix
table_nyse_monthly(:,1) = [];                 % remove dates from table

% save stock names
header_nyse_monthly = table_nyse_monthly.Properties.VariableNames;

% compute monthly log-returns
returns_nyse_monthly = diff(log(Nyse_monthly));

% compute descriptive statistics
n_columns = size(returns_nyse_monthly, 2);
table_parameters_nyse_monthly = zeros(6, n_columns);

for col = 1:n_columns
    data = returns_nyse_monthly(:, col);
    table_parameters_nyse_monthly(2, col) = mean(data, 'omitnan');  % Mean
    table_parameters_nyse_monthly(3, col) = var(data,  'omitnan');  % Variance
    table_parameters_nyse_monthly(4, col) = std(data,  'omitnan');  % Std deviation
    table_parameters_nyse_monthly(5, col) = skewness(data);         % Skewness
    table_parameters_nyse_monthly(6, col) = kurtosis(data);         % Kurtosis
end

% last aesthetic changes to the table 
table_parameters_nyse_monthly = transpose(table_parameters_nyse_monthly);
table_parameters_nyse_monthly = array2table(table_parameters_nyse_monthly);

table_parameters_nyse_monthly(:,1) = [];

% set column names 
table_parameters_nyse_monthly.Properties.VariableNames = ...
    {'MEAN','VARIANCE','STANDARDDEVIATION','SKEWNESS','KURTOSIS'};

% add stock names as first column
table_parameters_nyse_monthly.STOCK = header_nyse_monthly';
table_parameters_nyse_monthly = movevars(table_parameters_nyse_monthly, "STOCK", "Before", 1);

%% Exercise 3.a) Variance–Covariance matrices 
cov_nas_d  = cov(returns_nas_daily,   'partialrows');
cov_nas_m  = cov(returns_nas_monthly, 'partialrows');
cov_nyse_d = cov(returns_nyse_daily,  'partialrows');
cov_nyse_m = cov(returns_nyse_monthly,'partialrows');

%% Exercise 3.b) Correlation matrices (pairwise)
% NASDAQ – daily
corr_nas_d = corrcoef(returns_nas_daily, 'Rows', 'pairwise');
% NASDAQ – monthly
corr_nas_m = corrcoef(returns_nas_monthly, 'Rows', 'pairwise');
% NYSE – daily
corr_nyse_d = corrcoef(returns_nyse_daily, 'Rows', 'pairwise');
% NYSE – monthly
corr_nyse_m = corrcoef(returns_nyse_monthly, 'Rows', 'pairwise');

%% Exercise 4 – Selection of a Nasdaq sample (10–12 securities)
% The goal is to select 10–12 Nasdaq securities and build:
% (i) return tables (daily and monthly) for the selected sample
% (ii) price/value tables (daily and monthly) for the selected sample
% The selection is motivated by sector representativeness and correlation structure.

% 4.1 Define the Nasdaq sample 
Stocks_sample_nas = { ...
    'APPLE', ...
    'NVIDIA', ...
    'MICROSOFT', ...
    'METAPLATFORMSA', ...        
    'ALPHABET_A_', ...
    'BROADCOM', ...
    'CISCOSYSTEMS', ...
    'ADVANCEDMICRODEVICES', ...
    'ADOBE_NAS_', ...
    'INTUIT', ...
    'INTEL' ...
};


% 4.2 Build full return tables (all Nasdaq assets), then extract the sample


table_returns_nas_daily   = array2table(returns_nas_daily,   'VariableNames', header_nas);
table_returns_nas_monthly = array2table(returns_nas_monthly, 'VariableNames', header_nas);


missingDaily = setdiff(Stocks_sample_nas, table_returns_nas_daily.Properties.VariableNames);
if ~isempty(missingDaily)
    error("Exercise 4: some sample tickers are NOT found in NASDAQ DAILY returns table: %s", strjoin(missingDaily, ", "));
end

missingMonthly = setdiff(Stocks_sample_nas, table_returns_nas_monthly.Properties.VariableNames);
if ~isempty(missingMonthly)
    error("Exercise 4: some sample tickers are NOT found in NASDAQ MONTHLY returns table: %s", strjoin(missingMonthly, ", "));
end

% Extract sample returns
table_sample_return_nas_daily   = table_returns_nas_daily(:, Stocks_sample_nas);
table_sample_return_nas_monthly = table_returns_nas_monthly(:, Stocks_sample_nas);



table_sample_return_nas_daily.DATE   = date_nas_daily(2:end);
table_sample_return_nas_monthly.DATE = date_nas_monthly(2:end);

% Move DATE as first column
table_sample_return_nas_daily   = movevars(table_sample_return_nas_daily,   "DATE", "Before", 1);
table_sample_return_nas_monthly = movevars(table_sample_return_nas_monthly, "DATE", "Before", 1);

% 4.3 Extract sample price/value tables (from the original Nasdaq tables)

missingPricesDaily = setdiff(Stocks_sample_nas, table_nas_daily.Properties.VariableNames);
if ~isempty(missingPricesDaily)
    error("Exercise 4: some sample tickers are NOT found in NASDAQ DAILY price table: %s", strjoin(missingPricesDaily, ", "));
end

missingPricesMonthly = setdiff(Stocks_sample_nas, table_nas_monthly.Properties.VariableNames);
if ~isempty(missingPricesMonthly)
    error("Exercise 4: some sample tickers are NOT found in NASDAQ MONTHLY price table: %s", strjoin(missingPricesMonthly, ", "));
end

% Extract sample prices/values
table_sample_values_nas_daily   = table_nas_daily(:, Stocks_sample_nas);
table_sample_values_nas_monthly = table_nas_monthly(:, Stocks_sample_nas);

% Add dates and move DATE first
table_sample_values_nas_daily.DATE = date_nas_daily;
table_sample_values_nas_daily = movevars(table_sample_values_nas_daily, "DATE", "Before", 1);

table_sample_values_nas_monthly.DATE = date_nas_monthly;
table_sample_values_nas_monthly = movevars(table_sample_values_nas_monthly, "DATE", "Before", 1);

%% Exercise 5 – Selection of a NYSE sample (10–12 securities)

% Base list 
Stocks_base_nyse = { ...
    'ELILILLY', ...
    'TELEPHONE_DATASYS_', ...
    'QUAKERHOUGHTON', ...
    'ALLIANCEBERNSTEINHLDG_UNT_', ...
    'FTICONSULTING', ...
    'PHILIPMORRISINTL_', ...
    'SUNOCO', ...
    'VISA_A_' ...
};

% Build full return tables
table_returns_nyse_daily   = array2table(returns_nyse_daily,   'VariableNames', header_nyse_daily);
table_returns_nyse_monthly = array2table(returns_nyse_monthly, 'VariableNames', header_nyse_monthly);

% Keep only names that exist in BOTH daily and monthly returns
okDaily   = ismember(Stocks_base_nyse, table_returns_nyse_daily.Properties.VariableNames);
okMonthly = ismember(Stocks_base_nyse, table_returns_nyse_monthly.Properties.VariableNames);
Stocks_sample_nyse = Stocks_base_nyse(okDaily & okMonthly);

% Automatically add extra names from the dataset to reach 11 tickers
targetN = 11;  
candidates = intersect(table_returns_nyse_daily.Properties.VariableNames, ...
                       table_returns_nyse_monthly.Properties.VariableNames, 'stable');

% remove already selected
candidates = setdiff(candidates, Stocks_sample_nyse, 'stable');


candidates = candidates(~cellfun(@isempty, candidates));

% add enough to reach targetN
nToAdd = max(0, targetN - numel(Stocks_sample_nyse));
Stocks_sample_nyse = [Stocks_sample_nyse, candidates(1:nToAdd)];

% ------------------ Extract sample returns ------------------
table_sample_return_nyse_daily   = table_returns_nyse_daily(:, Stocks_sample_nyse);
table_sample_return_nyse_monthly = table_returns_nyse_monthly(:, Stocks_sample_nyse);

% Add dates 
table_sample_return_nyse_daily.DATE   = date_nyse_daily(2:end);
table_sample_return_nyse_monthly.DATE = date_nyse_monthly(2:end);

table_sample_return_nyse_daily   = movevars(table_sample_return_nyse_daily,   "DATE", "Before", 1);
table_sample_return_nyse_monthly = movevars(table_sample_return_nyse_monthly, "DATE", "Before", 1);

% ------------------ Extract sample prices/values ------------------
missingPricesDaily = setdiff(Stocks_sample_nyse, table_nyse_daily.Properties.VariableNames);
if ~isempty(missingPricesDaily)
    error("Exercise 5: missing NYSE DAILY price names: %s", strjoin(missingPricesDaily, ", "));
end

missingPricesMonthly = setdiff(Stocks_sample_nyse, table_nyse_monthly.Properties.VariableNames);
if ~isempty(missingPricesMonthly)
    error("Exercise 5: missing NYSE MONTHLY price names: %s", strjoin(missingPricesMonthly, ", "));
end

table_sample_values_nyse_daily   = table_nyse_daily(:, Stocks_sample_nyse);
table_sample_values_nyse_monthly = table_nyse_monthly(:, Stocks_sample_nyse);

table_sample_values_nyse_daily.DATE = date_nyse_daily;
table_sample_values_nyse_daily = movevars(table_sample_values_nyse_daily, "DATE", "Before", 1);

table_sample_values_nyse_monthly.DATE = date_nyse_monthly;
table_sample_values_nyse_monthly = movevars(table_sample_values_nyse_monthly, "DATE", "Before", 1);

% Print the final selected tickers 
disp("Final NYSE sample used (10–12 tickers):");
disp(Stocks_sample_nyse');
% ------------------ Data Cleaning (Handle missing values) ------------------
% Remove rows containing NaN or #ERROR to ensure statistical consistency
table_sample_return_nyse_daily   = rmmissing(table_sample_return_nyse_daily);
table_sample_return_nyse_monthly = rmmissing(table_sample_return_nyse_monthly);

table_sample_values_nyse_daily   = rmmissing(table_sample_values_nyse_daily);
table_sample_values_nyse_monthly = rmmissing(table_sample_values_nyse_monthly);

% Display the final size of the clean dataset
fprintf('Cleaned NYSE Daily rows: %d\n', height(table_sample_return_nyse_daily));
fprintf('Cleaned NYSE Monthly rows: %d\n', height(table_sample_return_nyse_monthly));

%% Exercise 6 
% label cleaning for legend only
legend_nas  = strrep(Stocks_sample_nas,  "_", " ");
legend_nyse = strrep(Stocks_sample_nyse, "_", " ");

% =========================
% NASDAQ - MONTHLY
% =========================
to_plot = table2array(table_sample_values_nas_monthly(:,2:end));

figure(1)
plot(table_sample_values_nas_monthly.DATE, to_plot, 'LineWidth', 1.5);
grid on;
title('Monthly prices of the selected NASDAQ sample');
xlabel('Date');
ylabel('Price');
legend(legend_nas, 'Location','bestoutside');

clear to_plot;

% =========================
% NASDAQ - DAILY
% =========================
to_plot = table2array(table_sample_values_nas_daily(:,2:end));

figure(2)
plot(table_sample_values_nas_daily.DATE, to_plot, 'LineWidth', 1.5);
grid on;
title('Daily prices of the selected NASDAQ sample');
xlabel('Date');
ylabel('Price');
legend(legend_nas, 'Location','bestoutside');

clear to_plot;

% =========================
% NYSE - MONTHLY
% =========================
to_plot = table2array(table_sample_values_nyse_monthly(:,2:end));

figure(3)
plot(table_sample_values_nyse_monthly.DATE, to_plot, 'LineWidth', 1.5);
grid on;
title('Monthly prices of the selected NYSE sample');
xlabel('Date');
ylabel('Price');
legend(legend_nyse, 'Location','bestoutside');

clear to_plot;

% =========================
% NYSE - DAILY
% =========================
to_plot = table2array(table_sample_values_nyse_daily(:,2:end));

figure(4)
plot(table_sample_values_nyse_daily.DATE, to_plot, 'LineWidth', 1.5);
grid on;
title('Daily prices of the selected NYSE sample');
xlabel('Date');
ylabel('Price');
legend(legend_nyse, 'Location','bestoutside');

clear to_plot;

%% Exercises 7-8-9-10 
% Mean-Variance optimal portfolio allocation (NASDAQ + NYSE)
% Daily + Monthly, with and without non-negativity constraint
% Pie charts: percentages in legend + weights normalized on plotted subset

% -------------------------
% Risk-free rates
% If you prefer rf = 0, set rf_daily = 0; rf_monthly = 0;
% -------------------------
rf_daily   = 0.02/252;
rf_monthly = 0.02/12;

% -------------------------
% Asset names from VALUES tables (prices) 
% -------------------------
assets_nas  = table_sample_values_nas_daily.Properties.VariableNames(2:end);
assets_nyse = table_sample_values_nyse_daily.Properties.VariableNames(2:end);

assets_nas_m  = table_sample_values_nas_monthly.Properties.VariableNames(2:end);
assets_nyse_m = table_sample_values_nyse_monthly.Properties.VariableNames(2:end);

% If daily/monthly lists differ, keep common assets 
if ~isequal(assets_nas, assets_nas_m)
    common = intersect(assets_nas, assets_nas_m, 'stable');
    table_sample_values_nas_daily   = table_sample_values_nas_daily(:,   ["DATE", common]);
    table_sample_values_nas_monthly = table_sample_values_nas_monthly(:, ["DATE", common]);
    assets_nas = common;
end

if ~isequal(assets_nyse, assets_nyse_m)
    common = intersect(assets_nyse, assets_nyse_m, 'stable');
    table_sample_values_nyse_daily   = table_sample_values_nyse_daily(:,   ["DATE", common]);
    table_sample_values_nyse_monthly = table_sample_values_nyse_monthly(:, ["DATE", common]);
    assets_nyse = common;
end

% Clean labels for legends 
labels_nas  = string(strrep(assets_nas,  "_", " "));
labels_nyse = string(strrep(assets_nyse, "_", " "));

% -------------------------
% Log returns from prices
% -------------------------
R_nas_daily    = diff(log(table_sample_values_nas_daily{:,2:end}));
R_nas_monthly  = diff(log(table_sample_values_nas_monthly{:,2:end}));
R_nyse_daily   = diff(log(table_sample_values_nyse_daily{:,2:end}));
R_nyse_monthly = diff(log(table_sample_values_nyse_monthly{:,2:end}));

% -------------------------
% Portfolio objects 
% -------------------------
p_nas_daily_base    = Portfolio("AssetList", assets_nas,  "RiskFreeRate", rf_daily);
p_nas_monthly_base  = Portfolio("AssetList", assets_nas,  "RiskFreeRate", rf_monthly);
p_nyse_daily_base   = Portfolio("AssetList", assets_nyse, "RiskFreeRate", rf_daily);
p_nyse_monthly_base = Portfolio("AssetList", assets_nyse, "RiskFreeRate", rf_monthly);

p_nas_daily_base    = estimateAssetMoments(p_nas_daily_base,    R_nas_daily);
p_nas_monthly_base  = estimateAssetMoments(p_nas_monthly_base,  R_nas_monthly);
p_nyse_daily_base   = estimateAssetMoments(p_nyse_daily_base,   R_nyse_daily);
p_nyse_monthly_base = estimateAssetMoments(p_nyse_monthly_base, R_nyse_monthly);

p_nas_daily_base    = setDefaultConstraints(p_nas_daily_base);
p_nas_monthly_base  = setDefaultConstraints(p_nas_monthly_base);
p_nyse_daily_base   = setDefaultConstraints(p_nyse_daily_base);
p_nyse_monthly_base = setDefaultConstraints(p_nyse_monthly_base);

%% (7-8) Max Sharpe - short allowed
p_nas_daily    = setBounds(p_nas_daily_base,   -1, 1);
p_nas_monthly  = setBounds(p_nas_monthly_base, -1, 1);
p_nyse_daily   = setBounds(p_nyse_daily_base,  -1, 1);
p_nyse_monthly = setBounds(p_nyse_monthly_base,-1, 1);

w_nas_daily    = estimateMaxSharpeRatio(p_nas_daily);
w_nas_monthly  = estimateMaxSharpeRatio(p_nas_monthly);
w_nyse_daily   = estimateMaxSharpeRatio(p_nyse_daily);
w_nyse_monthly = estimateMaxSharpeRatio(p_nyse_monthly);

table_w_nas_daily    = array2table(w_nas_daily',   "VariableNames", assets_nas);
table_w_nas_monthly  = array2table(w_nas_monthly', "VariableNames", assets_nas);
table_w_nyse_daily   = array2table(w_nyse_daily',  "VariableNames", assets_nyse);
table_w_nyse_monthly = array2table(w_nyse_monthly',"VariableNames", assets_nyse);

% ---- Plot (short allowed): pie + legend with percentages ----
figure
set(gcf,'Position',[100 100 1200 700])

% NASDAQ daily
subplot(2,2,1)
idx = w_nas_daily > 0.001;
weights = w_nas_daily(idx);  weights = weights(:);
weights = weights / sum(weights);                
labs    = labels_nas(idx);   labs = labs(:);
pie(weights);
legend(makeLegendLabels(labs, weights), 'Location','eastoutside');
title("NASDAQ weights (daily) - short allowed");

% NASDAQ monthly
subplot(2,2,3)
idx = w_nas_monthly > 0.001;
weights = w_nas_monthly(idx);  weights = weights(:);
weights = weights / sum(weights);                
labs    = labels_nas(idx);     labs = labs(:);
pie(weights);
legend(makeLegendLabels(labs, weights), 'Location','eastoutside');
title("NASDAQ weights (monthly) - short allowed");

% NYSE daily
subplot(2,2,2)
idx = w_nyse_daily > 0.001;
weights = w_nyse_daily(idx);  weights = weights(:);
weights = weights / sum(weights);                
labs    = labels_nyse(idx);   labs = labs(:);
pie(weights);
legend(makeLegendLabels(labs, weights), 'Location','eastoutside');
title("NYSE weights (daily) - short allowed");

% NYSE monthly
subplot(2,2,4)
idx = w_nyse_monthly > 0.001;
weights = w_nyse_monthly(idx);  weights = weights(:);
weights = weights / sum(weights);                
labs    = labels_nyse(idx);     labs = labs(:);
pie(weights);
legend(makeLegendLabels(labs, weights), 'Location','eastoutside');
title("NYSE weights (monthly) - short allowed");

%% (9-10) Max Sharpe - no short-selling
p_nas_daily_ns    = setBounds(p_nas_daily_base,    0, 1);
p_nas_monthly_ns  = setBounds(p_nas_monthly_base,  0, 1);
p_nyse_daily_ns   = setBounds(p_nyse_daily_base,   0, 1);
p_nyse_monthly_ns = setBounds(p_nyse_monthly_base, 0, 1);

w_nas_daily_ns    = estimateMaxSharpeRatio(p_nas_daily_ns);
w_nas_monthly_ns  = estimateMaxSharpeRatio(p_nas_monthly_ns);
w_nyse_daily_ns   = estimateMaxSharpeRatio(p_nyse_daily_ns);
w_nyse_monthly_ns = estimateMaxSharpeRatio(p_nyse_monthly_ns);

table_w_nas_daily_ns    = array2table(w_nas_daily_ns',   "VariableNames", assets_nas);
table_w_nas_monthly_ns  = array2table(w_nas_monthly_ns', "VariableNames", assets_nas);
table_w_nyse_daily_ns   = array2table(w_nyse_daily_ns',  "VariableNames", assets_nyse);
table_w_nyse_monthly_ns = array2table(w_nyse_monthly_ns',"VariableNames", assets_nyse);

% ---- Plot (no short-selling): pie + legend with percentages (consistent) ----
figure
set(gcf,'Position',[100 100 1200 700])

% NASDAQ daily
subplot(2,2,1)
idx = w_nas_daily_ns > 0.001;
weights = w_nas_daily_ns(idx);  weights = weights(:);
weights = weights / sum(weights);                
labs    = labels_nas(idx);      labs = labs(:);
pie(weights);
legend(makeLegendLabels(labs, weights), 'Location','eastoutside');
title("NASDAQ weights (daily) - no short-selling");

% NASDAQ monthly
subplot(2,2,3)
idx = w_nas_monthly_ns > 0.001;
weights = w_nas_monthly_ns(idx);  weights = weights(:);
weights = weights / sum(weights);                
labs    = labels_nas(idx);        labs = labs(:);
pie(weights);
legend(makeLegendLabels(labs, weights), 'Location','eastoutside');
title("NASDAQ weights (monthly) - no short-selling");

% NYSE daily
subplot(2,2,2)
idx = w_nyse_daily_ns > 0.001;
weights = w_nyse_daily_ns(idx);  weights = weights(:);
weights = weights / sum(weights);                
labs    = labels_nyse(idx);      labs = labs(:);
pie(weights);
legend(makeLegendLabels(labs, weights), 'Location','eastoutside');
title("NYSE weights (daily) - no short-selling");

% NYSE monthly
subplot(2,2,4)
idx = w_nyse_monthly_ns > 0.001;
weights = w_nyse_monthly_ns(idx);  weights = weights(:);
weights = weights / sum(weights);                
labs    = labels_nyse(idx);        labs = labs(:);
pie(weights);
legend(makeLegendLabels(labs, weights), 'Location','eastoutside');
title("NYSE weights (monthly) - no short-selling");

%% ---- Local function ----
function out = makeLegendLabels(labs, weights)
% labs: string array (Nx1), weights: numeric (Nx1) that sum to 1
weights = weights(:);
labs    = string(labs(:));
pct     = 100*weights;
out     = compose("%s (%.1f%%)", labs, pct);
end

%% Exercises 11-12 (short allowed + no short-selling)

% --- Portfolio returns (short allowed) ---
rp_nyse_daily   = R_nyse_daily   * w_nyse_daily(:);
rp_nyse_monthly = R_nyse_monthly * w_nyse_monthly(:);
rp_nas_daily    = R_nas_daily    * w_nas_daily(:);
rp_nas_monthly  = R_nas_monthly  * w_nas_monthly(:);

% --- Portfolio returns (no short-selling) ---
rp_nyse_daily_ns   = R_nyse_daily   * w_nyse_daily_ns(:);
rp_nyse_monthly_ns = R_nyse_monthly * w_nyse_monthly_ns(:);
rp_nas_daily_ns    = R_nas_daily    * w_nas_daily_ns(:);
rp_nas_monthly_ns  = R_nas_monthly  * w_nas_monthly_ns(:);

% ---------- Exercise 11: NYSE ----------
Table_11_NYSE_portfolio_stats = table( ...
    [mean(rp_nyse_daily); mean(rp_nyse_monthly)], ...
    [std(rp_nyse_daily);  std(rp_nyse_monthly)], ...
    [var(rp_nyse_daily);  var(rp_nyse_monthly)], ...
    [skewness(rp_nyse_daily); skewness(rp_nyse_monthly)], ...
    [kurtosis(rp_nyse_daily); kurtosis(rp_nyse_monthly)], ...
    [length(rp_nyse_daily); length(rp_nyse_monthly)], ...
    'VariableNames', {'Mean','StdDev','Variance','Skewness','Kurtosis','Nobs'}, ...
    'RowNames', {'Daily','Monthly'} ...
);

Table_11_NYSE_portfolio_stats_noshort = table( ...
    [mean(rp_nyse_daily_ns); mean(rp_nyse_monthly_ns)], ...
    [std(rp_nyse_daily_ns);  std(rp_nyse_monthly_ns)], ...
    [var(rp_nyse_daily_ns);  var(rp_nyse_monthly_ns)], ...
    [skewness(rp_nyse_daily_ns); skewness(rp_nyse_monthly_ns)], ...
    [kurtosis(rp_nyse_daily_ns); kurtosis(rp_nyse_monthly_ns)], ...
    [length(rp_nyse_daily_ns); length(rp_nyse_monthly_ns)], ...
    'VariableNames', {'Mean','StdDev','Variance','Skewness','Kurtosis','Nobs'}, ...
    'RowNames', {'Daily','Monthly'} ...
);

% ---------- Exercise 12: NASDAQ ----------
Table_12_NASDAQ_portfolio_stats = table( ...
    [mean(rp_nas_daily); mean(rp_nas_monthly)], ...
    [std(rp_nas_daily);  std(rp_nas_monthly)], ...
    [var(rp_nas_daily);  var(rp_nas_monthly)], ...
    [skewness(rp_nas_daily); skewness(rp_nas_monthly)], ...
    [kurtosis(rp_nas_daily); kurtosis(rp_nas_monthly)], ...
    [length(rp_nas_daily); length(rp_nas_monthly)], ...
    'VariableNames', {'Mean','StdDev','Variance','Skewness','Kurtosis','Nobs'}, ...
    'RowNames', {'Daily','Monthly'} ...
);

Table_12_NASDAQ_portfolio_stats_noshort = table( ...
    [mean(rp_nas_daily_ns); mean(rp_nas_monthly_ns)], ...
    [std(rp_nas_daily_ns);  std(rp_nas_monthly_ns)], ...
    [var(rp_nas_daily_ns);  var(rp_nas_monthly_ns)], ...
    [skewness(rp_nas_daily_ns); skewness(rp_nas_monthly_ns)], ...
    [kurtosis(rp_nas_daily_ns); kurtosis(rp_nas_monthly_ns)], ...
    [length(rp_nas_daily_ns); length(rp_nas_monthly_ns)], ...
    'VariableNames', {'Mean','StdDev','Variance','Skewness','Kurtosis','Nobs'}, ...
    'RowNames', {'Daily','Monthly'} ...
);

disp("Exercise 11 - NYSE (short allowed):"); disp(Table_11_NYSE_portfolio_stats)
disp("Exercise 11 - NYSE (no short-selling):"); disp(Table_11_NYSE_portfolio_stats_noshort)
disp("Exercise 12 - NASDAQ (short allowed):"); disp(Table_12_NASDAQ_portfolio_stats)
disp("Exercise 12 - NASDAQ (no short-selling):"); disp(Table_12_NASDAQ_portfolio_stats_noshort)

%% Exercises 13-14 
nPoints = 50;

% =========================
% NASDAQ (Exercise 13)
% =========================
figure;

% ---- NASDAQ Daily ----
subplot(2,1,1)
CovMatrix = p_nas_daily.AssetCovar;
AssetRisk = sqrt(diag(CovMatrix));
ExpectedReturns = p_nas_daily.AssetMean;

plotFrontier(p_nas_daily, nPoints);
grid on
title('Efficient Frontier of the NASDAQ Portfolio, Daily');
xlabel('Risk (Standard Deviation)');
ylabel('Expected Return');

% freeze legend updates from now on
legend('AutoUpdate','off');
hold on
scatter(AssetRisk, ExpectedReturns, 50, 'filled', 'DisplayName','Asset');
legend('Location','northeast');
hold off

% ---- NASDAQ Monthly ----
subplot(2,1,2)
CovMatrix = p_nas_monthly.AssetCovar;
AssetRisk = sqrt(diag(CovMatrix));
ExpectedReturns = p_nas_monthly.AssetMean;

plotFrontier(p_nas_monthly, nPoints);
grid on
title('Efficient Frontier of the NASDAQ Portfolio, Monthly');
xlabel('Risk (Standard Deviation)');
ylabel('Expected Return');

legend('AutoUpdate','off');
hold on
scatter(AssetRisk, ExpectedReturns, 50, 'filled', 'DisplayName','Asset');
legend('Location','northeast');
hold off


% =========================
% NYSE (Exercise 14)
% =========================
figure;

% ---- NYSE Daily ----
subplot(2,1,1)
CovMatrix = p_nyse_daily.AssetCovar;
AssetRisk = sqrt(diag(CovMatrix));
ExpectedReturns = p_nyse_daily.AssetMean;

plotFrontier(p_nyse_daily, nPoints);
grid on
title('Efficient Frontier of the NYSE Portfolio, Daily');
xlabel('Risk (Standard Deviation)');
ylabel('Expected Return');

legend('AutoUpdate','off');
hold on
scatter(AssetRisk, ExpectedReturns, 50, 'filled', 'DisplayName','Asset');
legend('Location','northeast');
hold off

% ---- NYSE Monthly ----
subplot(2,1,2)
CovMatrix = p_nyse_monthly.AssetCovar;
AssetRisk = sqrt(diag(CovMatrix));
ExpectedReturns = p_nyse_monthly.AssetMean;

plotFrontier(p_nyse_monthly, nPoints);
grid on
title('Efficient Frontier of the NYSE Portfolio, Monthly');
xlabel('Risk (Standard Deviation)');
ylabel('Expected Return');

legend('AutoUpdate','off');
hold on
scatter(AssetRisk, ExpectedReturns, 50, 'filled', 'DisplayName','Asset');
legend('Location','northeast');
hold off

%% Exercise 15 — Index statistics (Daily & Monthly, Price vs Total Return)

filename = "dataexam_jan26.xlsx";
to_name  = {'MEAN','VARIANCE','STANDARD_DEVIATION','SKEWNESS','KURTOSIS'};

%% =========================
% MONTHLY
% =========================
T_monthly = readtable(filename, 'Sheet', 'indexes monthly', "VariableNamingRule","preserve");

% NYSE block: (1 = DATE, 2:3 = S&P500 PI and TR)
table_index_nyse_monthly = T_monthly(:,1:3);

% NASDAQ block: (1 = DATE, 9:10 = NASDAQ PI and TR)  
if width(T_monthly) < 10
    error("indexes monthly: expected at least 10 columns to use (1,9,10). Found %d.", width(T_monthly));
end
table_index_nas_monthly  = T_monthly(:,[1 9 10]);

% Remove first two rows (metadata rows)
if height(table_index_nyse_monthly) >= 2, table_index_nyse_monthly(1:2,:) = []; end
if height(table_index_nas_monthly)  >= 2, table_index_nas_monthly(1:2,:)  = []; end

% Rename date column to DATE
table_index_nyse_monthly = renamevars(table_index_nyse_monthly, table_index_nyse_monthly.Properties.VariableNames{1}, 'DATE');
table_index_nas_monthly  = renamevars(table_index_nas_monthly,  table_index_nas_monthly.Properties.VariableNames{1}, 'DATE');

% Convert level columns to numeric 
table_index_nyse_monthly{:,2} = toNum(table_index_nyse_monthly{:,2});
table_index_nyse_monthly{:,3} = toNum(table_index_nyse_monthly{:,3});
table_index_nas_monthly{:,2}  = toNum(table_index_nas_monthly{:,2});
table_index_nas_monthly{:,3}  = toNum(table_index_nas_monthly{:,3});

% Keep only valid rows (DATE present + positive numeric levels)
mask_nyse_M = ~ismissing(table_index_nyse_monthly.DATE) & all(table_index_nyse_monthly{:,2:3} > 0, 2) & all(~isnan(table_index_nyse_monthly{:,2:3}),2);
mask_nas_M  = ~ismissing(table_index_nas_monthly.DATE)  & all(table_index_nas_monthly{:,2:3}  > 0, 2) & all(~isnan(table_index_nas_monthly{:,2:3}),2);

table_index_nyse_monthly = table_index_nyse_monthly(mask_nyse_M,:);
table_index_nas_monthly  = table_index_nas_monthly(mask_nas_M,:);

% Log-returns
table_index_return_nyse_monthly = array2table( ...
    diff(log(table_index_nyse_monthly{:,2:3})), ...
    "VariableNames", ["SP500_PI","SP500_RI"] );

table_index_return_nas_monthly = array2table( ...
    diff(log(table_index_nas_monthly{:,2:3})), ...
    "VariableNames", ["NASDAQ_PI","NASDAQ_RI"] );


%% =========================
% DAILY
% =========================
T_daily = readtable(filename, 'Sheet', 'indexes daily', "VariableNamingRule","preserve");

table_index_nyse_daily = T_daily(:,1:3);

if width(T_daily) < 10
    error("indexes daily: expected at least 10 columns to use (1,9,10). Found %d.", width(T_daily));
end
table_index_nas_daily  = T_daily(:,[1 9 10]);   % <-- FIX

if height(table_index_nyse_daily) >= 2, table_index_nyse_daily(1:2,:) = []; end
if height(table_index_nas_daily)  >= 2, table_index_nas_daily(1:2,:)  = []; end

table_index_nyse_daily = renamevars(table_index_nyse_daily, table_index_nyse_daily.Properties.VariableNames{1}, 'DATE');
table_index_nas_daily  = renamevars(table_index_nas_daily,  table_index_nas_daily.Properties.VariableNames{1}, 'DATE');

table_index_nyse_daily{:,2} = toNum(table_index_nyse_daily{:,2});
table_index_nyse_daily{:,3} = toNum(table_index_nyse_daily{:,3});
table_index_nas_daily{:,2}  = toNum(table_index_nas_daily{:,2});
table_index_nas_daily{:,3}  = toNum(table_index_nas_daily{:,3});

mask_nyse_D = ~ismissing(table_index_nyse_daily.DATE) & all(table_index_nyse_daily{:,2:3} > 0, 2) & all(~isnan(table_index_nyse_daily{:,2:3}),2);
mask_nas_D  = ~ismissing(table_index_nas_daily.DATE)  & all(table_index_nas_daily{:,2:3}  > 0, 2) & all(~isnan(table_index_nas_daily{:,2:3}),2);

table_index_nyse_daily = table_index_nyse_daily(mask_nyse_D,:);
table_index_nas_daily  = table_index_nas_daily(mask_nas_D,:);

table_index_return_nyse_daily = array2table( ...
    diff(log(table_index_nyse_daily{:,2:3})), ...
    "VariableNames", ["SP500_PI","SP500_RI"] );

table_index_return_nas_daily = array2table( ...
    diff(log(table_index_nas_daily{:,2:3})), ...
    "VariableNames", ["NASDAQ_PI","NASDAQ_RI"] );


%% =========================
% PARAMETERS TABLES
% =========================
table_index_parameters_nyse_monthly = computeParamTable(table_index_return_nyse_monthly, to_name);
table_index_parameters_nas_monthly  = computeParamTable(table_index_return_nas_monthly,  to_name);

table_index_parameters_nyse_daily   = computeParamTable(table_index_return_nyse_daily,   to_name);
table_index_parameters_nas_daily    = computeParamTable(table_index_return_nas_daily,    to_name);

disp("=== EX15: INDEX PARAMETERS (MONTHLY) — NYSE ===");
disp(table_index_parameters_nyse_monthly);

disp("=== EX15: INDEX PARAMETERS (MONTHLY) — NASDAQ ===");
disp(table_index_parameters_nas_monthly);

disp("=== EX15: INDEX PARAMETERS (DAILY) — NYSE ===");
disp(table_index_parameters_nyse_daily);

disp("=== EX15: INDEX PARAMETERS (DAILY) — NASDAQ ===");
disp(table_index_parameters_nas_daily);


%% ==========================================================
% Local functions 
% ==========================================================
function x = toNum(v)
    if isnumeric(v)
        x = v;
        return
    end
    s = string(v);
    s = strtrim(s);
    s = replace(s, ",", "");    % remove thousands separators
    s(s=="") = "NaN";
    x = str2double(s);
end

function P = computeParamTable(R, to_name)
    P = array2table(zeros(width(R),5), "VariableNames", to_name, "RowNames", R.Properties.VariableNames);
    for j = 1:width(R)
        x = R{:,j};
        P{j,'MEAN'}               = mean(x,'omitnan');
        P{j,'VARIANCE'}           = var(x,'omitnan');
        P{j,'STANDARD_DEVIATION'} = std(x,'omitnan');
        P{j,'SKEWNESS'}           = skewness(x);
        P{j,'KURTOSIS'}           = kurtosis(x);
    end
end

%% =========================================================
% Exercises 16–19 
% Betas (all securities) + Portfolio betas + SML tables + SML FIGURES 
% =========================================================
% --- portable Desktop (Mac + Windows) ---
if ispc
    homeDir = getenv("USERPROFILE");
else
    homeDir = getenv("HOME");
end

desk = fullfile(homeDir,"Desktop");
if isempty(homeDir) || ~isfolder(desk)
    desk = pwd;   % fallback: current folder
end

outXLS = fullfile(desk, "EX16_17_Betas_AllSecurities_and_Portfolios.xlsx");

%% =========================================================
% Exercise 16 — NYSE: betas for EACH security + NYSE portfolio beta (daily & monthly)
% =========================================================

% 16.1 Market returns from index LEVEL table (LOG returns) 
mktRet_nyse_daily_tbl   = buildIndexLogReturns(table_index_nyse_daily,   "SP500_RI");
mktRet_nyse_monthly_tbl = buildIndexLogReturns(table_index_nyse_monthly, "SP500_RI");

% 16.2 Align by DATE with NYSE sample returns (the ones from Exercise 5)
[RetNY_D, MktNY_D] = alignReturnsByDate(table_sample_return_nyse_daily,   mktRet_nyse_daily_tbl);
[RetNY_M, MktNY_M] = alignReturnsByDate(table_sample_return_nyse_monthly, mktRet_nyse_monthly_tbl);

% 16.3 Betas for each security (NYSE)
betas_nyse_daily   = computeBetasOLS(RetNY_D, MktNY_D);
betas_nyse_monthly = computeBetasOLS(RetNY_M, MktNY_M);

% 16.4 Portfolio betas (NYSE)
w_nyse_daily   = w_nyse_daily(:);
w_nyse_monthly = w_nyse_monthly(:);
beta_p_nyse_daily   = betas_nyse_daily(:)'   * w_nyse_daily;
beta_p_nyse_monthly = betas_nyse_monthly(:)' * w_nyse_monthly;

% 16.5 Output table (all securities + portfolio)
Table_16_Betas_NYSE = table( ...
    betas_nyse_daily(:), betas_nyse_monthly(:), ...
    'VariableNames', {'Beta_Daily','Beta_Monthly'}, ...
    'RowNames', Stocks_sample_nyse);
Table_16_Betas_NYSE{'PORTFOLIO',:} = [beta_p_nyse_daily, beta_p_nyse_monthly];

disp("=== EX16: NYSE betas DONE ===");

%% =========================================================
% Exercise 17 — NASDAQ: betas for EACH security + NASDAQ portfolio beta (daily & monthly)
% =========================================================

mktRet_nas_daily_tbl   = buildIndexLogReturns(table_index_nas_daily,   "NASDAQ_RI");
mktRet_nas_monthly_tbl = buildIndexLogReturns(table_index_nas_monthly, "NASDAQ_RI");

[RetNA_D, MktNA_D] = alignReturnsByDate(table_sample_return_nas_daily,   mktRet_nas_daily_tbl);
[RetNA_M, MktNA_M] = alignReturnsByDate(table_sample_return_nas_monthly, mktRet_nas_monthly_tbl);

betas_nas_daily   = computeBetasOLS(RetNA_D, MktNA_D);
betas_nas_monthly = computeBetasOLS(RetNA_M, MktNA_M);

w_nas_daily   = w_nas_daily(:);
w_nas_monthly = w_nas_monthly(:);
beta_p_nas_daily   = betas_nas_daily(:)'   * w_nas_daily;
beta_p_nas_monthly = betas_nas_monthly(:)' * w_nas_monthly;

Table_17_Betas_NASDAQ = table( ...
    betas_nas_daily(:), betas_nas_monthly(:), ...
    'VariableNames', {'Beta_Daily','Beta_Monthly'}, ...
    'RowNames', Stocks_sample_nas);
Table_17_Betas_NASDAQ{'PORTFOLIO',:} = [beta_p_nas_daily, beta_p_nas_monthly];

disp("=== EX17: NASDAQ betas DONE ===");

%% =========================================================
% SAVE EX16–EX17 TABLES  
% =========================================================

% Convert RowNames into a column 
T16 = Table_16_Betas_NYSE;
T16 = addvars(T16, string(T16.Properties.RowNames), 'Before', 1, 'NewVariableNames', 'Ticker');
T16.Properties.RowNames = {};

T17 = Table_17_Betas_NASDAQ;
T17 = addvars(T17, string(T17.Properties.RowNames), 'Before', 1, 'NewVariableNames', 'Ticker');
T17.Properties.RowNames = {};

Table_Portfolio_Betas = table( ...
    beta_p_nyse_daily, beta_p_nyse_monthly, ...
    beta_p_nas_daily,  beta_p_nas_monthly, ...
    'VariableNames', {'NYSE_Beta_Daily','NYSE_Beta_Monthly','NASDAQ_Beta_Daily','NASDAQ_Beta_Monthly'});

try
    writetable(T16, outXLS, 'Sheet', 'EX16_NYSE_AllBetas');
    writetable(T17, outXLS, 'Sheet', 'EX17_NASDAQ_AllBetas');
    writetable(Table_Portfolio_Betas, outXLS, 'Sheet', 'Portfolio_Betas_Summary');
    disp("Excel saved on Desktop:");
    disp(outXLS);
catch ME
    warning("Could not write Excel (probably file open). Close Excel and rerun SAVE part. Error: %s", ME.message);
end

%% =========================================================
% Exercise 18 — NYSE SML for 2 securities + portfolio (daily & monthly) + FIGURES
% =========================================================

rf_annual  = 0.02;
rf_daily   = rf_annual/252;
rf_monthly = rf_annual/12;

% Auto pick 2 securities 
idx2_nyse = pickTwoSecurities(betas_nyse_daily, betas_nyse_monthly);

disp("EX18 chosen NYSE securities:");
disp(Stocks_sample_nyse(idx2_nyse));

% Expected market returns
E_mkt_nyse_D = mean(MktNY_D,'omitnan');
E_mkt_nyse_M = mean(MktNY_M,'omitnan');

% Real expected returns (2 securities)
E_real_nyse_D_2 = mean(RetNY_D(:,idx2_nyse),1,'omitnan');
E_real_nyse_M_2 = mean(RetNY_M(:,idx2_nyse),1,'omitnan');

% Portfolio returns
rp_nyse_D = RetNY_D * w_nyse_daily;
rp_nyse_M = RetNY_M * w_nyse_monthly;
E_real_p_nyse_D = mean(rp_nyse_D,'omitnan');
E_real_p_nyse_M = mean(rp_nyse_M,'omitnan');

% CAPM expected returns
beta_nyse_D_2 = betas_nyse_daily(idx2_nyse);
beta_nyse_M_2 = betas_nyse_monthly(idx2_nyse);

E_capm_nyse_D_2 = rf_daily   + beta_nyse_D_2 .* (E_mkt_nyse_D - rf_daily);
E_capm_nyse_M_2 = rf_monthly + beta_nyse_M_2 .* (E_mkt_nyse_M - rf_monthly);

E_capm_p_nyse_D = rf_daily   + beta_p_nyse_daily   * (E_mkt_nyse_D - rf_daily);
E_capm_p_nyse_M = rf_monthly + beta_p_nyse_monthly * (E_mkt_nyse_M - rf_monthly);

Table_18_NYSE_Daily_SML   = makeSMLTable(Stocks_sample_nyse, idx2_nyse, beta_nyse_D_2, beta_p_nyse_daily,   E_capm_nyse_D_2, E_capm_p_nyse_D, E_real_nyse_D_2, E_real_p_nyse_D);
Table_18_NYSE_Monthly_SML = makeSMLTable(Stocks_sample_nyse, idx2_nyse, beta_nyse_M_2, beta_p_nyse_monthly, E_capm_nyse_M_2, E_capm_p_nyse_M, E_real_nyse_M_2, E_real_p_nyse_M);

try
    writetable(Table_18_NYSE_Daily_SML,   outXLS, 'Sheet', 'EX18_NYSE_Daily_SML');
    writetable(Table_18_NYSE_Monthly_SML, outXLS, 'Sheet', 'EX18_NYSE_Monthly_SML');
catch
end

% ---- FIGURES 
fig1 = plotSMLLineAndPoints(Table_18_NYSE_Daily_SML,   rf_daily,   E_mkt_nyse_D, "EX18 NYSE Daily SML");
saveas(fig1, fullfile(desk,"EX18_NYSE_Daily_SML.png"));

fig2 = plotSMLLineAndPoints(Table_18_NYSE_Monthly_SML, rf_monthly, E_mkt_nyse_M, "EX18 NYSE Monthly SML");
saveas(fig2, fullfile(desk,"EX18_NYSE_Monthly_SML.png"));

%% =========================================================
% Exercise 19 — NASDAQ SML for 2 securities + portfolio (daily & monthly) + FIGURES
% =========================================================

idx2_nas = pickTwoSecurities(betas_nas_daily, betas_nas_monthly);

disp("EX19 chosen NASDAQ securities:");
disp(Stocks_sample_nas(idx2_nas));

E_mkt_nas_D = mean(MktNA_D,'omitnan');
E_mkt_nas_M = mean(MktNA_M,'omitnan');

E_real_nas_D_2 = mean(RetNA_D(:,idx2_nas),1,'omitnan');
E_real_nas_M_2 = mean(RetNA_M(:,idx2_nas),1,'omitnan');

rp_nas_D = RetNA_D * w_nas_daily;
rp_nas_M = RetNA_M * w_nas_monthly;
E_real_p_nas_D = mean(rp_nas_D,'omitnan');
E_real_p_nas_M = mean(rp_nas_M,'omitnan');

beta_nas_D_2 = betas_nas_daily(idx2_nas);
beta_nas_M_2 = betas_nas_monthly(idx2_nas);

E_capm_nas_D_2 = rf_daily   + beta_nas_D_2 .* (E_mkt_nas_D - rf_daily);
E_capm_nas_M_2 = rf_monthly + beta_nas_M_2 .* (E_mkt_nas_M - rf_monthly);

E_capm_p_nas_D = rf_daily   + beta_p_nas_daily   * (E_mkt_nas_D - rf_daily);
E_capm_p_nas_M = rf_monthly + beta_p_nas_monthly * (E_mkt_nas_M - rf_monthly);

Table_19_NASDAQ_Daily_SML   = makeSMLTable(Stocks_sample_nas, idx2_nas, beta_nas_D_2, beta_p_nas_daily,   E_capm_nas_D_2, E_capm_p_nas_D, E_real_nas_D_2, E_real_p_nas_D);
Table_19_NASDAQ_Monthly_SML = makeSMLTable(Stocks_sample_nas, idx2_nas, beta_nas_M_2, beta_p_nas_monthly, E_capm_nas_M_2, E_capm_p_nas_M, E_real_nas_M_2, E_real_p_nas_M);

try
    writetable(Table_19_NASDAQ_Daily_SML,   outXLS, 'Sheet', 'EX19_NASDAQ_Daily_SML');
    writetable(Table_19_NASDAQ_Monthly_SML, outXLS, 'Sheet', 'EX19_NASDAQ_Monthly_SML');
catch
end

fig3 = plotSMLLineAndPoints(Table_19_NASDAQ_Daily_SML,   rf_daily,   E_mkt_nas_D, "EX19 NASDAQ Daily SML");
saveas(fig3, fullfile(desk,"EX19_NASDAQ_Daily_SML.png"));

fig4 = plotSMLLineAndPoints(Table_19_NASDAQ_Monthly_SML, rf_monthly, E_mkt_nas_M, "EX19 NASDAQ Monthly SML");
saveas(fig4, fullfile(desk,"EX19_NASDAQ_Monthly_SML.png"));

disp("EX18–EX19 figures GENERATED and LEFT OPEN.");
disp("PNG files saved on Desktop.");

%% =========================================================
% LOCAL FUNCTIONS (EX16–EX19) 
% =========================================================

function idxRetTbl = buildIndexLogReturns(indexLevelTbl, colNameRI)
    if ~any(strcmp(indexLevelTbl.Properties.VariableNames,'DATE'))
        error("Index table must contain a DATE column.");
    end
    d = indexLevelTbl.DATE;

    if any(strcmp(indexLevelTbl.Properties.VariableNames, colNameRI))
        level = indexLevelTbl.(colNameRI);
    else
        if width(indexLevelTbl) < 3
            error("Index table has <3 columns; cannot fallback to RI column.");
        end
        level = indexLevelTbl{:,3};
        warning("Column %s not found. Using 3rd column as RI (fallback).", string(colNameRI));
    end

    level = level(:);
    r  = diff(log(level));
    dR = d(2:end);
    idxRetTbl = table(dR, r, 'VariableNames', {'DATE','MKT'});
end

function [Rmat, mkt] = alignReturnsByDate(assetReturnTbl, mktReturnTbl)
    if ~any(strcmp(assetReturnTbl.Properties.VariableNames,'DATE'))
        error("Asset returns table must contain DATE column.");
    end
    dA = assetReturnTbl.DATE;
    dM = mktReturnTbl.DATE;

    [~, ia, im] = intersect(dA, dM);

    A = assetReturnTbl(ia,:);
    A.DATE = [];
    Rmat = table2array(A);
    mkt  = mktReturnTbl.MKT(im);

    mask = ~isnan(mkt);
    Rmat = Rmat(mask,:);
    mkt  = mkt(mask);
end

function betas = computeBetasOLS(R, mkt)
    k = size(R,2);
    betas = NaN(1,k);

    if var(mkt,'omitnan') < 1e-12
        warning("Market variance ~0. Betas not reliable.");
        return
    end

    X = [ones(numel(mkt),1), mkt(:)];

    for j = 1:k
        y = R(:,j);
        mask = ~isnan(y) & ~isnan(mkt);
        if sum(mask) < 20
            betas(j) = NaN;
        else
            b = X(mask,:) \ y(mask);
            betas(j) = b(2);
        end
    end
end

function idx2 = pickTwoSecurities(betaDaily, betaMonthly)
    valid = ~isnan(betaDaily) & ~isnan(betaMonthly);
    idx = find(valid);
    if numel(idx) < 2
        idx2 = [1 2];
        return
    end
    b = betaDaily(valid);
    [~,iMin] = min(b);
    [~,iMax] = max(b);
    idx2 = [idx(iMin) idx(iMax)];
    if idx2(1) == idx2(2)
        idx2 = idx(1:2);
    end
end

function SMLtbl = makeSMLTable(tickers, idx2, beta2, betaP, Ecapm2, EcapmP, Ereal2, ErealP)
    names = [tickers(idx2), {'PORTFOLIO'}];
    Beta = [beta2(:); betaP];
    E_R_CAPM = [Ecapm2(:); EcapmP];
    E_R_Real = [Ereal2(:); ErealP];
    Diff = E_R_Real - E_R_CAPM;

    SMLtbl = table(string(names(:)), Beta, E_R_CAPM, E_R_Real, Diff, ...
        'VariableNames', {'Asset','Beta','E_R_CAPM','E_R_Real','Diff'});
end

function fig = plotSMLLineAndPoints(SMLtbl, rf, Emkt, figName)
    betaPts = SMLtbl.Beta;
    yPts    = SMLtbl.E_R_Real;

    bmin = min(betaPts) - 0.2;
    bmax = max(betaPts) + 0.2;
    betaGrid = linspace(bmin, bmax, 200);
    smlLine  = rf + betaGrid*(Emkt - rf);

    fig = figure('Name', figName);
    plot(betaGrid, smlLine, 'LineWidth', 1.5); hold on;
    scatter(betaPts, yPts, 60, 'filled');
    title(figName);
    xlabel('Beta'); ylabel('Expected Return');
    grid on;
end

%% ============================================================
%  Exercises 20-21: BLACK-LITTERMAN (NYSE + NASDAQ, daily + monthly)

% ----------------------------
% Risk-free 
% ----------------------------
rf_daily   = 0.02/252;
rf_monthly = 0.02/12;

[R_nyse_d, assetNames_nyse] = fetchReturnsAndNames( ...
    ["sample_returns_nyse_daily","R_nyse_daily"], ...
    ["header_sample_nyse","assets_nyse","names_nyse","tickers_nyse"] );

[R_nyse_m, ~] = fetchReturnsAndNames( ...
    ["sample_returns_nyse_monthly","R_nyse_monthly"], ...
    ["header_sample_nyse","assets_nyse","names_nyse","tickers_nyse"] );

[R_nas_d, assetNames_nas] = fetchReturnsAndNames( ...
    ["sample_returns_nas_daily","R_nas_daily","sample_returns_nasdaq_daily","R_nasdaq_daily"], ...
    ["header_sample_nas","assets_nas","names_nas","tickers_nas","header_sample_nasdaq"] );

[R_nas_m, ~] = fetchReturnsAndNames( ...
    ["sample_returns_nas_monthly","R_nas_monthly","sample_returns_nasdaq_monthly","R_nasdaq_monthly"], ...
    ["header_sample_nas","assets_nas","names_nas","tickers_nas","header_sample_nasdaq"] );

% ----------------------------
% Fetch MV weights already computed 
% ----------------------------
w_MV_nyse_daily   = fetchVector(["w_p_nyse_daily","w_nyse_daily","wMV_nyse_daily","w_mvp_nyse_daily"]);
w_MV_nyse_monthly = fetchVector(["w_p_nyse_monthly","w_nyse_monthly","wMV_nyse_monthly","w_mvp_nyse_monthly"]);
w_MV_nas_daily    = fetchVector(["w_p_nas_daily","w_nas_daily","wMV_nas_daily","w_mvp_nas_daily","w_p_nasdaq_daily"]);
w_MV_nas_monthly  = fetchVector(["w_p_nas_monthly","w_nas_monthly","wMV_nas_monthly","w_mvp_nas_monthly","w_p_nasdaq_monthly"]);

% ----------------------------
% Tau choice (data-driven): tau = 1/T
% ----------------------------
tau_nyse_d = 1/size(R_nyse_d,1);
tau_nyse_m = 1/size(R_nyse_m,1);
tau_nas_d  = 1/size(R_nas_d,1);
tau_nas_m  = 1/size(R_nas_m,1);

% ----------------------------
% Benchmark "ideal allocation" for prior: equal-weight
% (Assumption: no market-cap weights available; EW is neutral baseline)
% ----------------------------
w_mkt_nyse = ones(size(R_nyse_d,2),1) / size(R_nyse_d,2);
w_mkt_nas  = ones(size(R_nas_d,2),1)  / size(R_nas_d,2);

%% ============================================================
% ES20 - NYSE DAILY
%% ============================================================
[stats_nyse_daily, views_nyse_daily, table_weights_nyse_daily, w_BL_nyse_daily] = ...
    runBlackLittermanCase(R_nyse_d, assetNames_nyse, w_mkt_nyse, w_MV_nyse_daily, rf_daily, tau_nyse_d, "NYSE_DAILY");

%% ============================================================
% ES20 - NYSE MONTHLY
%% ============================================================
[stats_nyse_monthly, views_nyse_monthly, table_weights_nyse_monthly, w_BL_nyse_monthly] = ...
    runBlackLittermanCase(R_nyse_m, assetNames_nyse, w_mkt_nyse, w_MV_nyse_monthly, rf_monthly, tau_nyse_m, "NYSE_MONTHLY");

%% ============================================================
% ES21 - NASDAQ DAILY
%% ============================================================
[stats_nas_daily, views_nas_daily, table_weights_nas_daily, w_BL_nas_daily] = ...
    runBlackLittermanCase(R_nas_d, assetNames_nas, w_mkt_nas, w_MV_nas_daily, rf_daily, tau_nas_d, "NASDAQ_DAILY");

%% ============================================================
% ES21 - NASDAQ MONTHLY
%% ============================================================
[stats_nas_monthly, views_nas_monthly, table_weights_nas_monthly, w_BL_nas_monthly] = ...
    runBlackLittermanCase(R_nas_m, assetNames_nas, w_mkt_nas, w_MV_nas_monthly, rf_monthly, tau_nas_m, "NASDAQ_MONTHLY");

%% ----------------------------
% FINAL SUMMARY 
% ----------------------------
stats_all = [stats_nyse_daily; stats_nyse_monthly; stats_nas_daily; stats_nas_monthly];
disp(stats_all);

disp(views_nyse_daily);
disp(views_nyse_monthly);
disp(views_nas_daily);
disp(views_nas_monthly);

%% ============================================================
% LOCAL FUNCTIONS 
%% ============================================================

function [R, names] = fetchReturnsAndNames(returnsCandidates, namesCandidates)
    % returnsCandidates: string array of possible return variable names
    % namesCandidates: string array of possible names variable names
    R = [];
    names = [];

    % --- find returns
    for v = returnsCandidates
        if evalin('base', "exist('" + v + "','var')")
            R = evalin('base', v);
            break;
        end
    end
    if isempty(R)
        error("Non trovo i rendimenti. Cercavo una di queste variabili: %s", join(returnsCandidates,", "));
    end

    % Ensure numeric matrix
    if istable(R) || istimetable(R)
        R = table2array(R);
    end
    if ~isnumeric(R)
        error("La variabile rendimenti trovata non è numerica (matrix/table convertibile). Controlla il formato.");
    end

    % --- find names
    for n = namesCandidates
        if evalin('base', "exist('" + n + "','var')")
            names = evalin('base', n);
            break;
        end
    end

    % If no names found, create placeholder names
    if isempty(names)
        k = size(R,2);
        names = arrayfun(@(i) "Asset" + i, (1:k)', 'UniformOutput', false);
    end

    % Normalize to cellstr column
    if isstring(names)
        names = cellstr(names);
    end
    if ischar(names)
        names = cellstr(string(names));
    end
    names = names(:);
end

function w = fetchVector(candidates)
    w = [];
    for v = candidates
        if evalin('base', "exist('" + v + "','var')")
            w = evalin('base', v);
            break;
        end
    end
    if isempty(w)
        error("Non trovo i pesi MV standard. Cercavo una di queste variabili: %s", join(candidates,", "));
    end
    if istable(w) || istimetable(w); w = table2array(w); end
    w = w(:);
end

function [statsTable, viewsTable, table_weights, w_BL] = runBlackLittermanCase(R, assetNames, w_mkt, w_MV, rf, tau, label)
    % --- moments
    Sigma = cov(R);
    r_mkt = R * w_mkt;

    delta = (mean(r_mkt) - rf) / var(r_mkt); % risk aversion
    PI = delta * Sigma * w_mkt;              % equilibrium returns

    % --- choose assets for views (first 6 for reproducibility)
    n = size(R,2);
    if n < 6
        error("Servono almeno 6 asset per costruire 4 views (2 assolute + 2 relative). Ne ho trovati %d.", n);
    end
    i1=1; i2=2; i3=3; i4=4; i5=5; i6=6;

    mu_hist = mean(R)';

    % --- set views magnitude depending on frequency (label contains DAILY/MONTHLY)
    isMonthly = contains(string(label),"MONTHLY");

    if ~isMonthly
        % DAILY views (order of magnitude: 1e-4)
        q1 = mu_hist(i1) + 0.0004;
        q2 = mu_hist(i2) + 0.0002;
        q3 = 0.00015;
        q4 = 0.00010;
    else
        % MONTHLY views (order of magnitude: 1e-3 to 1e-2)
        q1 = mu_hist(i1) + 0.0080;
        q2 = mu_hist(i2) + 0.0040;
        q3 = 0.0030;
        q4 = 0.0020;
    end

    Q = [q1; q2; q3; q4];

    P = zeros(4, n);
    P(1,i1) = 1;
    P(2,i2) = 1;
    P(3,i3) = 1;  P(3,i4) = -1;
    P(4,i5) = 1;  P(4,i6) = -1;

    % --- confidence levels (assumption)
    conf = [0.60; 0.55; 0.60; 0.55];

    Omega = makeOmegaFromConfidence(P, Sigma, tau, conf);

    [mu_bl, Sigma_bl] = blackLittermanPosterior(Sigma, PI, tau, P, Q, Omega);

    % --- BL portfolio: max Sharpe ratio (same criterion as MV comparison)
    portBL = Portfolio('AssetList', assetNames, 'RiskFreeRate', rf);
    portBL = setAssetMoments(portBL, mu_bl, Sigma_bl);
    portBL = setDefaultConstraints(portBL);
    w_BL = estimateMaxSharpeRatio(portBL);

    % --- realized returns and statistics
    rp_MV = R * w_MV(:);
    rp_BL = R * w_BL(:);

    statsTable = makePortfolioStatsTable(rp_MV, rp_BL, rf, label);
    viewsTable = makeViewsTable(assetNames, [i1 i2 i3 i4 i5 i6], Q, conf, label);

    table_weights = table(assetNames(:), w_MV(:), w_BL(:), ...
        'VariableNames', ["Asset","w_MV_MaxSharpe","w_BL_MaxSharpe"]);

    % --- Plot weights comparison
    figure('Name',char(label) + " - Weights MV vs BL");
    bar([w_MV(:), w_BL(:)]);
    grid on;
    title(char(label) + ": Weights comparison (MV vs Black-Litterman)");
    xlabel('Assets'); ylabel('Weight');
    legend('MV','BL','Location','best');
end

function Omega = makeOmegaFromConfidence(P, Sigma, tau, conf)
    % Omega = diag(P*(tau*Sigma)*P') .* (1-conf)/conf
    base = diag(P * (tau*Sigma) * P');  % Kx1
    scale = (1-conf)./conf;            % Kx1
    Omega = diag(base .* scale);
end

function [mu_bl, Sigma_bl] = blackLittermanPosterior(Sigma, PI, tau, P, Q, Omega)
    C = tau * Sigma;

    invC = inv(C);
    invOmega = inv(Omega);

    A = invC + P' * invOmega * P;
    b = invC * PI + P' * invOmega * Q;

    Sigma_mu_bl = inv(A);
    mu_bl = Sigma_mu_bl * b;

    Sigma_bl = Sigma + Sigma_mu_bl;
end

function statsTable = makePortfolioStatsTable(rp_MV, rp_BL, rf, label)
    mean_MV = mean(rp_MV);
    var_MV  = var(rp_MV);
    std_MV  = std(rp_MV);
    skew_MV = skewness(rp_MV);
    kurt_MV = kurtosis(rp_MV);
    sharpe_MV = (mean_MV - rf) / std_MV;

    mean_BL = mean(rp_BL);
    var_BL  = var(rp_BL);
    std_BL  = std(rp_BL);
    skew_BL = skewness(rp_BL);
    kurt_BL = kurtosis(rp_BL);
    sharpe_BL = (mean_BL - rf) / std_BL;

    statsTable = table(string(label), ...
        mean_MV, var_MV, std_MV, skew_MV, kurt_MV, sharpe_MV, ...
        mean_BL, var_BL, std_BL, skew_BL, kurt_BL, sharpe_BL, ...
        'VariableNames', ["Case", ...
        "Mean_MV","Var_MV","Std_MV","Skew_MV","Kurt_MV","Sharpe_MV", ...
        "Mean_BL","Var_BL","Std_BL","Skew_BL","Kurt_BL","Sharpe_BL"]);
end

function viewsTable = makeViewsTable(assetNames, idx, Q, conf, label)
    i1=idx(1); i2=idx(2); i3=idx(3); i4=idx(4); i5=idx(5); i6=idx(6);

    viewType = ["Absolute"; "Absolute"; "Relative"; "Relative"];

    viewText = strings(4,1);
    viewText(1) = "E[r(" + string(assetNames{i1}) + ")] = Q1";
    viewText(2) = "E[r(" + string(assetNames{i2}) + ")] = Q2";
    viewText(3) = "E[r(" + string(assetNames{i3}) + ") - r(" + string(assetNames{i4}) + ")] = Q3";
    viewText(4) = "E[r(" + string(assetNames{i5}) + ") - r(" + string(assetNames{i6}) + ")] = Q4";

    viewsTable = table(repmat(string(label),4,1), (1:4)', viewType, viewText, Q, conf, ...
        'VariableNames', ["Case","ViewID","Type","Description","Q","Confidence"]);
end

%% ============================================================
% Exercise 22: BAYESIAN ASSET ALLOCATION (Conjugate NIW prior)
% - Prior mean: mu0 = mean(R) + 1*std(R)  (element-wise)
% - Prior covariance scale: Psi0 = 2 * cov(R)
% - Compute posterior (mu_post, Sigma_post)
% - Build Bayesian portfolio (max Sharpe)
% - Compute portfolio stats and compare with MV and BL
% Do for DAILY and MONTHLY, NYSE and NASDAQ
%% ============================================================

% Risk-free 
rf_daily   = 0.02/252;
rf_monthly = 0.02/12;


% ===== NYSE DAILY =====
[w_bayes_nyse_daily, stats_nyse_daily_22] = runBayesianCase( ...
    R_nyse_d, assetNames_nyse, rf_daily, "NYSE_DAILY", ...
    w_MV_nyse_daily, w_BL_nyse_daily);

% ===== NYSE MONTHLY =====
[w_bayes_nyse_monthly, stats_nyse_monthly_22] = runBayesianCase( ...
    R_nyse_m, assetNames_nyse, rf_monthly, "NYSE_MONTHLY", ...
    w_MV_nyse_monthly, w_BL_nyse_monthly);

% ===== NASDAQ DAILY =====
[w_bayes_nas_daily, stats_nas_daily_22] = runBayesianCase( ...
    R_nas_d, assetNames_nas, rf_daily, "NASDAQ_DAILY", ...
    w_MV_nas_daily, w_BL_nas_daily);

% ===== NASDAQ MONTHLY =====
[w_bayes_nas_monthly, stats_nas_monthly_22] = runBayesianCase( ...
    R_nas_m, assetNames_nas, rf_monthly, "NASDAQ_MONTHLY", ...
    w_MV_nas_monthly, w_BL_nas_monthly);

% --- Summary table (MV vs BL vs Bayesian)
stats_bayes_all = [stats_nyse_daily_22; stats_nyse_monthly_22; stats_nas_daily_22; stats_nas_monthly_22];
disp("=== EX22: Summary (MV vs BL vs Bayesian) ===");
disp(stats_bayes_all);
%% ============================================================
% Weights comparison plot (MV vs BL vs Bayesian)
% We show DAILY only to keep the report concise
%% ============================================================

% --- NYSE DAILY weights comparison
figure('Name','EX22 - NYSE DAILY Weights: MV vs BL vs Bayesian');
bar([w_MV_nyse_daily(:), w_BL_nyse_daily(:), w_bayes_nyse_daily(:)]);
grid on;
title('EX22 - NYSE DAILY: Weights comparison (MV vs BL vs Bayesian)');
xlabel('Assets'); ylabel('Weight');
legend('MV','BL','Bayesian','Location','best');

if exist('assetNames_nyse','var') && numel(assetNames_nyse) <= 15
    set(gca,'XTick',1:numel(assetNames_nyse),'XTickLabel',assetNames_nyse);
    xtickangle(45);
end

% --- NASDAQ DAILY weights comparison
figure('Name','EX22 - NASDAQ DAILY Weights: MV vs BL vs Bayesian');
bar([w_MV_nas_daily(:), w_BL_nas_daily(:), w_bayes_nas_daily(:)]);
grid on;
title('EX22 - NASDAQ DAILY: Weights comparison (MV vs BL vs Bayesian)');
xlabel('Assets'); ylabel('Weight');
legend('MV','BL','Bayesian','Location','best');

if exist('assetNames_nas','var') && numel(assetNames_nas) <= 15
    set(gca,'XTick',1:numel(assetNames_nas),'XTickLabel',assetNames_nas);
    xtickangle(45);
end
% --- NYSE MONTHLY weights comparison
figure('Name','EX22 - NYSE MONTHLY Weights: MV vs BL vs Bayesian');
bar([w_MV_nyse_monthly(:), w_BL_nyse_monthly(:), w_bayes_nyse_monthly(:)]);
grid on;
title('EX22 - NYSE MONTHLY: Weights comparison (MV vs BL vs Bayesian)');
xlabel('Assets'); ylabel('Weight');
legend('MV','BL','Bayesian','Location','best');

% --- NASDAQ MONTHLY weights comparison
figure('Name','EX22 - NASDAQ MONTHLY Weights: MV vs BL vs Bayesian');
bar([w_MV_nas_monthly(:), w_BL_nas_monthly(:), w_bayes_nas_monthly(:)]);
grid on;
title('EX22 - NASDAQ MONTHLY: Weights comparison (MV vs BL vs Bayesian)');
xlabel('Assets'); ylabel('Weight');
legend('MV','BL','Bayesian','Location','best');


%% ============================================================
% LOCAL FUNCTIONS 
%% ============================================================

function [w_bayes, outTable] = runBayesianCase(R, assetNames, rf, label, w_MV, w_BL)
    % ----- 1) Compute sample moments
    [T, N] = size(R);
    rbar = mean(R)';          % Nx1
    svec = std(R)';           % Nx1
    S = cov(R);               % NxN sample covariance

    % ----- 2) Set conjugate prior NIW parameters
    mu0  = rbar + 1*svec;     % Nx1 (element-wise)
    kappa0 = 1;               % prior strength on mean (assumption)
    Psi0 = 2 * S;             % prior scale matrix for IW (assignment)
    nu0  = N + 2;             % df > N+1 to have finite mean (assumption)

    % ----- 3) Posterior NIW update
    % NIW posterior:
    % kappa_n = kappa0 + T
    % nu_n    = nu0 + T
    % mu_n    = (kappa0*mu0 + T*rbar) / (kappa0 + T)
    % Psi_n   = Psi0 + (T-1)*S + (kappa0*T/(kappa0+T))*(rbar-mu0)(rbar-mu0)'
    kappa_n = kappa0 + T;
    nu_n    = nu0 + T;
    mu_n    = (kappa0*mu0 + T*rbar) / kappa_n;

    diff = (rbar - mu0);
    Psi_n = Psi0 + (T-1)*S + (kappa0*T/kappa_n) * (diff * diff');

    % Posterior expected covariance: E[Sigma | data] = Psi_n / (nu_n - N - 1)
    Sigma_post = Psi_n / (nu_n - N - 1);

    % Posterior expected mean: E[mu | data] = mu_n
    mu_post = mu_n;

    % ----- 4) Build Bayesian portfolio (same criterion: max Sharpe)
    portBayes = Portfolio('AssetList', assetNames, 'RiskFreeRate', rf);
    portBayes = setAssetMoments(portBayes, mu_post, Sigma_post);
    portBayes = setDefaultConstraints(portBayes);
    w_bayes = estimateMaxSharpeRatio(portBayes);

    % ----- 5) Realized returns for MV / BL / Bayesian
    rp_MV    = R * w_MV(:);
    rp_BL    = R * w_BL(:);
    rp_Bayes = R * w_bayes(:);

    % ----- 6) Stats
    outTable = make3wayStatsTable(rp_MV, rp_BL, rp_Bayes, rf, label);

    % weights table printed 
    % weightsTbl = table(assetNames(:), w_MV(:), w_BL(:), w_bayes(:), ...
    %     'VariableNames', ["Asset","w_MV","w_BL","w_Bayes"]);
    % disp(weightsTbl);

end

function tbl = make3wayStatsTable(rp_MV, rp_BL, rp_Bayes, rf, label)

    [m1,v1,s1,sk1,ku1,sh1] = oneStats(rp_MV, rf);
    [m2,v2,s2,sk2,ku2,sh2] = oneStats(rp_BL, rf);
    [m3,v3,s3,sk3,ku3,sh3] = oneStats(rp_Bayes, rf);

    tbl = table(string(label), ...
        m1,v1,s1,sk1,ku1,sh1, ...
        m2,v2,s2,sk2,ku2,sh2, ...
        m3,v3,s3,sk3,ku3,sh3, ...
        'VariableNames', ["Case", ...
        "Mean_MV","Var_MV","Std_MV","Skew_MV","Kurt_MV","Sharpe_MV", ...
        "Mean_BL","Var_BL","Std_BL","Skew_BL","Kurt_BL","Sharpe_BL", ...
        "Mean_Bayes","Var_Bayes","Std_Bayes","Skew_Bayes","Kurt_Bayes","Sharpe_Bayes"]);
end

function [m,v,s,sk,ku,sh] = oneStats(rp, rf)
    m  = mean(rp);
    v  = var(rp);
    s  = std(rp);
    sk = skewness(rp);
    ku = kurtosis(rp);
    sh = (m - rf) / s;
end

%% ============================================================
% Eercises 23-24: Global Minimum Variance Portfolio (GMVP)
% EX23: NYSE (daily + monthly)
% EX24: NASDAQ (daily + monthly)
% ============================================================

% Risk-free (coherent with frequency)
rf_daily   = 0.02/252;
rf_monthly = 0.02/12;

R_nyse_d = fetchMatrix(["sample_returns_nyse_daily","R_nyse_daily"]);
R_nyse_m = fetchMatrix(["sample_returns_nyse_monthly","R_nyse_monthly"]);
R_nas_d  = fetchMatrix(["sample_returns_nas_daily","R_nas_daily","sample_returns_nasdaq_daily","R_nasdaq_daily"]);
R_nas_m  = fetchMatrix(["sample_returns_nas_monthly","R_nas_monthly","sample_returns_nasdaq_monthly","R_nasdaq_monthly"]);

% Asset names (for weight tables)
names_nyse = fetchNames(["header_sample_nyse","header_sample_nyse_daily","assets_nyse","names_nyse","tickers_nyse"], size(R_nyse_d,2));
names_nas  = fetchNames(["header_sample_nas","header_sample_nas_daily","assets_nas","names_nas","tickers_nas","header_sample_nasdaq"], size(R_nas_d,2));

% Portfolio objects already built in previous exercises (mean-variance)
p_nyse_daily   = fetchPortfolioObj(["p_nyse_daily","port_nyse_daily"]);
p_nyse_monthly = fetchPortfolioObj(["p_nyse_monthly","port_nyse_monthly"]);
p_nas_daily    = fetchPortfolioObj(["p_nas_daily","port_nas_daily","p_nasdaq_daily"]);
p_nas_monthly  = fetchPortfolioObj(["p_nas_monthly","port_nas_monthly","p_nasdaq_monthly"]);

%% ----------------------------
% EX23: NYSE GMVP (daily + monthly)
%% ----------------------------
[w_gmvp_nyse_daily,   stats_gmvp_nyse_daily]   = runGMVPcase(p_nyse_daily,   R_nyse_d, rf_daily,   "NYSE_DAILY");
[w_gmvp_nyse_monthly, stats_gmvp_nyse_monthly] = runGMVPcase(p_nyse_monthly, R_nyse_m, rf_monthly, "NYSE_MONTHLY");

table_weights_gmvp_nyse_daily   = array2table(w_gmvp_nyse_daily(:)',   'VariableNames', names_nyse);
table_weights_gmvp_nyse_monthly = array2table(w_gmvp_nyse_monthly(:)', 'VariableNames', names_nyse);

%% ----------------------------
% EX24: NASDAQ GMVP (daily + monthly)
%% ----------------------------
[w_gmvp_nas_daily,   stats_gmvp_nas_daily]   = runGMVPcase(p_nas_daily,   R_nas_d, rf_daily,   "NASDAQ_DAILY");
[w_gmvp_nas_monthly, stats_gmvp_nas_monthly] = runGMVPcase(p_nas_monthly, R_nas_m, rf_monthly, "NASDAQ_MONTHLY");

table_weights_gmvp_nas_daily   = array2table(w_gmvp_nas_daily(:)',   'VariableNames', names_nas);
table_weights_gmvp_nas_monthly = array2table(w_gmvp_nas_monthly(:)', 'VariableNames', names_nas);

%% ----------------------------
% Display outputs 
%% ----------------------------
disp("=== EX23: NYSE GMVP stats (daily) ===");   disp(stats_gmvp_nyse_daily);
disp("=== EX23: NYSE GMVP weights (daily) ==="); disp(table_weights_gmvp_nyse_daily);

disp("=== EX23: NYSE GMVP stats (monthly) ===");   disp(stats_gmvp_nyse_monthly);
disp("=== EX23: NYSE GMVP weights (monthly) ==="); disp(table_weights_gmvp_nyse_monthly);

disp("=== EX24: NASDAQ GMVP stats (daily) ===");   disp(stats_gmvp_nas_daily);
disp("=== EX24: NASDAQ GMVP weights (daily) ==="); disp(table_weights_gmvp_nas_daily);

disp("=== EX24: NASDAQ GMVP stats (monthly) ===");   disp(stats_gmvp_nas_monthly);
disp("=== EX24: NASDAQ GMVP weights (monthly) ==="); disp(table_weights_gmvp_nas_monthly);

% Summary table  
stats_gmvp_all = [stats_gmvp_nyse_daily; stats_gmvp_nyse_monthly; stats_gmvp_nas_daily; stats_gmvp_nas_monthly];
disp("=== EX23-EX24: GMVP Summary (all cases) ===");
disp(stats_gmvp_all);

%% ============================================================
% LOCAL FUNCTIONS
%% ============================================================

function [w_gmvp, statsTbl] = runGMVPcase(pObj, R, rf, label)
    % GMVP weights
    % Works with Portfolio object from Financial Toolbox
    w_gmvp = estimateFrontierLimits(pObj, 'min');   % Nx1

    % realized portfolio returns
    rp = R * w_gmvp(:);

    % stats
    m  = mean(rp,'omitnan');
    v  = var(rp,'omitnan');
    s  = std(rp,'omitnan');
    sk = skewness(rp);
    ku = kurtosis(rp);
    sh = (m - rf) / s;

    statsTbl = table(string(label), m, v, s, sk, ku, sh, ...
        'VariableNames', ["Case","Mean_GMVP","Var_GMVP","Std_GMVP","Skew_GMVP","Kurt_GMVP","Sharpe_GMVP"]);
end

function X = fetchMatrix(candidates)
    X = [];
    for v = candidates
        if evalin('base', "exist('" + v + "','var')")
            X = evalin('base', v);
            break;
        end
    end
    if isempty(X)
        error("Non trovo la matrice rendimenti. Cercavo: %s", join(candidates,", "));
    end
    if istable(X) || istimetable(X)
        X = table2array(X);
    end
    X = double(X);
end

function names = fetchNames(candidates, N)
    names = [];
    for v = candidates
        if evalin('base', "exist('" + v + "','var')")
            names = evalin('base', v);
            break;
        end
    end
    if isempty(names)
        names = arrayfun(@(i) "Asset"+i, (1:N)', 'UniformOutput', false);
    end
    if isstring(names); names = cellstr(names); end
    names = names(:)';
    if numel(names) ~= N
        % fallback if mismatch
        names = arrayfun(@(i) "Asset"+i, (1:N)', 'UniformOutput', false);
        names = names(:)';
    end
end

function pObj = fetchPortfolioObj(candidates)
    pObj = [];
    for v = candidates
        if evalin('base', "exist('" + v + "','var')")
            pObj = evalin('base', v);
            break;
        end
    end
    if isempty(pObj)
        error("Non trovo l'oggetto Portfolio per GMVP. Cercavo: %s", join(candidates,", "));
    end
end

%% ============================================================
% EX25: Combine portfolios (MV, BL, Bayesian, GMVP) and discuss
% 25% each. Compute stats and Sharpe, NYSE and NASDAQ,
% daily and monthly.
%% ============================================================

rf_daily   = 0.02/252;
rf_monthly = 0.02/12;

%% ------------------------------------------------------------
% 0) PICK RETURNS MATRICES 
%% ------------------------------------------------------------
% NYSE daily
if exist('R_nyse_daily','var');          R_nyse_d = R_nyse_daily;
elseif exist('sample_returns_nyse_daily','var'); R_nyse_d = sample_returns_nyse_daily;
elseif exist('R_nyse_d','var');          R_nyse_d = R_nyse_d;
else
    error("EX25: NYSE daily returns not found. Expected R_nyse_daily or sample_returns_nyse_daily.");
end

% NYSE monthly
if exist('R_nyse_monthly','var');          R_nyse_m = R_nyse_monthly;
elseif exist('sample_returns_nyse_monthly','var'); R_nyse_m = sample_returns_nyse_monthly;
elseif exist('R_nyse_m','var');            R_nyse_m = R_nyse_m;
else
    error("EX25: NYSE monthly returns not found. Expected R_nyse_monthly or sample_returns_nyse_monthly.");
end

% NASDAQ daily
if exist('R_nas_daily','var');             R_nas_d = R_nas_daily;
elseif exist('sample_returns_nas_daily','var');    R_nas_d = sample_returns_nas_daily;
elseif exist('sample_returns_nasdaq_daily','var'); R_nas_d = sample_returns_nasdaq_daily;
elseif exist('R_nas_d','var');             R_nas_d = R_nas_d;
else
    error("EX25: NASDAQ daily returns not found. Expected R_nas_daily or sample_returns_nas_daily.");
end

% NASDAQ monthly
if exist('R_nas_monthly','var');              R_nas_m = R_nas_monthly;
elseif exist('sample_returns_nas_monthly','var'); R_nas_m = sample_returns_nas_monthly;
elseif exist('sample_returns_nasdaq_monthly','var'); R_nas_m = sample_returns_nasdaq_monthly;
elseif exist('R_nas_m','var');                R_nas_m = R_nas_m;
else
    error("EX25: NASDAQ monthly returns not found. Expected R_nas_monthly or sample_returns_nas_monthly.");
end

% convert tables/timetables to arrays 
if istable(R_nyse_d) || istimetable(R_nyse_d); R_nyse_d = table2array(R_nyse_d); end
if istable(R_nyse_m) || istimetable(R_nyse_m); R_nyse_m = table2array(R_nyse_m); end
if istable(R_nas_d)  || istimetable(R_nas_d);  R_nas_d  = table2array(R_nas_d);  end
if istable(R_nas_m)  || istimetable(R_nas_m);  R_nas_m  = table2array(R_nas_m);  end

R_nyse_d = double(R_nyse_d); R_nyse_m = double(R_nyse_m);
R_nas_d  = double(R_nas_d);  R_nas_m  = double(R_nas_m);

%% ------------------------------------------------------------
% 1) ASSET NAMES 
%% ------------------------------------------------------------

if exist('assetNames_nyse','var'); names_nyse = assetNames_nyse;
elseif exist('tickers_nyse','var'); names_nyse = tickers_nyse;
else
    names_nyse = arrayfun(@(i) "Asset"+i, 1:size(R_nyse_d,2), 'UniformOutput', false);
end

if exist('assetNames_nas','var'); names_nas = assetNames_nas;
elseif exist('tickers_nas','var'); names_nas = tickers_nas;
else
    names_nas = arrayfun(@(i) "Asset"+i, 1:size(R_nas_d,2), 'UniformOutput', false);
end

if isstring(names_nyse); names_nyse = cellstr(names_nyse); end
if isstring(names_nas);  names_nas  = cellstr(names_nas);  end
names_nyse = names_nyse(:)'; 
names_nas  = names_nas(:)';

%% ------------------------------------------------------------
% 2) COMBINATION WEIGHTS (25% each)
%% ------------------------------------------------------------
alpha25 = struct('MV',0.25,'BL',0.25,'Bayes',0.25,'GMVP',0.25);

%% ------------------------------------------------------------
% 3) RUN CASES 
%% ------------------------------------------------------------

[w_comb_nyse_daily, stats25_nyse_daily, tblW_nyse_daily] = runCombineCase25( ...
    "NYSE_DAILY", R_nyse_d, rf_daily, names_nyse, ...
    w_MV_nyse_daily, w_BL_nyse_daily, w_bayes_nyse_daily, w_gmvp_nyse_daily, alpha25);

[w_comb_nyse_monthly, stats25_nyse_monthly, tblW_nyse_monthly] = runCombineCase25( ...
    "NYSE_MONTHLY", R_nyse_m, rf_monthly, names_nyse, ...
    w_MV_nyse_monthly, w_BL_nyse_monthly, w_bayes_nyse_monthly, w_gmvp_nyse_monthly, alpha25);

[w_comb_nas_daily, stats25_nas_daily, tblW_nas_daily] = runCombineCase25( ...
    "NASDAQ_DAILY", R_nas_d, rf_daily, names_nas, ...
    w_MV_nas_daily, w_BL_nas_daily, w_bayes_nas_daily, w_gmvp_nas_daily, alpha25);

[w_comb_nas_monthly, stats25_nas_monthly, tblW_nas_monthly] = runCombineCase25( ...
    "NASDAQ_MONTHLY", R_nas_m, rf_monthly, names_nas, ...
    w_MV_nas_monthly, w_BL_nas_monthly, w_bayes_nas_monthly, w_gmvp_nas_monthly, alpha25);

%% ------------------------------------------------------------
% 4) OUTPUT 
%% ------------------------------------------------------------
disp("=== EX25: Combined portfolio weights (NYSE daily) ===");   disp(tblW_nyse_daily);
disp("=== EX25: Combined portfolio weights (NASDAQ daily) ==="); disp(tblW_nas_daily);

stats25_all = [stats25_nyse_daily; stats25_nyse_monthly; stats25_nas_daily; stats25_nas_monthly];
disp("=== EX25: Summary stats (MV vs BL vs Bayes vs GMVP vs Combined) ===");
disp(stats25_all);

table_EX25_combined = table( ...
    stats25_all{:,1}, ...
    stats25_all.Mean_Comb, stats25_all.Var_Comb, stats25_all.Std_Comb, ...
    stats25_all.Skew_Comb, stats25_all.Kurt_Comb, stats25_all.Sharpe_Comb, ...
    'VariableNames', {'Case','Mean','Variance','Std','Skewness','Kurtosis','Sharpe'} );

disp("=== EX25: Combined portfolio – final statistics ===");
disp(table_EX25_combined);

Table25_NYSE   = table_EX25_combined(contains(string(table_EX25_combined.Case),"NYSE"), :);
Table25_NASDAQ = table_EX25_combined(contains(string(table_EX25_combined.Case),"NASDAQ"), :);

disp("=== Table 25a: Combined portfolio stats (NYSE) ===");   disp(Table25_NYSE);
disp("=== Table 25b: Combined portfolio stats (NASDAQ) ==="); disp(Table25_NASDAQ);

%% ------------------------------------------------------------
% 5) OPTIONAL PLOTS 
%% ------------------------------------------------------------
figure('Name','EX25 - NYSE DAILY Weights (MV/BL/Bayes/GMVP/Combined)');
bar([w_MV_nyse_daily(:), w_BL_nyse_daily(:), w_bayes_nyse_daily(:), w_gmvp_nyse_daily(:), w_comb_nyse_daily(:)]);
grid on; title('EX25 - NYSE DAILY: Weights comparison');
xlabel('Assets'); ylabel('Weight'); legend('MV','BL','Bayes','GMVP','Combined','Location','best');

figure('Name','EX25 - NASDAQ DAILY Weights (MV/BL/Bayes/GMVP/Combined)');
bar([w_MV_nas_daily(:), w_BL_nas_daily(:), w_bayes_nas_daily(:), w_gmvp_nas_daily(:), w_comb_nas_daily(:)]);
grid on; title('EX25 - NASDAQ DAILY: Weights comparison');
xlabel('Assets'); ylabel('Weight'); legend('MV','BL','Bayes','GMVP','Combined','Location','best');

%% ============================================================
% LOCAL FUNCTION 
%% ============================================================
function [w_comb, statsRow, tblW] = runCombineCase25(label, R, rf, assetNames, wMV, wBL, wBayes, wGMVP, alpha25)

    wMV    = wMV(:); 
    wBL    = wBL(:);
    wBayes = wBayes(:);
    wGMVP  = wGMVP(:);

    % Combine weights
    w_comb = alpha25.MV*wMV + alpha25.BL*wBL + alpha25.Bayes*wBayes + alpha25.GMVP*wGMVP;

    % Normalize
    w_comb = w_comb / sum(w_comb);

    % Portfolio returns
    rpMV    = R * wMV;
    rpBL    = R * wBL;
    rpBayes = R * wBayes;
    rpGMVP  = R * wGMVP;
    rpComb  = R * w_comb;

    % Stats helper
    S_MV    = oneStats25(rpMV, rf);
    S_BL    = oneStats25(rpBL, rf);
    S_Bayes = oneStats25(rpBayes, rf);
    S_GMVP  = oneStats25(rpGMVP, rf);
    S_Comb  = oneStats25(rpComb, rf);

    statsRow = table(string(label), ...
        S_MV.mean, S_MV.var, S_MV.std, S_MV.skew, S_MV.kurt, S_MV.sharpe, ...
        S_BL.mean, S_BL.var, S_BL.std, S_BL.skew, S_BL.kurt, S_BL.sharpe, ...
        S_Bayes.mean, S_Bayes.var, S_Bayes.std, S_Bayes.skew, S_Bayes.kurt, S_Bayes.sharpe, ...
        S_GMVP.mean, S_GMVP.var, S_GMVP.std, S_GMVP.skew, S_GMVP.kurt, S_GMVP.sharpe, ...
        S_Comb.mean, S_Comb.var, S_Comb.std, S_Comb.skew, S_Comb.kurt, S_Comb.sharpe, ...
        'VariableNames', ["Case", ...
        "Mean_MV","Var_MV","Std_MV","Skew_MV","Kurt_MV","Sharpe_MV", ...
        "Mean_BL","Var_BL","Std_BL","Skew_BL","Kurt_BL","Sharpe_BL", ...
        "Mean_Bayes","Var_Bayes","Std_Bayes","Skew_Bayes","Kurt_Bayes","Sharpe_Bayes", ...
        "Mean_GMVP","Var_GMVP","Std_GMVP","Skew_GMVP","Kurt_GMVP","Sharpe_GMVP", ...
        "Mean_Comb","Var_Comb","Std_Comb","Skew_Comb","Kurt_Comb","Sharpe_Comb"]);

    % Weights table (combined)
    try
        tblW = array2table(w_comb(:)', 'VariableNames', assetNames);
    catch
        tblW = array2table(w_comb(:)');
    end
end

function S = oneStats25(rp, rf)
    S.mean   = mean(rp,'omitnan');
    S.var    = var(rp,'omitnan');
    S.std    = std(rp,'omitnan');
    S.skew   = skewness(rp);
    S.kurt   = kurtosis(rp);
    S.sharpe = (S.mean - rf) / S.std;
end
