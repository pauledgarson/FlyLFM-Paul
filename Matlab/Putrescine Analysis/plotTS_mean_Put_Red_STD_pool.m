%% Plots the average traces for the resposne to Putrescine for the animals of the Red Group (n=5)

% opens window to select and load multiple datasets
[file,path]=uigetfile('*.mat','Select TSROImeanTimeSeries mat-file with 12 regions','MultiSelect','on','/home/paul/Desktop/Putrescine Pool');
data=strcat(path,file)

for j=1:size(data,2)
load(data{j})
end

TimeSeriesPut307=cat(1,zeros(200,12),TimeSeriesPut307);
TimeSeriesPut307=TimeSeriesPut307([1:3398],:);

%Avering traces across animals
TimeSeriesPaul=cat(3,TimeSeriesPut2,TimeSeriesPut6,TimeSeriesPut7,TimeSeriesPut10,TimeSeriesPut11);
TimeSeriesPaul=TimeSeriesPaul([1:3398],:,:);
TimeSeriesSophie=cat(3,TimeSeriesPut307,TimeSeriesPut308);

TimeSeriesAvg=mean(cat(3,TimeSeriesPaul,TimeSeriesSophie),3);
% TimeSeriesAvg=median(cat(3,TimeSeriesPaul,TimeSeriesSophie),3);

f=figure

clear C

 C(:,1)=[1,0,0];
 C(:,2)=[0,1,0];
 C(:,3)=[0,0,1];
 C(:,4)=[0.8,0.8,0];
 C(:,5)=[0,1,1];
 C(:,6)=[1,0,1];

D=TimeSeriesAvg;
 
Imax=size(D,1);
h=10;

dim=size(D);
D_std=zeros(dim);
up_bound=zeros(dim);
low_bound=zeros(dim);
region_index=1:size(D,2);
time_index=1:size(D,1);


for i=region_index
%i-ceil((i-6)/6)*6
D_std(:,i)=(D(:,i)-mean(D(:,i)))/sqrt(var(D(:,i)));
D_01(:,i)=10*(D(:,i)-min(D(:,i)))/(max(D(:,i))-min(D(:,i)));

std(i)=sqrt(var(D_01(:,i)));
up_bound(:,i)=D_01(:,i)+5*std(i)/2+h*i;
low_bound(:,i)=D_01(:,i)-5*std(i)/2+h*i;
patch=[up_bound(:,i).' fliplr(low_bound(:,i).')];
i2=[time_index fliplr(time_index)];
color=C(:,i-ceil((i-6)/6)*6).';
f=fill(i2,patch,color,'facealpha',0.3,'edgealpha',0);
hold on;
plot(D_01(:,i)+h*i,'color',C(:,i-ceil((i-6)/6)*6));

%x1 = 0.005*Imax+2;
%y1 = h*i;
%str1 = int2str(i);
%text(x1,y1,str1)
end



%naming y-axis-ticks with brain regions and plotting it
regionslist={'OL';'CX';'LX';'LH';'PENP';'INP';'VMNP';'MB';'AL';'SNP';'VLNP';'GNG'};
set(gca, 'YTick', 10:10:120);
set(gca, 'YTickLabel', regionslist,'FontSize', 12);

%rescaling x-axis from tenth-of-sec to sec for recordings with framerate of
%10 Hz
time=length(D(:,1))/10;
timescale=time*10;
if time >= 100;
    xaxticks=[0:50:time+10];
    timescale=(time*10)+100;
else
    xaxticks=[0:50:time+1];
    timescale=(time*10)+10;
end

set(gca, 'Xtick', [0:500:timescale]);
set(gca,'XTickLabel',xaxticks);

%edit to add vertical lines for beginning of stimulus
xline(1000,'--');
xline(1500,'--');
xline(2000,'--');
xline(2500,'--');
xline(3000,'--');

ylabel('Brain Regions', 'fontsize',15);
xlabel('Time in sec','fontsize',15);
title('Average GCamp Signal (Virgin, n=7)'); 

%savefig('RegionTS.fig')
