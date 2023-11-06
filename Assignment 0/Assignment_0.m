% load data
data1 = load("./Data_Assignment_0/data1.mat").data1;
data2 = load("./Data_Assignment_0/data2.mat").data2;
data3 = load("./Data_Assignment_0/data3.mat").data3;

%% data sampling frequencies [Hz]
fs1 = 2000;
fs2 = 166;
fs3 = 250;

% calculate time axis for each dataset
t1 = 0:1/fs1:(length(data1)-1)/fs1;
t2 = 0:1/fs2:(size(data2,2)-1)/fs2;
t3 = 0:1/fs3:(length(data3)-1)/fs3;


%% plot data1
figure();
plot(t1, data1);
grid on;
title("Data 1 - EMG");
xlabel("time [s]");

%% fft estimation for EMG signal considering locally stationarity subset
data1_stat = data1(30000:32000);
L1 = length(data1_stat);
fft_1 = fft(data1_stat);
fft_1_shift = fftshift(fft_1);
fft_1_shift_oneSide = fft_1_shift(1:L1/2+1);
f1 = (fs1/L1)*(L1/2:-1:0);
figure();
plot(f1, abs(fft_1_shift_oneSide));
title("Qualitative FFT data 1 - EMG");
subtitle("samples from 30000 to 32000");
xlabel("frequency [HZ]");
grid on;

%% comments on data 1
% - base noisy
% - zero mean
% - activation observable due to different amplitude
% - difficulty to recognize a clear threshold for determine when an
%   activation starts
% - different levels of activations
% - looking at the time series, it is difficult to estimate the content
%   frequency
% - missing unit on amplitude, so it is not possible evaluate it

%% plot data2
figure();
subplot(2,1,1);
plot(t2, data2(1,:)); hold on;
plot(t2, data2(2,:));
grid on;
title("Data 2 - motion")
xlabel("time [s]");

subplot(2,1,2);
plot(data2(1,:),data2(2,:));
grid on;
title("Data 2 - Motion");

%% comments on data 2
% - signal clean, apparently without noise
% - dynamics slower than data 1 and data 2
% - presence of constant levels
% - presence of peaks and valleys
% - missing unit on amplitude, so it is not possible evaluate it

%% plot data3
figure();
plot(t3, data3);
grid on;
title("Data 3 - EEG");
xlabel("time [s]");

%% comments on data 3
% - noisy
% - not a clear pattern
% - lower frequency than data 1
% - not a clear mean
% - missing unit on amplitude, so it is not possible evaluate it