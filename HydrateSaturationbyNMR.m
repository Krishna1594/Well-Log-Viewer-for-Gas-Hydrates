%% Calculating Hydrate Saturation using Nuclear Magnetic Resinance(NMR) data
% DENSITY LOG DATA: We need density log data to calculate the TCMR porosity and Hydrate saturation.
display('Import the Density log data.');
display('Choose the file-type of Log data: 1.Excel file 2.Text file');
choice=input('1 or 2: ');
switch choice
    case 1
        [filename,PathName] = uigetfile('*.xlsx','Select the Excel file');
        [DEN, text, alldata]=xlsread(filename);
    case 2
        [filename,PathName] = uigetfile('*.txt','Select the Text file');
        DEN=dlmread(filename,'\t',6,0);
    otherwise
        display('file not supported!');
end
% We ask user to upload the NMR data in only ASCII or text format.
display('Please import the NMR data in Log-ASCII file format or ".txt" file format.');
[Fname,PathName] = uigetfile('*.txt','Select the Text file');
fid=fopen(Fname);
S=textscan(fid,'%s','delimiter','\n');
fclose(fid) ;
S = S{1} ;
%% Get positions
idx1 = find(not(cellfun('isempty',strfind(S, 'T2'))));                      % T2 position 
idx2 = find(not(cellfun('isempty',strfind(S, 'DEPTH'))));                   % Depth position 
idx3 = idx2:length(S) ;
%% Get the organized data
x = cell2mat(cellfun(@str2num,strsplit(S{idx1}),'un',0)) ;                     % T2 (Milliseconds)
depth = cell2mat(cellfun(@str2num,strsplit(S{idx2}),'un',0)) ;
data = cell2mat(cellfun(@str2num,S(idx3),'un',0)) ;
y = data(:,1) ;                                                                % Depth (meters)
Data=data(:,2:end);
dataCBW = Data(:,1:5) ;
% ----Now plotting T2 Distribution curve----NMR Log----
grid on
surface(x,y,Data)
xlabel('T2 Distribution');
set(gca,'YDir','Reverse');
set(gca,'XAxisLocation','top');
%% Area under the each curve
[m,n]=size(dataCBW);
%N = length(depth) ;
Area = zeros(m,1) ;
for i = 1:m
    Area(i) = trapz(x(1,1:5),dataCBW(i,:)) ;
end
display('Please enter the following values:');
RHO_mat=input('Enter the density of the matrix (in g/cc): ');
RHO_mud=input('Enter the density of the drilling mud (in g/cc): ');
Phi_D=(RHO_mat-DEN(:,2))./(RHO_mat-RHO_mud);                                %Density Porosity
LAMDA=(RHO_mud-0.91)/(RHO_mat-RHO_mud);
PHI_NMR=Area./100;                                                           % NMR Porosity
PHI=(Phi_D(1:2309,1)+(LAMDA.*(Area(1:2309,1))./100))./(1+LAMDA);             % Total Porosity
Sh=(PHI-(Area(1:2309,1))./100)./PHI                                          % Hydrate Saturation
figure;
plot(Sh,y(1:2309,1))
xlabel('Hydrate Saturation (dec %)');
ylabel('Depth (meters)');
set(gca,'XAxisLocation','top');
set(gca,'YDir','Reverse');
figure;
plot(PHI_NMR(1:2309,1),y(1:2309,1),'r-',Phi_D,y(1:2309,1),'b-');
xlabel('Porosity (%)');
ylabel('Depth (meters)');
set(gca,'XAxisLocation','top');
set(gca,'YDir','Reverse');