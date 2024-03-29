function ind = ndsub2ind(sz, sub)
%NDSUB2IND Convert N dimensional subscripts to linear indices.

% cumulative products for the dimension
k = cumprod(sz);
k = [1, k(1:end-1)];

% offset
off = ones(size(k));
off(1) = 0;
off = repmat(off, [size(sub, 1), 1]);

% conver to linear index to dot products
ind = (sub-off) * k';

end
