function xy_new = gradientDescentWithMomentum(xy_old, eta, dx, dy, p, delta_xy_old)

grad_f = computeGradient(xy_old,dx,dy); % Compute gradient

xy_new = xy_old - eta*grad_f + p*delta_xy_old; % Descent with momentum