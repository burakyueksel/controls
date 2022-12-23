plot3(p_des_vis(:,1),p_des_vis(:,2),p_des_vis(:,3));hold on;
%% desired positions
% plot3(0,0,0,'kx','LineWidth',2);hold on;
% plot3(0,0,10,'ko','LineWidth',2);hold on;
% plot3(0,-10,10,'ko','LineWidth',2);hold on;
% plot3(10,-10,10,'kx','LineWidth',2);hold on;
%% XMass Tree
% farbe_stern = [1 0.9 0];
% farbe_tanne = [0 .5 0];
% z = linspace(0,10,360);                                   % Z-Achse
% x = 10-sin(2*pi*3*z + pi*8/9) .* (max(z)-z).^1.3 / max(z); % X-Achse
% y = -10+cos(2*pi*3*z + pi*8/9) .* (max(z)-z).^1.3 / max(z);  % Y-Achse
% plot3(x, y, z+.1, 'color', [0,0.5,0], ...        % Tannenbaum
%                   'LineWidth', 3); hold on;
% if (t>2001)              
%     plot3(10, -10, max(z)*1.1, 'MarkerSize', 16, ...    % Stern
%                   'Marker', 'pentagram', ...
%                   'LineStyle', 'none',... 
%                   'Color', farbe_stern, ...
%                   'LineWidth', 4); hold on;
%     tt=text(-10,0,20,'VOLOCOPTER wishes you a Merry X-Mass','Color',[1 0 0],'FontSize',18);
% %     tt.FontSize = 12;
% %     tt.Color = [1 0 0];
% else
%     plot3(p0(1), p0(2), p0(3)*1.1, 'MarkerSize', 16, ...    % Stern
%                   'Marker', 'pentagram', ...
%                   'LineStyle', 'none',... 
%                   'Color', farbe_stern, ...
%                   'LineWidth', 4); hold on;
% %     tt=text(0,0,15,'Merry X-Mas!','Color',[1 0 0],'FontSize',18);
% end
%% compute the lines connecting points
p_01 = [p0';p1'];
p_02 = [p0';p2'];
p_03 = [p0';p3'];
p_04 = [p0';p4'];
% plot the lines
plot3(p_01(:,1),p_01(:,2),p_01(:,3),'r','LineWidth',2);hold on; grid on;
plot3(p_02(:,1),p_02(:,2),p_02(:,3),'k','LineWidth',2);hold on; 
plot3(p_03(:,1),p_03(:,2),p_03(:,3),'b','LineWidth',2);hold on; %front
plot3(p_04(:,1),p_04(:,2),p_04(:,3),'k','LineWidth',2);hold on; %front
% plot the points
plot3(p0(1),p0(2),p0(3),'or','LineWidth',3);hold on; % COM
plot3(p1(1),p1(2),p1(3),'bx','LineWidth',3);hold on; % rest are propellers
plot3(p2(1),p2(2),p2(3),'bx','LineWidth',3);hold on;
plot3(p3(1),p3(2),p3(3),'bx','LineWidth',3);hold on;
plot3(p4(1),p4(2),p4(3),'bx','LineWidth',3);hold on;