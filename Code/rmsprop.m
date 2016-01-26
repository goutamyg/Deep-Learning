function [grad_history,xy_new] = rmsprop(xy_old,eta,rho,dx,dy,grad_history)

grad_f = computeGradient(xy_old,dx,dy); % Compute gradient

grad_history = rho*grad_history + (1-rho)*grad_f.^2;

xy_new = xy_old - eta*(grad_f./sqrt(grad_history));