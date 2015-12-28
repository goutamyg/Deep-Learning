% This function evalues the function-value at (x,y)

function fval = function_eval(x,y)

% 1.
fval = x^3 - 3*x*y^2;

% xy_init = [-0.7,1.6]; 
% xy_init = [-3,3.5]; 
% xy_init = [3.5,0.5]; 

% 2.
% fval = 3*x^2 - y^2;
% xy_init = [3.5,0.5]; 

% 3.
% fval = x^3 - y^3 - 3*x + 3*y;
% xy_init = [1.8,1.2]; 
% xy_init = [-0.5,-1.8];

% 4.
% fval = exp(-(x^2+y^2))*sin(x)*sin(y);
% xy_init = [0.4,0.2]; 
% xy_init = [-1,-0.6];

% 5.
% fval = cos(x)*sin(y);
% xy_init = [-0.3,0.7];
% xy_init = [-0.7,1.6];
% xy_init = [-1.8,1.5];

% 6.
% fval = x^3 + y^3 - 3*x*y;
% xy_init = [3.6,2.6];

% 7. 
% fval = sin(((x^2)/2)-((y^2)/4)+3)*cos(2*x+1-exp(y));



% fval = abs(x)+abs(y);