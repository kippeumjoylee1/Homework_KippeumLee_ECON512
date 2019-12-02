function loglike = likeliMC(gamma,mu,muu,var_mu,var_u,var_muu)
    
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
    f = @(b,u) prod( ( F( b*xi + gamma*zi + u ).^(yi) ).*( (1 - F( b*xi + gamma*zi + u )).^( 1 - yi ) ) );
    MU = [ mu ; muu ];
    SIGMA = [ var_mu var_muu ; var_muu var_u ];
    U = chol(SIGMA);
    a = randn(2,100);
    rnd = repmat(MU,1,100) + U'*a;
    rnd1 = rnd(1,:)';
    rnd2 = rnd(2,:)';
    integral = 0;
    for r = 1:100
        integral = integral + f( rnd1(r,1),rnd2(r,1) );
    end
    integral = (1/100)*integral;
    loglikelihood2 = loglikelihood2 + log(integral);
end

loglike = loglikelihood2;

end