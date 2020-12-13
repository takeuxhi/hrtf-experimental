function [sig,t_total] = signalgen(T,Tp,Tf,fs,N_rep,f_target,fmin,fmax,type)
    N_total = T*fs;
    N_pulse = Tp*fs;
    N_fade = Tf*fs;
    dt = 1/fs;
    t_total = (0:N_total-1)*dt;t_total=t_total.';
    t_pulse = (0:N_pulse-1)*dt;t_pulse=t_pulse.';
    sig = zeros(N_total,1);
    
    switch type
        case 'white'
            [sig(1:N_pulse)] = ones(N_pulse,1);
            for ii = 2:N_pulse/2
                phase = 2*pi*rand();
                X(ii) = exp(1j*phase);
                X(N_pulse-(ii-2)) = exp(-1j*phase);
            end
            sig = ifft(X)/dt;
            sig = 0.001*sig;
            sig = sig';
        case 'pink'
            [sig(1:N_pulse)] = noisegen(N_pulse,fs,'pink');
        case 'impulse'
            sig(1) = 1;
        case 'cwpulse'
            sig(1:N_pulse) = sin(2*pi*f_target*t_pulse);
        case 'linchirp'
            phi = 2*pi*((fmax-fmin)/(2*Tp)*t_pulse.^2 + fmin*t_pulse);
            sig(1:N_pulse) = sin(phi);
        case 'logchirp'
            phi = 2*pi*fmin*Tp/log(fmax/fmin)*((fmax/fmin).^(t_pulse/Tp)-1);
            sig(1:N_pulse) = sin(phi);
        otherwise
            disp('signal type not found')  
    end
    
%     fade_window = hann(2*N_fade);
%     fade_window = fade_window(1:N_fade);
%     sig_fade = sig;
%     for ii = 1:N_fade
%         sig_fade(ii) = sig(ii)*fade_window(ii);
%         sig_fade(length(sig(1:N_pulse))-ii+1) = sig(length(sig(1:N_pulse))-ii+1)*fade_window(ii);
%     end
%     sig_full = repmat(sig_fade,[N_rep,1]);
%     t_full = (0:N_total*N_rep-1)*dt;t_full=t_full.';
end