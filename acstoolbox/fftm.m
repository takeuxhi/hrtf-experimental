function [x_fft, f_int] = fftm(x,fs)
 N = size(x,1);
 dt = 1/fs;
 df = 1/N/dt;
 f = (0:N-1)*df;f=f.';
 x_fft = fft(x)*dt;
 x_fft = [x_fft(floor(N/2)+2:end,:);x_fft(1:floor(N/2)+1,:)];
 f_int = [f(floor(N/2)+2:end)-fs;f(1:floor(N/2)+1)];
end