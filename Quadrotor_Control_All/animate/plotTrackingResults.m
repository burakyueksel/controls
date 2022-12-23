% plot Quadrotor Des Vs Actual
subplot(2,2,1);
plot(time,p_des(:,1));hold on
plot(time,positions(:,1),'r');
subplot(2,2,2);
plot(time,p_des(:,2));hold on
plot(time,positions(:,2),'r');
subplot(2,2,3);
plot(time,p_des(:,3));hold on
plot(time,positions(:,3),'r');
subplot(2,2,4);
plot(time,yaw_des);hold on
plot(time,rotations(:,3),'r');
%%
posError = p_des - positions;
yawError = yaw_des-rotations(:,3);
normPosError = sqrt(posError(:,1).^2 + posError(:,2).^2 + posError(:,3).^2);
normYawError = sqrt(yawError.^2);
figure
plot(time,normPosError); hold on;
% plot(time,normYawError,'r');