clc;
close all;

% Read & get parameters of each audio signal
[y1, fs1, len_audio1, t1] = getSignalParam('first.mpga');
[y2, fs2, len_audio2, t2] = getSignalParam('second.mpga');
[y3, fs3, len_audio3, t3] = getSignalParam('third.mpga');

% Resample signals to increase the frequency
y1 = resample(y1(:,1),3,1);
y2 = resample(y2(:,1),3,1);
y3 = resample(y3(:,1),3,1);

% Unify the length and sampling frequency of all signals
fs = 3 * min([fs1, fs2, fs3]);
maxLength = max([length(y1), length(y2), length(y3)]);

% Extend signals to have the same length
y1 = [y1; zeros(maxLength-length(y1),1)];
y2 = [y2; zeros(maxLength-length(y2),1)];
y3 = [y3; zeros(maxLength-length(y3),1)];

n = length(y1);
time = linspace(0,n/fs,n);
frequency = linspace(-fs/2, fs/2, n);

% Modulate 1st signal
[mod_audio1, carrier1] = modeulate(y1, time, fs/12, 0);
%[fft_audio1, frequency_audio1] = FT(fs, n, y1);
%plot(frequency_audio1, abs(fft_audio1)); title('Y 1 - FFT Amplitude'); xlabel('Frequency(HZ)'); ylabel('Amplitude'); figure;

% Modulate 2nd signal
[mod_audio2, carrier2] = modeulate(y2, time, fs/4, 0);
%[fft_audio2, frequency_audio2] = FT(fs, n, y2);
%plot(frequency_audio2, abs(fft_audio2)); title('Y 2 - FFT Amplitude'); xlabel('Frequency(HZ)'); ylabel('Amplitude'); figure;

% Modulate 3rd signal
[mod_audio3, carrier3] = modeulate(y3, time, fs/4, 1);
%[fft_audio3, frequency_audio3] = FT(fs, n, y3);
%plot(frequency_audio3, abs(fft_audio3)); title('Y 3 - FFT Amplitude'); xlabel('Frequency(HZ)'); ylabel('Amplitude'); figure;

% Add all modulated signals together
s = mod_audio1 + mod_audio2 + mod_audio3;

% Demodulation
demod1 = demodulate(s, carrier1);
demod2 = demodulate(s, carrier2);
demod3 = demodulate(s, carrier3);
% Cutoff frequency
fc = (1/6*fs/2);
% Low-Pass filter
[x,y] = butter(20, fc/(fs/2));
demod1 = 2 * filter(x, y, demod1);
demod2 = 2 * filter(x, y, demod2);
demod3 = 2 * filter(x, y, demod3);

% Write signals after demodulation
audiowrite('First_Retreived.wav',demod1, fs);
audiowrite('Second_Retreived.wav',demod2,fs);
audiowrite('Third_Retreived.wav',demod3,fs);

% Demodulate first signal with frequency shift = 2 HZ
demod1 = demodulate_f_shift(mod_audio1, time, fs/12, 0, 2);
demod1 = 2 * filter(x, y, demod1);
audiowrite('First_Demod_Freq2.wav',demod1,fs);

% Demodulate first signal with frequency shift = 10 HZ
demod1 = demodulate_f_shift(mod_audio1, time, fs/12, 0, 10);
demod1 = 2 * filter(x, y, demod1);
audiowrite('First_Demod_Freq10.wav',demod1,fs);

% Demodulation with phase shift = 10 degree
demod1 = demodulate_phase_shift(mod_audio1, time, fs/12, 0, pi/18);
demod2 = demodulate_phase_shift(mod_audio2, time, fs/4, 0, pi/18);
demod3 = demodulate_phase_shift(mod_audio3, time, fs/4, 1, pi/18);
demod1 = 2 * filter(x, y, demod1);
demod2 = 2 * filter(x, y, demod2);
demod3 = 2 * filter(x, y, demod3);
audiowrite('First_Retreived_Phase_10.wav',demod1, fs);
audiowrite('Second_Retreived_Phase_10.wav',demod2,fs);
audiowrite('Third_Retreived_Phase_10.wav',demod3,fs);

% Demodulation with phase shift = 30 degree
demod1 = demodulate_phase_shift(mod_audio1, time, fs/12, 0, pi/6);
demod2 = demodulate_phase_shift(mod_audio2, time, fs/4, 0, pi/6);
demod3 = demodulate_phase_shift(mod_audio3, time, fs/4, 1, pi/6);
demod1 = 2 * filter(x, y, demod1);
demod2 = 2 * filter(x, y, demod2);
demod3 = 2 * filter(x, y, demod3);
audiowrite('First_Retreived_Phase_30.wav',demod1, fs);
audiowrite('Second_Retreived_Phase_30.wav',demod2,fs);
audiowrite('Third_Retreived_Phase_30.wav',demod3,fs);

% Demodulation with phase shift = 90 degree
demod1 = demodulate_phase_shift(mod_audio1, time, fs/12, 0, pi/2);
demod2 = demodulate_phase_shift(mod_audio2, time, fs/4, 0, pi/2);
demod3 = demodulate_phase_shift(mod_audio3, time, fs/4, 1, pi/2);
demod1 = 2 * filter(x, y, demod1);
demod2 = 2 * filter(x, y, demod2);
demod3 = 2 * filter(x, y, demod3);
audiowrite('First_Retreived_Phase_90.wav',demod1, fs);
audiowrite('Second_Retreived_Phase_90.wav',demod2,fs);
audiowrite('Third_Retreived_Phase_90.wav',demod3,fs);

% Read signal and return its parameters
function [y, fs, len_audio, t] = getSignalParam(path)
    [y, fs] = audioread(path);
    len_audio = length(y);
    y = y(:,1);
    dt = 1 / fs;
    t = 0 : dt : (len_audio-1)*dt;
end

% Modulate a signal with specific carrier and frequency
function [mod_audio, carrier] = modeulate(y, t, freq, useSin)
    Wc = 2*pi*freq;
    carrier = cos(Wc * t);
    if useSin
        carrier = sin(Wc * t);
    end
    mod_audio = (y)'.*carrier;
end

% Get Fourier Transform of a signal
function [fft_audio, frequency_audio] = FT(fs, len_audio, mod_audio)
    df = fs / len_audio;
    frequency_audio = -fs/2 : df : fs/2-df;
    Y = fft(mod_audio);
    fft_audio = fftshift(Y)/length(Y);
end

% Normal demodulation of a signal
function demod_audio  = demodulate(mod_audio, carrier)
    demod_audio = mod_audio.*carrier;
end

% Demodulate a signal with frequency shift
function demod_audio  = demodulate_f_shift(mod_audio, t, freq, useSin, freq_shift)
    Wc = 2*pi*(freq+freq_shift);
    carrier = cos(Wc * t);
    if useSin
        carrier = sin(Wc * t);
    end
    demod_audio = mod_audio.*carrier;
end

% Demodulate a signal with phase shift
function demod_audio  = demodulate_phase_shift(mod_audio, t, freq, useSin, phase_shift)
    Wc = 2*pi*freq;
    carrier = cos(Wc * t + phase_shift);
    if useSin
        carrier = sin(Wc * t + phase_shift);
    end
    demod_audio = mod_audio.*carrier;
end
