function P = getPressureISA(z)

    R = 287;
    a = 0.0065;
    T0 = 15 + 273;
    P0 = 101300;
    g = 9.8;

    P =  P0.*(1 - (a.*z)./T0).^(g./(R.*a));

end