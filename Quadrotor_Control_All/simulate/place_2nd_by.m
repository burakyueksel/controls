% implemented based on the Ackermann's formula.
% see e.g. the page 6 of
% https://ocw.mit.edu/courses/aeronautics-and-astronautics/16-30-feedback-control-systems-fall-2010/lecture-notes/MIT16_30F10_lec11.pdf
% Author: Burak Yuksel
function K = place_2nd_by(A,B,poles)
    if length(poles)~=2
        display ("Poles should be in size of 2");
        return;
    elseif size(A)~=[2 2]
        display ("A Matrix should be in size of 2x2");
        return;
    elseif size(B)~=[2 1]
        display ("B Matrix should be in size of 2x1");
        return;
    end
    myinf       =10000;
    negpoles    = -poles; % the following computations are done for (s+pole1)(s+pole2)
    % this means if one wants to have pole1, pole2, pole3, ploe4 then one
    % needs to compute for (s-pole1)(s-pole2), which is
    % equivalent to (s+negpole1)(s+negpole2)
    coef_2      = 1;
    coef_1      = negpoles(1)+negpoles(2);
    coef_0      = negpoles(1)*negpoles(2);
%
    Mc          = [B  A*B];
    if abs(det(Mc))>1e-6
        K       = [0 1]*inv(Mc)*(coef_2*A*A + coef_1*A + coef_0*eye(2));
    else
        display ("System is not controllable");
        K       = myinf*eye(4);
    end
end