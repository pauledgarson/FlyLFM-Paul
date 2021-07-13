
f=figure

clear C

 C(:,1)=[1,0,0];
 C(:,2)=[0,1,0];
 C(:,3)=[0,0,1];
 C(:,4)=[0.8,0.8,0];
 C(:,5)=[0,1,1];
 C(:,6)=[1,0,1];

D=TSo;
 
Imax=size(D,1);
h=10;

%naming y-axis-ticks with brain regions and plotting it
regionslist={'AME_R';'LO_R';'NO';'BU_R';'PB';'LH_R';'LAL_R';'SAD';'CAN_R';'AMMC_R';'ICL_R';'VES_R';'IB_R';'ATL_R';'CRE_R';'MB-PED_R';'MB-VL_R';'FLA_R';'LOP_R';'EB';'AL_R';'ME_R';'FB';'SLP_R';'SIP_R';'SMP_R';'AVLP_R';'PVLP_R';'IVLP_R';'PLP_R';'AOTU_R';'GOR_R';'MB-CA_R';'SPS_R';'IPS_R';'SCL_R';'EPA_R';'GNG';'PRW';'GA_R';'AME_L';'LO_L';'BU_L';'LH_L';'LAL_L';'AMMC_L';'ICL_L';'VES_L';'IB_L';'ATL_L';'CRE_L';'MB-PED_L';'MB-VL_L';'MB-ML_L';'FLA_L';'LOP_L';'AL_L';'ME_L';'SLP_L';'SIP_L';'SMP_L';'AVLP_L';'PVLP_L';'IVLP_L';'PLP_L';'AOTU_L';'GOR_L';'MB-CA_L';'SPS_L';'IPS_L';'SCL_L';'EPA_L';'GA_L'};
yaxticks=[10:10:750];

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
xline(1014, '-','Quinine');
xline(1090);
xline(743, '-','Water');
xline(909);
xline(330, '-','Sucrose');
xline(407);

ylabel('Brain Regions', 'fontsize',10);
xlabel('Time in sec','fontsize',10);
title('Average GCamp Signal'); 

