%% Extracts the data for the stimulation phases for 10 Hz recordings with three stimulations and plots the time series 
%% Change variable names in line 29, 42 and 46 according to datafile name

% opens window to select and load dataset with the average ROI for 12 regions 
[file,path]=uigetfile('*.mat','Select TSROImean mat-file with 12 regions','/home/paul/Desktop');
data=strcat(path,file)
load(data)

% input the frame number for on and offset of the stimulations
OnFirst=250;
OffFirst=308;

OnSec=566;
OffSec=625;

OnThird=879;
OffThird=931;

% extract data for stim phases (2 sec before and 5 sec after On/Off set)
ONfirst=Brain((OnFirst-20):(OnFirst+49),:);
OFFfirst=Brain((OffFirst-20):(OffFirst+49),:);

ONsec=Brain((OnSec-20):(OnSec+49),:);
OFFsec=Brain((OffSec-20):(OffSec+49),:);

ONthird=Brain((OnThird-20):(OnThird+49),:);
OFFthird=Brain((OffThird-20):(OffThird+49),:);

StimResponses241=cat(3,ONfirst,OFFfirst,ONsec,OFFsec,ONthird,OFFthird);

% Calculate peak response of stim On/Off set (The baseline is the mean
% response before the On/Offset)
PeakONfirst=max(ONfirst,[],1)-mean(ONfirst([1:19],:));
PeakOFFfirst=max(OFFfirst,[],1)-mean(OFFfirst([1:19],:));

PeakONsec=max(ONsec,[],1)-mean(ONsec([1:19],:));
PeakOFFsec=max(OFFsec,[],1)-mean(OFFsec([1:19],:));

PeakONthird=max(ONthird,[],1)-mean(ONthird([1:19],:));
PeakOFFthird=max(OFFthird,[],1)-mean(OFFthird([1:19],:));

StimPeaks241=[PeakONfirst;PeakOFFfirst;PeakONsec;PeakOFFsec;PeakONthird;PeakOFFthird];


%saves variable as new mat file with matching name
save(strcat(data(1:size(data,2)-6),'Peaks12.mat'),'StimResponses241','StimPeaks241');


% plotting the Time series for the full recording for each of the 12
% regions
f=figure

clear C

 C(:,1)=[1,0,0];
 C(:,2)=[0,1,0];
 C(:,3)=[0,0,1];
 C(:,4)=[0.8,0.8,0];
 C(:,5)=[0,1,1];
 C(:,6)=[1,0,1];

D=Brain;
 
Imax=size(D,1);
h=10;

%naming y-axis-ticks with brain regions and plotting it
regionslist={'OL';'CX';'LX';'LH';'PENP';'INP';'VMNP';'MB';'AL';'SNP';'VLNP';'GNG'};
yaxticks=[10:10:120];

Dh=0
for i=1:size(D,2)
Dhnew=Dh+max((D(:,i)-mean(D(:,i))))-min((D(:,i)-mean(D(:,i))));
yaxticks(i)=Dh+(Dhnew-Dh)/2;
Dh=Dhnew;
end
axes1 = axes('Parent',f,...
    'YTickLabel',regionslist,...
    'YTick',yaxticks);

%rescaling x-axis from tenth-of-sec to sec for recordings with framerate of
%10 Hz
time=length(D(:,1))/10
timescale=time*10
if time >= 100
    xaxticks=[0:10:time+10]
    timescale=(time*10)+100
else
    xaxticks=[0:10:time+1]
    timescale=(time*10)+10
end

set(axes1, 'Xtick', [0:100:timescale]);
set(axes1,'XTickLabel',xaxticks);
ax = gca;
ax.YAxis.FontSize=10;
ylim(axes1,[0 Dhnew]);

box(axes1,'on');
hold(axes1,'on');

%plotting the data
Dh=0
for i=1:size(D,2)
i-ceil((i-6)/6)*6
Dhnew=Dh+max((D(:,i)-mean(D(:,i))))-min((D(:,i)-mean(D(:,i))));
plot((D(:,i)-mean(D(:,i)))+Dh+(Dhnew-Dh)/2,'color',C(:,i-ceil((i-6)/6)*6),'LineWidth',1);
x1 = 0.005*Imax+2;
y1 =Dh+(Dhnew-Dh)/2;
str1 = int2str(i);

hold on
yaxticks(i)=Dh+(Dhnew-Dh)/2
Dh=Dhnew;
end


% add vertical lines for beginning and end of stimulus
xline(OnThird, '-','Third');
xline(OffThird);
xline(OnSec, '-','Second');
xline(OffSec);
xline(OnFirst, '-','First');
xline(OffFirst);

ylabel('Brain Regions', 'fontsize',15);
xlabel('Time in sec','fontsize',15);
title('Average GCamp Signal'); 
