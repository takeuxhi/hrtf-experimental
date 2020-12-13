%% octave band filter
function [fil] = octfilt(x,octaves,fs)
    N = length(x);
    dt = 1/fs;
    df = 1/N/dt;
    fil = zeros(N,length(octaves));
    for ii = 1:length(octaves)
        f_center = octaves(ii);
        f_low = f_center./sqrt(2);
        f_high = f_center*sqrt(2);
        if f_high > (fs/2)
            f_high = fs/2-1;
        end
        [b,a] = butter(3, [f_low f_high]/(fs/2));
        fil(1:N,ii) = filter(b,a,x);
    end
end