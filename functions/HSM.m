    function [mode] = HSM(sample, limit, n, k)
    
    if limit == 0 || n <= 0
       mode = mode_estimator(sample);
    else
        S = sample(1:end-n);
        EXT = sample(end-length(S)+1:end);
        L = EXT - S;
        [M, I] = min(L);

        mode = HSM(sample(I:I+n), limit-1, ceil(n*k), k);
    end
end

