function [x_min , f_min , iter] = newton_GSS( f , gf , hf , x0 , stop_tol , GSS_tol)
    f_eval = 0;
    x = x0;
    gf_ = gf(x(1,:));
    hf_ = hf(x(1,:));
    hf_ = pd(hf_);
    d = -1*(gf_/hf_);
    h_eval = 1;
    gf_eval = 1;
    alpha_ = @(a) f(x(1,:) + a*d);
    iter = 2;
        while 1
            [alpha0 , N] = GSS_98205902(alpha_,0,20,GSS_tol);
            f_eval = f_eval + N ; 
            x_min = x(iter-1,:) + alpha0 * d;
            x = [x;x_min];
            if norm(x(iter,:) - x(iter-1,:))<stop_tol
                break
            end
            d = -1*(gf(x(iter,:))/pd(hf(x(iter,:))));
            h_eval = h_eval + 1;
            gf_eval = gf_eval +1 ; 
            alpha_ = @(a) f(x(iter,:) + a*d);
            iter = iter + 1;
        end
    f_min = f(x_min);
    iter = iter -1 ; 
    disp([' function evaluation:  ' num2str(f_eval)]);
    disp([' gradient evaluation:  ' num2str(gf_eval)]);
    disp([' hessian evaluation:  ' num2str(h_eval)]); 
end