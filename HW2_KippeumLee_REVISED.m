%% Assignment 2 
clear;

one = [ 1 0 ];
two = [ 0 1 ];
v = [2;2];
Da = @(v,p) exp( one*( v - p ) )/( 1 + exp( one*( v - p ) ) + exp( two*( v - p ) ) );
Db = @(v,p) exp( two*( v - p ) )/( 1 + exp( one*( v - p ) ) + exp( two*( v - p ) ) );

% Q1
% GOOD
% When v_A = v_B = 2, the demand for each option if p_A = p_B = 1 is,
% D_A = e/(1+2e), D_B = e/(1+2e), D_0 = 1/(1+2e)
p1 = [ 1 ; 1 ];
Da(v,p1)
Db(v,p1)
(1 - Da(v,p1) - Db(v,p1))

% Q2 : Broyden's method

% YOU DIDNT UPLOAD MYJAC FUNCTION. USE BROYDEN FUNCTION DIRECTLY

p = [ 0.2 ; 1.2 ];
fVal = foc(v,p);
focc = @(p) foc(v,p);
iJac = inv( myJac(focc, p ) );

maxit = 100;
tol = 1e-6;

for iter = 1:maxit
    fnorm = norm(fVal);
    fprintf('iter %d: p(1) = %f, p(2) = %f, norm(f(x)) = %.8f\n', iter, p(1), p(2), norm(fVal));
    if fnorm < tol
        break
    end
    d = - (iJac * fVal);
    p = p + d;
    fOld = fVal;
    fVal = focc(p);
    u = iJac*(fVal - fOld);
    iJac = iJac + ( (d - u)*(d'*iJac) )/(d'*u);
end

fVal
p

% Q3 : Gauss - Sidel method
% VERY GOOD. ALSO, SUBITERATIONS DONT HAVE TO BE THE SAME AS OUTER
% ITERATIONS
p1 = 0.2;
p2 = 1.2;

for iter = 1:maxit
    
    p1Old = 0;
    p2Old = 0;
    
    DaG = @(p) exp( v(1,1) - p )/( 1 + exp( v(1,1) - p ) + exp( v(2,1) - p2 ) );
    
    FOCa = @(p) ( DaG(p) - p * DaG(p) * ( 1 - DaG(p) ) );
    
    
    p10 = p1;
    p20 = p2;
    fOlda = FOCa(p1Old);
    
    

    for i = 1:maxit
        fValGa = FOCa(p10);
        if norm(fValGa) < tol
            break
        else
        p1New = p10 - ( ( p10 - p1Old )/( fValGa - fOlda ) ) * fValGa;
        p1Old = p10;
        p10 = p1New;
        fOlda = fValGa;
        end
    end
        
    DbG = @(p) exp( v(2,1) - p )/( 1 + exp( v(1,1) - p10 ) + exp( v(2,1) - p ) );
    FOCb = @(p) ( DbG(p) - p * DbG(p) * ( 1 - DbG(p) ) );
    fOldb = FOCb(p2Old);
    
    for i = 1:maxit
        
        fValGb = FOCb(p20);
        if norm(fValGb) < tol
            break
        else       
            p2New = p20 - ( ( p20 - p2Old )/( fValGb - fOldb ) ) * fValGb;
            p2Old = p20;
            p20 = p2New;
            fOldb = fValGb;
        end
    end
    fprintf('iter %d: p(1) = %f, p(2) = %f, norm([ p1-p10 ; p2-p20 ]) = %.8f\n', iter, p10, p20, norm([ p1-p10 ; p2-p20 ]));
    if norm( [ p1-p10 ; p2-p20 ] ) < tol
        break
    else
        p1 = p10;
        p2 = p20;
    end
end

[p1 ; p2]

% As you can see in the result from iteration, this method makes price
% converge faster than Broyden's method does. This is because Gauss-seidel
% method uptades prices more quickly. You can check this in above code in
% which updated p1 is used in second sub-iteration for finding solution for
% FOC_b = 0 given p1.

% Q4
% GOOD

p = [0.2,1.2];

for iter = 1:maxit
    newp1 = 1/( 1 - Da(v,p) );
    newp2 = 1/( 1 - Db(v,p) );
    newp = [ newp1 ; newp2 ];
    fprintf('iter %d: p(1) = %f, p(2) = %f, norm(f(x)) = %.8f\n', iter, p(1), p(2), norm(newp - p));
    if norm( newp - p ) < tol
        break
    end
    p = newp;
end
p

% It converges to equilibrium price level p which is the same with previous
% results. But even though convergence criteria is different, you can check
% it converges slower than others. This is because previous two methods use
% first derivatives, which means they approach to maximum value more
% accurately in each iteration, compared to this method which exploits only
% demand function, thus more fluctuate since its step size is big. 

% Q5
% SAME COMMENT AS ABOVE

va = 2;
ppp = [ 0 0 ];
for vb = 0:0.2:3
    v = [ va ; vb ];
    p = [ 0.5 ; 0.5 ];
    fVal = foc(v,p);
    focc = @(p) foc(v,p);
    iJac = inv( myJac(focc, p ) );
    for iter = 1:maxit
        fnorm = norm(fVal);
        fprintf('iter %d: p(1) = %f, p(2) = %f, norm(f(x)) = %.8f\n', iter, p(1), p(2), norm(fVal));
        if fnorm < tol
            break
        end
        d = - (iJac * fVal);
        p = p + d;
        fOld = fVal;
        fVal = focc(p);
        u = iJac*(fVal - fOld);
        iJac = iJac + ( (d - u)*(d'*iJac) )/(d'*u);
    end
    ppp = [ ppp ; p' ];
end

plot(ppp(2:17,1))
hold on
plot(ppp(2:17,2))
hold off
