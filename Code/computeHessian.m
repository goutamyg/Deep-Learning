% Compute the Hessian

function Hessian = computeHessian(xy_pos,dx,dy)

x = xy_pos(1);
y = xy_pos(2);

dxx = (function_eval(x+2*dx,y) - 2*function_eval(x+dx,y) + function_eval(x,y))/dx^2;
dyy = (function_eval(x,y+2*dy) - 2*function_eval(x,y+dy) + function_eval(x,y))/dy^2;
dxy = (function_eval(x+dx,y+dy) - function_eval(x,y+dy) - function_eval(x+dx,y) + function_eval(x,y))/(dx*dy);

Hessian = [dxx dxy;dxy dyy];
