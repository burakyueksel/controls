% plot flat outputs from the linear filter
plot(time,px_ref, '--');hold on
plot(time,p_des(:,1));hold on
plot(time,dp_des(:,1),'r');hold on
plot(time,ddp_des(:,1),'g');hold on
plot(time,dddp_des(:,1),'k');hold on
plot(time,ddddp_des(:,1),'m');
legend('reference position','position','velocity', 'acceleration', 'jerk', 'snap')
xlabel('Time [s]')
ylim ([-1 2])
title('Output of a 4-th order linear filter')
grid on