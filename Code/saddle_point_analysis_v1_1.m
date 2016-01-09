clear all
close all
clc

x_range = 4;
y_range = 4;
resolution = 0.1;
x = -(x_range-resolution): resolution: x_range;
y = -(y_range-resolution): resolution: y_range;

for i = 1:length(x)
    for j = 1:length(y)
        f(i,j) = function_eval(x(i),y(j));
    end
end

% Initialization Point
xy_init = [3.5,0.5];  

% Plotting the function
figure(),mesh(y, x, f);
xlabel('Y-Axis')
ylabel('X-Axis')
hold on
scatter3(xy_init(2),xy_init(1),function_eval(xy_init(1),xy_init(2)),'ok','filled')

% Set the grid resolution
dx = 0.001; % grid resolution for x-axis 
dy = 0.001; % grid resolution for y-axis

%% Gradient Descent

alpha = 0.01; % Learning rate
xy_old = xy_init;
max_iter = 1000;
eps = 10^-5;
grad_desc_steps = []; % Tracking the path of Gradient Descent

for i = 1:max_iter
    
    grad_f = computeGradient(xy_old,dx,dy); % Compute gradient
    xy_new = xy_old - alpha*grad_f; % Descent step
    
    grad_desc_steps = [grad_desc_steps; xy_new];
    
    if(i == max_iter)    
        disp('Gradient Descent: termination after max iteration')
        
    elseif(norm(xy_new - xy_old) < eps)
        disp('Gradient Descent: termination due to convergence')
        break
        
    elseif((abs(xy_new(1))> x_range) || (abs(xy_new(2))> y_range))
        disp('Gradient Descent: termination due to out of range')
        break
    end
    
    % Re-initialization for next iteration
    xy_old = xy_new;
    
end

%% Newton's  method

max_iter = 50;
xy_old = xy_init;
newton_steps = []; % Tracking the path of Newton method

for i = 1:max_iter
    
    grad_xy = computeGradient(xy_old,dx,dy);
    hessian_xy = computeHessian(xy_old,dx,dy);
    
    xy_new = xy_old - (hessian_xy\grad_xy')';
    newton_steps = [newton_steps; xy_new];
    
    if(i == max_iter)
        disp('Newtons method: termination after max iteration')
        
    elseif(norm(xy_new - xy_old) < eps)
        disp('Newtons method: termination due to convergence')
        break
        
    elseif((abs(xy_new(1))> x_range) || (abs(xy_new(2))> y_range))
        disp('Newtons method: termination due to out of range')
        break
    end
    
    % Re-initialization for next iteration
    xy_old = xy_new;
    
end

%% Saddle-Free Newton

max_iter = 50;
xy_old = xy_init;
SFN_steps = []; % Tracking the path of SFN

for i = 1:max_iter
    
    grad_xy = computeGradient(xy_old,dx,dy);
    hessian_xy = computeHessian(xy_old,dx,dy);
    
    [eigvec_hessian, eigval_hessian] = eig(hessian_xy);
    new_hessian_xy = eigvec_hessian*abs(eigval_hessian)*eigvec_hessian';
    
    xy_new = xy_old - (new_hessian_xy\grad_xy')';
    SFN_steps = [SFN_steps; xy_new];
    
    if(i == max_iter)
        disp('SFN: termination after max iteration')
        
    elseif(norm(xy_new - xy_old) < eps)
        disp('SFN: termination due to convergence')
        break
        
    elseif((abs(xy_new(1))> x_range) || (abs(xy_new(2))> y_range))
        disp('SFN: termination due to out of range')
        break
    end
    
    % Re-initialization for next iteration
    xy_old = xy_new;
    
end

%% Plot the results

% Plotting Gradient Descent Results
[r,~] = size(grad_desc_steps);
for i = 1:r
    scatter3(grad_desc_steps(i,2),grad_desc_steps(i,1),...
        function_eval(grad_desc_steps(i,1),grad_desc_steps(i,2)),'or','filled')
end

% Plotting Newton Method results
[r,~] = size(newton_steps);
for i = 1:r
    scatter3(newton_steps(i,2),newton_steps(i,1),...
        function_eval(newton_steps(i,1),newton_steps(i,2)),'og','filled')
end

% Plotting SFN results
[r,~] = size(SFN_steps);
for i = 1:r
    scatter3(SFN_steps(i,2),SFN_steps(i,1),function_eval(SFN_steps(i,1),SFN_steps(i,2)),'ob','filled')
end
