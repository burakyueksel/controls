% Quadrotor Frame is NED, figure frame is z up.
% To allign Quadrotor frame with figure frame, we need to rotate
% p0 and R0 with Rx(-pi)
RxMinPi = [1        0           0;
           0   cos(-pi)     -sin(-pi);
           0   sin(-pi)      cos(-pi)];
% visualized desired trajectory
p_des_vis = (RxMinPi*p_des')';
% changing the coordinates for the plots
p0 = RxMinPi*p0;
R0 = RxMinPi*R0;
% inner propellers
p1 = p0 + R0*rotationZ(0)*l_in; % 0 degrees = 0 rad
p2 = p0 + R0*rotationZ(1.5708)*l_in;  % 90 degrees = 1.5708  rad
p3 = p0 + R0*rotationZ(3.1416)*l_in;  % 180 degrees = 3.1416  rad
p4 = p0 + R0*rotationZ(4.7124)*l_in;  % 135 degrees = 4.7124  rad