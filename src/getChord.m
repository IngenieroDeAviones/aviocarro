function [theta, theta_chord] = getChord(b, L, rootChord, Ct)

    N = 101; %Number of positions to compute the chord
    y = linspace((-b/2), (b/2), N); %Each position to compute the chord

    for i = 1:length(y)-1

        y_pos(i) = (y(i) + y(i+1))/2;

        if y_pos(i) < -L/2;
            theta_chord(i) = Ct + (-b/2 - y_pos(i))*((rootChord - Ct)/(L/2 - b/2));

        elseif y_pos(i) >= -L/2 && y_pos(i) <= L/2;
            theta_chord(i) = rootChord;
        
        else y_pos(i) > L/2;
            theta_chord(i) = + rootChord - ((rootChord - Ct)./(b./2 - L./2)).*(y_pos(i) - L./2); %Lineal function

        end

    end
     
    theta = linspace(0, pi, length(y_pos)); %Convert y to theta

end