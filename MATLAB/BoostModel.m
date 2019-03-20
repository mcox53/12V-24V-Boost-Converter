clear
clc

s = tf('s');

% The following transfer function represents the 
% small signal variations in output voltage in terms 
% of small signal variations in duty cycle for a 
% given input voltage. Duty cycle with a capital D
% is the duty cycle for 24V output with an ideal boost 
% converter calculated previousy 

Vin = 13.3;
D = .7677;

% This model takes into account ESR of both the inductor
% as well as the capacitor

% Change these values once parts are selected
Rout = 24;
Cout = 4.7e-6;
CoutESR = 2e-3;
L = 3.3e-6;
L_ESR = 2.3e-3;

Gdo = Vin/((1-D)^2);

wz1 = 1/(CoutESR * Cout);
wz2 = (((1-D)^2) * (Rout-L_ESR))/(L);
wo = ((1)/(sqrt(L*Cout)))* sqrt((L_ESR + ((1-D)^2)*Rout)/(Rout));
Q = (wo)/((L_ESR/L)+(1/(Cout*(Rout+CoutESR))));

tf = Gdo * ((1+(s/wz1))*(1-(s/wz2)))/(1+(s/(wo*Q))+((s^2)/(wo^2)));

