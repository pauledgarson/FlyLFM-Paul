%% Plots the average traces for the resposne to Putrescine for the animals of the Red Group (n=5)

% % opens window to select and load multiple datasets
% [file,path]=uigetfile('*.mat','Select TSROImeanTimeSeries mat-file with 12 regions','MultiSelect','on','/home/paul/Desktop');
% data=strcat(path,file)
% 
% for j=1:size(data,2)
% load(data{j})
% end

%Avering traces across animals
TimeSeriesAvg=mean(cat(4,TimeSeriesPut1,TimeSeriesPut9,TimeSeriesPut12,TimeSeriesPut13),4);

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


for i=1:size(D,2)
i-ceil((i-6)/6)*6
plot((D(:,i)-mean(D(:,i)))/sqrt(var(D(:,i)))+h*i,'color',C(:,i-ceil((i-6)/6)*6));
x1 = 0.005*Imax+2;
y1 = h*i;
str1 = int2str(i);
%text(x1,y1,str1)
hold on
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
title('Average GCamp Signal (Green, n=4)'); 

%savefig('RegionTS.fig')

