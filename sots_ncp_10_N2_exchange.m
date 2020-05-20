% Calculate required Air-Sea N2 exchange to match N2 record

%%
% We convert the gas transfer velocity into metres per second.
mooring_data.Gc_O2_ms = mooring_data.Gc_O2_cmhr./(100*3600);

mooring_data.Gc_N2_ms = mooring_data.Gc_N2_cmhr./(100*3600);

% If a timeseries of atmospheric pressure is not available in mooring_data, 
% we use the user defined steady choice

if ~isfield(mooring_data,'atmosphericpress_Pa')
   
    mooring_data.atmosphericpress_Pa = (101325*atmospheric_pressure_choice) * ones(size(mooring_data.time));
    
end
 
% We use Gc to calculate the rate of exchange of gas between atmosphere and
% water in moles per m^2 per s, as described in Emerson et al. 2008, eqns 4
% and 5.

mooring_data.GE_N2 = mooring_data.Gc_N2_ms.*((mooring_data.Sc_N2/600).^(-0.5)).*(mooring_data.N2_molm3 - (mooring_data.atmosphericpress_Pa/101325).*mooring_data.N2sol_molm3);
    
% In order to estiamte gas injections due to bubbles, we need to estimate
% molecular diffusion, using Ferrell and Himmelblau (1967).


mooring_data.MDiff_O2 = (constants.Ac_O2*exp(-constants.Ea_O2./(0.0083144621*(mooring_data.temp_C+273.15))))*(10^-5).*(1 - 0.049*mooring_data.psal_PSU/35.5); % in cm^2 per s

mooring_data.MDiff_N2 = (constants.Ac_N2*exp(-constants.Ea_N2./(0.0083144621*(mooring_data.temp_C+273.15))))*(10^-5).*(1 - 0.049*mooring_data.psal_PSU/35.5); % in cm^2 per s


% We smooth the mixed layer depth time series, differentiate wrt time, and
% set times of decreasing depth to 0, for the purpose of calculating
% entrainment, as we are only interested when the MLDP deepens, bringing
% oxygen into the layer. 

mooring_data.mld_smooth = smooth(mooring_data.mld_m,mld_smooth_span);

mooring_data.mld_diff = diff(mooring_data.mld_smooth);

mooring_data.mld_increasing = find(mooring_data.mld_diff<=0);

mooring_data.mld_diff(mooring_data.mld_increasing) = 0;

% We preallocate zero arrays used in the for loop

[mooring_data.N2_gas_ex_molm3, mooring_data.N2_bubbles_molm3, mooring_data.Vinj] = deal(zeros(size(mooring_data.time)));

for i = 2:length(mooring_data.time)
    
    % We calculate the N2 gas exchange from the previous time stamp using
    % the calculate gas exchange rate from that time stamp, and the MLDP of
    % the current time stamp (as we are calculating the gas that will have
    % exchanged in the previous time stamp into the current time stamp).
    
    mooring_data.N2_gas_ex_molm3(i-1) = -3600*mooring_data.GE_N2(i-1)/mooring_data.mld_smooth(i);
    
    % We subtract the calculated gas exchange from the measured change, to
    % determine the remainder, which we attribute to bubbles.
    
    mooring_data.N2_bubbles_molm3(i-1) = mooring_data.N2_molm3(i) - mooring_data.N2_molm3(i-1) - mooring_data.N2_gas_ex_molm3(i-1);
    
    % We rearrange eqn 9 from Emerson et al. 2008 to solve for Vinj
    
    mooring_data.Vinj(i-1) = mooring_data.N2_bubbles_molm3(i-1)/(3600*constants.mole_fraction_N2*(1+(1/bubble_beta)*((mooring_data.MDiff_N2(i-1)/mooring_data.MDiff_O2(i-1))^(0.5))*(mooring_data.N2sol_umkg(i-1)/mooring_data.dox2_sol_umolkg(i-1)))/mooring_data.mld_smooth(i)); 
    
end

% We set the final timestamps value for Vinj to the previous value, as we
% have no way of calculating it

mooring_data.Vinj(length(mooring_data.time)) = mooring_data.Vinj(length(mooring_data.time)-1);







