function [ca, depth] = transientDiffModel(B,Ds,H,ct,dz,t,th)
% Returns antibiotic concentration profile data based on Fick's Second Law 
% of Diffusion, diffusion with time in one dimension.
% ca: vector of antibiotic concentration throughout biofilm, in ug/L
% depth: vector of depth corresponding to ca, in mm
%        I.e., ca and depth have the same length; at depth(i) the 
%        antibiotic concentration is ca(i)
% B: degradation rate of antibiotic in biofilm, in s^-1
% Ds: diffusion constant of antibiotic, in mm^2/s
% H: total depth of biofilm, in mm
% ct: strength of source of antibiotic at z=0, in ug*mm/L
% dz: step size in depth for simulation, in mm
% t: time at which concentration profile is being computed, in s
% th: threshold below which a concentration is considered to be zero, 
%     in ug/L
% All values in ca are no smaller than th. I.e., as soon as concentration
% drops below the threshold, stop the calculations and do not include that
% last value below th in ca.

%defining Concentration (ca) and depth outputs as empty vectors
ca = [];                
depth = [];             

%initializing values
z = 0;                  %initial depth 
i = 1;                  %the first index value must be one
ca_temp = inf;          %any value > than the threshold can be initial concentration

%will run until vector reaches max height or concentration falls below threshold
while z<=H && ca_temp>=th
   
    %concentration with every iteration updates
    ca_temp = (ct/sqrt(4*pi*Ds*t))*exp((-z^2)/(4*Ds*t)-B*t);
    
    %prevents last index value in ca vector from falling below threshold
    if ca_temp >=th
        depth(i) = z;              
        ca(i) = ca_temp;           %stores each concentration value for each index
         i= i + 1;                 %updates index 
         z= round(z + dz, 10);     %updates current z value and accounts for error 
    end
end











