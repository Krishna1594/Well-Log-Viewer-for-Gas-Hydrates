%% Calculation of Hydrate Saturation using Archie's Equation
% Before we can start calculating the hydrate saturation, we need to study the well logs carefuly and interpret the gas hydrate zones.
% The following code can calculate the hydrate saturation along the composite log.
display('First, calculating the sea water resistivity at a salinity(in ppm) of seawater measured at reference temperature of 20 degrees celcius (68 degrees Fahrenheit):');
display('Please enter the salinity of seawater.');
SAL_NaCl=input('Salinity (ppm)= ');
Rw_Tr=(400000/(68*SAL_NaCl))^0.88                %Resistivity of seawater measured at a salinitiy (at Reference Temperature,Tr)
%%
% We need to correct this resistivity of sewater to resistivity at Formation Temperature using Arp's Formula. Formation Temperature can be in Fahrenheit or Celcius.
display('Is your Temperature log in: 1.degree F or 2.degree C?');
option=input('choose between 1 or 2: ');
switch option
    case 1
        Rw_Ft=Rw_Tr.*((68+6.77)./(TEMP(362:9079,2)+6.77));
    case 2
        Rw_Ft=Rw_Tr.*((20+21.5)./(TEMP(362:9079,2)+21.5));
end
%%
% Since we do not have core samples and its data the following valuse are assumed; a=1.7, m=2.0, n=1.9386 for most of the gas hydrate wells
a=1.7; 
m=2.0; 
n=1.9386;
%%
% Now we need to calculate Density porosity by assuming the type of matrix or grains: Limestone, Sandstone or Dolomite. We can write a code such as:
display('choose the type of matrix: 1. Sand-stone, 2.Limestone, 3.Dolomite');
choice=input('1 or 2 or 3');
switch choice
           case 1
            Rho_mat= 2.65;   %gm/cc         
           case 2 
            Rho_mat= 2.71;   %gm/cc
           case 3
            Rho_mat= 2.87;   %gm/cc
end
%%
% Now we can calculate the density porosity, by observing the resistivity logs carefully:
display('Enter the density of Drilling Mud in gm/cc.');
Rho_mud=input('Rho_mud= ');
display('Enter the Resistivity of formation water (Ro) by observing the resistivity log carefully (true resistivity).');
Ro=input('Resistivity of formation water= ');
Phi_D=(Rho_mat-DEN(:,2))/(Rho_mat-Rho_mud);
%%
% Now we can calculae the total porosoty as:
PHI_t=(a.*((Rw_Ft)./(RES(159:3899,2)))).^(1./m);
%%
% Now we can efficiently calculate the Hydrate Saturation as:
Sw=(Ro.*((PHI_t).^m)/(a.*Rw_Ft)).^(1/n);                       %Water Saturation
Sh=1-Sw;                                                                   %HYDRATE SATURATION
%% Plotting the Final Composite Log
grid on
subplot(1,4,1);
plot(CALI(:,2),CALI(:,1),'k:',GR(:,2),GR(:,1),'r--');
legend('Caliper','SGR');
ylabel('Depth (meters)');
set(gca,'YDir','Reverse');
set(gca,'XAxisLocation','top');
hold on
%-------
grid on
subplot(1,4,2);
plot(DEN(:,2),DEN(:,1),'k--',DEN(:,3),DEN(:,1),'r--');
legend('RHOB','DRHO');
ylabel('Depth (meters)');
set(gca,'YDir','Reverse');
set(gca,'XAxisLocation','top');
hold on
%-------
grid on
subplot(1,4,3);
semilogx(RES(:,2),RES(:,1),'k');
legend('Deep (ohm-m)');
ylabel('Depth (meters)');
set(gca,'YDir','Reverse');
set(gca,'XAxisLocation','top');
hold on
%-------
grid on
subplot(1,4,4);
plot(Sh,RES(1:2263,1),'k');
legend('Hydrate Saturation (Sh)');
ylabel('Depth (meters)');
set(gca,'YDir','Reverse');
set(gca,'XAxisLocation','top');