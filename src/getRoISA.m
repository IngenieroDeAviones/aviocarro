function ro = getRoISA(z)
    
    R = 287;
    T = getTemperatureISA(z);
    P = getPressureISA(z);
    ro = P./(R.*T);
    
end