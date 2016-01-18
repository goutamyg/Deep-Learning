function xy_new = newtonsMethod(xy_old,dx,dy)

grad_xy = computeGradient(xy_old,dx,dy);
hessian_xy = computeHessian(xy_old,dx,dy);
    
xy_new = xy_old - (hessian_xy\grad_xy')';