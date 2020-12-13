%% A/C weighting filter
function [fil] =filt(f,type)
    f2 = 20.598997;
    f3 = 107.65265;
    f4 = 737.86223;
    f1 = 12194.217;
    switch type
        case 'C'
            fil = 1.0072.*(1j.*f).^2.*f1^2./(f1+1j.*f).^2./(f2+1j.*f).^2;
        case 'A'
            fil = 1.0072.*(1j.*f).^2.*f1^2./(f1+1j.*f).^2./(f2+1j.*f).^2.*1.250.*(1j.*f).^2./(f3+1j.*f)./(f4+1j.*f);
        otherwise
            disp('filter type not found')
end
