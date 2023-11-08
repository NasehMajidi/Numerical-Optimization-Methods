function [x_min , f_min , iter] = SD_GSS( f , gf , x0 , stop_tol , GSS_tol , varargin)
    f_eval = 0;
    x = x0;
    gf_ = gf(x(1,:));
    gf_eval = 1;
    alpha_ = @(a) f(x(1,:) - a*gf_);
    iter = 2;
    while 1
        [alpha0 , N] = GSS_98205902(alpha_,0,10,GSS_tol);
        f_eval = f_eval + N ; 
        x_min = x(iter-1,:) - alpha0 * gf_(iter-1 , :);
        x = [x;x_min];
        if norm(x(iter,:) - x(iter-1,:))< stop_tol
            break
        end
        gf_ = [gf_ ; gf(x(iter,:))];
        gf_eval = gf_eval + 1;
        alpha_ = @(a) f(x(iter,:) - a*gf_(iter , :));
        iter = iter+1;
    end
    f_min = f(x_min);
    disp([' function evaluation:  ' num2str(f_eval)]);
    disp([' gradient evaluation:  ' num2str(gf_eval)]);
    iter = iter - 1;
end