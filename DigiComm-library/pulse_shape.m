%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Association: Digital Communications Lab-Fall 1399
% 
% Name of Block: Pulse Generator
%
% Description: Genrates time samples of one pulse with E=1
%
% Input(s): pulse_name = name of modulating pulse ('rectangular', 'triangular', 'sine', 'raised_cosine', 'root_raised_cosine', 'gaussian')
%           fs = sampling frequency in Hz
%           smpl_per_symbol = number of samples in one symbol
%           Extra inputs for pulse_name = ['raised_cosine','root_raised_cosine', 'gaussian']:
%               beta
%               span_in_symbl = span of symbol that can extend to neighbour symbol territories for values more than 1.
% 
% Return Value: p = samples of pulse
%               t = sampling time for each sample
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [p, t] = pulse_shape(pulse_name, fs, smpl_per_symbl, varargin)
    if strcmp(pulse_name,'rectangular')
       [p, t] = rectangular(fs, smpl_per_symbl);
    
    elseif strcmp(pulse_name,'triangular')
       [p, t] = triangular(fs, smpl_per_symbl);
       
    elseif strcmp(pulse_name,'sine')
       [p, t] = sine(fs, smpl_per_symbl);

    elseif strcmp(pulse_name,'raised_cosine')
        if length(varargin) == 2
            beta = varargin{1};
            span_in_symbl = varargin{2};
        else
            disp('Wrong number of inputs for raised cosine pulse.');
        end
        [p, t] = raised_cosine(fs, smpl_per_symbl, beta, span_in_symbl);
        
    elseif strcmp(pulse_name,'root_raised_cosine')
        if length(varargin) == 2
            beta = varargin{1};
            span_in_symbl = varargin{2};
        else
            disp('Wrong number of inputs for raised cosine pulse.');
        end
        [p, t] = root_raised_cosine(fs, smpl_per_symbl, beta, span_in_symbl);
        
    elseif strcmp(pulse_name,'gaussian')
        if length(varargin) == 2
            beta = varargin{1};
            span_in_symbl = varargin{2};
        else
            disp('Wrong number of inputs for raised cosine pulse.');
        end
        [p, t] = gaussian(fs, smpl_per_symbl, beta, span_in_symbl);
    end
   
   %normalize energy of signal to 1
   E = sum(abs(p).^2);
   p = p/sqrt(E);
end

function [p, t] = rectangular(fs, smpl_per_symbl)
   t = ((0:(smpl_per_symbl-1))/fs).';
   p = (1/sqrt(smpl_per_symbl))*ones(size(t));
end

function [p, t] = triangular(fs, smpl_per_symbl)
   t = ((0:(smpl_per_symbl-1))/fs).';
   Ts = smpl_per_symbl/fs;
   p = max(Ts/2 - abs(t - Ts/2), zeros(size(t)));
end

function [p, t] = sine(fs, smpl_per_symbl)
   t = ((0:(smpl_per_symbl-1))/fs).';
   Ts = smpl_per_symbl/fs;
   p = sin(pi*t/Ts);
end   

function [p, t] = raised_cosine(fs, smpl_per_symbl, beta, span_in_symbl)
    n = span_in_symbl*smpl_per_symbl;
    t = ((ceil(-n/2):ceil(n/2)-1)/fs).';
    Ts = smpl_per_symbl/fs;
    p = sinc(t/Ts) .* cos(pi*beta/Ts*t) ./ (1-(2*beta/Ts*t).^2);

    tt = (t((1-(2*beta/Ts*t).^2) == 0));
    p((1-(2*beta/Ts*t).^2) == 0) = sinc(tt/Ts);
end

function [p, t] = root_raised_cosine(fs, smpl_per_symbl, beta, span_in_symbl)
    n = span_in_symbl*smpl_per_symbl;
    t = ((ceil(-n/2):ceil(n/2)-1)/fs).';
    Ts = smpl_per_symbl/fs;
    p = sin(pi*(1-beta)/Ts*t) + (4*beta*t/Ts) .* cos(pi*(1+beta)/Ts*t);
    p = p ./ ((pi/Ts.*t) .* (1 - (4*beta/Ts.*t).^2));
    p = p./sqrt(Ts);

    p(t == 0) = (1-beta+4*beta/pi)/sqrt(Ts);
    p(t == Ts/4/beta | t == -Ts/4/beta) = ...
        (beta/sqrt(2*Ts))*((1+2/pi)*sin(pi/4/beta) + (1-2/pi)*cos(pi/4/beta));
end

function [p, t] = gaussian(fs, smpl_per_symbl, beta, span_in_symbl)
    n = span_in_symbl*smpl_per_symbl;
    t = ((ceil(-n/2):ceil(n/2)-1)/fs).';
    Ts = smpl_per_symbl/fs;
    p = (qfunc(2*pi*beta*(t - Ts/2)) - qfunc(2*pi*beta*(t + Ts/2)))/log(2);
end