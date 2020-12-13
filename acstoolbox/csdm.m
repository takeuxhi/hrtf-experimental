%% CROSS SPECTRAL DENSITY
function [Sxy,Gxy,Rxy,f_half,tau] = csdm(CH1,CH2,fs)
    N = length(CH1);
    T = N/fs;
    dt = 1/fs;
    df = 1/N/dt;
    f = (0:N-1)*df;f=f.';
    CH1fft = fftm(CH1,fs);
    CH2fft = fftm(CH2,fs);
    Sxy = 1/T*conj(CH1fft(:)).*CH2fft(:);
    Gxy = zeros(floor(N/2)+1,1);
    Gxy(1) = Sxy(ceil(N/2));
    Gxy(2:end-1) = 2*Sxy(ceil(N/2)+1:end-1);
        if mod(N,2) == 0
            Gxy(end) = Sxy(end);
        else
            Gxy(end) = 2*Sxy(end);
        end
    f_half = [0:floor(N/2)]*df;f_half=f_half.';
    [Rxy_n, tau] = ifftm(Sxy,fs);
    Rxy = [Rxy_n(ceil(N/2):end,:);Rxy_n(1:ceil(N/2)-1,:)];
    tau = tau - T/2;
end