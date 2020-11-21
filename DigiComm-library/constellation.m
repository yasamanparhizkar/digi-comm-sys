%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Association: Digital Communications Lab-Fall 1399
% 
% Name of Block: Constellation Generator for MPAM, MPSK and MQAM
%
% Description: Generates ordered list of all possible baseband symbols
%              for Mth-order PAM, PSK or QAM modulations.
%
% Input(s): M = order of modulation/number of symbols (must be 2^k)   
%           modulation = name of modulation ('pam', 'psk' or 'qam')              
%
% Return Value: cons[M x 1] = list of all possible symbols.
%               Es_avg = average energy of symbols (= 1).
%
% Example: M = 4
%          modulation = 'psk'
%          -> 
%          cons = [1+0i; 0+1i; -1+0i; 0-1i]
%          Es_avg = 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [cons, Es_avg] = constellation(M, modulation)
    %initialization
    cons = 0;
    
    %find lambda
    lambda = log2(M);
    
    if strcmp(modulation,'qam') && (mod(lambda,1)==0) && (lambda > 0)
        %creat M-qam constellation
        cons = qam(M);
    elseif strcmp(modulation,'psk') && (mod(lambda,1)==0) && (lambda > 0)
        %creat M-psk constellation
        cons = psk(M);
    elseif strcmp(modulation,'pam') && (mod(lambda,1)==0) && (lambda > 0)
        %creat M-pam constellation
        cons = pam(M);  
    else
        disp('Error: "M ~= 2^l (l>0)" or the name of modulation is invalid.');
    end
    
    %find Es_avg again! (should equal 1)
    Es_avg = sum(abs(cons).^2)/M;
end

function cons = qam(M)
    %find lambda
    lambda = log2(M);
    
    %creat x and y vectors
    Lx = 2^(floor((lambda+1)/2));
    Ly = 2^(ceil((lambda-1)/2));
    x = -(Lx-1):2:(Lx-1);
    y = (Ly-1):-2:-(Ly-1);

    %create points from x and y vector
    [X, Y] = meshgrid(x, y);
    cons = X + 1i*Y;
    
    %flip even columns
    cons(end:-1:1, 2:2:size(cons, 2)) = cons(:,2:2:size(cons, 2));
    cons = cons(:);

    %find Es_avg
    Es_avg = sum(abs(cons).^2)/M;

    %normalize constellation
    cons = cons/sqrt(Es_avg);
end


function cons = psk(M)
    cons = (exp((0:(M-1))*(2i*pi/M))).';
    
%     if M == 4
%         cons = cons .* exp(1i*pi/4);
%     end
    % No Need for this if clause
end

function cons = pam(M) 
    cons = (-(M-1):2:(M-1)).';

    %find Es_avg
    Es_avg = sum(abs(cons).^2)/M;

    %normalize constellation
    cons = cons/sqrt(Es_avg);
end
