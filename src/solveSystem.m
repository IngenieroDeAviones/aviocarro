function [A, b, sol] = solveSystem(span, theta, theta_chord, A1)

    alfa_0 = -0.2; %This is a fixed value obtained from XFLR5
    N = length(theta); %Total number of points  

    for i = 1:N %Row, number of equations
        
        %j = 3; %Computing for odd coefficients
        
        for j = 2:N %Colum Element
            
            A(i, j-1) = (2*span/(pi*theta_chord(i)))*sin(j*theta(i)) + j*(sin(j*theta(i))/sin(theta(i)));
            %j = j + 2; %Compute for next odd coefficient
        
        end
        
        A(i,N) = -1; %Last colum of A is always -alfa(pi/2)
        b(i, 1) = -alfa_0 - A1*((2*span/(pi*theta_chord(i)))*sin(1*theta(i)) + 1*(sin(1*theta(i))/sin(theta(i))));
        %b(i, 1) = -alfa_0 - A1*(2*span/(pi*theta_chord(i)))*sin(1*theta(i));
    
    end
    
    sol = A\b; %Solution to the system
          
   
end