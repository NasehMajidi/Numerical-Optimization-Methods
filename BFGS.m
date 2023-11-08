function [x_min , f_min , iter , f_eval] = BFGS( f , gf , x0 , stop_tol,alpha,alpha_max,c1,c2)
x = x0;
f_eval = 0;
gf_eval = 0;
iter = 1;
n = length(x);
C = eye(n);
while abs(gf(x(iter,:))) > stop_tol
    P = - C * gf(x(iter,:))';
    [alpha0 , gf_e,f_e] = LineSearch(f,gf,alpha ,alpha_max, c1 ,c2 ,x(iter,:) ,P');
    f_eval = f_eval + f_e ; 
    gf_eval = gf_eval +gf_e;
    x_min = x(iter,:) + alpha0*P';
    x = [x;x_min];
    delta = x(iter+1,:)' - x(iter,:)';
    gamma = gf(x(iter+1,:))' - gf(x(iter,:))';
    if iter == 1
       C = (dot(gamma,delta)/dot(gamma,gamma))*eye(n);
       disp(C);
    end
    a = 1/(dot(gamma , delta));
    C = (eye(n) - a.*delta*gamma')*C*(eye(n)-a.*gamma*delta') + a.*delta*delta';
    gf_eval = gf_eval +1 ; 
    iter = iter + 1;
end
f_min = f(x_min);
iter = iter -1 ; 
disp([' function evaluation:  ' num2str(f_eval)]);
disp([' gradient evaluation:  ' num2str(gf_eval)]);

