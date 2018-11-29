function AoA = solveAoA(b, L, theta_span, Ct, Cr, Uinf, alfa_0, a, aircraft, ambient, N)

    for n_theta=1:length(theta_span)
        
        lim1 = acos(L/b);
        lim2 = acos(-L/b);        
        
        if theta_span(n_theta) >= 0 && theta_span(n_theta)<=lim1
            chord(n_theta)=Ct+((Cr-Ct)./(b./2-L./2)).*((-b./2.*cos(theta_span(n_theta)))+b./2);

        elseif theta_span(n_theta)>lim1 && theta_span(n_theta) <= lim2
            chord(n_theta)=Cr;
 
        elseif n_theta <= length(theta_span) && theta_span(n_theta)>lim2
            chord(n_theta)=Cr-((Cr-Ct)./(b./2-L./2)).*((-b./2.*cos(theta_span(n_theta)))-L/2);
        end
    end
    
    A1=zeros(length(Uinf));
        
    for n_Uinf = 1:length(Uinf)
        
        A1(n_Uinf)=2*aircraft.W/(ambient.rho*aircraft.S*aircraft.AR*pi*(Uinf(n_Uinf))^2); %Computing coefficient for that speed
        
        B=zeros(N, 1);
        A=zeros(length(theta_span), N);
        A(:, 1)=1;
        
        for g=2:length(theta_span)
            for n=2:100
                A(g,n)=-((a./chord(g)).*sin(n.*theta_span(g))+n.*(sin(n.*theta_span(g))./sin(theta_span(g))));
                A(1,n)=-n.^2;  
                B(1)=alfa_0 +A1(n_Uinf).*(a./chord(g)).*sin(theta_span(g))+A1(n_Uinf);
                B(g)=alfa_0 +A1(n_Uinf).*(a./chord(g)).*sin(theta_span(g))+A1(n_Uinf);
            end
        end
        
        [x, ~] = linsolve(A,B);
        AoA(n_Uinf) = x(1);
    
    end

end