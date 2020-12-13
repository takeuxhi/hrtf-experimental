clc; clear all; close all;
%% 
load control-front-white.mat
fs = 44100;
t = [1:length(data)]/fs;

[sig_fft,f] = fftm(data,fs);

figure(1)
subplot(2,1,1)
semilogx(f, 10*log10(sig_fft))
xlim([10,24000])
legend('Left Channel','Right Channel','Location','southwest', 'Interpreter', 'latex')
xlabel('Frequency (Hz)', 'Interpreter', 'latex')
ylabel('Sound Pressure Level (dB)', 'Interpreter', 'latex')
set(gca,'TickLabelInterpreter', 'latex')
grid on
subplot(2,1,2)
semilogx(f, unwrap(angle(sig_fft)))
xlim([10,24000])
% title('In-Ear Frequency Response at Elevation 0° Azimuth 90° (Phase)','Interpreter', 'latex')
legend('Left Channel','Right Channel','Location','southwest', 'Interpreter', 'latex')
xlabel('Frequency (Hz)', 'Interpreter', 'latex')
ylabel('Phase Angle (Rad)', 'Interpreter', 'latex')
set(gca,'TickLabelInterpreter', 'latex')
grid on
saveas(gcf, 'mic', 'epsc')
%%
T = 5;
Tp = T;
Tf = 0;
fs = 44100;
N_rep = 1;
f_target = 0;
fmin = 20;
fmax = 20000;
type = 'logchirp'; 
[ref,t] = signalgen(T,Tp,Tf,fs,N_rep,f_target,fmin,fmax,type);

[ref_fft,f] = fftm(ref,fs);
h = ifft(sig_fft./ref_fft);

[hrir,t] = ifftm(h,fs);

figure(2)
plot(t,hrir)
legend('Left Channel','Right Channel','Location','southwest', 'Interpreter', 'latex')
xlabel('Time (s)', 'Interpreter', 'latex')
ylabel('Amplitude (V)', 'Interpreter', 'latex')
saveas(gcf, 'fig_name', 'epsc')