% Plots the data contained in mooring_data
%% Grouped plots

% Produces a plot of temperature and salinity
figure('units','normalized','outerposition',[0 0 1 1])
subplot(2,2,1)
yyaxis left
plot(mooring_data.time,mooring_data.temp_C)
ylabel('Temp °C')
yyaxis right
plot(mooring_data.time,mooring_data.psal_PSU)
ylabel(' Salinity PSU')
xlim([mooring_data.time(1) mooring_data.time(end)])
datetick(gca,'KeepLimits')
title('Temperature and salinity')
grid on

% Produces a plot of measured oxygen and oxygen solubility
subplot(2,2,2)
yyaxis left
plot(mooring_data.time,mooring_data.dox2_umolkg)
ylabel('Measured O2 umol/kg')
yyaxis right
plot(mooring_data.time,mooring_data.dox2_sol_umolkg)
title('Oxygen')
ylabel('O2 solubility umol/kg')
xlim([mooring_data.time(1) mooring_data.time(end)])
datetick(gca,'KeepLimits')
grid on

% Produces a plot of gas tension and water density
subplot(2,2,3)
yyaxis left
plot(mooring_data.time,mooring_data.gastension_Pa)
ylabel('Gas tension Pa')
yyaxis right
plot(mooring_data.time,mooring_data.density_kgm3)
title('Gas tension and density')
ylabel('Density kg/m3')
xlim([mooring_data.time(1) mooring_data.time(end)])
datetick(gca,'KeepLimits')
grid on

% Produces a plot of mixed layer depth and windspeed
subplot(2,2,4)
yyaxis left
plot(mooring_data.time,mooring_data.mld_m)
ylabel('Mixed layer depth m')
yyaxis right
plot(mooring_data.time,mooring_data.windspeed_ms)
title('Mixed layer depth and windspeed')
ylabel('10m windspeed m/s')
xlim([mooring_data.time(1) mooring_data.time(end)])
datetick(gca,'KeepLimits')
grid on


%% Old automatic plot, not grouped
% % Collects variable names from the mooring data
% var_names_to_plot = fieldnames(mooring_data);
% 
% % Removes qc variables
% var_names_to_plot = var_names_to_plot(~contains(var_names_to_plot,'qc'));
% 
% % Removes time variable
% var_names_to_plot = var_names_to_plot(~contains(var_names_to_plot,'time'));

% % Plot each variable, colouring by qc value when available
% for i = 1:length(var_names_to_plot)
%     
%     if any(contains(fieldnames(mooring_data),strcat(var_names_to_plot{i},'_qc')))
%         figure
%         scatter(mooring_data.time,mooring_data.(var_names_to_plot{i}),10,mooring_data.(strcat(var_names_to_plot{i},'_qc')))
%         c = lines(9);
%         colormap(c);
%         colorbar
%         title(var_names_to_plot{i})
%         
%     else
%         figure
%         scatter(mooring_data.time,mooring_data.(var_names_to_plot{i}),10)
%         c = lines(9); 
%         title(var_names_to_plot{i})
%     end
% 
% end

