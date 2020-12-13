%% SPECTROGRAM
function [] = spectrog(t,f,Gxx_n)
    df = f(2)-f(1);
    dt = t(2)-t(1);
    fs = 1/dt;
    imagesc(t,f,Gxx_n);
    set(gca,'YDir','normal','FontSize',12);
    colormap('jet');
    colorbar();
    xlabel('Time (s)','FontSize',12)
    ylabel('Frequency (Hz)','FontSize',12)
end