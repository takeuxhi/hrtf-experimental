%% RMS AVERAGING
function [Gxx_av,Gxx_n,f_n] = psdavm(x,fs,ovrl,N_av)
    N = size(x,1);
    N_r = floor(length(x)/N_av);
    T = N/fs;
    dt = 1/fs;
    df = 1/N/dt;
    f = (0:N-1)*df;f=f.';
    if ovrl == 0
        x_n = zeros(floor(N/N_av),N_av);
        for ii = 1:N_av
        x_n(:,ii) = x((ii-1)*floor(N/N_av)+1:ii*floor(N/N_av));
        [Sxx_n(:,ii),Gxx_n(:,ii),~] = psdm(x_n(:,ii),fs);
        end
    else
        Gxx_n = zeros(floor(N_r/2)+1,N_av);
        t_n = zeros(N_r,N_av);
        x_n = zeros(N_r,N_av);
        for ii = 1:N_av
            % Take only N_r samples of x starting at ovrl(ii)
            t = (1+floor((1-ovrl)*N_r*ii):floor((1-ovrl)*N_r*ii+N_r))*dt;t = t.';
            t_n(1:end,ii) = t;
            x_int = x(1+floor((1-ovrl)*N_r*ii):floor((1-ovrl)*N_r*ii+N_r));
            x_n(1:end,ii) = x_int;
            % Find the power spectral density
            [Sxx_n(:,ii),Gxx_n(:,ii),~] = psdm(x_n(:,ii),fs);
        end
    end
    df_n = 1/N*N_av/dt;
    f_n = [0:floor(N/N_av/2)]*df_n;f_n=f_n.';
    Sxx_av = sum(Sxx_n,2)/N_av;
    Gxx_av = sum(Gxx_n,2)/N_av;
end