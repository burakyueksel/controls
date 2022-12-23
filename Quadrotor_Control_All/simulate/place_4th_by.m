% implemented based on the Ackermann's formula.
% see e.g. the page 6 of
% https://ocw.mit.edu/courses/aeronautics-and-astronautics/16-30-feedback-control-systems-fall-2010/lecture-notes/MIT16_30F10_lec11.pdf
% Author: Burak Yuksel
function K = place_4th_by(A,B,poles)
    if length(poles)~=4
        display ("Poles should be in size of 4");
        return;
    elseif size(A)~=[4 4]
        display ("A Matrix should be in size of 4x4");
        return;
    elseif size(B)~=[4 1]
        display ("B Matrix should be in size of 4x1");
        return;
    end
    myinf       =10000;
    negpoles    = -poles; % the following computations are done for (s+pole1)(s+pole2)(s+pole3)(s+pole4)
    % this means if one wants to have pole1, pole2, pole3, ploe4 then one
    % needs to compute for (s-pole1)(s-pole2)(s-pole3)(s-pole4), which is
    % equivalent to (s+negpole1)(s+negpole2)(s+negpole3)(s+negpole4)
    coef_4      =  1;
    coef_3      =  negpoles(1)+negpoles(2)+negpoles(3)+negpoles(4);
    coef_2      =  negpoles(1)*negpoles(2)+negpoles(3)*negpoles(4)+(negpoles(1)+negpoles(2))*(negpoles(3)+negpoles(4));
    coef_1      = (negpoles(1)+negpoles(2))*negpoles(3)*negpoles(4) + negpoles(1)*negpoles(2)*(negpoles(3)+negpoles(4));
    coef_0      =  negpoles(1)*negpoles(2)*negpoles(3)*negpoles(4);
%
    Mc          = [B  A*B  A*A*B A*A*A*B];
    if abs(det(Mc))>1e-6
        K       = [0 0 0 1]*inv(Mc)*(coef_4*A*A*A*A + coef_3*A*A*A + coef_2*A*A + coef_1*A + coef_0*eye(4));
    else
        display ("System is not controllable");
        K       = myinf*eye(4);
    end
end