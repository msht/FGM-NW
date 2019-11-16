%This code will plot the stress-strain graphs of the result files, and
% plot the Elastic modulus and ultimate tensile stresses against the
% parameters along with the bounds
%use saveornot=1 if you'd like to save the figures
%-Md Shajedul Hoque Thakur
clear;
saveornot=0;
Ecu=[52.3748667188447];
Eni=[115.201207743188];
Ucu=[5.95746430507542];
Uni=[13.4722239520955];
%addr = 'G:\tension-20190918T154134Z-001\tension\';
addr = 'G:\Results\';
count=1;
allE={};
allU={};
for jj=["pfgm" "efgm" "sfgm"]
data=[];
l=[];
for i=[0.1 0.2 0.5 1 2 5 10]
    if jj=="sfgm"
        if i<1
            continue;
        end
        if i==5
            i=4;
        end
    end
	filename = [addr char(jj) '\TENSION\' char(string(i)) '\result_final.txt'];
    %filename = [addr char(jj) '\' char(string(i)) '\result_final.txt'];
    if exist(filename, 'file') ~= 2
        continue;
    end
	p=dlmread(filename,' ', 1,0);
    if length(p)<length(data)
        p(length(p):length(data),:)=zeros((length(data)-length(p)+1),3);
    end
    data =[data p(:,2)];
    
    l=[l "{\it p} = "+string(i)];
end
if length(p)<1
    continue;
end
strain = p(:,1);
strain = strain'*100;
ultimate=[];
ustrain=[];
E=[];
data=data';


colorr='rgbcmyk';


[M,I]=max(data(1,:));

j=1;
figure();
for i=[0.1 0.2 0.5 1 2 5 10]
    stress=sgolayfilt(sgolayfilt(data(j,:),1,3),1,3);
    if jj=="sfgm"
        if i<1
            continue;
        end
        if i==5
            i=4;
        end
    end
    [M,I]=max(data(j,:));
    plot(strain,stress,colorr(j),'linewidth',4,'DisplayName',char(l(j))); hold on;
    p = polyfit(strain(1:I),data(j,1:I),3);
    E=[E p(3)];
    ultimate=[ultimate M];
    ustrain=[ustrain strain(I)];
    j=j+1;
end
E=E*100;
legend('Location','northwest');
xlabel('Strain (%)');
ylabel('Stress (GPa)');
ylim([0 13]);
%xlim([0 round(max(ustrain))+10]);
xlim([0 20]);
name =['C:\Users\mshta\Dropbox\MMMRN 15 BATCH FGM\Figures\' char(jj) ''];
myplot(name,1,saveornot);
allE{count}=E;
allU{count}=ultimate;
count=count+1;
end

bounds
plotU