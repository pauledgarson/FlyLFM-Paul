%% Renaming the time series data variable 'Brain' and saving alone in a new file

%opens window to select and load dataset
[file,path]=uigetfile('*.mat','Select TSROImean mat-file with 12 regions','/home/paul/Desktop');
data=strcat(path,file)
load(data)

TimeSeriesPut308=Brain;

%saves variable as new mat file with matching name
save(strcat(data(1:size(data,2)-6),'TimeSeries12.mat'),'TimeSeriesPut308');