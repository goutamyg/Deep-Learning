function xy_new = saddleFreeNewton(xy_old,dx,dy)

grad_xy = computeGradient(xy_old,dx,dy);
hessian_xy = computeHessian(xy_old,dx,dy);

[eigvec_hessian, eigval_hessian] = eig(hessian_xy);
new_hessian_xy = eigvec_hessian*abs(eigval_hessian)*eigvec_hessian';

xy_new = xy_old - (new_hessian_xy\grad_xy')';