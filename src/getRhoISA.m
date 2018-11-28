function ro = getRhoISA(z)
    
    R = 287;
    T = getTemperatureISA(z);
    P = getPressureISA(z);
    ro = P./(R.*T);
    
end