% animate volo
% initial values
p0=positions(1,:)';
R0=eye(3);
l_in  = [2;0;0]; % meters
l_out = [4;0;0]; % meters
computePropellerPosQuad
hFig = figure(1);
set(hFig, 'Position', [80 100 1000 800])
plotQuad
step = 10;
plotLimTresh = 5;
tic
% writerObj = VideoWriter('out2.avi'); % Name it.
% writerObj.FrameRate = 60; % How many frames per second.
% open(writerObj); 
for t=1:step:length(time)
    hold off;
    p0 = positions(t,:)';
    R0 = RotationMat(:,:,t);
    computePropellerPosQuad
    plotQuad
%     xlim([-15 15])
%     ylim([-15 15])
%     zlim([-5 15])
%     xlim([-30 30])
%     ylim([-30 30])
%     zlim([-30 30])    
    xlim([-max(abs(positions(:,1)))-plotLimTresh max(abs(positions(:,1)))+plotLimTresh])
    ylim([-max(abs(positions(:,2)))-plotLimTresh max(abs(positions(:,2)))+plotLimTresh])
    zlim([-max(abs(positions(:,3)))-plotLimTresh max(abs(positions(:,3)))+plotLimTresh])
    xlabel('x-axis'); ylabel('y-axis'); zlabel('z-axis')
    view([120 30]) %http://de.mathworks.com/help/matlab/ref/view.html
% %     view(0,0)  % XY
%     F=getframe(gcf);
%     writeVideo(writerObj, F);
    pause(0.01);
end
position_vis = (RxMinPi*positions')';
plot3(position_vis(:,1),position_vis(:,2),position_vis(:,3), 'r');
toc
% close(writerObj)
