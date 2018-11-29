function x = solveSystemCl(b, L_span, theta_span, Ct, Cr, k, alfa_0, N)

    for n_theta = 1:length(theta_span)
    
        lim1 = acos(L_span/b);
        lim2 = acos(-L_span/b);
    
        if theta_span(n_theta) >= 0 && theta_span(n_theta) <= lim1
            chord(n_theta)=Ct+((Cr-Ct)./(b./2-L_span./2)).*((-b./2.*cos(theta_span(n_theta)))+b./2);

        elseif theta_span(n_theta)>lim1 && theta_span(n_theta) <= lim2
            chord(n_theta)=Cr;
 
        elseif n_theta <= length(theta_span) && theta_span(n_theta)>lim2
            chord(n_theta)=Cr-((Cr-Ct)./(b./2-L_span./2)).*((-b./2.*cos(theta_span(n_theta)))-L_span/2);
        end
        
    end
    
    
    A = zeros(length(theta_span), N);
    B = zeros(N, 1);
    
    A(:,1)=1;
    
    for n_theta = 2:length(theta_span)
        for n=1:(N-1)
            
        A(n_theta,n+1) = -((k./chord(n_theta)).*sin(n.*theta_span(n_theta))+n.*(sin(n.*theta_span(n_theta))./sin(theta_span(n_theta))));
        A(1,n+1)=-n.^2;  
        B(n_theta)=alfa_0;
        B(1)=alfa_0;
        
        end
    end
    
    x = linsolve(A,B);

end