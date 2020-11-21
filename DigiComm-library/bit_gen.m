%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Association: Digital Communications Lab-Fall 1399
% 
% Name of Block: Bit Generator Block
%
% Description: Generates N random words, each consisted of
%              k uniformly random bits.
%
% Input(s): N = number of words (= columns of output)
%           k = number of bits in each word
%
% Return Value: b[Nxk]
%
% Example: N = 3 and k = 2 -> 
%             b = [0, 1
%                  1, 0
%                  0, 0]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [b] = bit_gen(N, k)
    b = randi([0 1],N,k);
end
