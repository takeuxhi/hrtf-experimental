clc; clear all; close all;
%%
%frequency matrix
fn = 0:1:24000; %frequency (hz)
w = 2*pi*fn;    %frequency (rad)

f0 = 84.8;  %resonant frequency
Qms = 2.55; %mechanical Q
Qes = 0.66; %electromagnetic Q 
Q = 0.53;   %total Q
BL = 3.18;  %BL product
m = 4.3e-3; %diaphragm mass
Vas = 0.00142;   %Compliance equivalent volume
A_d = 35.3e-4;   %cone surface area
Z_a = 4;    %nominal impedance
a = 2*25.4/1000; %driver radius

%impedances
R_m = 2*pi*f0*m./Q; 
Cm = 0.83e-3;
Z_moc = R_m + 1i*(w*m - 1./(w*Cm)); %mechanical impedance
R_e = 3;     %DC resistance
L_e = 0.28e-3;  %voice coil inductance
Z_e = R_e;
Z_eq = Z_a + Z_e + BL^2./(Z_moc);
Z_eq_mech = Z_moc + BL^2./(Z_a+Z_e);

figure(101)
semilogx(fn,real(Z_eq))
figure(102)
semilogx(fn,imag(Z_eq))
figure(103)
plot(real(Z_eq),imag(Z_eq))

%air and sound constants
rho = 1.21; %air density
c = 343;    %speed of sound
k = w/c;    %wave number

% box
V_box = 0.008;
C_box = V_box/(rho*c^2);
R_box = 10/A_d^2;
Z_box = - 1i*1./(w*C_box);

% radiation
R_rad = rho*c/A_d*(k*a).^2/2;
X_rad = rho*c/A_d*(k*a)*(8/3/pi);
Z_rad = R_rad + 1i*X_rad;
F = BL./(Z_a + Z_e);

v = F./(Z_eq_mech + Z_rad*(A_d^2) + Z_box*A_d^2);
PI_rad = 0.5*(R_rad*(A_d^2)).*v.^2;

figure(1)
semilogx(fn,10*log10(abs(PI_rad)/max(abs(PI_rad))),'LineWidth',2)
ylim([-15 5])
xlim([20 20000])


% %port
% A_p = A_d/4;
% L_port = 0.08;
% R_port = 5/A_d^2;
% m_port = rho*L_port/A_p;
% Z_port = R_port + 1i*w*m_port;
% 
% R_rad_port = rho*c/A_p*(k*a/2).^2/2;
% X_rad_port = rho*c/A_p*(k*a/2)*(8/3/pi);
% Z_rad_port = R_rad_port + 1i*X_rad_port;
% 
% Z_port_eq = 1./(1./(Z_port*A_d.^2 + Z_rad_port.*A_d^2) + 1./(Z_box*A_d^2));
% v_p = F./(Z_e+Z_moc+Z_rad*A_d^2+Z_port_eq);
% PI_radp = 0.5*(R_rad*(A_d^2)).*v_p.^2;
% semilogx(fn,log10(abs(PI_rad)/max(abs(PI_rad))),'LineWidth',2)
% hold on
% title('Simulated Frequency Response of Speaker with Enclosure')
% legend('No Port, Fully Sealed','2-Inch Dia Port')
% xlabel('Frequency (Hz)')
% ylabel('Sound Pressure Level (dB)')