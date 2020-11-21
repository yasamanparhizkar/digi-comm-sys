function [ax] = draw_pulse(p, t, fft_L)
    %energy of pulse
    E = sum(abs(p).^2);
    disp(['Energy of Pulse(s) = ',num2str(E)]);
    
    %fourier transform with L points
    fs = 1/abs(t(1)-t(2));
    f = ((ceil(-fft_L/2):ceil(fft_L/2)-1)*(fs/fft_L)).';
    P = fftshift(fft(p, fft_L, 1)/size(p, 1));
    
    %plot pulse in time and frequency domains
    figure;
    ax(1) = subplot(3,1,1);
    for i=1:size(p,2)
        stem(t, p(:,i));
        hold on
    end
    title('Pulse Samples In Time Domain');
    xlabel('t (sec)');
    ylabel('pulse');
    ax(2) = subplot(3,1,2);
    for i=1:size(p,2)
        plot(f, 10*log10(abs(P(:,i))));
        hold on
    end
    xlabel('f (Hz)');
    ylabel('|P(f)| (dB)');
    ax(3) = subplot(3,1,3);
    for i=1:size(p,2)
        plot(f, angle(P(:,i)));
        hold on
    end
    xlabel('f (Hz)');
    ylabel('\angle P(f) (rad)');
end