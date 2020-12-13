function sig_f = fade(sig,fs,Tf)
    N_fade = Tf*fs;
    fade_window = hann(2*N_fade);
    fade_window = fade_window(1:N_fade)
    sig_f = sig;
    for ii = 1:N_fade;
        sig_f(ii) = sig(ii)*fade_window(ii);
        sig_f(length(sig)-ii+1) = sig(length(sig)-ii+1)*fade_window(ii);
    end
end