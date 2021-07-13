%% Plots average traces for similiar components in different animals

% opens window to select and load multiple datasets
[file,path]=uigetfile('*.mat','Select TS comp mat-file','MultiSelect','on','/home/paul/Subha');
data=strcat(path,file)

for j=1:size(data,2)
load(data{j})
end

LHcomp1=mean(TimeSeriesPutComp1(:,[37 52]),2);
LHcomp9=mean(TimeSeriesPutComp9(:,[84 85]),2);
LHcomp12=mean(TimeSeriesPutComp12(:,[27 29]),2);
LHcomp13=TimeSeriesPutComp13(:,79);

LHcompAvgGreen=mean(cat(2,LHcomp1,LHcomp9,LHcomp12,LHcomp13),2);

GNGcomp1=mean(TimeSeriesPutComp1(:,[39 54 120]),2);
GNGcomp12=mean(TimeSeriesPutComp12(:,[2 5 6 7 9 19 32]),2);
GNGcomp9=mean(TimeSeriesPutComp9(:,[9 19 41 73]),2);
GNGcomp13=mean(TimeSeriesPutComp13(:,[6 12 15 39]),2);

GNGcompAvgGreen=mean(cat(2,GNGcomp1,GNGcomp9,GNGcomp12,GNGcomp13),2);

MBcomp1=mean(TimeSeriesPutComp1(:,[22 23 24]),2);
MBcomp9=mean(TimeSeriesPutComp9(:,[46 60 139 163]),2);
MBcomp12=mean(TimeSeriesPutComp12(:,[44 47 64 69 99 185]),2);
MBcomp13=mean(TimeSeriesPutComp13(:,[100 115]),2);

MBcompAvgGreen=mean(cat(2,MBcomp1,MBcomp9,MBcomp12,MBcomp13),2);

CXcomp1=mean(TimeSeriesPutComp1(:,[6 18 36 51]),2);
CXcomp9=mean(TimeSeriesPutComp9(:,[3 12 16 37 45 173]),2);
CXcomp12=mean(TimeSeriesPutComp12(:,[134 159 167 170 186]),2);
CXcomp13=mean(TimeSeriesPutComp13(:,[17 19 31 32 34 40 68]),2);

CXcompAvgGreen=mean(cat(2,CXcomp1,CXcomp9,CXcomp12,CXcomp13),2);


LHcomp7=TimeSeriesPutComp7(:,48);
LHcomp10=mean(TimeSeriesPutComp10(:,[68 81]),2);
LHcomp11=mean(TimeSeriesPutComp11(:,[3 62]),2);

LHcompAvgRed=mean(cat(2,LHcomp7,LHcomp10,LHcomp11),2);

GNGcomp7=mean(TimeSeriesPutComp7(:,[9 20 21 22 24 25]),2);
GNGcomp10=mean(TimeSeriesPutComp10(:,[2 7 13 32 37 53]),2);
GNGcomp11=mean(TimeSeriesPutComp11(:,[32 45 51 108 121 134]),2);

GNGcompAvgRed=mean(cat(2,GNGcomp7,GNGcomp10,GNGcomp11),2);

MBcomp7=TimeSeriesPutComp7(:,89);
MBcomp10=TimeSeriesPutComp10(:,34);
MBcomp11=mean(TimeSeriesPutComp11(:,[15 31 33 44 105]),2);

MBcompAvgRed=mean(cat(2,MBcomp7,MBcomp10,MBcomp11),2);

CXcomp7=mean(TimeSeriesPutComp7(:,[11 18 76 102 133 142]),2);
CXcomp10=mean(TimeSeriesPutComp10(:,[27 40 84 118 179 214]),2);
CXcomp11=mean(TimeSeriesPutComp11(:,[9 28 63 64 89]),2);

CXcompAvgRed=mean(cat(2,CXcomp7,CXcomp10,CXcomp11),2);


CompAll=cat(2, LHcompAvgGreen,MBcompAvgGreen,GNGcompAvgGreen,CXcompAvgGreen,LHcompAvgRed,MBcompAvgRed,GNGcompAvgRed,CXcompAvgRed);



D=CompAll;

f=figure

clear C

 C(:,1)=[1,0,0];
 C(:,2)=[0,1,0];
 C(:,3)=[0,0,1];
 C(:,4)=[0.8,0.8,0];
 C(:,5)=[0,1,1];
 C(:,6)=[1,0,1];

 
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
up_bound(:,i)=D_01(:,i)+3*std(i)/2+h*i;
low_bound(:,i)=D_01(:,i)-3*std(i)/2+h*i;
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
set(gca, 'Ytick', [12 22 35 45 55 65 75 85]);
set(gca, 'YTicklabel', {'Mated-AL/LH','Mated-MB','Mated-GNG','Mated-CX','Virgin-AL/LH','Virgin-MB','Virgin-GNG','Virgin-CX'},'fontsize',12)

%edit to add vertical lines for beginning of stimulus
xline(1000,'--');
xline(1500,'--');
xline(2000,'--');
xline(2500,'--');
xline(3000,'--');

ylabel('Components', 'fontsize',15);
xlabel('Time in sec','fontsize',15);
title('Average GCamp Signal (n=4/3)');

