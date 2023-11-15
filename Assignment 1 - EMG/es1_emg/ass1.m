%% load data
data = load("ES1_emg.mat").Es1_emg.matrix;
emg = data(:,1);

fs = 2000;
t = 0:1/fs:(length(emg)-1)/fs;
%% design filter and plot

% bpfilt = designfilt('bandpassfir', ...
%     'FilterOrder',20,'CutoffFrequency1',30, ...
%     'CutoffFrequency2',450,'SampleRate',2000);

bpfilt = designfilt('bandpassiir', ...
    'FilterOrder',20,'HalfPowerFrequency1',30, ...
    'HalfPowerFrequency2',450,'SampleRate',2000);

y = filtfilt(bpfilt,emg);
figure(1);
plot(t, emg); 
grid on
hold on
plot(t, y,'r');
%% 

% emg1 = emg(3000:18000);
% [pxx,f] = pwelch(emg1,[],[],[],2000);
% y1 = y(3000:18000);
% [y_pxx,y_f] = pwelch(y1,[],[],[],2000);
% 
% figure(2);
% plot(f,pxx);
% grid on
% hold on
% plot(y_f,y_pxx);

%% rectify the signal

y_rect = abs(y);
figure;
plot(t,y_rect);

%% compute the envelope

lpfilt = fir1(100,3/1000,'low');
y_envelope = filtfilt(lpfilt,1,y_rect);
grid on
hold on
plot(t,y_envelope, 'r');

%% Down-sample the envelope
f_downsampling = 20;
y_downsample = downsample(y_envelope, fs/f_downsampling);
t_downsampling = 0:1/f_downsampling:(length(y_downsample)-1)/f_downsampling;

plot(t_downsampling, y_downsample,'g');