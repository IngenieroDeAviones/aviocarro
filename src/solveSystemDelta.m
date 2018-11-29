function [delta, Cd, x] = solveSystem(L_span, theta_span, chord_span, a, A1, alfa_0, Cl, AR, N)


    A = zeros(length(theta_span), N); %Prellocating on memory A matrix
    B = zeros(N, 1); %Prellocating on memory B matrix
    delta = zeros(length(L_span));
    
    for n_L = 1:length(L_span)
        A(:,1)=1;
       
    for n_theta=2:length(theta_span)
        for n = 2:N
        
        A(n_theta,n)=-((a./chord_span(n_theta,n_L)).*sin(n.*theta_span(n_theta))+n.*(sin(n.*theta_span(n_theta))./sin(theta_span(n_theta))));
        A(1,n)=-n.^2;  
        B(1)=alfa_0+A1;
        B(n_theta)=alfa_0+A1.*(a./chord_span(n_theta,n_L)).*sin(theta_span(n_theta))+A1;
        
        end
    end
    
    x = linsolve(A,B);
    
    for n = 2:N
        delta(n_L)=delta(n_L)+n*((x(n))/A1)^2;
    end
    
    Cd(n_L)=Cl^2/(pi*AR)*(1+delta(n_L));
    
    end
    
end

    