%% Extracting the ON and OFF response (1 sec before and 2 sec after touch/release of stimulus) from TS averaged over both hemispheres
%% Works with 10 Hz recordings!!

%opens window to select and load dataset
[file,path]=uigetfile('*.mat','Select TSROImean mat-file with 12 regions','/home/paul/Desktop');
data=strcat(path,file)
load(data)

OnS=749;
OffS=798;

OnW=499;
OffW=547;

OnQ=217;
OffQ=268;

ONsuc=Brain((OnS-10):(OnS+19),:);
OFFsuc=Brain((OffS-10):(OffS+19),:);


ONwat=Brain((OnW-10):(OnW+19),:);
OFFwat=Brain((OffW-10):(OffW+19),:);


ONqui=Brain((OnQ-10):(OnQ+19),:);
OFFqui=Brain((OffQ-10):(OffQ+19),:);

StimResponses96=cat(3,ONsuc,OFFsuc,ONwat,OFFwat,ONqui,OFFqui);


PeakONsuc=max(ONsuc,[],1)-ONsuc(9,:);
PeakOFFsuc=max(OFFsuc,[],1)-OFFsuc(9,:);

PeakONwat=max(ONwat,[],1)-ONwat(9,:);
PeakOFFwat=max(OFFwat,[],1)-OFFwat(9,:);

PeakONqui=max(ONqui,[],1)-ONqui(9,:);
PeakOFFqui=max(OFFqui,[],1)-OFFqui(9,:);

StimPeaks96=[PeakONsuc;PeakOFFsuc;PeakONwat;PeakOFFwat;PeakONqui;PeakOFFqui];


%saves variable as new mat file with matching name
save(strcat(data(1:size(data,2)-6),'Peaks12.mat'),'StimResponses96','StimPeaks96');