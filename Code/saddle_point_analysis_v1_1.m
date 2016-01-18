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
xy_init = [3,-0.5];  

% Set the grid resolution
dx = 0.001; % grid resolution for x-axis 
dy = 0.001; % grid resolution for y-axis

%% Gradient Descent

eta = 0.01; % Learning rate
xy_old = xy_init;
max_iter = 1000;
eps = 10^-5;
grad_desc_steps = []; % Tracking the path of Gradient Descent

for i = 1:max_iter
    
    xy_new = gradientDescent(xy_old,eta,dx,dy); % Computing gradient descent step
    
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
    
    xy_new = newtonsMethod(xy_old,dx,dy); % Computing Newton step

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
    
    xy_new = saddleFreeNewton(xy_old,dx,dy); % compuitng SFN step
    
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

%% Gradient Descent with Momentum

eta = 0.01; % Learning rate
p = 0.9; % Momentum Parameter
xy_old = xy_init;
delta_xy_old = zeros(size(xy_old)); 
max_iter = 1000;
eps = 10^-5;
grad_desc_with_momentum_steps = []; % Tracking the path of Gradient Descent

for i = 1:max_iter
    
    xy_new = gradientDescentWithMomentum(xy_old,eta,dx,dy,p,delta_xy_old); % Computing gradient descent step
    
    grad_desc_with_momentum_steps = [grad_desc_with_momentum_steps; xy_new];
    
    if(i == max_iter)    
        disp('Gradient Descent with Momentum: termination after max iteration')
        
    elseif(norm(xy_new - xy_old) < eps)
        disp('Gradient Descent with Momentum: termination due to convergence')
        break
        
    elseif((abs(xy_new(1))> x_range) || (abs(xy_new(2))> y_range))
        disp('Gradient Descent with Momentum: termination due to out of range')
        break
    end
    
    % Re-initialization for next iteration
    delta_xy_old = xy_new - xy_old;
    xy_old = xy_new;
end

%% RMS-Prop

eta = 0.01; % Learning rate
xy_old = xy_init;
max_iter = 1000;
eps = 10^-5;
rmsprop_steps = []; % Tracking the path of Gradient Descent
num_previous_grad = 5; % Number of previous gradients under consideration
grad_history = zeros(num_previous_grad,2);

for i = 1:max_iter
    
    [grad_f,xy_new] = rmsprop(xy_old,eta,dx,dy,grad_history); % Computing rmsprop step
    
    rmsprop_steps = [rmsprop_steps; xy_new];
    
    if(i == max_iter)    
        disp('RMS-Prop: termination after max iteration')
        
    elseif(norm(xy_new - xy_old) < eps)
        disp('RMS-Prop: termination due to convergence')
        break
        
    elseif((abs(xy_new(1))> x_range) || (abs(xy_new(2))> y_range))
        disp('RMS-Prop: termination due to out of range')
        break
    end
    
    % Re-initialization for next iteration
    xy_old = xy_new;
    grad_history = circshift(grad_history,1,1);
    grad_history(1,:) = grad_f;
    
end

%% Plot the results

% Plotting the function
figure(),mesh(y, x, f);
xlabel('Y-Axis')
ylabel('X-Axis')
hold on
scatter3(xy_init(2),xy_init(1),function_eval(xy_init(1),xy_init(2)),'ok','filled')

% Plotting Gradient Descent Results
plotPath(grad_desc_steps,'or')

% Plotting Newton Method results
plotPath(newton_steps,'og')

% Plotting SFN results
plotPath(SFN_steps,'ob')

% Plotting Gradient Descent with Momentum Results
plotPath(grad_desc_with_momentum_steps,'oc')

% Plotting RMS-Prop results
plotPath(rmsprop_steps,'om')