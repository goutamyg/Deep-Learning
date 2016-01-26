function [xy_new,first_moment, second_moment] = ...
    ADAM(xy_old, dx, dy, beta1, beta2, alpha, first_moment_old, second_moment_old, iter_number)

eps = 10^-8;

grad_f = computeGradient(xy_old, dx, dy); % Compute the gradient

first_moment_biased = beta1*first_moment_old + (1-beta1)*grad_f; 
second_moment_biased = beta2*second_moment_old + (1-beta2)*(grad_f.^2);

first_moment = first_moment_biased/(1 - beta1^(iter_number)); % Bias corrected first moment estimate
second_moment = second_moment_biased/(1 - beta2^(iter_number)); % Bias corrected second moment estimate

xy_new = xy_old - alpha* (first_moment./(sqrt(second_moment)+eps)); % weight update