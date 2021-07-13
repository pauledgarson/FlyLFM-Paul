%% Extracts data from dff-file for the 21 regions (neuropil supercategories) the anatomical mask and averages the response for both hemispheres (i.e reducing the number of regions to 12)

clear all

%open mask (TransformedSeperate.nii)
[FileName,PathName] = uigetfile('*.nii','Select the Nifti file (Mask)','/home/paul/Desktop');
file=strcat(PathName,FileName)
M=MRIread(file);
Mask=M.vol;

%Mask=1-Mask;%use that line if mask from segmentation editor
%Md=double(M);

% open data (dffskf.nii)
[FileName,PathName] = uigetfile('*.nii','Select the Nifti file (Data)','/home/paul/Desktop');
file=strcat(PathName,FileName)
D=MRIread(file);
Data=D.vol;

% extracting data for regions
S=size(Data);
M2=Mask./max((max(max(max(Mask)))));
SM2=size(M2);
Data(isnan(Data))=0;

for i=1:S(4)
    for j=1:SM2(4)
        Sm(i,j)=sum(sum(sum(M2(:,:,:,j).*squeeze(Data(:,:,:,i)))))/sum(sum(sum(M2(:,:,:,j))));
    end
end

Sm(isnan(Sm))=0;

save(strcat(file(1:size(file,2)-4),'TSROI_21.mat'),'Sm');


% creates variables and combines appropriate regions from both hemispheres
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

% calculates the average signal for regions in both hemispheres
Brain=[mean(OL,2),CX,mean(LX,2),mean(LH,2),PENP,mean(INP,2),mean(VMNP,2),mean(MB,2),mean(AL,2),mean(SNP,2),mean(VLNP,2),GNG];

% saves variable as new mat file with matching name
save(strcat(file(1:size(file,2)-6),'mean12.mat'),'Brain');