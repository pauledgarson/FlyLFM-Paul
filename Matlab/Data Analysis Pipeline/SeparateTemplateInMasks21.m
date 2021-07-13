%% Creating a Mask with 21 anatomical regions (neuropil supercategories) from a registered temmplate file

clear all

% opening registered template file (Transformed.nii)
[FileName,PathName] = uigetfile('*.nii','Select the registered template file','/home/paul/Desktop/');
file=strcat(PathName,FileName)
D=MRIread(file);
Masks=D.vol;
Sm=size(Masks);

% create mask with 87 regions
Masks2=zeros(Sm(1),Sm(2),Sm(3),87);

parfor j=1:87
    Masks2(:,:,:,j)=(Masks==j);
    j
end

% reduce number of regions to 75
load('87to75.mat');
Masks3=Masks2(:,:,:,VarName3);

% combine 75 regions into 21 large regions (neuropil supercategories)
load('75to21old.mat');

MasksLargeRegion=zeros(Sm(1),Sm(2),Sm(3),21);
for j=1:21
for i=1:75

        if (Regionslist21old(i)==j)

      MasksLargeRegion(:,:,:,j)=MasksLargeRegion(:,:,:,j)+Masks3(:,:,:,i);

      end

  end

end


out.vol=MasksLargeRegion;
err = MRIwrite(out,strcat(file(1:size(file,2)-4),'separate21.nii'));

