% Modify parameters before running script
Vinmin = 8;
Vinnom = 13.3;
Vinmax = 14;
Vout = 24;
IOmax = 1.5;
Vrip = .09;
Irip = .04;
fsw = 30000;
Vdfw = 0.7;

% Estimated Efficiency
eff = .7;

D = 1 - ((Vinmin * eff)/Vout);

% Maximum switch current
Iswmax = (Irip/2) + (IOmax/(1-D));

% Estimation of inductor from app note

L_est = (Vinnom * (Vout - Vinnom))/(Irip * fsw * Vout);

% Power rating of diode

Pdiode = IOmax * Vdfw;

% Output capacitor selection

Coutmin = (IOmax * D)/(fsw * Vrip);




