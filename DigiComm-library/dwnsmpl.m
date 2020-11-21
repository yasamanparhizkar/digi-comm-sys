function [y] = dwnsmpl(x,M)
    n = 1:length(x);
    y = x(mod(n - 1,M)==0);
end

