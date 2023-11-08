function [des_alpha , gf_eval , f_eval] = LineSearch(f,gf,alpha ,alpha_max, c1 ,c2 , x ,p)
    gf_ = gf(x);
    gf_eval = 1;
    phi = @(a) f(x + a*p);
    f_eval = 0;
    while 1
        phi_0 = phi(0);
        phi_alpha = phi(alpha(2));
        phi_alpha_ = phi(alpha(1));
        phi_prime_0 = dot(p , gf_);
        phi_prime_alpha = dot(p,gf(x+alpha(2)*p));
        f_eval = f_eval + 1;
        gf_eval = gf_eval + 1;
        if phi_alpha > phi_0 + c1*alpha(2)*phi_prime_0 || phi_alpha >= phi_alpha_
           [des_alpha, f_e] = zoom(alpha(1) , alpha(2),x ,f , gf ,p);
           break
        end
        if abs(phi_prime_alpha) <= -c2 * phi_prime_0
           des_alpha = alpha(2);
           gf_eval = gf_eval + 1;
           break
        end
        if phi_prime_alpha >= 0
           [des_alpha , f_e] = zoom(alpha(1) , alpha(2),x ,f ,gf , p);
           gf_eval = gf_eval + 1 ;
           f_eval =f_eval + f_e;
           break
        end
        alpha(1) = alpha(2);
        alpha(2) = 0.5*(alpha(2) + alpha_max);
    end
end




