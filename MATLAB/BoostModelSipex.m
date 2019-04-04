% Boost Model translated to standard part values

clear
clc

s = tf('s');

% The following transfer function represents the 
% small signal variations in output voltage in terms 
% of small signal variations in duty cycle for a 
% given input voltage. Duty cycle with a capital D
% is the duty cycle for 24V output with an ideal boost 
% converter calculated previousy 

Vin = 18;
fsw = 70000;
D = .5333;

% This model takes into account ESR of both the inductor
% as well as the capacitor

% Change these values once parts are selected
Rout = 24;
Cout = 2.2e-4;
CoutESR = .18;
L = .0012;
L_ESR = .232;

Gdo = Vin/((1-D)^2);

wz1 = 1/(CoutESR * Cout);
wz2 = (((1-D)^2) * (Rout-L_ESR))/(L);
wo = ((1)/(sqrt(L*Cout)))* sqrt((L_ESR + ((1-D)^2)*Rout)/(Rout));
Q = (wo)/((L_ESR/L)+(1/(Cout*(Rout+CoutESR))));

tf = Gdo * ((1+(s/wz1))*(1-(s/wz2)))/(1+(s/(wo*Q))+((s^2)/(wo^2)));

%% Type III Compensator

% From voltage divider
R1 = 118000;

% Choose first capacitor value arbitrarily
% First pole should be placed as close to origin
% as possible to form integrator
C1 = 3.74e-10;

% Compensator zeros are placed around the resonsant
% frequency spike of the LC filter

% Arbitrarily selected resonant boundaries used to
% solve for capacitor and resistor values

wresleft = 100;
wresright = 1000;

R2 = 127000;

% Second pole goes at ESR zero frequency of power stage
% Need to either pick R3 or C2 here since only two zeros
% Another option is to pick half the switching frequency
C2 = 7.257e-9;

% Now have enough info to get R3 from other resonant boundary

R3 = 313;

% Third pole goes at right hand plane zero frequency

wrhpzero = 1.068e3;

C3 = 1e-12;

% Assert R3 is positive

wp0 = 1/(R1*C1);
wp1 = 1/(R3*C2);
wp2 = 1/(R2*C3);
wz3 = 1/((R1+R3)*C2);
wz4 = 1/(R2*C1);

comp = (wp0 * (1+(s/wz1))*(1+(s/wz2)))/(s*(1+(s/wp1))*(1+(s/wp2)));

bode(comp)
