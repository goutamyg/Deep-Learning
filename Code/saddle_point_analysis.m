clear all
close all
clc

x_range = 2;
y_range = 2;
resolution = 0.1;
x = -(x_range-resolution): resolution: x_range;
y = -(y_range-resolution): resolution: y_range;

for i = 1:length(x)
    for j = 1:length(y)
        f(i,j) = function_eval(x(i),y(j));
    end
end

figure(),mesh(y, x, f);
hold on

%% Gradient Descent
xy_init = [3,3];  
scatter3(xy_init(2),xy_init(1),function_eval(xy_init(1),xy_init(2)),'og','filled')

dx = resolution; dy = resolution;
alpha = 0.1;
xy_old = xy_init;
max_iter = 800;
eps = 10^-5;

for i = 1:max_iter
    
    grad_f = computeGradient(xy_old,dx,dy); % Compute gradient
    xy_new = xy_old - alpha*grad_f; % Descent step
    
    if(i == max_iter)
        scatter3(xy_new(2),xy_new(1),function_eval(xy_new(1),xy_new(2)),'or','filled')
        
        disp('Gradient Descent: termination after max iteration')
        
    elseif(norm(xy_new - xy_old) < eps)
        scatter3(xy_new(2),xy_new(1),function_eval(xy_new(1),xy_new(2)),'or','filled')
        disp('Gradient Descent: termination due to convergence')
        break
        
    else
        scatter3(xy_new(2),xy_new(1),function_eval(xy_new(1),xy_new(2)),'ob')
    end
    
    if((abs(xy_new(1))> x_range) || (abs(xy_new(2))> y_range))
        scatter3(xy_new(2),xy_new(1),function_eval(xy_new(1),xy_new(2)),'or','filled')
        disp('Gradient Descent: termination due to out of range')
        break
    end
    
    xy_old = xy_new;
    
end

%% Newton's  method

figure(),mesh(y, x, f);
hold on

scatter3(xy_init(2),xy_init(1),function_eval(xy_init(1),xy_init(2)),'og','filled')

max_iter = 50;
xy_old = xy_init;

for i = 1:max_iter
    
    grad_xy = computeGradient(xy_old,dx,dy);
    hessian_xy = computeHessian(xy_old,dx,dy);
    
    xy_new = xy_old - (hessian_xy\grad_xy')';

    if(i == max_iter)
        scatter3(xy_new(2),xy_new(1),function_eval(xy_new(1),xy_new(2)),'or','filled')
        disp('Newtons method: termination after max iteration')
        
    elseif(norm(xy_new - xy_old) < eps)
        scatter3(xy_new(2),xy_new(1),function_eval(xy_new(1),xy_new(2)),'or','filled')
        disp('Newtons method: termination due to convergence')
        break
        
    else
        scatter3(xy_new(2),xy_new(1),function_eval(xy_new(1),xy_new(2)),'ob')
    end
    
    xy_old = xy_new;
    
    if((abs(xy_new(1))> x_range) || (abs(xy_new(2))> y_range))
        scatter3(xy_new(2),xy_new(1),function_eval(xy_new(1),xy_new(2)),'or','filled')
        disp('Newtons method: termination due to convergence')
        break
    end
    
end

%% Saddle-Free Newton

figure(),mesh(y, x, f);
hold on

scatter3(xy_init(2),xy_init(1),function_eval(xy_init(1),xy_init(2)),'og','filled')

max_iter = 50;
xy_old = xy_init;

for i = 1:max_iter
    
    grad_xy = computeGradient(xy_old,dx,dy);
    hessian_xy = computeHessian(xy_old,dx,dy);
    
    [eigvec_hessian, eigval_hessian] = eig(hessian_xy);
    new_hessian_xy = eigvec_hessian*abs(eigval_hessian)*eigvec_hessian';
    
    xy_new = xy_old - (new_hessian_xy\grad_xy')';

    if(i == max_iter)
        scatter3(xy_new(2),xy_new(1),function_eval(xy_new(1),xy_new(2)),'or','filled')
        disp('SFN: termination after max iteration')
        
    elseif(norm(xy_new - xy_old) < eps)
        scatter3(xy_new(2),xy_new(1),function_eval(xy_new(1),xy_new(2)),'or','filled')
        disp('SFN: termination due to convergence')
        break
    else
        scatter3(xy_new(2),xy_new(1),function_eval(xy_new(1),xy_new(2)),'ob')
    end
    
    xy_old = xy_new;
    
    if((abs(xy_new(1))> x_range) || (abs(xy_new(2))> y_range))
        scatter3(xy_new(2),xy_new(1),function_eval(xy_new(1),xy_new(2)),'or','filled')
        disp('SFN: termination due to out of range')
        break
    end
    
end
