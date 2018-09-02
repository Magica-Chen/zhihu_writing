function A = meanExp(hyp, x, i)

% Exponential mean function. The mean function is parameterized as:
%
% m(x) = sum_i a * exp ( x_i/b_i);
%
% The hyperparameter is:
%
% hyp = [ a
%         b_1
%         b_2
%         ..
%         b_D   ]
%
% See also MEANFUNCTIONS.M.

if nargin<2, A = '1 + D'; return; end             % report number of hyperparameters
[n,D] = size(x);

if any(size(hyp)~=[1+D,1]), error('Exactly D hyperparameters needed.'), end
a = hyp(1);b =hyp(2:1+D);
if nargin==2
    A = exp(x.*b)*a;                                                % evaluate mean
else
    A = a *b.^i.* exp(x.*b);
end
end