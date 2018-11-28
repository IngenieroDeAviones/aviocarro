%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% AERODYNAMICS LABORATORY %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% CLEARING WORKSPACE AND CONSOLE
clear; clc;

%% LOADING AMBIENT VARIABLES
altitude = 3050; %[m]
ambient.rho = getRhoISA(altitude);

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

%% SOLVING  Ct 
L_span = 0:0.01:11.26; %Span of L
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

[delta, aircraft.Cd] = solveSystem(L_span, theta_span, chord_span, a, A1, alfa_0, aircraft.Cl, aircraft.AR, N);

%% PLOTING ALL GRAPHS
figure()
plot(Ct_span, delta)
title('\delta vs C_{t}');
xlabel('C_{t}')
ylabel('\delta')




