%% Reading
% A service company has its own format of recording and storing data.
% The data is either stored in '.las' file format or '.xlsx','.xlsm' format.
% Sometimes companies also store the raw data in log-ASCII format but separate file for each loging tool or sonde. 
[FileName,PathName] = uigetfile('*.xlsx','Select the Excel file');
[RAWDATA, text, alldata]=xlsread(FileName);
[m,n] = size(text);
[M,N] =size(RAWDATA);
%% Identifying the depth track from a combined log data file and storing its position.
idx1 = find(not(cellfun('isempty',strfind(text,'DEPT'))));
pos_DEPTH = max(idx1);
col_DEPTH = pos_DEPTH/m;
%% Identifying the lithology track from the log data file and storing its position.
% Here we can have Gamma Raya(GR), Hostile environment Spectral Gamma
% Ray(HNGS)-standard Gamma Ray(HSGR) and HNGS-Computed Gamma Ray (HCGR).
% The problem with combined log data is that the required log data can be at
% different colomn and at different row for differnt wells. So we will tell
% MATLAB to find the keyword note the position (location) of it and plot the values under it with respect to
% depth log. Keywords are usually the log tool abbreveations such as for
% caliper log it can be CAL or for HNGS Gamma ray it could be HSGR as
% mentioned above. All companies can have common nomenclature or can be
% different.
idx2 = find(not(cellfun('isempty',strfind(text, 'HSGR'))));
pos_HSGR = max(idx2);
col_HSGR = pos_HSGR/m;
idx3 = find(not(cellfun('isempty',strfind(text, 'HCGR'))));
pos_HCGR = max(idx3);
col_HCGR = pos_HCGR/m;
idx4 = find(not(cellfun('isempty',strfind(text, 'HCAL'))));
pos_CAL = max(idx4);
col_CAL = pos_CAL/m;
%% Identifying the Density log-Track and storing its position
% Similarly, we can store the location of our density log data.
idx5 = find(not(cellfun('isempty',strfind(text, 'RHOB'))));
pos_RHOB = max(idx5);
col_RHOB = pos_RHOB/m;
idx6 = find(not(cellfun('isempty',strfind(text, 'PEFB'))));
pos_PEFB = max(idx6);
col_PEFB = pos_PEFB/m;
%% Results:Well-Logs
grid on
subplot(1,2,1);
plot(RAWDATA(1:M,col_HSGR),RAWDATA(1:M,col_DEPTH),'r-',...
    RAWDATA(1:M,col_HCGR),RAWDATA(1:M,col_DEPTH),'b-',...
    RAWDATA(1:M,col_CAL),RAWDATA(1:M,col_DEPTH),'k--');
legend('HSGR','HCGR','HCAL');
ylabel('Depth (meters)');
set(gca,'YDir','Reverse');
set(gca,'XAxisLocation','top');
hold on
%------
subplot(1,2,2);
plot(RAWDATA(1:M,col_RHOB),RAWDATA(1:M,col_DEPTH),'r-',...
    RAWDATA(1:M,col_PEFB),RAWDATA(1:M,col_DEPTH),'b-');
legend('RHOB','PEFB');
ylabel('Depth (meters)');
set(gca,'YDir','Reverse');
set(gca,'XAxisLocation','top');