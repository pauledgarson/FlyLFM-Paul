
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

%rescaling x-axis from to sec for recordings with framerate of 100 Hz
time=length(D(:,1))/100
timescale=time*100
if time >= 100
    xaxticks=[0:5:time+10]
    timescale=(time*100)+100
else
    xaxticks=[0:5:time+1]
    timescale=(time*100)+10
end

set(axes1, 'Xtick', [0:500:timescale]);
set(axes1,'XTickLabel',xaxticks);
ax = gca;
ax.YAxis.FontSize=7;
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


%edit to add vertical lines for beginning and end of stimulus
xline(1100, '-','Quinine');
xline(1295);
% xline(540, '-','Water');
% % xline(647);
% xline(1530, '-','Sucrose');
% xline(1740);

ylabel('Brain Regions', 'fontsize',10);
xlabel('Time in sec','fontsize',10);
title('Average GCamp Signal'); 

