function [Sxx,Gxx,f_half] = psdmfft(xfft,fs)
    N = size(xfft,1);
    T = N/fs;
    dt = 1/fs;
    df = 1/N/dt;
    f = (0:N-1)*df;f=f.';
    Sxx = abs(xfft).^2/T;
    Gxx = zeros(floor(N/2)+1,1);
    Gxx(1) = Sxx(ceil(N/2));
    Gxx(2:end-1) = 2*Sxx(ceil(N/2)+1:end-1);
        if mod(N,2) == 0
            Gxx(end) = Sxx(end);
        else
            Gxx(end) = 2*Sxx(end);
        end
    f_half = [0:floor(N/2)]*df;f_half=f_half.';
end