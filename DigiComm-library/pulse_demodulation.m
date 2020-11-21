%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Association: Digital Communications Lab-Fall 1399
% 
% Name of Block: Digital Pulse Demodulator
%
% Description: Demodulates a time signal into a sequence of symbols.
%
% Input(s): rx_signal = time signal to be demodulated
%           modulation = name of modulation ('pam', 'psk' or 'qam')
%           M = order of modulation
%           fs = sampling frequency in Hz
%           smpl_per_symbol = number of samples in one symbol
%           pulse_name = name of modulating pulse ('rectangular', 'triangular', 'sine', 'raised_cosine', 'root_raised_cosine', 'gaussian')
%           mode = mode of modualting pulses ('conv', 'kron')
%           Extra inputs for pulse_name = ['raised_cosine','root_raised_cosine', 'gaussian']:
%               beta
%               span_in_symbl = span of symbol that can extend to neighbour symbol territories for values more than 1.
% **NOTE: for pulse_name = ['raised_cosine', 'root_raised_cosine', 'gaussian'] only valid mode is 'conv'.
% 
% Return Value: det_sym_idx = list of detected symbols (1,2,...,M)
%               rec_sym_tot = list of received baseband symbols befor detection
%                             (usually used for drawing constellation of received symbols)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [det_sym_idx, rec_sym_tot] = pulse_demodulation(rx_signal, ...
    modulation, M, fs, smpl_per_symbl, pulse_name, mode, varargin)
    
    [cons, ~] = constellation(M, modulation);
    [p, ~] = pulse_shape(pulse_name, fs, smpl_per_symbl, varargin{1}, varargin{2});
    rec_sym = corr_match(rx_signal, p, smpl_per_symbl, mode);
    rec_sym_tot = min_dist_detector(rec_sym, cons);
    [~, det_sym_idx] = ismember(rec_sym_tot, cons);
    
    rec_sym_tot = rec_sym;
end

