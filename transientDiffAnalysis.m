%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%1.2 assignment
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clc
clear

%constant input values
B = .2;                  %degradation rate of antibiotic in biofilm, in s^-1
Ds = .05;                %diffusion constant of antibiotic, in mm^2/s
H =  3;                  %total depth of biofilm, in mm
ct =  9;                 %strength of source of antibiotic at z=0, in ug*mm/L
dz =  .01;               %step size in depth for simulation, in mm
th = .001;               %threshold below which a concentration is considered to be zero, in ug/L
dt = .1;                 %time step, in s

%set figure window
close all                % Close all figure windows
figure                   % Start a new figure window
axis([0 H 0 40])         % x-axis limits are set from 0 to H; % y-axis limits are set from 0 to 40
hold on                  % Hold subsequent plot commands on current axes

%initializing values
t = .1;                  %starting time          
depth = 0;               %initial depth

%will run until last value in depth vector reaches max height
while depth(length(depth))<H

    %call function
    [ca, depth] = transientDiffModel(B,Ds,H,ct,dz,t,th)
    
    %plotting vectors in figure 
    plot(depth, ca);
   
    %update the value of time by .1 s each iteration
    t = t+dt

end

%Graph labels
xlabel('Depth (mm)')
ylabel('Concentration (ug/L)')

%Graph title
messageToShow= sprintf('Amount of Time it takes for antibiotic to reach full depth of the biofilm = %.1f seconds', t);
title(messageToShow)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%1.31 assignment
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%The goal of this script is to display how changes to the diffusion
%constant Ds impact the concentration profiles at a fixed time.

%set figure window
figure
hold on
axis([0 5 0 11])


%constant input values
B = .2;                  %degradation rate of antibiotic in biofilm, in s^-1
H =  3;                  %total depth of biofilm, in mm
ct =  9;                 %strength of source of antibiotic at z=0, in ug*mm/L
dz =  .01;               %step size in depth for simulation, in mm
th = .001;               %threshold below which a concentration is considered to be zero, in ug/L
t = 1;                   %constant time, in s


%Loop over Ds values
for Ds = .05:.01:.09    

    % Obtain x-y data for plotting one curve, stored in vector variables `depth` and `ca` 
    [ca, depth] = transientDiffModel(B,Ds,H,ct,dz,t,th)
    
    % Plot the curve, letting MATLAB choose a color automatically and setting the legend text
    plot(depth, ca, 'DisplayName', sprintf('D_s=%.2f', Ds))

end

% Turn legend on
legend

%set title
messageToShow= sprintf('Sensitivity Analysis for the diffusion model as the diffusion constant Ds is manipulated');
title(messageToShow)

%axes labels
xlabel('Depth (mm)')
ylabel('Concentration (ug/L)')

hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%1.32
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%The goal of this analysis is to display how changes in the Ds value will 
%affect the amount of time that it takes for the antibiotic to travel
%across the thickness of the biofilm.

%constant input values
B = .2;                  %degradation rate of antibiotic in biofilm, in s^-1
H =  3;                  %total depth of biofilm, in mm
ct =  9;                 %strength of source of antibiotic at z=0, in ug*mm/L
dz =  .01;               %step size in depth for simulation, in mm
th = .001;               %threshold below which a concentration is considered to be zero, in ug/L
dt0 = .1;                 %time step

%set figure window
figure                   %Start a new figure window
                      
hold on              
axis auto                %automatically scales graph

%initializing values
t0 = .1;                  %starting time
depth0 = 0;               %starting depth

%Loop over Ds values
for Ds = .05:.01:.09
    t = t0;               %for each new ds value, time resets from 0
    depth = depth0;       %for each new ds value, depth resets from 0
    
    %will run until last value in depth vector reaches max height
    while depth(length(depth))<H
        [ca, depth] = transientDiffModel(B,Ds,H,ct,dz,t,th)
         t = t+dt
    end
    
    %plot the Ds and t, everytime t is calculated for each Ds value
    plot(Ds, t, 'o')
    
end

%axes labels
xlabel('ds (mm^2/s)')
ylabel('t (s)')

%set title
messageToShow= sprintf('Amount of Time it takes for antibiotic to reach full depth of the biofilm = %.1f seconds', t);
title(messageToShow)


