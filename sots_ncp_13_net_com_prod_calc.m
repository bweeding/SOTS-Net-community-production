% Here net community production is estimated, first in micromoles of Oxygen
% per m^2 per hour, then in milligrams of Carbon per m^2 per hour. These
% can then be summed over the entire time series using cumsum().


% O2 records are differentiated wrt time, depending on which exchange_choice
% has been set
mooring_data.ddox2_dt_umkg = diff(mooring_data.dox2_umolkg);

mooring_data.ddox2_dt_molm3 = diff(mooring_data.dox2_molm3);

if exchange_choice==1
    mooring_data.ddox2_phys_dt_umkg = diff(mooring_data.dox2_phys_no_ent_umkg);
    
elseif exchange_choice==2
    mooring_data.ddox2_phys_dt_umkg = diff(mooring_data.dox2_phys_ent_umkg);  
    
elseif exchange_choice==3
    mooring_data.ddox2_phys_dt_umkg = diff(mooring_data.dox2_phys_ent_umkg); 
    
elseif exchange_choice==4
    % Space for heat budget based MLD calculations
    
end

 
% The rate of change of biological oxygen is calculated, by subtracting the
% calculated physical rate of change from the measured rate of change.
 
mooring_data.ddox2bio_dt_umkg = mooring_data.ddox2_dt_umkg - mooring_data.ddox2_phys_dt_umkg; 
 
% The final value is set to nan, as we are unable to calculate it.
 
mooring_data.ddox2bio_dt_umkg(end+1) = nan; 
 
% The above process is repeated but in moles m^3
if exchange_choice==1
    mooring_data.ddox2phys_dt_molm3 = diff(mooring_data.dox2_phys_no_ent_molm3);
    
elseif exchange_choice==2 
    mooring_data.ddox2phys_dt_molm3 = diff(mooring_data.dox2_phys_ent_molm3);
    
elseif exchange_choice==3
    mooring_data.ddox2phys_dt_molm3 = diff(mooring_data.dox2_phys_ent_molm3);
    
elseif exchange_choice==4
    % Space for heat budget based MLD calculations
end

mooring_data.ddox2bio_dt_molm3 = mooring_data.ddox2_dt_molm3 - mooring_data.ddox2phys_dt_molm3;

% The final value is set to nan, as we are unable to calculate it.

mooring_data.ddox2bio_dt_molm3(end+1) = nan;
 
% The NCP is calculated in micromoles of O2 per m^2 per hour, by
% multiplying the calculated rate per cubic metre by the mixed layer depth
% and density, for each time stamp.

mooring_data.ncp_O2_umm2hr = mooring_data.ddox2bio_dt_molm3.*mooring_data.mld_smooth*1E6;
 
% This is converted into milligrams of carbon per m^2 per hour, dividing
% by 1E6 and a default Redfield ratio of 1.45 (Anderson and Sarmiento, 1994), 
% and multiplying by the molar mass of Carbon, and 1000.
 
mooring_data.ncp_C_mgm2hr = mooring_data.ncp_O2_umm2hr/((1E6)*constants.ncp_oxygen2carbon)*constants.atomic_mass_C*1000;


% The NCP estimates are cummulatively summed to arrive at cummulative time
% series, with the total NCP for the timeseries being the final value of
% each vector

mooring_data.ncp_C_mgm2_cumsum = cumsum(mooring_data.ncp_C_mgm2hr,'omitnan');

mooring_data.ncp_O2_umm2_cumsum = cumsum(mooring_data.ncp_O2_umm2hr,'omitnan');
