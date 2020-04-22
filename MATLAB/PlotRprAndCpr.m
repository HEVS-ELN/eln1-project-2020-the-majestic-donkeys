path = 'C:\Cours\HES\ElN\Projets\eln1-project-2020-the-majestic-donkeys\data\ConductiveProbe\';
freq = [];
V1=[];
V2=[];
for k=0:4
file = [path 'R10k_' num2str(k) '.csv'];
data = readmatrix(file, 'Range', 2);

freq(:,k+1) = data(:,1);
V2(:,k+1) = 10.^(data(:,3)/20).*exp(1j*data(:,4)*pi/180);
Amp2(:,k+1) = 10.^(data(:,3)/20);
Phase2(:,k+1) = data(:,4)*pi/180;

end

R1 = 10000;
w = 2*pi.*freq;
s = w*1i;
Rscope = 1000000;
Cscope = 2.4e-11;
Rprtot = (R1.*Amp2.*sqrt(tan(Phase2).^2+1))./(1-Amp2.*sqrt(tan(Phase2).^2+1));
Cprtot = (-tan(Phase2).*(R1+Rprtot))./(Rprtot.*R1.*w);

Rpr = 1./((1./Rprtot)-(1./Rscope));
Cpr = Cprtot- Cscope;

K = Rprtot./(R1+Rprtot);
H = K.*(1./((Rprtot.*R1)./(Rprtot+R1).*s.*Cprtot+1));

index = 501;
f = freq(index);
wf = 2*pi*f;
R01 = 100000;

Amp00 = Amp2(index, 1);
Phase00 = Phase2(index, 1);
Rpr0 = (R01.*Amp00.*sqrt(tan(Phase00).^2+1))./(1-Amp00.*sqrt(tan(Phase00).^2+1));
Cpr0 = (-tan(Phase00).*(R01+Rpr0))./(Rpr0.*R01.*wf);

Amp01 = Amp2(index, 2);
Phase01 = Phase2(index, 2);
Rpr1 = (R01.*Amp01.*sqrt(tan(Phase01).^2+1))./(1-Amp01.*sqrt(tan(Phase01).^2+1));
Cpr1 = (-tan(Phase01).*(R01+Rpr1))./(Rpr1.*R01.*wf);

Amp02 = Amp2(index, 3);
Phase02 = Phase2(index, 3);
Rpr2 = (R01.*Amp02.*sqrt(tan(Phase02).^2+1))./(1-Amp02.*sqrt(tan(Phase02).^2+1));
Cpr2 = (-tan(Phase02).*(R01+Rpr2))./(Rpr2.*R01.*wf);

Amp03 = Amp2(index, 4);
Phase03 = Phase2(index, 4);
Rpr3 = (R01.*Amp03.*sqrt(tan(Phase03).^2+1))./(1-Amp03.*sqrt(tan(Phase03).^2+1));
Cpr3 = (-tan(Phase03).*(R01+Rpr3))./(Rpr3.*R01.*wf);

Amp04 = Amp2(index, 5);
Phase04 = Phase2(index, 5);
Rpr4 = (R01.*Amp04.*sqrt(tan(Phase04).^2+1))./(1-Amp04.*sqrt(tan(Phase04).^2+1));
Cpr4 = (-tan(Phase04).*(R01+Rpr4))./(Rpr4.*R01.*wf);

sprintf('.params freq=%e R1=%e Rpr0=%e Rpr1=%e  Rpr2=%e  Rpr3=%e  Rpr4=%e  Cpr0=%e  Cpr1=%e Cpr2=%e  Cpr3=%e Cpr4=%e', f, R01, Rpr0, Rpr1,Rpr2,Rpr3,Rpr4, Cpr0 , Cpr1 , Cpr2 , Cpr3 , Cpr4)

loglog(freq, Cpr);
hold;
loglog(freq, Rpr);