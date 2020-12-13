%% NOISE GENERATOR
function [x] = noisegen(N,fs,type)
    dt = 1/fs;
    switch type
        case 'white'
            X = ones(N,1);
            for ii = 2:N/2
                phase = 2*pi*rand();
                X(ii) = exp(1j*phase);
                X(N-(ii-2)) = exp(-1j*phase);
            end
            x = ifft(X)/dt;
            x = 0.001*x;
            x = x';
        case 'pink'
            X = ones(N,1);
            k = (1:N/2).';
            for ii = 2:N/2
               phase = 2*pi*rand();
               X(ii) = X(ii)*exp(1j*phase)/sqrt(fs/N*k(ii));
               X(N-(ii-2)) = X(N-(ii-2))*exp(-1j*phase)/sqrt(fs/N*k(ii));
            end
            x = ifft(X)/dt;
        otherwise
            disp('noise type not found')
    end
end