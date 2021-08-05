[signal,Fs,tm]=rdsamp('mitdb/105',1,20000);

%[ann,type] = rdann('mitdb/118', 'atr',1,10000,[],'L');

%disp(strcat('ANN=',num2str(ann(1)/360)));
x = 13;
y = 3978;
analysis = RunBioSigKit(signal,Fs,0);
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

[PRlocs] = zeros(length(tP),1);
for f=1:length(tP)
    PRlocs(f) = tR(f) - tP(f); 
end

%writematrix(PRlocs,'M.csv') 

disp(strcat('R locs = ',num2str(tR)));
disp(strcat('R locs = ',num2str(tP)));

disp(strcat('PR intervals = ',num2str(PRlocs)));