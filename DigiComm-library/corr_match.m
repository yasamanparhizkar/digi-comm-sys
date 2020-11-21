function [rec_sym] = corr_match(r, p, smpl_per_symbl, mode)
    span_in_symbl = length(p)/smpl_per_symbl;
    pkt_size = floor(length(r)/smpl_per_symbl);
    rec_sym = zeros(pkt_size,1);
    
    if strcmp(mode, 'correlator')
        n = floor((span_in_symbl - 1)/2*smpl_per_symbl);
        r = [zeros(ceil(n),1); r; zeros(floor(n),1)];
        for i = 0:pkt_size-1
            rec_sym(i+1) = sum(r((i*smpl_per_symbl+1):(i*smpl_per_symbl+length(p))).' .* (conj(p).'));
        end
    elseif strcmp(mode, 'matched_filter')
        %probably needs further edit to include RC, RRC and Gaussian pulses
        rec_sym = conv(r, conj(p(end:-1:1)));
        rec_sym = rec_sym((1:pkt_size)*smpl_per_symbl);
        rec_sym = rec_sym.';
    end
end

