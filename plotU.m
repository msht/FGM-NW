saveornot=0;
allU{1}=[12.14 11.65 10.73 9.62 8.26 6.99 6.45];
allU{2}=[9.6100    9.2200    8.7100    8.4100    7.5800    6.7900    6.1900];
allU{3}=[9.35 10.11 10.26 10.48];
p=[0.1 0.2 0.5 1 2 5 10];
name='C:\Users\mshta\Dropbox\MMMRN 15 BATCH FGM\Figures\UTS_SFGM';
figure(); 
semilogx(p,allU{1},'^r','markerface','r','linewidth',4,'markersize',10); hold on;
semilogx(p,allU{2},'sg','linewidth',4,'markerface','g','markersize',10); hold on;

p=[1 2 4 10]; semilogx(p,allU{3},'ob','linewidth',4,'markerface','b','markersize',10); hold on;
xlabel('{\it p}');
xlim([0.09 11]); xticks([0.1 1 10]);
ylabel('Elastic Modulus (GPa)');
ylabel('Ultimate Tensile Stress (GPa)');
ylim([5 14]);
legend({'P-FGM' 'E-FGM' 'S-FGM'});
myplot(name,1,saveornot);