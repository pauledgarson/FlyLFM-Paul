PointsTemplate=readtable('/media/NAS/Sophie/WalkProject/SmallJRC2018Template.points','FileType','text','ReadVariableNames',false);
St=[242 113 34];


    Points=readtable(Nlist{2+(j-1)*4},'FileType','text','ReadVariableNames',false);

    
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
    
clear Points 

Datab(isnan(Datab))=0;


%% Thin plate
for x=1:St(1)
for y=1:St(2)
for z=1:St(3)

[wobject] = TPS3D(TempPoints',DataPoints',[x y z]);
for n=1:size(GoodICs,2)
    if (round(wobject(1))>0 && round(wobject(2))>0 && round(wobject(3))>0 && round(wobject(2))<S(2) && round(wobject(1))<S(1) && round(wobject(3))<S(3))
NewVals(x,y,z,n)=Datab(round(wobject(1)),round(wobject(2)),round(wobject(3)),GoodICs(n));
    else
NewVals(x,y,z,1)=0;        
    end
end
end
end

end


%out.vol=IregMC2;
NewValsb=permute(NewValsc,[2 1 3 4]);
NewValsfin=permute(NewVals,[2 1 3 4]);


out.vol=NewValsfin;
err = MRIwrite(out,strcat(file(1:size(file,2)-4),'JRC2018reg.nii'));
