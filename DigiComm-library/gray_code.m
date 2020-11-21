%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Association: Digital Communications Lab-Fall 1399
% 
% Name of Block: Gray Code Sequence Generator
%
% Description: Generates k-bit Gray code sequence.
%
% Input(s): k = number of bits for code words.
%
% Return Value: b_gray[2^k x k] = each row is a word and
%               words are sorted in order.
%
% Example: k = 2 -> 
%             b = [0, 0
%                  0, 1
%                  1, 1
%                  1, 0]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [b_gray] = gray_code(k)
    if k==1
       b_gray = [0;1]; 
    elseif k>1
       dummy = gray_code(k-1);
       dummyB = zeros(size(dummy));
       for i=1:(k-1)
          dummyB(:,i) =  dummy((2^(k-1)):-1:1, i);
       end
       b_gray = [zeros(2^(k-1),1);ones(2^(k-1),1)];
       b_gray = [b_gray, [dummy; dummyB]];
    else
        disp('k invalid.');
        b_gray = 0;
    end
end

