
f=figure

clear C

 C(:,1)=[1,0,0];
 C(:,2)=[0,1,0];
 C(:,3)=[0,0,1];
 C(:,4)=[0.8,0.8,0];
 C(:,5)=[0,1,1];
 C(:,6)=[1,0,1];

% Input the number of components of interest 
componentlist=[5 37 89 195];
yaxticks=[10:10:length(componentlist)];

D=TSo(:,componentlist);
 
Imax=size(D,1);
h=10;

Dh=0
for i=1:size(D,2)
Dhnew=Dh+max((D(:,i)-mean(D(:,i))))-min((D(:,i)-mean(D(:,i))));
yaxticks(i)=Dh+(Dhnew-Dh)/2;
Dh=Dhnew;
end
axes1 = axes('Parent',f,...
    'YTickLabel',componentlist,...
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
% for i=1:size(D,2)
% i-ceil((i-6)/6)*6
% plot((D(:,i)-mean(D(:,i)))/sqrt(var(D(:,i)))+h*i,'color',C(:,i-ceil((i-6)/6)*6));
% x1 = 0.005*Imax+2;
% y1 = h*i;
% str1 = int2str(i);
% %text(x1,y1,str1)
% hold on
% end


xline(281, '-','Sucrose');
xline(321);
xline(621, '-','Water');
xline(666);
xline(924, '-', 'Quinine');
xline(967);


ylabel('Component #', 'fontsize',12);
xlabel('Time in sec','fontsize',12);
title('Average GCamp Signal'); 



%savefig('RegionTS.fig')
%ylim([-h h*(i+10)])
%  plot(Tvid(503:3557)-Tvid(503),13-Walk862*5+h*i,'r+')
%  plot(Tvid(503:3557)-Tvid(503),13-Idle862*5+h*i,'b+')
%  plot(Tstim,Stim-2,'m+')
%  plot(Tstim,Stim + h*i + 15,'m+')
