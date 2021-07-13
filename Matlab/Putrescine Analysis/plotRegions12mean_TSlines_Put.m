% %opens window to select and load dataset
% [file,path]=uigetfile('*.mat','Select TSROImean mat-file with 12 regions','/home/paul/Desktop');
% data=strcat(path,file)
% load(data)


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
plot((D(:,i)-mean(D(:,i)))/sqrt(var(D(:,i)))+h*i,'color',C(:,i-ceil((i-6)/6)*6));
x1 = 0.005*Imax+2;
y1 = h*i;
str1 = int2str(i);
%text(x1,y1,str1)
hold on
end
yaxticks(i)=Dh+(Dhnew-Dh)/2
Dh=Dhnew;
end


%edit to add vertical lines for beginning and end of stimulus
xline(1000,'--');
xline(1500,'--');
xline(2000,'--');
xline(2500,'--');
xline(3000,'--');

ylabel('Brain Regions', 'fontsize',15);
xlabel('Time in sec','fontsize',15);
title('Average GCamp Signal'); 

