%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% AERODYNAMICS LABORATORY %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% CLEARING WORKSPACE AND CONSOLE
clear; clc;

%% LOADING AMBIENT VARIABLES
altitude = 3050; %[m]
ambient.rho = getRhoISA(altitude);
ambient.mu = 1.519e-3; 
ambient.T = getTemperatureISA(altitude);

%% LOADING AIRCRAFT VARIABLES
aircraft.S= 41; %[m^2]
aircraft.b = 20.27; %[m]
aircraft.Cr = 2.6; %[m]
aircraft.mass = 8000; %[Kg]
aircraft.W = aircraft.mass * 9.8; %[N]
aircraft.cruiseSpeed = 300*1000/3600; %[m/s]
aircraft.AR = 10; %Aspec Ratio
aircraft.altitude = altitude; %[m]
aircraft.Cl = (2*aircraft.W)/(ambient.rho*aircraft.cruiseSpeed^2*aircraft.S);

aircraft.Re = (ambient.rho/ambient.mu)*aircraft.cruiseSpeed*aircraft.b;

%% SOLVING  Ct 
L_span = 0:0.01:11.26; %Span of L
%L_span = 0:0.01:aircraft.b/2;
Ct_span = getCt(aircraft.S, aircraft.b, aircraft.Cr, L_span); %Get the chord for that point
theta_span = 0:0.01:pi; %Span of theta

%% COMPUTING CHORD DISTRIBUTION
chord_span = getChord(aircraft.b, L_span, theta_span, Ct_span, aircraft.Cr);

%% DEFINING SOME EXTRA PARAMETERS AND EQUATIONS
A1 = getA1(aircraft.W, ambient.rho, aircraft.cruiseSpeed, aircraft.S, aircraft.AR); %A1 Coefficient
dCl = 2*pi; %Because of thin airfoil theory
a = (4*aircraft.b)/dCl; %Just to make equation more easier
alfa_0 = deg2rad(-0.2); %Convert data XFLR5 to radians

N = 100; %Resolution of the allocation method

[delta_plot, aircraft.Cd_plot, x] = solveSystemDelta(L_span, theta_span, chord_span, a, A1, alfa_0, aircraft.Cl, aircraft.AR, N);

figure() %Plotting the results
plot(Ct_span, delta_plot, 'Linewidth', 2);
title('\delta vs C_{t}');
xlabel('C_{t}')
ylabel('\delta')
hold on
plot(0.7658, 0.0080, 'ro');

pos = 752; %This is the position of the minimum length in the Ct_span vector

%% POLAR PLOTS BETWEEN MATLAB AND XFLR5

%Fixed values
%L = 7.46;
L = L_span(pos);
Ct = 0.7658;

N = 101;
x = solveSystemCl(aircraft.b, L, theta_span, Ct, aircraft.Cr, a, alfa_0, N);
delta = 0;

for n = 2:(N-1)
    delta = delta + n*((x(n+1))/x(2))^2;
end
    
Cd = 0:0.001:0.06;
    
for n_Cd = 1:length(Cd)
    Cl(n_Cd)=sqrt(Cd(n_Cd)*aircraft.AR*pi/(1+delta));
end


data_1 = load('ClCdXflr5.txt');

Cd_XFRL5 = data_1(:,1);
Cl_XFLR5 = data_1(:,2);


figure()
plot(Cd, Cl, 'b', 'Linewidth', 2);
title('POLAR PLOT: C_{l} vs C_{d}')
xlabel('C_{d}')
ylabel('C_{l}')
hold on
plot(Cd_XFRL5, Cl_XFLR5, 'r', 'Linewidth', 2);
legend('Matlab', 'XFLR5');

%% AoA AS FUNCTION OF Uinf

Uinf = 50:0.1:aircraft.cruiseSpeed;
N = 50;

AoA = solveAoA(aircraft.b, L, theta_span, Ct, aircraft.Cr, Uinf, alfa_0, a, aircraft, ambient, N);

data_2 = load('U_inf_AoA.txt');

AoA_XFRL5 = data_2(:,1);
U_XFLR5 = data_2(:,2);


figure()
plot(Uinf, rad2deg(AoA), 'b', 'Linewidth', 2);
title('AoA as function of U_{inf}')
xlabel('U_{inf} [m/s]')
ylabel('AoA [rad]')
hold on
plot(U_XFLR5, AoA_XFRL5, 'r', 'Linewidth', 2);
legend('Matlab', 'XFLR5');





