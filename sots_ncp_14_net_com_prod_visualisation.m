figure('units','normalized','outerposition',[0 0 1 1])

% Plots cummulative net community production
subplot(3,1,1)
plot(mooring_data.time,mooring_data.ncp_O2_umm2_cumsum/1E6,'LineWidth',2)
title('Net Community Production')
grid on
dim = [.81 .66 .1 .1];
str = strcat('NCP total:',compose("%5.1f",mooring_data.ncp_O2_umm2_cumsum(end)/1E6),'mol of O2');
annotation('textbox',dim,'String',str,'FitBoxToText','on');
xlim([mooring_data.time(1) mooring_data.time(end)]);
datetick('x','mmm','KeepLimits');
ylabel('mol of O2')
set(gca,'Fontsize',12)

% Plots smoothed mixed layer depth
subplot(3,1,2)
ylabel('m')
plot(mooring_data.time,mooring_data.mld_smooth,'LineWidth',2)
title('Mixed Layer Depth (smoothed)')
xlim([mooring_data.time(1) mooring_data.time(end)]);
datetick('x','mmm','KeepLimits');
set(gca,'YDir','reverse')
grid on
set(gca,'Fontsize',12)

subplot(3,1,3)

% Plots measured oxygen, oxygen solubility, and calculated physical oxygen
if exchange_choice==1
    
    set(gca,'Fontsize',12)
    hold on
    plot(mooring_data.time,mooring_data.dox2_molm3,'LineWidth',2)
    plot(mooring_data.time,mooring_data.dox2_sol_molm3,'LineWidth',2)
    plot(mooring_data.time,mooring_data.dox2_phys_no_ent_molm3,'LineWidth',2)
    title('Oxygen record (atmoshperhic exchange only)')
    legend('Measured','Solubility','Physical model')
    ylabel('O2 (mol/m^3)')
    xlim([mooring_data.time(1) mooring_data.time(end)])
    datetick('x','mmm','KeepLimits');
    grid on

elseif exchange_choice==2
    
    set(gca,'Fontsize',12)
    hold on
    plot(mooring_data.time,mooring_data.dox2_molm3,'LineWidth',2)
    plot(mooring_data.time,mooring_data.dox2_sol_molm3,'LineWidth',2)
    plot(mooring_data.time,mooring_data.dox2_phys_ent_molm3,'LineWidth',2)
    title('Oxygen record (atmoshperhic and eddy exchange)')
    legend('Measured','Solubility','Physical model')
    ylabel('O2 (mol/m^3)')
    xlim([mooring_data.time(1) mooring_data.time(end)])
    datetick('x','mmm','KeepLimits');
    grid on
    
    
elseif exchange_choice==3
    
        set(gca,'Fontsize',12)
    hold on
    plot(mooring_data.time,mooring_data.dox2_molm3,'LineWidth',2)
    plot(mooring_data.time,mooring_data.dox2_sol_molm3,'LineWidth',2)
    plot(mooring_data.time,mooring_data.dox2_phys_ent_molm3,'LineWidth',2)
    title('Oxygen record (atmoshperhic, eddy, and entrainment exchange)')
    legend('Measured','Solubility','Physical model')
    ylabel('O2 (mol/m^3)')
    xlim([mooring_data.time(1) mooring_data.time(end)])
    datetick('x','mmm','KeepLimits');
    grid on
    
elseif exchange_choice==4
    
end








