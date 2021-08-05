[signal,Fs,tm]=rdsamp('mitdb/124',1);

%[ann,type] = rdann('mitdb/118', 'atr',1,10000,[],'L');

%disp(strcat('ANN=',num2str(ann(1)/360)));
%x = 1;
%y = 1231;

x = 94500;
y = 96500;
disp(strcat(num2str(x),num2str(y)));
analysis = RunBioSigKit(signal(x:y),Fs,0);
analysis.MTEO_qrstAlg();

timelimit = (y-x)/360;
tR = analysis.Results.R/360;
disp(strcat('Heart rate=',num2str(length(tR)*60/timelimit)));
locs = analysis.Results.P;
tP = (locs)/360; 
locsQ = analysis.Results.Q;
tQ = (locsQ)/360;  
locsS = analysis.Results.S;
tS = (locsS)/360;  

%[PRlocs] = zeros(length(tP),1);
%[QRSlocs] = zeros(length(tS),1);
[RRlocs] = zeros(11,1);
count =0;
for f=2:4
   count =0;
   RRlocs(f-1) = tR(f)-tR(f-1);
    
    disp(strcat('Count = ',num2str(count)));
end

for f=1:3
    RRlocs(3+f) = tS(f)-tQ(f);
   
end

disp(strcat('R locs = ',num2str(tR)));
disp(strcat('P locs = ',num2str(tP)));

for f=1:3
    RRlocs(6+f) = (tR(f)-tP(f)); 
end

RRlocs(10) = length(tR)*60/timelimit;
RRlocs(11) = 3;

%dlmwrite('M.csv',transpose(RRlocs),'delimiter',',','-append');

disp(strcat('RR intervals = ',num2str(RRlocs(1:3))));
disp(strcat('QRS intervals = ',num2str(RRlocs(4:6))));
disp(strcat('PR intervals = ',num2str(RRlocs(7:9))));
disp(strcat('Heart Rate = ',num2str(RRlocs(10))));

