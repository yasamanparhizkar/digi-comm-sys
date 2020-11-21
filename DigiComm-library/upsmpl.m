function [y] = upsmpl(x,N)
    n = 1:(length(x)*N - N + 1);
    y = zeros(size(n));
    y(mod(n - 1,N)==0) = x;
end


