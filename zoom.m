function [des_alpha_ , f_eval] = zoom(a_ , b_ ,x , f , gf ,p)
gf_ = gf(x);
phi = @(a) f(x(1,:) + a*p); 
f_eval = 1;
c1 = 1e-2;
c2 = 0.5;
while 1
    alpha = .5*(a_+b_);
    phi_alpha = phi(alpha);
    phi_prime_0 = dot(p , gf_);
    phi_prime_alpha = dot(p,gf(x+alpha*p));
    if phi_alpha >  phi(0) + c1*alpha*phi_prime_0 || phi_alpha > phi(a_)
        b_ = alpha;
        f_eval = f_eval + 1;
    else
        if abs(phi_prime_alpha) <= -c2*phi_prime_0
            des_alpha_ = alpha;
            break
        end
        if phi_prime_alpha*(b_-a_) >=0
            b_ = a_ ;
        end
        a_ = alpha;
    end
end
end
    


