% opens window to select and load dataset
[file,path]=uigetfile('*.mat','Select mat-file with IC time series','/home/paul/Desktop');
data=strcat(path,file)
load(data)


f=figure

clear C

 C(:,1)=[1,0,0];
 C(:,2)=[0,1,0];
 C(:,3)=[0,0,1];
 C(:,4)=[0.8,0.8,0];
 C(:,5)=[0,1,1];
 C(:,6)=[1,0,1];

% Input the number of components of interest 
componentlist=[9 28 54 63 64 74 89 97 152];
yaxticks=length(componentlist)*10;

D=TSo(:,componentlist);
 
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

set(gca, 'YTick', 10:10:yaxticks);
set(gca, 'YTickLabel', componentlist,'FontSize', 12);

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


xline(1000, '--');
xline(1500, '--');
xline(2000, '--');
xline(2500, '--');
xline(3000, '--');


ylabel('Component #', 'fontsize',12);
xlabel('Time in sec','fontsize',12);
title('Average GCamp Signal'); 



%savefig('RegionTS.fig')
%ylim([-h h*(i+10)])
%  plot(Tvid(503:3557)-Tvid(503),13-Walk862*5+h*i,'r+')
%  plot(Tvid(503:3557)-Tvid(503),13-Idle862*5+h*i,'b+')
%  plot(Tstim,Stim-2,'m+')
%  plot(Tstim,Stim + h*i + 15,'m+')
