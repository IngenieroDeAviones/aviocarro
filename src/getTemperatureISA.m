function T = getTemperatureISA(z)
    
    T0 = 15 + 273;
    a = 0.0065;
    
    T = T0 - a*z;

end