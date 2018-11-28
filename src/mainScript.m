%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% AERODYNAMICS LABORATORY %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; clc; %Clearing workspace and screen

%% LOADING AIRCRAFT VARIABLES
data = load('naca_aviocarro.dat'); %Loading the airfoil from the Aviocarro
x_naca = data(:, 1); %X Coordinate
y_naca = data(:, 2); %Y Coorfinate

aircraft.mass = 8000; %[kg]
aircraft.weight = aircraft.mass*9.81; %[N]
aircraft.cruiseSpeed = 300*1000/3600; %[m/s]
aircraft.altitude = 3050; %[m]

wing.rootChord = 2.6; %[m]
wing.aspectRatio = 10; %[AR]
wing.surface = 41.0; %[m^2]
wing.span = 20.27; %[m^2]
wing.name = 'NACA 65-218'; %Name of the airfoil

ambient.density = getRoISA(aircraft.altitude); %[kg/m^3]


%% REQUIREMENTS FOT THE WING DIMENSIONS Ct and L
Length = 0:0.1:wing.span; %For all sizes of L

counter = 1;

for i = 1:length(Length)
    
    possible_ct = getCt(wing.surface, wing.span, wing.rootChord, Length(i)); %We compute the Ct associated with L(i)

    if  possible_ct >= 0 && Length(i) <= wing.span %If they fullfill geometrical properties

        L(counter) = Length(i); %We add this new value
        ct(counter) = possible_ct; %We add this new value

        [theta, theta_chord] = getChord(wing.span, L(i), wing.rootChord, ct(i)); %We compute the chord distribution along theta [0, PI]        
        A1 = getA1(aircraft.weight, ambient.density, aircraft.cruiseSpeed, wing.surface, wing.aspectRatio); %We compute the A1 coefficient
        
        [A, b, sol] = solveSystem(wing.span, theta, theta_chord, A1); %We solve the system
        
        An = sol([1:length(sol)-1])';
        alfa_pi_2 = sol(length(sol))';
        
        delta(counter) = getDelta(A1, An); %Computing delta
        
        counter = counter + 1; %Increase counter
    end

end



%% ALL PLOTS BELOW THIS LINE

%{
figure() %Plotting the airfoil
fill(x_naca, y_naca, 'b')
title('NACA 65-218')
xlabel('x-coordinate')
ylabel('z-coordinate')
xlim([0 1]);
ylim([-0.1 0.12])
width=750;
height=200;
set(gcf,'units','points','position',[100,100,width,height])


figure() %Ploting Ct vs L
plot(L, ct, 'b', 'Linewidth', 2)
title('Combination of L and C_{t} for S=41m^2')
xlabel('L [m]')
ylabel('C_{t} [m]')


wing.plot_y = [-wing.span/2 (-wing.span/2):0.1:(wing.span/2) wing.span/2];
wing.plot_x = drawChord(wing.plot_y, wing.span, L(40), wing.rootChord, ct(40));
figure()
fill(wing.plot_y, wing.plot_x, 'b');
title('Wing view from top')
xlabel('Y-AXIS')
ylabel('X-AXIS')


prompt = 'PRESS ENTER TO CLOSE ALL GRAPHS...';
command = input(prompt);
close all; clc;
%}


