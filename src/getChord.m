function chord = getChord(b, L_span, theta_span, Ct, Cr)

for n_L = 1:length(L_span) %For each geometry
  for n_theta = 1:length(theta_span) %For each theta position

    lim1 = acos(L_span(n_L)/b); %This is first point at which wing deflects
    lim2 = acos(-L_span(n_L)/b); %This second point at which wing deflects

    if theta_span(n_theta) >= 0 && theta_span(n_theta) <= lim1; %Chord grows linearly
      chord(n_theta, n_L) = Ct(n_L)+((Cr-Ct(n_L))./(b./2-L_span(n_L)./2)).*((-b./2.*cos(theta_span(n_theta)))+b./2);

    elseif theta_span(n_theta) > lim1 && theta_span(n_theta) <= lim2; %Chord remains constant
      chord(n_theta, n_L) = Cr;

    elseif n_theta <= length(theta_span) && theta_span(n_theta) > lim2; %Chord decreases linearly
      chord(n_theta, n_L)=Cr-((Cr-Ct(n_L))./(b./2-L_span(n_L)./2)).*((-b./2.*cos(theta_span(n_theta)))-L_span(n_L)./2);
    
    end
  
  end

end