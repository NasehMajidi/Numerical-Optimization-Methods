function y = pd(x)
    landa = eig(x);
    if landa(end) <=  0
        dim = size(x);
        y = x + landa(1) * eye(dim(1) , dim(2));
    else
        y = x;
    end
end