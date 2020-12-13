function [x_n,t_n] = ifftcsd(Sxy,fs)
    N = length(Sxy);
    dt = 1/fs;
    df = 1/N/dt;
    arr = 1-ceil(N/2);
    Sxy = circshift(Sxy,arr);

    x_n = ifftm(Sxy,fs);
    x_n = circshift(x_n,arr);

    t_n = (0:N-1)*dt;t_n=t_n.';
    t_n = t_n - (ceil(N/2)-1)*dt;
end