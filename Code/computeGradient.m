% compute Gradient %

function grad_f = computeGradient(currentLocn,dx,dy)

partial_X = (function_eval(currentLocn(1)+dx,currentLocn(2)) - ...
                        function_eval(currentLocn(1),currentLocn(2)))/dx;
                    
partial_Y = (function_eval(currentLocn(1),currentLocn(2)+dy) - ...
    function_eval(currentLocn(1),currentLocn(2)))/dy;

grad_f = [partial_X, partial_Y];