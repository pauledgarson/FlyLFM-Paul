
%% Summarizes TSROI dataset with 21 brain regions into 12 regions and averages the signal in both hemispheres

clear all

%opens window to select and load dataset
[file,path]=uigetfile('*.mat','Select TSROI mat-file with 21 regions','/home/paul/Desktop');
data=strcat(path,file)
load(data)

%creates variables and combines appropriate regions from both hemispheres
OL=[Sm(:,1),Sm(:,13)];
CX=Sm(:,2);
LX=[Sm(:,3),Sm(:,14)];
LH=[Sm(:,4),Sm(:,15)];
PENP=Sm(:,5);
INP=[Sm(:,6),Sm(:,16)];
VMNP=[Sm(:,7),Sm(:,17)];
MB=[Sm(:,8),Sm(:,18)];
AL=[Sm(:,9),Sm(:,19)];
SNP=[Sm(:,10),Sm(:,20)];
VLNP=[Sm(:,11),Sm(:,21)];
GNG=Sm(:,12);

%calculates the average signal for regions in both hemispheres
Brain=[mean(OL,2),CX,mean(LX,2),mean(LH,2),PENP,mean(INP,2),mean(VMNP,2),mean(MB,2),mean(AL,2),mean(SNP,2),mean(VLNP,2),GNG];

%saves variable as new mat file with matching name
save(strcat(data(1:size(data,2)-6),'mean12.mat'),'Brain');

