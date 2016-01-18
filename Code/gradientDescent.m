function xy_new = gradientDescent(xy_old, eta, dx, dy)

grad_f = computeGradient(xy_old,dx,dy); % Compute gradient
xy_new = xy_old - eta*grad_f; % Descent step