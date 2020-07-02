% Calculates hourly NCP in moles of O2 per cubic metre
NCP = mooring_data.ncp_O2_molm3hr;

NCP_qc = max(var_names_qc_values,[],1)';

% The following are assigned, depending on the value of exchange_choice
% 2. Bubble_injected_oxygen	% hourly timeseries of bubble injected oxygen in moles per cubic metre
% 3. Entrained_oxygen		% hourly timeseries of entrained oxygen (from below MLD) in moles per cubic metre
% 4. Eddy_diff_oxygen       % hourly timeseries of eddy diffused oxygen (from below MLD) in moles per cubic metre
% 5. Gas_exchange_oxygen    % hourly timeseries of oxygen exchanged into water from atmosphere in moles per cubic metre

if exchange_choice == 1
    
    Gas_exchange_oxygen = mooring_data.dox2_gas_exchange_molm2./mooring_data.mld_smooth;

    Bubble_injected_oxygen = mooring_data.dox2_bubbles_molm2./mooring_data.mld_smooth;
    
end
    
if exchange_choice == 2

    Eddy_diff_oxygen = mooring_data.dox2_eddy_diffusion_molm2./mooring_data.mld_smooth;
    
end
    
if exchange_choice == 3    
    
    Entrained_oxygen = mooring_data.dox2_entrainment_molm2./mooring_data.mld_smooth;

end

to_clear = {'var_names','var_names_check_qc','var_names_qc_values','constants','dim','end_good','i','qc_change_idx','qc_limit','start_good','str'};

clear(to_clear{:})

clear('to_clear')






