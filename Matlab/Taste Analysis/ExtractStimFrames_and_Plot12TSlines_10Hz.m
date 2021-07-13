% opens window to select and load dataset
[file,path]=uigetfile('*.mat','Select TSROImean mat-file with 12 regions','/home/paul/Desktop');
data=strcat(path,file)
load(data)

OnS=832;
OffS=882;

OnW=515;
OffW=567;

OnQ=206;
OffQ=250;


ONsuc=Brain((OnS-10):(OnS+19),:);
OFFsuc=Brain((OffS-10):(OffS+19),:);


ONwat=Brain((OnW-10):(OnW+19),:);
OFFwat=Brain((OffW-10):(OffW+19),:);


ONqui=Brain((OnQ-10):(OnQ+19),:);
OFFqui=Brain((OffQ-10):(OffQ+19),:);

StimResponses163=cat(3,ONsuc,OFFsuc,ONwat,OFFwat,ONqui,OFFqui);


PeakONsuc=max(ONsuc,[],1)-mean(ONsuc([1:9],:));
PeakOFFsuc=max(OFFsuc,[],1)-mean(OFFsuc([1:9],:));

PeakONwat=max(ONwat,[],1)-mean(ONwat([1:9],:));
PeakOFFwat=max(OFFwat,[],1)-mean(OFFwat([1:9],:));

PeakONqui=max(ONqui,[],1)-mean(ONqui([1:9],:));
PeakOFFqui=max(OFFqui,[],1)-mean(OFFqui([1:9],:));

StimPeaks163=[PeakONsuc;PeakOFFsuc;PeakONwat;PeakOFFwat;PeakONqui;PeakOFFqui];


%saves variable as new mat file with matching name
save(strcat(data(1:size(data,2)-6),'Peaks12.mat'),'StimResponses163','StimPeaks163');


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
plot((D(:,i)-mean(D(:,i)))+Dh+(Dhnew-Dh)/2,'color',C(:,i-ceil((i-6)/6)*6));
x1 = 0.005*Imax+2;
y1 =Dh+(Dhnew-Dh)/2;
str1 = int2str(i);

hold on
yaxticks(i)=Dh+(Dhnew-Dh)/2
Dh=Dhnew;
end


% add vertical lines for beginning and end of stimulus
xline(OnQ, '-','Quinine');
xline(OffQ);
xline(OnW, '-','Water');
xline(OffW);
xline(OnS, '-','Sucrose');
xline(OffS);

ylabel('Brain Regions', 'fontsize',15);
xlabel('Time in sec','fontsize',15);
title('Average GCamp Signal'); 
