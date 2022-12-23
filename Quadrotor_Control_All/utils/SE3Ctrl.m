function [f, M] = SE3Ctrl(xd,vd,ad,jd,sd,yawRef,yawRefDot,yawRefDDot,x,v,a,j,R,Omega,J, g, m)
% control gains
kx = 4*m;
kv = 5.6*m;
kR = 8.81;
kOmega = 2.54;
% calculate translational errors
error_x = x - xd;
error_v = v - vd;
error_a = a - ad;
error_j = j - jd;
% desired heading as function of yaw and its derivatives     
b1_d      = [cos(yawRef) sin(yawRef) 0]'; %e1
b1_d_dot  = [-sin(yawRef)*yawRefDot cos(yawRef)*yawRefDot 0]';
b1_d_ddot = [-sin(yawRef)*yawRefDDot - cos(yawRef)*yawRefDot^2  cos(yawRef)*yawRefDDot - sin(yawRef)*yawRefDot^2 0]';    
% inertial frame 3-axis
e3 = [0;0;1];
% control thrust and its magnitude
A = -kx*error_x - kv*error_v - m*g*e3 + m*ad;
f = vec_dot(-A, R*e3);
% Now we are going to construct the desired/control rotation matrix
% direction of the thrust vector (desired/control)
% aka body z direction
b3_c = -A/norm(A);
% vector orthogonal to thrust direction and desired heading.
% this is directing to y axis
C = vec_cross(b3_c, b1_d);
% orthonormal desired body y direction
b2_c = C/norm(C);
% orthonormal desired body x direction
b1_c = vec_cross(b2_c,b3_c);
% construct the rotation matrix to be tracked
R_c = [b1_c b2_c b3_c];
% time derivatives of body axes for excessive attitude tracking
% performances
A_dot   = -kx*error_v - kv*error_a + m*jd;
% time derivative of body z
b3_c_dot = -A_dot/norm(A) + (vec_dot(A,A_dot)/norm(A)^3)*A;
C_dot   = vec_cross(b3_c_dot, b1_d) + vec_cross(b3_c, b1_d_dot);
% time derivative of body y
b2_c_dot = C/norm(C) - (vec_dot(C,C_dot)/norm(C)^3)*C;
% time derivative of body x
b1_c_dot = vec_cross(b2_c_dot, b3_c) + vec_cross(b2_c, b3_c_dot);
% second time derivatives of body axes
A_ddot   = -kx*error_a - kv*error_j + m*sd;
% second time derivative of body z
b3_c_ddot = -A_ddot/norm(A) + (2/norm(A)^3)*vec_dot(A,A_dot)*A_dot ...
         + ((norm(A_dot)^2 + vec_dot(A,A_ddot))/norm(A)^3)*A       ...
         - (3/norm(A)^5)*(vec_dot(A,A_dot)^2)*A;
C_ddot   = vec_cross(b3_c_ddot, b1_d) + vec_cross(b3_c, b1_d_ddot)          ...
         + 2*vec_cross(b3_c_dot, b1_d_dot);
% time derivative of body y
b2_c_ddot = C_ddot/norm(C) - (2/norm(C)^3)*vec_dot(C,C_dot)*C_dot  ...
         - ((norm(C_ddot)^2 + vec_dot(C,C_ddot))/norm(C)^3)*C       ...
         + (3/norm(C)^5)*(vec_dot(C,C_dot)^2)*C;
% time derivative of body x
b1_c_ddot = vec_cross(b2_c_ddot, b3_c) + vec_cross(b2_c, b3_c_ddot)          ...
         + 2*vec_cross(b2_c_dot, b3_c_dot);
% High order rotation terms
R_c_dot      = [b1_c_dot b2_c_dot b3_c_dot];
R_c_ddot     = [b1_c_ddot b2_c_ddot b3_c_ddot];
Omega_c      = vee(R_c'*R_c_dot);
Omega_c_dot  = vee(R_c'*R_c_ddot - hat(Omega_c)*hat(Omega_c));
% proper error definition in SO3 and in its tangent
error_R     = (1/2)*vee(R_c.'*R - R.'*R_c);
error_Omega = Omega - R.'*R_c*Omega_c;
% control torques
M = -kR*error_R - kOmega*error_Omega + vec_cross(Omega, J*Omega) ...
  - J*(hat(Omega)*R.'*R_c*Omega_c - R.'*R_c*Omega_c_dot);
    
end

function c = vec_cross(a, b)
    c = [a(2)*b(3) - a(3)*b(2) ;
         -a(1)*b(3) + a(3)*b(1) ;
         a(1)*b(2) - a(2)*b(1)] ;
end

function t = vee(A)
t = [A(3,2) ;
     A(1,3) ;
     A(2,1)] ;
end

function A = hat(t)
    A = [0 -t(3) t(2) ; t(3) 0 -t(1) ; -t(2) t(1) 0] ;
end

function c = vec_dot(a, b)
    c = a'*b ;
end