% We calculate schmidt numbers for water of salinity=35 and temperatures 
% range -2-40C (Wanninkhof 14)
mooring_data.Sc_N2_W14 = constants.Sc_A_N2_W14 + constants.Sc_B_N2_W14*mooring_data.temp_C + constants.Sc_C_N2_W14*(mooring_data.temp_C.^2) + constants.Sc_D_N2_W14*(mooring_data.temp_C.^3) + constants.Sc_E_N2_W14*(mooring_data.temp_C.^4);

mooring_data.Sc_O2_W14 = constants.Sc_A_O2_W14 - constants.Sc_B_O2_W14*mooring_data.temp_C + constants.Sc_C_O2_W14*(mooring_data.temp_C.^2) - constants.Sc_D_O2_W14*(mooring_data.temp_C.^3) + constants.Sc_E_O2_W14*(mooring_data.temp_C.^4);

% We assign the Schmidt values
mooring_data.Sc_N2 = mooring_data.Sc_N2_W14;

mooring_data.Sc_O2 = mooring_data.Sc_O2_W14;

% We scale up the windspeed using the log layer relationship
mooring_data.U_10 = 1.1*mooring_data.windspeed_ms;

% We calculate the gas transfer velocity using Wanninkhof 2014
mooring_data.Gc_O2_cmhr = (0.22*(mooring_data.U_10.^2) + 0.33.*mooring_data.U_10);

mooring_data.Gc_N2_cmhr = mooring_data.Gc_O2_cmhr;

