clc
clear

n1 = 80; n2 = 40;
S1 = eye(2); S2 = [1 0.95; 0.95 1];
m1 = [0.75; 0]; m2 = [-0.75; 0];

x1 = bsxfun(@plus, chol(S1)'*gpml_randn(0.2, 2, n1), m1);
x2 = bsxfun(@plus, chol(S2)'*gpml_randn(0.3, 2, n2), m2); 

x = [x1 x2]'; y = [-ones(1,n1) ones(1,n2)]';

plot(x1(1,:), x1(2,:), 'b+', 'MarkerSize', 12); hold on
plot(x2(1,:), x2(2,:), 'r+', 'MarkerSize', 12);

[t1, t2] = meshgrid(-4:0.1:4,-4:0.1:4);

t = [t1(:) t2(:)]; n = length(t);               % these are the test inputs
tmm = bsxfun(@minus, t, m1');
p1 = n1*exp(-sum(tmm*inv(S1).*tmm/2,2))/sqrt(det(S1));

tmm = bsxfun(@minus, t, m2');
p2 = n2*exp(-sum(tmm*inv(S2).*tmm/2,2))/sqrt(det(S2));
% 
% set(gca, 'FontSize', 24)
% disp('contour(t1, t2, reshape(p2./(p1+p2), size(t1)), [0.1:0.1:0.9])')
% contourf(t1, t2, reshape(p2./(p1+p2), size(t1)), [0.1:0.1:0.9])
% [c h] = contourf(t1, t2, reshape(p2./(p1+p2), size(t1)), [0.5 0.5]);
% set(h, 'LineWidth', 2)
% colorbar

meanfunc = @meanConst; hyp.mean = 0;
% disp('covfunc = @covSEard;   hyp.cov = log([1 1 1]);')
covfunc = @covSEard;   hyp.cov = log([1 1 1]);
% disp('likfunc = @likErf;')
likfunc = @likErf;
disp(' ')

% disp('hyp = minimize(hyp, @gp, -40, @infEP, meanfunc, covfunc, likfunc, x, y);')
hyp = minimize(hyp, @gp, -40, @infEP, meanfunc, covfunc, likfunc, x, y);
% disp('[a b c d lp] = gp(hyp, @infEP, meanfunc, covfunc, likfunc, x, y, t, ones(n, 1));')
[a b c d lp] = gp(hyp, @infEP, meanfunc, covfunc, likfunc, x, y, t, ones(n,1));

set(gca, 'FontSize', 24)
% disp('plot(x1(1,:), x1(2,:), ''b+''); hold on')
plot(x1(1,:), x1(2,:), 'b+', 'MarkerSize', 12); hold on
% disp('plot(x2(1,:), x2(2,:), ''r+'')')
plot(x2(1,:), x2(2,:), 'r+', 'MarkerSize', 12)
% disp('contour(t1, t2, reshape(exp(lp), size(t1)), 0.1:0.1:0.9)')
contourf(t1, t2, reshape(exp(lp), size(t1)))
% [c h] = contourf(t1, t2, reshape(exp(lp), size(t1)));
% set(h, 'LineWidth', 2)
colorbar
