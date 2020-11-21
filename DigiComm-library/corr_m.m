function [r] = corr_m(x, y)
    L = abs(length(x)-length(y)) + 1;
    r = zeros(1,L);
    y = conj(y);
    for m = 1:L
        if(length(y) < length(x))
            for n = 1:length(y)
                    r(m) = r(m) + x(n+m-1) * y(n);
            end
        else
            for n = 1:length(x)
                    r(L-m+1) = r(L-m+1) + x(n) * y(n+m-1);
            end
        end
    end
end

%%%%% Correlation with toeplitz:
% function [r] = corr_m(x, y)
%     L = abs(length(x)-length(y)) + 1;
%     x = conj(x);
%     row = zeros(1,max(length(x),length(y)));
%     if length(x) > length(y)
%         row(1:length(y)) = y;
%     else
%         row(1:length(x)) = x;
%     end
%     col = [row(1);zeros(L-1,1)];
%     h = toeplitz(col,row);
%     if length(x) > length(y)
%         r = h * (x');
%     else
%         r = h * (y');
%     end
%     r = r';
% end
