%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% AERODYNAMICS LABORATORY %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; clc; %Clearing workspace and screen

%% LOADING AIRCRAFT VARIABLES
data = load('naca_aviocarro.dat'); %Loading the airfoil from the Aviocarro
x = data(:, 1); %X Coordinate
y = data(:, 2); %Y Coorfinate

aircraft.weight = 8000; %[kg]
aircraft.cruise = 300; %[km/h]



wing.rootChord = 2.6; %[m]
wing.aspectRatio = 10; %[AR]
wing.surface = 41.0; %[m^2]
wing.span = 20.27; %[m^2]
wing.name = 'NACA 65-218'; %Name of the airfoil


%% ALL PLOTS BELOW THIS LINE

figure() %Plotting the airfoil
fill(x, y, 'b')
title('NACA 65-218')
xlabel('x-coordinate')
ylabel('z-coordinate')
xlim([0 1]);
ylim([-0.1 0.12])
width=750;
height=200;
set(gcf,'units','points','position',[100, 100, width, height])


