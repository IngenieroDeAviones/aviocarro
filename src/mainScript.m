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


%% REQUIREMENTS FOT THE WING DIMENSIONS Ct and L

possible_L = 1.0:0.1:wing.span;

for i = 1:length(possible_L)
    possible_ct = (wing.surface - 2.6*possible_L(i) - ((wing.span - possible_L(i))/2)*wing.rootChord)/((wing.span - possible_L(i)) - (wing.span - possible_L(i))/2);

    if possible_ct > 0 && possible_L(i) < wing.span
        L(i) = possible_L(i); %We add this value
        ct(i) = possible_ct; %We add this value
    end

end

wing.x = [-wing.span/2 (-wing.span/2):0.1:(wing.span/2) wing.span/2];
wing.y = getChord(wing.x, wing.span, L(40), wing.rootChord, ct(40));

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
set(gcf,'units','points','position',[100,100,width,height])
xL = xlim;
yL = ylim;
line(xL, [0 0],'color','k','linewidth',1.5) %x-axis
line([0 0], yL,'color','k','linewidth',1.5) %y-axis

figure() %Ploting Ct vs L
plot(L, ct, 'b', 'Linewidth', 2)
title('Combination of L and C_{t} for S=41m^2')
xlabel('L [m]')
ylabel('C_{t} [m]')

figure()
fill(wing.x, wing.y, 'b');
title('Wing view from top')
xlabel('Y-AXIS')
ylabel('X-AXIS')

prompt = 'PRESS ENTER TO CLOSE ALL GRAPHS...';
command = input(prompt);
close all; clc;

