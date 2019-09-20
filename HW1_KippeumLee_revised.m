
% HW1
% Kippeum Lee

%% Q1

X = [1,1.5,3,4,5,7,9,10]; % Much Faster X = [1, 1.5, 3:5, 7, 9, 10];
X

% generate Y1 and Y2
Y1 = -2 + 0.5*X;
Y2 = -2 + 0.5*(X.^2);
Y1
Y2

% plot Y1 and Y2 against X
figure
plot(X,Y1,X,Y2)

%% Q2

% generate X
X = linspace(-10,20,200)';
X

% sum of X
sum = sum(X);
sum

%% Q3

A = [ 2 4 6 ; 1 7 5 ; 3 12 4 ];
b = [ -2 3 10 ]';

C = A'*b; 
D = (A'*A)\b;
C
D

% Better to do: E = sum(b?*A)
E = 0;
for i = 1:3
    for j = 1:3
        E = E + A(i,j)*b(i,1)
    end
end
E

F = A;
F(2,:) = [];
F(:,3) = [];
F

% Simpler F = A([1 ,3] ,1:2)

x = A\b;
x

%% Q4

B = blkdiag(A,A,A,A,A);
B

%% 05

G = normrnd(10,5,[5,3]);
A = G;
A

% Do this: A = A>=10
for i = 1:5
    for j = 1:3
        if A(i,j) < 10 
            A(i,j) = 0
        else
            A(i,j) = 1
        end
    end
end
A

%% Q6

% I imported the datahw1.csv with the name datahw1. I deleted 3
% observations which have blank in their data set. Thus, the size of
% imported data set is 4389

% Your approach implictly assumes that there are no NaNs in the data:
% Consider following the procedure used in the answer key.

n = 4389;
id = datahw1(:,1);
year = datahw1(:,2);
export = datahw1(:,3);
rd = datahw1(:,4);
prod = datahw1(:,5);
cap = datahw1(:,6);

y = prod;
one = ones(n,1);
X = [ one export rd cap ];
k = 4;

% OLS estimator
b = (X'*X)\(X'*y);
b

% standard errors
res = y - X*b; % estimate residuals
res2 = res.^2;
cov = (X'*X)\(X'*res2)*(X'*res2)'/(X'*X); % covariance matrix
stderror = diag(cov); % standard errors
tvalue = b./sqrt(stderror); % t values
stderror

