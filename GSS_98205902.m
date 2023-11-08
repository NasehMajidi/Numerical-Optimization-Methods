function [x_min , N ] = GSS_98205902( function_name , int1 , int2 , epsilon , varargin )
    f = function_name;
    n_f = nargin(f);
    if n_f == 2 % if our function owns two independent variables
        sec_var =  varargin{1};
    end
    a = zeros(1 , 1);
    b = zeros(1 , 1);
    a(1) = int1;
    b(1) = int2;
    i = 2;
    p = (3-sqrt(5))*.5;
    int = [a(1) ; b(1)]; 
    delta = int(2) - int(1) ; 
    a(2) = a(1) + p*delta;
    b(2) = a(1) + (1-p) * delta;
    while int(2) - int(1) > epsilon
        if n_f == 2 % fixing the second variable 
            f1 = f(a(i) , sec_var);
            f2 = f(b(i) , sec_var);
        else
            f1 = f(a(i));
            f2 = f(b(i));
        end
        if f1 < f2
            int(2) = b(i) ;
            a(i+1) = int(1) + p * (int(2) - int(1));
            b(i+1) = a(i);
            i = i+1;
        else
            int(1) = a(i);
            b(i+1) = int(1) + (1-p) * ( int(2) - int(1));
            a(i+1) = b(i);
            i = i+1;
        end
    end
    x_min = 0.5*( int(2) + int(1));
    N = i-2;
end
