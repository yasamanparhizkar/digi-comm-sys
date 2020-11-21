%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Association: Digital Communications Lab-Fall 1399
% 
% Name of Block: Digital Pulse Modulator
%
% Description: Modulates list of symbols into a digital time signal.
%
% Input(s): sym_idx = list of symbols (1,2,...,M)
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
% Return Value: tx_smpl[length(sym_idx)*smpl_per_symbl x 1] = samples of modulated signal in time domain
%               cons[M x 1] = list of all possible symbols in the specified modualtion
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [tx_smpl, cons] = pulse_modulation(sym_idx, modulation, M, fs,...
    smpl_per_symbl, pulse_name, mode, varargin)

    [cons, ~] = constellation(M, modulation);
    mod_sym = cons(sym_idx);
    [p, ~] = pulse_shape(pulse_name, fs, smpl_per_symbl, varargin{1}, varargin{2});
       
    
    if strcmp(mode, 'kron')
        tx_smpl = kron(mod_sym, p);
    elseif strcmp(mode, 'conv')
        s = upsmpl(cons(sym_idx), smpl_per_symbl);
        tx_smpl = conv(s, p);
        
        if strcmp(pulse_name, 'raised_cosine') || ...
            strcmp(pulse_name, 'root_raised_cosine') || ...
            strcmp(pulse_name, 'gaussian')
           span_in_symbl = varargin{2};
           n = floor((span_in_symbl-1)*smpl_per_symbl/2);
           tx_smpl = tx_smpl(n+1:end-n);
       end
    else
        disp('\"mode\" invalid.');
        tx_smpl = 0;
    end
    
    tx_smpl = tx_smpl(:);
end

