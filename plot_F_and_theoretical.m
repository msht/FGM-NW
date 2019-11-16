saveornot=0;
F{3}=[31.80 32.31 32.35 32.80];
F{2}=[30.74 30.59 29.975 29.225 27.78 25.84 24.62];
F{1}=[34.84 34.11 33.23 31.61 29.16 26.48 24.81];
theo_F{3}=[28.24 27.57 28.14 27.79];
theo_F{2}=[27.15 27.23 26.52 25.99 24.03 22.15 21.52];
theo_F{1}=[31.99 30.12 29.25 26.95 24.72 21.82 21.84];

L=196.65e-10;
D=37.8e-10;
A=1/4*pi*D^2;
I=1/64*pi*D^4;
tao=2.502;
for i=1:3
E=(1e9)*allE{i};

eta=2*tao*D*L^2./(E.*I);

R_f=sqrt(eta*0.025+1);

N_F{i}=R_f.*theo_F{i};
end
p=[0.1 0.2 0.5 1 2 5 10];
figure();
semilogx(p,F{2},'gs','markersize',10,'markerface','g','linewidth',4,'displayname','MD Result'); hold on;
semilogx(p,theo_F{2},'bo','markersize',10,'markerface','b','linewidth',4,'displayname','Euler–Bernoulli Beam Theory'); hold on;
semilogx(p,N_F{2},'r^','linewidth',4,'displayname','He-Lilley Theoretical Model'); hold on;
xlabel('{\it p}');
ylabel('Natural Frequency (GHz)');
legend('location','best'); xticks([0.1 1 10]); xlim([0.09 11]); ylim([20 36]); myplot('F_PFGM',1,saveornot);
figure();
semilogx(p,F{1},'gs','markersize',10,'markerface','g','linewidth',4,'displayname','MD Result'); hold on;
semilogx(p,theo_F{1},'bo','markersize',10,'markerface','b','linewidth',4,'displayname','Euler–Bernoulli Beam Theory'); hold on;
semilogx(p,N_F{1},'r^','linewidth',4,'displayname','He-Lilley Theoretical Model'); hold on;
xlabel('{\it p}');
ylabel('Natural Frequency (GHz)');
legend('location','best'); xticks([0.1 1 10]); xlim([0.09 11]); ylim([20 36]); myplot('F_EFGM',1,saveornot);
p=[1 2 4 10];
figure();
plot(p,F{3},'gs','markersize',10,'markerface','g','linewidth',4,'displayname','MD Result'); hold on;
plot(p,theo_F{3},'bo','markersize',10,'markerface','b','linewidth',4,'displayname','Euler–Bernoulli Beam Theory'); hold on;
plot(p,N_F{3},'r^','linewidth',4,'displayname','He-Lilley Theoretical Model'); hold on;
xlabel('{\it p}');
ylabel('Natural Frequency (GHz)');
legend('location','best'); xlim([0.09 11]); ylim([20 36]); myplot('F_SFGM',1,saveornot);