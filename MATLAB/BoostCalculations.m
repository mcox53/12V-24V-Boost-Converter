clear
clc

% Modify parameters before running script
Vinmin = 11;
Vinnom = 13.3;
Vinmax = 14;
Vout = 24;
IOmax = 1.5;
Vrip = .09;
Irip = .2;
fsw = 70000;
Vdfw = 0.7;
Rload = 16;

% Estimated Efficiency
eff = .7;

D = 1 - ((Vinmin * eff)/Vout);

% Maximum switch current
Iswmax = (Irip/2) + (IOmax/(1-D));

% Estimation of inductor from app note

L_est = (Vinnom * (Vout - Vinnom))/(Irip * fsw * Vout);
L_min = (D*((1-D)^2)*Rload)/(2*fsw);

% Power rating of diode

Pdiode = IOmax * Vdfw;

% Output capacitor selection

Coutmin = (IOmax * D)/(fsw * Vrip);




