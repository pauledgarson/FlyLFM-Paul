clear all;

%fname = fileread('/media/NAS/Sophie/WalkProject/THDDC/THDDCVoxelsList.txt');
%fname = fileread('/media/NAS/Sophie/WalkProject/TH/THDDCVoxelsListSpont.txt');
fname = fileread('/media/NAS/Sophie/WalkProject/Vglut_Gad/Gad/GadAVoxelsListRbin.txt');

Nlist = strsplit(fname);
% 
% DRegion=MRIread('/media/NAS/Sophie/WalkProject/JRCShallowOnSmallJRC2018Template.nii');
% DataRegions=double(DRegion.vol);
% Sm=size(DataRegions);
% MasksRegions=zeros(Sm(1),Sm(2),Sm(3),87);
% load('87to75.mat')
% parfor j=1:75
%     MasksRegion(:,:,:,j)=(DataRegions==VarName3(j));
% end

%load('NeuralNetTransfer.mat')
load('GoodBadICnet.mat')
%PointsTemplate=readtable('/media/NAS/Sophie/WalkProject/SmallJRC2018Template.points','FileType','text','ReadVariableNames',false);
PointsTemplate=readtable('/media/NAS/Sophie/WalkProject/SmallJRC2018Template.points','FileType','text','ReadVariableNames',false);

St=[242 113 34];

%% Open all: IC.nii, ICTS.mat, .points ...


for j=1:ceil(size(Nlist,2)/4)
    
    load(Nlist{3+(j-1)*4});
    D=MRIread(Nlist{2+(j-1)*4});
    Data=double(D.vol);
    Datab = permute(Data,[2 1 3 4]);
    S=size(Data);
    Points=readtable(Nlist{1+(j-1)*4},'FileType','text','ReadVariableNames',false);

    file=Nlist{2+(j-1)*4}

% %% Make regression maps voxel-wise
% % Get regression coeff,R2,pvalues
% 
%     
% % 
for i=1:S(1)
    i
        for l=1:S(2)
            parfor k=1:S(3)
    mdl = fitlm(Rkd,squeeze(Data(i,l,k,:)));
    R2(i,l,k)=mdl.Rsquared.Ordinary;
    Coef(i,l,k)=mdl.Coefficients.Estimate(2);
    pval(i,l,k)=-log(mdl.coefTest);
            end
        end
end


out.vol=R2;
err = MRIwrite(out,strcat(file(1:size(file,2)-4),'R2.nii'));
out.vol=Coef;
err = MRIwrite(out,strcat(file(1:size(file,2)-4),'Coef.nii'));
out.vol=pval;
err = MRIwrite(out,strcat(file(1:size(file,2)-4),'pval.nii'));

    
    Coefb = permute(Coef,[2 1 3 4]);
    R2b= permute(R2,[2 1 3 4]);
    pvalb=permute(pval,[2 1 3 4]);
    
%% Zip points 
    k=1;
    for t=1:size(PointsTemplate,1)-1    
         for i=1:size(Points,1)-1
            if size(Points.Var3{i},2)==size(PointsTemplate.Var3{t},2)
            if all(Points.Var3{i} == PointsTemplate.Var3{t})
                if (size(Points,2)<6) 
                Xstr=split(Points.Var4(i),'"'); Ystr=split(Points.Var5(i),'"');Zstr=split(Points.Var1(i+1),'"');
                else
                Xstr=split(Points.Var4(i),'"'); Ystr=split(Points.Var5(i),'"');Zstr=split(Points.Var6(i),'"');
                end
                Xstrt=split(PointsTemplate.Var4(t),'"'); Ystrt=split(PointsTemplate.Var5(t),'"');Zstrt=split(PointsTemplate.Var6(t),'"');
                TempPoints(:,k)=[str2num(cell2mat(Xstrt(2))) str2num(cell2mat(Ystrt(2))) str2num(cell2mat(Zstrt(2)))];           
                DataPoints(:,k)=[str2num(cell2mat(Xstr(2))) str2num(cell2mat(Ystr(2))) str2num(cell2mat(Zstr(2)))];
                k=k+1;
                clear Xstr Xstrt Ystr Ystrt Zstr Zstrt
            end
            end
        end
    end
    


Coefb(isnan(Coefb))=0;
R2b(isnan(R2b))=0;
pvalb(isnan(pvalb))=0;


%% Thin plate
for x=1:St(1)
for y=1:St(2)
for z=1:St(3)

[wobject] = TPS3D(TempPoints',DataPoints',[x y z]);

    if (round(wobject(1))>0 && round(wobject(2))>0 && round(wobject(3))>0 && round(wobject(1))<S(2) && round(wobject(2))<S(1) && round(wobject(3))<S(3))
	Coefreg(x,y,z,1)=Coefb(round(wobject(1)),round(wobject(2)),round(wobject(3)));
	R2reg(x,y,z,1)=R2b(round(wobject(1)),round(wobject(2)),round(wobject(3)));
	pvalreg(x,y,z,1)=pvalb(round(wobject(1)),round(wobject(2)),round(wobject(3)));
    else
	Coefreg(x,y,z,1)=0;
	R2reg(x,y,z,1)=0;
	pvalreg(x,y,z,1)=0;

    end

end
end
end



Coefregb=permute(Coefreg,[2 1 3 4]);
R2regb=permute(R2reg,[2 1 3 4]);
pvalregb=permute(pvalreg,[2 1 3 4]);

CoeffregAll(:,:,:,j)=Coefregb;
R2egAll(:,:,:,j)=R2regb;
pvalregAll(:,:,:,j)=pvalregb;

out.vol=R2regb;
err = MRIwrite(out,strcat(file(1:size(file,2)-4),'R2reg.nii'));
out.vol=Coefregb;
err = MRIwrite(out,strcat(file(1:size(file,2)-4),'Coefreg.nii'));
out.vol=pvalregb;
 err = MRIwrite(out,strcat(file(1:size(file,2)-4),'pvalreg.nii'));
% 
 clear PeriodRight PeriodLeft out mdl pval pvalb pvalreg pvalregb Coef Coefb Coefreg Coefregb R2 R2b R2reg R2regb Data Datab Scoresc ScoresCl ScoresEM ScoresFC Scorescby2 ScoresClby2 ScoresEMby2 ScoresFCby2 GoodIC GoodICs

    clear R Rkd Rk Rs Rd TS PeriodStraight LeftPeriod RightPeriod BackPeriod StraightPeriod
    clear Mask 
    clear Data 
    clear M2q

clear NewValsc NewValsb NewVals Datar Data Datab Scoresc ScoresCl ScoresEM ScoresFC Scorescby2 ScoresClby2 ScoresEMby2 ScoresFCby2 GoodIC GoodICs

end

%% Put the maps together to make summaries
out.vol=R2egAll;
err = MRIwrite(out,strcat(file(1:size(file,2)-4),'R2voxelregAll.nii'));
out.vol=CoeffregAll;
err = MRIwrite(out,strcat(file(1:size(file,2)-4),'CoefvoxelregAll.nii'));
out.vol=pvalregAll;
err = MRIwrite(out,strcat(file(1:size(file,2)-4),'pvalvoxelregAll.nii'));
%% Put the maps together to make summaries
R2egAll(R2egAll==0)=nan;
R2AllMean=nanmean(R2egAll,4);
out.vol=R2AllMean;
err = MRIwrite(out,'/media/NAS/Sophie/WalkProject/GadR2voxelregAllMean.nii');
R2AllMedian=nanmedian(R2egAll,4);
out.vol=R2AllMedian;
err = MRIwrite(out,'/media/NAS/Sophie/WalkProject/GadR2voxelregAllMedian.nii');
out.vol=CoeffregAll;
err = MRIwrite(out,'/media/NAS/Sophie/WalkProject/GadCoefvoxelregAll.nii');
CoeffregAll(CoeffregAll==0)=nan;
CoeffAllMean=nanmean(CoeffregAll,4);
out.vol=CoeffAllMean;
err = MRIwrite(out,'/media/NAS/Sophie/WalkProject/GadCoefvoxelregAllMean.nii');
CoeffAllMedian=nanmedian(CoeffregAll,4);
out.vol=CoeffAllMedian;
err = MRIwrite(out,'/media/NAS/Sophie/WalkProject/GadCoefvoxelregAllMedian.nii');
out.vol=pvalregAll;
err = MRIwrite(out,'/media/NAS/Sophie/WalkProject/GadpvalvoxelregAll.nii');

CoeffregAlln=CoeffregAll;
for i=1:size(CoeffregAll,4)
    CoeffregAlln(:,:,:,i)=CoeffregAll(:,:,:,i)/max(max(max(CoeffregAll(:,:,:,i))));
end
out.vol=CoeffregAlln;
CoeffregAlln(CoeffregAlln==0)=nan;
err = MRIwrite(out,'/media/NAS/Sophie/WalkProject/GadCoefvoxelregAllNorm.nii');
CoeffAllMeann=nanmean(CoeffregAlln,4);
out.vol=CoeffAllMeann;
err = MRIwrite(out,'/media/NAS/Sophie/WalkProject/GadCoefvoxelregAllMeanNorm.nii');
CoeffAllMediann=nanmedian(CoeffregAlln,4);
out.vol=CoeffAllMediann;
err = MRIwrite(out,'/media/NAS/Sophie/WalkProject/GadCoefvoxelregAllMedianNorm.nii');

MontageMedian=squeeze(Montage(CoeffAllMediann,8));
MontageMedian(isnan(MontageMedian))=0;
imwrite(MontageMedian,'/media/NAS/Sophie/WalkProject/GadCoefvoxelregAllMedianNormMontage8.png')    
MontageMean=squeeze(Montage(CoeffAllMeann,8));
MontageMean(isnan(MontageMean))=0;
imwrite(MontageMean,'/media/NAS/Sophie/WalkProject/GadCoefvoxelregAllMeanNormMontage8.png')    
out.vol=MontageMedian;
err = MRIwrite(out,'/media/NAS/Sophie/WalkProject/GadCoefvoxelregAllMedianNormMontage8.nii');
out.vol=MontageMean;
err = MRIwrite(out,'/media/NAS/Sophie/WalkProject/GadCoefvoxelregAllMeanNormMontage8.nii');
