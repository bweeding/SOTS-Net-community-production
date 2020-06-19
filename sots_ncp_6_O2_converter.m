% Calculates oxygen saturation and concentration

%%

% If a timeseries of atmospheric pressure is not available in mooring_data, 
% we use the user defined steady choice

if ~isfield(mooring_data,'atmosphericpress_Pa') || atmospheric_pressure_manual_override
   
    mooring_data.atmosphericpress_Pa = (constants.atm_in_Pa*atmospheric_pressure_choice) * ones(size(mooring_data.time));
    
    disp(['Atmospheric pressure: Constant user choice of ',num2str(atmospheric_pressure_choice),'atm used.'])
    
else
    
    disp(strcat('Atmospheric pressure: Timeseries available from mooring used'))
    
end

% Calculate oxygen saturation
mooring_data.dox2_sat = mooring_data.dox2_umolkg./(mooring_data.dox2_sol_umolkg.*(mooring_data.atmosphericpress_Pa/constants.atm_in_Pa));

mooring_data.dox2_sat_qc = max(mooring_data.dox2_umolkg_qc,mooring_data.dox2_sol_umolkg_qc);

% Calculate measured oxygen in moles per cubic metre
mooring_data.dox2_molm3 = mooring_data.density_kgm3.*mooring_data.dox2_umolkg.*(10^-6);

mooring_data.dox2_molm3_qc = max(mooring_data.density_kgm3,mooring_data.dox2_umolkg);

% Calculate solubility in moles per cubic metre

mooring_data.dox2_sol_molm3 = mooring_data.density_kgm3.*mooring_data.dox2_sol_umolkg.*(10^-6);

mooring_data.dox2_sol_molm3_qc = max(mooring_data.density_kgm3,mooring_data.dox2_sol_umolkg);