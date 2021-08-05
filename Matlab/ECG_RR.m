[signal,Fs,tm]=rdsamp('mitdb/109',1,10000) ;
[ann,type] = rdann('mitdb/109', 'atr',1,10000,[],'L') ; 

disp(strcat('ANN=',num2str(ann/360)));


figure
disp(num2str(length(signal)));
disp(num2str(length(tm)));
plot(tm,signal)
hold on
plot(tm(ann),signal(ann),'ro')
xlabel('Seconds')

ylabel('Amplitude')
title('Subject - MIT-BIH 100')
wt = modwt(signal((19/360):(3587/360)),5);
wtrec = zeros(size(wt));
wtrec(4:5,:) = wt(4:5,:);
y = imodwt(wtrec,'sym4');
y = abs(y).^2;
[qrspeaks,locs] = findpeaks(y,tm,'MinPeakHeight',0.30,...
'MinPeakDistance',0.150);
[rrlocs] = zeros(34,1);
for f=2:length(locs)
    rrlocs(f) = locs(f) - locs(f-1);
  
end    
%disp(strcat('R location = ',num2str(locs)));
%disp(strcat('RR interval = ',num2str(rrlocs)));
figure
plot(tm,y)
hold on
plot(locs,qrspeaks,'ro')
xlabel('Seconds')
title('R Peaks Localized by Wavelet Transform with Automatic Annotations')