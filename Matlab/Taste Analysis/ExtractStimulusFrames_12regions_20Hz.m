%% Extracting the ON and OFF response (1 sec before and 1,5 sec after touch/release of stimulus) from TS averaged over both hemispheres
%% Works with 20 Hz recordings!!
%% Names of variables need to be changed according to recording name!!

%opens window to select and load dataset
[file,path]=uigetfile('*.mat','Select TSROImean mat-file with 12 regions','/home/paul/Desktop');
data=strcat(path,file)
load(data)

%enter frame number for stimulus start/end of recording
OnS=204;
OffS=244;

OnW=0;
OffW=0;

OnQ=767;
OffQ=806;

%creates array with values for ON/OFF response with each stimulus (1 sec
%before and 1,5 sec after)
ONsuc=Brain((OnS-20):(OnS+29),:);
OFFsuc=Brain((OffS-20):(OffS+29),:);

if OnW > 0
    ONwat=Brain((OnW-20):(OnW+29),:);
    OFFwat=Brain((OffW-20):(OffW+29),:);
end

ONqui=Brain((OnQ-20):(OnQ+29),:);
OFFqui=Brain((OffQ-20):(OffQ+29),:);

if OnW > 0
    StimResponses79=cat(3,ONsuc,OFFsuc,ONwat,OFFwat,ONqui,OFFqui);
else
    StimResponses79=cat(3,ONsuc,OFFsuc,ONqui,OFFqui);
end


%creates array with peak response for ON/OFF stimulus by subtracting the
%baseline value 1 frame before Stimulus ON/OFF from max value
PeakONsuc=max(ONsuc,[],1)-ONsuc(19,:);
PeakOFFsuc=max(OFFsuc,[],1)-OFFsuc(19,:);

if OnW > 0
    PeakONwat=max(ONwat,[],1)-ONwat(19,:);
    PeakOFFwat=max(OFFwat,[],1)-OFFwat(19,:);
end

PeakONqui=max(ONqui,[],1)-ONqui(19,:);
PeakOFFqui=max(OFFqui,[],1)-OFFqui(19,:);

if OnW > 0
    StimPeaks79=[PeakONsuc;PeakOFFsuc;PeakONwat;PeakOFFwat;PeakONqui;PeakOFFqui];
else
    StimPeaks79=[PeakONsuc;PeakOFFsuc;PeakONqui;PeakOFFqui];
end


%saves variable as new mat file with matching name
save(strcat(data(1:size(data,2)-6),'Peaks12.mat'),'StimResponses79','StimPeaks79');