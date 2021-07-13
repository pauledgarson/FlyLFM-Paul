%% Renaming the time series data variable 'TSo' and saving alone in a new file

%opens window to select and load dataset
[file,path]=uigetfile('*.mat','Select IC_Smith mat-file with component TS','/home/paul/Desktop');
data=strcat(path,file)
load(data)

TimeSeriesPutComp11=TSo;

%saves variable as new mat file with matching name
save(strcat(data(1:size(data,2)-6),'TimeSeriesComp.mat'),'TimeSeriesPutComp11');