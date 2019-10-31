%% HW3

%%% NICELY DONE! CHECK PLUS!

% Q1

b1 = [-0.5 -0.5 -0.5 -0.5 -0.5 -0.5]';
b2 = [0.1 0.1 0.1 0.1 0.1 0.1]';
b3 = [0.4 0.4 0.4 0.4 0.4 0.4]';
b4 = [1 1 1 1 1 1]';
b5 = [2 2 2 2 2 2]';

BHAT1 = [];
BHAT2 = [];
BHAT3 = [];
BHAT4 = [];

for b0 = [b1 b2 b3 b4 b5];

likelihood = @(b) -sum( -exp( X*b ) + y.*( X*b ) - log(factorial(y)) ); % YOU CAN DROP THE FACTORIAL. INCREASE SPEED

options = optimset('PlotFcns',@optimplotfval,'Display','iter');
bhat1 = fminsearch(likelihood,b0,options);

% Q2

options = optimoptions(@fminunc,'Display','iter','Algorithm','quasi-newton');
% Default method here is BFGS
bhat2= fminunc(likelihood,b0,options);

% Q3

objective = @(b) ( y - exp( X*b ) );
options = optimoptions(@lsqnonlin,'Display','iter','Algorithm','trust-region-reflective');
bhat3 = lsqnonlin(objective,b0,[],[],options);

% Q4

objective = @(b) sum( ( y - exp( X*b ) ).^2 );
options = optimset('PlotFcns',@optimplotfval,'Display','iter');
bhat4 = fminsearch(objective,b0,options);

BHAT1 = [BHAT1 bhat1];
BHAT2 = [BHAT2 bhat2];
BHAT3 = [BHAT3 bhat3];
BHAT4 = [BHAT4 bhat4];

end

BHAT1
BHAT2
BHAT3
BHAT4

% For robustness, method1 estimates relatively stably (roughly 2.5, 0, 0, -0.3, 0, -0.4) 
% with various initial values.Thus, we can think this point as desired coefficient
% Method3 shows 3 stable results but intercepts of other 2 results blow off
% a bit. Method 2 and method 4 have respectively 2 and 1 stable results.
% Thus, I can rank method1 > method3 > method2 > method1 in order of
% robustness. But for time to convergence, you can easily check method2 >
% method3 > method1,method4

%%% INTERESTING CONCLUSIONS
