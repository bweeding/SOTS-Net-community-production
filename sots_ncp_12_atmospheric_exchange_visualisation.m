% Plots the atmospheric gas exchange data
%% Grouped plots

% No entrainment or eddy diffusion
if exchange_choice==1
    figure('units','normalized','outerposition',[0 0 1 1])
    
    % Plots calculated nitrogen and nitrogen solubility
    subplot(2,2,1)
    set(gca,'Fontsize',12)
    hold on
    plot(mooring_data.time,mooring_data.N2_molm3)
    ylim([0.49 0.535])
    ylabel('N2 (mol/m^3)')
    title('Nitrogen record')
    plot(mooring_data.time,mooring_data.N2sol_molm3)
    legend('Measured','Solubility')
    xlim([mooring_data.time(1) mooring_data.time(end)])
    datetick('x','mmm','KeepLimits');
    grid on

    % Plots nitrogen exchange
    subplot(2,2,3)
    hold on
    set(gca,'Fontsize',12)
    plot(mooring_data.time,cumsum(mooring_data.N2_bubbles_molm3))
    plot(mooring_data.time,cumsum(mooring_data.N2_gas_ex_molm3))
    legend('Bubbles','Air-sea gas exchange')
    ylabel('Cummulative N2 (mol/m^3)')
    title('Measured Nitrogen record components')
    xlim([mooring_data.time(1) mooring_data.time(end)])
    datetick('x','mmm','KeepLimits');
    grid on

    % Plots measured oxygen, solubility, and calculated physical oxygen
    subplot(2,2,2)
    set(gca,'Fontsize',12)
    hold on
    plot(mooring_data.time,mooring_data.dox2_molm3)
    plot(mooring_data.time,mooring_data.dox2_sol_molm3)
    plot(mooring_data.time,mooring_data.dox2_phys_no_ent_molm3)
    legend('Measured','Solubility','Physical model')
    title('Oxygen record (Atmospheric exchange only)')
    ylabel('O2 (mol/m^3)')
    xlim([mooring_data.time(1) mooring_data.time(end)])
    datetick('x','mmm','KeepLimits');
    grid on

    % Plots oxygen exchange
    subplot(2,2,4)
    hold on
    set(gca,'Fontsize',12)
    plot(mooring_data.time,cumsum(mooring_data.dox2_phys_bubbles_no_ent_molm3))
    plot(mooring_data.time,cumsum(mooring_data.dox2_phys_gas_exchange_no_ent_molm3))
    legend('Bubbles','Air-sea gas exchange')
    ylabel('Cummulative O2 no entrainment (mol/m^3)')
    title('Physical Oxygen record components')
    xlim([mooring_data.time(1) mooring_data.time(end)])
    datetick('x','mmm','KeepLimits');
    grid on
    
% Eddy diffusion no entrainment    
elseif exchange_choice==2
    
    figure('units','normalized','outerposition',[0 0 1 1])
    
    % Plots calculated nitrogen and nitrogen solubility
    subplot(2,2,1)
    set(gca,'Fontsize',12)
    hold on
    plot(mooring_data.time,mooring_data.N2_molm3)
    ylim([0.49 0.535])
    ylabel('N2 (mol/m^3)')
    plot(mooring_data.time,mooring_data.N2sol_molm3)
    legend('Measured','Solubility')
    title('Nitrogen record')
    xlim([mooring_data.time(1) mooring_data.time(end)])
    datetick('x','mmm','KeepLimits');
    grid on
    
    % Plots nitrogen exchange
    subplot(2,2,3)
    hold on
    set(gca,'Fontsize',12)
    plot(mooring_data.time,cumsum(mooring_data.N2_bubbles_molm3))
    plot(mooring_data.time,cumsum(mooring_data.N2_gas_ex_molm3))
    legend('Bubbles','Air-sea gas exchange')
    ylabel('Cummulative N2 (mol/m^3)')
    title('Measured Nitrogen record components')
    xlim([mooring_data.time(1) mooring_data.time(end)])
    datetick('x','mmm','KeepLimits');
    grid on

    % Plots measured oxygen, solubility, and calculated physical oxygen
    subplot(2,2,2)
    set(gca,'Fontsize',12)
    hold on
    plot(mooring_data.time,mooring_data.dox2_molm3)
    plot(mooring_data.time,mooring_data.dox2_sol_molm3)
    plot(mooring_data.time,mooring_data.dox2_phys_ent_molm3)
    plot(mooring_data.time,mooring_data.sub_mld_dox2_molm3)
    legend('Measured','Solubility','Physical model','Sub MLD')
    ylabel('O2 (mol/m^3)')
    title('Oxygen record (Atmospheric and eddy exchange)')
    xlim([mooring_data.time(1) mooring_data.time(end)])
    datetick('x','mmm','KeepLimits');
    grid on

    % Plots oxygen exchange
    subplot(2,2,4)
    hold on
    set(gca,'Fontsize',12)
    plot(mooring_data.time,cumsum(mooring_data.dox2_phys_bubbles_ent_molm3))
    plot(mooring_data.time,cumsum(mooring_data.dox2_phys_gas_exchange_ent_molm3))
    plot(mooring_data.time,cumsum(mooring_data.dox2_phys_eddy_diffusion_ent_molm3))
    legend('Bubbles','Air-sea gas exchange','Eddy diffusion')
    ylabel('Cummulative O2 (mol/m^3)')
    title('Physical Oxygen record components')
    xlim([mooring_data.time(1) mooring_data.time(end)])
    datetick('x','mmm','KeepLimits');
    grid on
    
% Eddy diffusion and entrainment from MLD record    
elseif exchange_choice==3
    
    figure('units','normalized','outerposition',[0 0 1 1])
    
    % Plots calculated nitrogen and nitrogen solubility
    subplot(2,2,1)
    set(gca,'Fontsize',12)
    hold on
    plot(mooring_data.time,mooring_data.N2_molm3)
    ylim([0.49 0.535])
    ylabel('N2 (mol/m^3)')
    plot(mooring_data.time,mooring_data.N2sol_molm3)
    legend('Measured','Solubility')
    title('Nitrogen record')
    xlim([mooring_data.time(1) mooring_data.time(end)])
    datetick('x','mmm','KeepLimits');
    grid on

    % Plots nitrogen exchange
    subplot(2,2,3)
    hold on
    set(gca,'Fontsize',12)
    plot(mooring_data.time,cumsum(mooring_data.N2_bubbles_molm3))
    plot(mooring_data.time,cumsum(mooring_data.N2_gas_ex_molm3))
    legend('Bubbles','Air-sea gas exchange')
    ylabel('Cummulative N2 (mol/m^3)')
    title('Measured Nitrogen record components')
    xlim([mooring_data.time(1) mooring_data.time(end)])
    datetick('x','mmm','KeepLimits');
    grid on

    % Plots measured oxygen, solubility, and calculated physical oxygen
    subplot(2,2,2)
    set(gca,'Fontsize',12)
    hold on
    plot(mooring_data.time,mooring_data.dox2_molm3)
    plot(mooring_data.time,mooring_data.dox2_sol_molm3)
    plot(mooring_data.time,mooring_data.dox2_phys_ent_molm3)
    plot(mooring_data.time,mooring_data.sub_mld_dox2_molm3)
    legend('Measured','Solubility','Physical model','Sub MLD')
    ylabel('O2 (mol/m^3)')
    title('Oxygen record (Atmospheric, eddy and entrainment exchange)')
    xlim([mooring_data.time(1) mooring_data.time(end)])
    datetick('x','mmm','KeepLimits');
    grid on

    % Plots oxygen exchange
    subplot(2,2,4)
    hold on
    set(gca,'Fontsize',12)
    plot(mooring_data.time,cumsum(mooring_data.dox2_phys_bubbles_ent_molm3))
    plot(mooring_data.time,cumsum(mooring_data.dox2_phys_gas_exchange_ent_molm3))
    plot(mooring_data.time,cumsum(mooring_data.dox2_phys_eddy_diffusion_ent_molm3))
    plot(mooring_data.time,cumsum(mooring_data.dox2_phys_entrainment_ent_molm3))
    legend('Bubbles','Air-sea gas exchange','Eddy diffusion','Entrainment')
    ylabel('Cummulative O2 (mol/m^3)')
    title('Physical Oxygen record components')
    xlim([mooring_data.time(1) mooring_data.time(end)])
    datetick('x','mmm','KeepLimits');
    grid on
    
elseif exchange_choice==4
    
end
