[signal,Fs,tm]=rdsamp('118',1,10000) ;
[ann,type] = rdann('118', 'atr',1,10000 ) ; 
analysis = RunBioSigKit(signal,Fs,0);
analysis.MTEO_qrstAlg();

tR = analysis.Results.R/360;
locs = analysis.Results.P;
tP = (locs)/360; 
locsQ = analysis.Results.Q;
tQ = (locsQ)/360;  
locsS = analysis.Results.S;
tS = (locsS)/360;  

[QRSlocs] = zeros(34,1);
for f=2:length(locs)
    QRSlocs(f) = tS(f) - tQ(f); 
end


disp(strcat('QRS intervals = ',num2str(QRSlocs)));