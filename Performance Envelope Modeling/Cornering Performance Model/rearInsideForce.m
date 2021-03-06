function [fri] = rearInsideForce()
load("cornering_parameters");

syms a

LLTr = a.*(mass.*g./t).*((hl.*Kr)./(Kf+Kr)) + a.*(mass.*g.*(b)./L).*hr;

wri = 0.5.*mass.*g.*((L-b)./L) + 0.25.*rho.*Cl.*A.*((b)./L).*v.^2-LLTr;

fri = simplify(-0.0001.*wri.^2+2.18.*wri+149);
end

