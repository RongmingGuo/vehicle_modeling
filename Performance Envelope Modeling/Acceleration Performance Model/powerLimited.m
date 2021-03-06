
function [Fx,Ax] = powerLimited(v)

%Author: Marc Maquiling,maquilingm@gatech.edu,646-745-4078
%Date: 12/28/21

load("vehicle");

D = 0.5.*rho.*Cd.*v.^2.*A; %drag force, parameters taken from Aero presentation

Rr =  Crr.* mass.*9.81; %Rolling resistance

adjTm = -2.*10.^-5.*(v).^5+0.0014.*v.^4-0.0372.*v.^3+0.4109.*v.^2-1.7775.*v + Tm;

%^This function comes from the Emrax 208 torque vs RPM data. Data points
%from the spec sheet were put into an Excel sheet and then I fitted a curve
%to them. 

netF = ((adjTm.*N.*eta)./r) - D - Rr;

Fx = (adjTm.*N.*eta)./r;

effectiveMass = (mass + ((Im.*N.^2+Ip)./r.^2));

Ax = (1./effectiveMass).*netF;



end

