%% TIME AVERAGING
function [Gxx_av,f_half] = timeavm(x,fs,N_av)
    N = size(x,1);
    N_r = floor(length(x)/N_av);
    T = N/fs;
    dt = 1/fs;
    t = (0:N-1)*dt;t=t.';
    df = 1/N/dt;
    f = (0:N-1)*df;f=f.';
    onst = zeros(N_av,1);
    
    for jj = 1:N_av
            onst(jj) = (jj-1)*N_r+1;
    end
    
    t_set = zeros(N_r,N_av);
    x_set = zeros(N_r,N_av);
    
    for ii = 1:N_av
        t = (onst(ii)-1:onst(ii)+N_r-2)*dt;t = t.';
        t_set(1:end,ii) = t;
        x_int = x(onst(ii):onst(ii)+N_r-1);
        x_set(1:end,ii) = x_int;
    end
    
    x_av = (sum(x_set,2)/N_av);
    [~,Gxx_av,f_half] = psdm(x_av,fs);

end