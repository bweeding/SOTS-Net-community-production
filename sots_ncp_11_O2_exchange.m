% Here we calculate a theoretical 'physical' oxygen record - beginning with
% the first timestamp's measured O2 value, and calculating how we believe
% the O2 would change over time, without any biology being present. For
% this calculation we ignore any entrainment effects.

% We preallocate zero arrays used in the for loop

[mooring_data.GE_dox2_phys_no_ent_molm3, mooring_data.dox2_phys_gas_exchange_no_ent_molm3, mooring_data.dox2_phys_bubbles_no_ent_molm3, mooring_data.dox2_phys_no_ent_molm3] = deal(zeros(size(mooring_data.time)));

% We create a vector representing the physical oxygen record without
% entrainment, and set its first value to the first measured oxygen value.
% The physical records here are labelled with no_ent, as neither eddy diffusion
% nor entrainment across the mixed layer have been taken into account.

mooring_data.dox2_phys_no_ent_molm3 = zeros(size(mooring_data.dox2_umolkg));

mooring_data.dox2_phys_no_ent_molm3(1) = mooring_data.dox2_molm3(1);



for i = 2:length(mooring_data.time)
    
    % We calculate the rate of gas exchange in the previous time stamp, as
    % seen in the final equations of section 8, but now using the
    % theoretical physical oxygen record.
    
    mooring_data.GE_dox2_phys_no_ent_molm3(i-1) = (mooring_data.Gc_O2_ms(i-1)*((mooring_data.Sc_O2(i-1)/600).^(-0.5)).*(mooring_data.dox2_phys_no_ent_molm3(i-1) - mooring_data.dox2_sol_molm3(i-1)));
    
    % We calculate the effect of the above calculated gas exchange in the
    % current time stamp (the multiplication by 3600 here account for the
    % fact that the rates are per second, and the time stamps are an hour
    % long).
    
    mooring_data.dox2_phys_gas_exchange_no_ent_molm3(i) = (3600/mooring_data.mld_smooth(i))*(-mooring_data.GE_dox2_phys_no_ent_molm3(i-1));
    
    % We calculate the effect of bubble injection in the current time
    % stamp, using the calculated Vinj and bubble_beta.
    
    mooring_data.dox2_phys_bubbles_no_ent_molm3(i) = 3600/mooring_data.mld_smooth(i)*mooring_data.Vinj(i-1)*constants.mole_fraction_O2*(1+1/bubble_beta);
    
    
    % For each time stamp, we add the calculated contributions to calculate
    % the theoretical physical oxygen record, without entrainment.
    
    mooring_data.dox2_phys_no_ent_molm3(i) = mooring_data.dox2_phys_no_ent_molm3(i-1) + mooring_data.dox2_phys_bubbles_no_ent_molm3(i) + mooring_data.dox2_phys_gas_exchange_no_ent_molm3(i);
    
end

% We convert the timeseries from mol per cubic metre to micromoles per kilogram
mooring_data.dox2_phys_no_ent_umkg = (mooring_data.dox2_phys_no_ent_molm3*1E6)./(mooring_data.density_kgm3);
