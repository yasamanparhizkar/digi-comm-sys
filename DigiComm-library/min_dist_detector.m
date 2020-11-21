function [det_sym] = min_dist_detector(r, constellation)
    L = length(r);
    r = repmat(r(:),1,length(constellation));
    r = r.';
    constellation = repmat(constellation(:), 1, L);
    [~, idx] = min(abs(r - constellation).^2);
    det_sym = constellation(idx, 1);
end

