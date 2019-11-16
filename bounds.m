%This code is meant to be run by the graphs_E_UTS.m as it uses values from
%there
%-Md Shajedul Hoque Thakur
q=[-199.1075 -72.1687 83.721]; %These are the values of empirical fitting parameters of Timura micromechanical model of P-FGM, E-FGM and S-FGM respectively
for ii=[3 2 1]
y=[];
Voigt=[];
Reuss=[];
HUPPER=[];
HLOWER=[];
figure();
p=[0.1 0.2 0.5 1 2 5 10];
if ii==3
    p=[1 2 4 10];
end
if ii==3
    plot(p,allE{ii},'k^','linewidth',4,'DisplayName','MD Result'); hold on;
else
    semilogx(p,allE{ii},'k^','linewidth',4,'DisplayName','MD Result'); hold on;
end

p=0.01:0.001:11;
if ii==3
    p=0.9:0.1:11;
end
for i=1:length(p)
    x=0:0.001:1;
    if ii==1
        y=x.^p(i); %PFGM
    elseif ii==2
        y=1-exp(-x.^p(i));  %EFGM
    else
        %%SFGM%%
        for j=1:length(x)
           if x(j)<0.5
               y(j)=0.5*(2*x(j)).^p(i);
           else
               y(j)=1-0.5*(2*(1-x(j))).^p(i);
           end
        end
        %%SFGM%%
    end
    for k=1:length(x)
       fni=y(k);
       fcu=1-fni;
       HL(k)=Ecu + fni / ((Eni - Ecu)^(-1)+fcu*(1+0.325)/(3*Ecu*(1-0.325)));
       HU(k)=Eni + fcu / ((Ecu - Eni)^(-1)+fni*(1+0.325)/(3*Eni*(1-0.325)));
       V(k)=Ecu*fcu + Eni*fni;
       R(k)=1/(fcu/Ecu +fni/Eni);
    end
    HLOWER(i)=2*trapz(x,HL.*x);
    HUPPER(i)=2*trapz(x,HU.*x);
    Voigt(i)=2*trapz(x,V.*x);
    Reuss(i)=2*trapz(x,R.*x);
    
    Y=(((1-y)*Ecu*(q(ii)-Eni)+y*Eni*(q(ii)-Ecu))/((1-y)*(q(ii)-Eni)+y*(q(ii)-Ecu)))*x;
    tamura(i) = 2*trapz(x,Y);
end
YY=[Voigt' Reuss' HUPPER' HLOWER' tamura'];
if ii==3
    plot(p,YY,'linewidth',3); 
else
    semilogx(p,YY,'linewidth',3); 
end
%{
plot(p,Voigt,'displayname','Voigt Model','linewidth',3); hold on;
plot(p,Reuss,'displayname','Reuss Model','linewidth',3); hold on;
plot(p,HUPPER,'displayname','HS Upper Bound','linewidth',3); hold on;
plot(p,HLOWER,'displayname','HS Lower Bound','linewidth',3); hold on;

plot(p,tamura,'displayname',tname,'linewidth',3); hold on;
%}
tname=['Tamura Model (' '{\it q_T = }' num2str(q(ii),3) ' GPa)'];
if ii==3
    xlim([0.9 11]);
else
    xlim([0.09 11]);
end
if ii~=3
    xticks([0.1 1 10]);
else
    xticks('auto');
end
ylim([50 120]);
xlabel('{\it p}');
ylabel('Elastic Modulus (GPa)');
legend({'Voigt Model' 'Reuss Model' 'HS Upper Bound' 'HS Lower Bound' tname},'location','best');
if ii==1
    legend('location','southwest');
end
name={'E_PFGM' 'E_EFGM' 'E_SFGM'};
name=['C:\Users\mshta\Dropbox\MMMRN 15 BATCH FGM\Figures\' name{ii}];
myplot(name,1,saveornot);
end
