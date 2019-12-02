function loglike = likeliGauss(gamma,mu,var)
    
    data = load('C:\Users\padag\Documents\MATLAB\hw5.mat');
    X = data.data.X;
    Y = data.data.Y;
    Z = data.data.Z;
    N = data.data.N;
    T = data.data.T;

    F = @(x) ( 1 + exp( -x ) ).^(-1);
    loglikelihood = 0;

    for i = 1:100
        xi = X(:,i);
        yi = Y(:,i);
        zi = Z(:,i);
        f = @(b) prod( ( F( b*xi + gamma*zi ).^(yi) ).*( (1 - F( b*xi + gamma*zi )).^( 1 - yi ) ) );
        [b,w] = qnwnorm(20,mu,var);
        fmatrix = [];
        for t = 1:20
        bt = b(t,1);
        fmatrix = [fmatrix ; f(bt) ];
        end
        Ef = w'*fmatrix;
        loglikelihood = loglikelihood + log(Ef);
    end

    loglike = loglikelihood;
end
