function loglike = likeliMC(gamma,mu,var)
    
    data = load('C:\Users\padag\Documents\MATLAB\hw5.mat');
    X = data.data.X;
    Y = data.data.Y;
    Z = data.data.Z;
    N = data.data.N;
    T = data.data.T;

    F = @(x) ( 1 + exp( -x ) ).^(-1);
   loglikelihood2 = 0;

for i = 1:100
    xi = X(:,i);
    yi = Y(:,i);
    zi = Z(:,i);
    f = @(b) prod( ( F( b*xi + gamma*zi ).^(yi) ).*( (1 - F( b*xi + gamma*zi )).^( 1 - yi ) ) );
    % For pseudo random number, I will use [-100,100] as an interval
    rnd = -10 + 20*rand(100,1);
    integral = 0;
    for r = 1:100
        integral = integral + f( rnd(r,1) )*normpdf(rnd(r,1),mu,var);
    end
    integral = (20/100)*integral;
    loglikelihood2 = loglikelihood2 + log(integral);
end

loglike = loglikelihood2;

end

    