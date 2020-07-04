%   EE 6265 ??? Luo WenSheng 107064426 HW2 10/30/2019

% 6 functions have been made for this assignment
% derivative: finds the derivative of the filtered ETS
% overlap: finds shift for the window given a window size
% getETS: finds the echo time shift
% findrange: finds the range for the calculated wavelength
% getstrain: finds strain using filtered ETS
% changevec: finds filtered ETS


clear all,close all,clc

load('FUS_RFData.mat')



[range,depth_axis,n]=findrange(FUS_pre, c0,fs,fc);

figure,
subplot(311),plot(depth_axis,FUS_pre)
title('RF signal before FUS heating')
subplot(312),plot(depth_axis,FUS_post)
title('RF signal during FUS heating')
subplot(313),plot(depth_axis,FUS_pre)
title('Both RF signals together')
hold on
plot(depth_axis,FUS_post,'r--')
hold off




window_sizes=[ 2 6 10];
overlapping_ratios=[0 0.5 0.75];

window_range=range*window_sizes;
results={};
Depths={};
Filtered_ETS={};

for i=1:length(window_range)

for j=1:length(overlapping_ratios)   
   
[out,depth]=getETS(FUS_pre,FUS_post,depth_axis,window_range(i),overlapping_ratios(j),fs);
results{i,j}=out;
Depths{i,j}=n*depth;
  

Filtered_ETS{i,j}=changevec(results{i,j});

end
figure
subplot(311),plot(Depths{i,1},results{i,1})
hold on
subplot(311),plot(Depths{i,1},Filtered_ETS{i,1},'r--')
title(['Plot for window size ',num2str(window_range(i)),' and overlapping ratio ',num2str(overlapping_ratios(1))])
xlabel('Depth')
ylabel('Echo time shift')
hold off

subplot(312),plot(Depths{i,2},results{i,2})
hold on
subplot(312),plot(Depths{i,2},Filtered_ETS{i,2},'r--')
title(['Plot for window size ',num2str(window_range(i)),' and overlapping ratio ',num2str(overlapping_ratios(2))])
xlabel('Depth')
ylabel('Echo time shift')
hold off


subplot(313),plot(Depths{i,3},results{i,3})
hold on
subplot(313),plot(Depths{i,3},Filtered_ETS{i,3},'r--')
title(['Plot for window size ',num2str(window_range(i)),' and overlapping ratio ',num2str(overlapping_ratios(3))])
xlabel('Depth')
ylabel('Echo time shift')
hold off
end


getstrain(Depths,Filtered_ETS,i+1,n,window_range,overlapping_ratios)


function c=changevec(signal)
l=length(signal);
size=round(l/10)+1;
c=[];
for i=1:l-size
sample=signal(i:i+size-1);  
c=[c mean([max(sample) mean(sample) mode(sample) median(sample) min(sample)])]; 

end

for i=l-size+1:l
remainder=l-i;
sample=(signal(i:i+remainder));
c=[c mean([max(sample) mean(sample) mode(sample) median(sample)]) ];    
% this is done to reduce variations in the signal before smoothing    
end   

 N=round(length(c)/3);
 c=conv(c, ones(1,N)/N);
 c=c(1:length(signal));
end

function getstrain(Depths,results,c,n,window_range,overlapping_ratios)
[m p]=size(results);
for i=1:m
figure(i+c)
for j=1:p  
y=derivative(results{i,j},n);
x=Depths{i,j}(2:length(y)+1);

subplot(310+j),plot(x,y)

title(['Strain plot for window size ',num2str(window_range(i)),' and overlapping ratio ',num2str(overlapping_ratios(j)),' with max: ',num2str(max(y)) ])

xlabel('Depth')
ylabel('strain')
end
end
end




function [out depth_axis n]=findrange(signal, c0,fs,fc)

Nsample=length(signal);
depth_axis=(0:1:(Nsample-1))*(c0/fs); 
n=depth_axis(2)-depth_axis(1);

wavelength=c0/fc;
%find location
axis=abs(depth_axis-wavelength);
out=find(axis==min(axis));
end



function [out depth]=getETS(signal_1,signal_2,depth_axis,window_range,overlapping_ratio,fs)
out=[];
next=overlap(window_range,overlapping_ratio);
k=window_range;
i=1;
depth=[];

while k>=window_range
 a=1+(next)*(i-1);
 b=a+(window_range-1);
 depth=[depth depth_axis(round((a+b)/2))];  
 
 [corr lag]=xcorr(signal_2(a:b),signal_1(a:b));   
 echo_time_shift=lag(find(corr==max(corr)) )/fs;% where ETS= lag*(1/fs)
 

out=[out abs(echo_time_shift)];
k=length(signal_1)-b;


i=i+1;
end
end


function out=overlap(x,r)
out=round(x*(1-r));
end

function out=derivative(x,n)%(y2-y1)/(x2-x1) where n=(x2-x1)

out=(1/n)*(x(2:end)-x(1:end-1));
end








