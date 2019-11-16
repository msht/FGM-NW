natural_frequency=[];
addr='G:\vibration_results_last\sfgm';
yall=[0 0];
xall=[0 0];
x=5;    %arbitrary constant that needs to be adjusted to find the two frequencies. x=5 works for most cases.
for p=[1 2 4 10]
filename =[addr '\' char(num2str(p)) '\result.txt']; 
data = dlmread(filename,' ',1,0); %pe or ke ar data read kore%
data=data(:,2);
a=mean(data);
n=length(data);
data=data-mean(data);
length(data);
n=length(data);
Ts=1e-15;
Fs=1/Ts;
NFFT = 2^nextpow2(n);
Y = fft(data,NFFT)/n;
f = Fs/2*linspace(0,1,NFFT/2+1);
f=f(673:end); %673 is the number of data points upto which the values are random.
f=f/1e9;
Y_f=2*abs(Y(1:NFFT/2+1));
Y_f=Y_f(673:end);
maxx=max(Y_f);
result = find(Y_f==maxx);
f_max=f(result);
x1=f_max;
y1=maxx;
figure();
plot(f,Y_f,'k-','linewidth',3);

a1=Y_f(1:result-x);
a2=Y_f(result+4:end);
Y_f=[a1;a2];
a1=f(1:result-x);
a2=f(result+4:end);
f=[a1 a2];


maxx=max(Y_f);
result = find(Y_f==maxx);
f_max2=f(result);
x2=f_max2;
y2=maxx;
%ylim([0 4])
xlim([x1-x1*0.1 x2+x2*0.1]);
hold on;
plot([x1 x2],[y1 y2],'*r','markersize',15,'linewidth',2);
text(x1-0.05*x1,y1,[num2str(x1,'%.1f') 'GHz'],'Color','black','FontSize',20,'fontweight','bold')
text(x2+0.005*x2,y2,[num2str(x2,'%.1f') 'GHz'],'Color','black','FontSize',20,'fontweight','bold')
natural_frequency = ( x1 + x2 ) /4
ylabel('Amplitude of the DFT');
xlabel('Frequency (GHz)');
myplot('spectrum',0,0);
end