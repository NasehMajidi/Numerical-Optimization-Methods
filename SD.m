function [x_min , f_min , iter , f_eval] = SD( f , gf , x0 , stop_tol,alpha_max,c1,c2)
    f_eval = 0;
    x = x0;
    gf_ = gf(x(1,:));
    gf_eval = 1;
    iter = 2;
    alpha = [ 0 , 1];
    while 1
        p = -gf(x(iter-1 ,:));
        [alpha0 , gf_e , f_e] = LineSearch(f,gf,alpha ,alpha_max, c1 ,c2 ,x(iter-1,:) , p);
        f_eval = f_eval +  f_e ; 
        gf_eval = gf_eval +gf_e ; 
        x_min = x(iter-1,:) - alpha0 * gf_(iter-1 , :);
        x = [x;x_min];
        alpha = [ 0 , abs(x(iter-1,:))/abs(x(iter,:))];
        if norm(x(iter,:) - x(iter-1,:))< stop_tol
            break
        end
        gf_ = [gf_ ; gf(x(iter,:))];
        gf_eval = gf_eval + 1;
        iter = iter+1;
    end
    f_min = f(x_min);
    disp([' function evaluation:  ' num2str(f_eval)]);
    disp([' gradient evaluation:  ' num2str(gf_eval)]);
    iter = iter - 1;
end