function  chord = drawChord(x, b, L, rootChord, Ct)

    for i = 1:length(x)

        if x(i) == -b/2;
            chord = 0;

        elseif x(i) < -L/2 && x(i) ~= -b/2;
            chord(i) = Ct + (-b/2 - x(i))*((rootChord - Ct)/(L/2 - b/2));

        elseif x(i) >= -L/2 && x(i) <= L/2;
            chord(i) = rootChord;
        
        elseif x(i) > L/2 && x(i) ~= b/2;
            chord(i) = + rootChord - ((rootChord - Ct)./(b./2 - L./2)).*(x(i) - L./2); %Lineal function
        
        else
            chord(i) = 0;
        end

    end
     
end