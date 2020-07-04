
clear all

tc = gauspuls('cutoff',50E3,.6,[],-40);
t  = -tc : 1E-6 : tc;
yi = gauspuls(t,50E3,.6); plot(t,yi)

pre = [zeros(1,20) yi zeros(1,20)];
post = [ zeros(1,10) yi, zeros(1,30)]; % post: 10 data point shift forward ~ time shift = 10*1E-6
subplot(2,1,1)
plot(1:length(pre), pre, 'b', 1:length(post), post, 'r--');
legend('pre','post')
xlabel('index (t = index*1/fs)')
ylabel('amplitude')
title('time shift: 10 indice')
[c,lag] = xcorr(pre,post); % how about [c, lag] = xcorr(pre,post,30)? [c,lag] = xcov(pre, post)? or [c, lag] = xcov(pre, post, 30)?
subplot(2,1,2)
plot(lag,c)
xlabel('lag')
ylabel('xcorr')
title('find the lag corresponding to the peak value')
axis([-40 50 -15 15])

[m,idx] = max(c);
time_shift = lag(idx) % find the lag where the xcorr is maximum, lag*1/fs = true time shift

