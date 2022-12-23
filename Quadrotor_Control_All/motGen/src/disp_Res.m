%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
% Plots all splines (position, velocity, acceleration and jerk) for all        %
% components.                                                                  %
%                                                                              %
% Inputs                                                                       %
%    T          : values of the time         : [1,N]                           %
%    X          : values of the position     : [1,N]                           %
%    V          : values of the velocity     : [1,N]                           %
%    A          : values of the acceleration : [1,N]                           %
%    Je         : values of the jerk         : [1,N]                           %
%    TTrajChange: times at which the new traj starts : [1,nrOfIntervals]       %
%    vmax      : maximum velocity                          : [1,1]             %
%    amax      : maximum acceleration                      : [1,1]             %
%    jmax      : maximum jerk                              : [1,1]             %
%    smax      : maximum snap                              : [1,1]             %
%    colors    : style vector for components               : [1,n]             %
%                                                                              %
% Author: Burak Yueksel: -                           %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function []=disp_Res(X,V,A,Je,T,TTrajChange,      ...
                        xmax,vmax,amax,jmax,smax, ...
                        colors)
                    
   X0 = X(1);
   V0 = V(1);
   A0 = A(1);
   XF = X(end);
   VF = V(end);
   AF = A(end);
   tF = T(end);
   minx=xmax;
   minv=-vmax;
   maxx=-xmax;
   maxv=vmax;

   NbDof=size(X0,2);

   clf
   NbColors=numel(colors);
   for k=1:NbDof

      if(k>NbColors)
         color='b';
      else
         color=colors(k);
      end
      
      minx=min([minx X]);
      minv=min([minv V]);
      maxx=max([maxx X]);
      maxv=max([maxv V]);

      if(k==1)
      
         subplot(4,1,1);
         hold on
         plot([0 tF],[-xmax -xmax],'k--');
         plot([0 tF],[0 0],'k--');
         plot([0 tF],[xmax xmax],'k--');
         for i=1:length(TTrajChange)
            plot([TTrajChange(i) TTrajChange(i)],[-xmax xmax],'k--');
         end
         title('POSITION');
         
         subplot(4,1,2);
         hold on
         plot([0 tF],[-vmax -vmax],'k--');
         plot([0 tF],[0 0],'k--');
         plot([0 tF],[vmax vmax],'k--');
         for i=1:1:length(TTrajChange)
            plot([TTrajChange(i) TTrajChange(i)],[-vmax vmax],'k--');
         end
         title('VELOCITY');
      
         subplot(4,1,3);
         hold on
         plot([0 tF],[-amax -amax],'k--');
         plot([0 tF],[0 0],'k--');
         plot([0 tF],[amax amax],'k--');
         for i=1:1:length(TTrajChange)
            plot([TTrajChange(i) TTrajChange(i)],[-amax amax],'k--');
         end         
         title('ACCELERATION');
         
         subplot(4,1,4);
         hold on
         plot([0 tF],[-jmax -jmax],'k--');
         plot([0 tF],[0 0],'k--');
         plot([0 tF],[jmax jmax],'k--');
         for i=1:1:length(TTrajChange)
            plot([TTrajChange(i) TTrajChange(i)],[-jmax jmax],'k--');
         end         
         title('JERK');
      
      end
      
      subplot(4,1,1);
      hold on
      plot(0,X0(k),[color 'o']);
      plot(tF,XF(k),[color 'o']);
      plot(T,X,color);
      
      subplot(4,1,2);
      hold on
      plot(0,V0(k),[color 'o']);
      plot(tF,VF(k),[color 'o']);
      plot(T,V,color);

      subplot(4,1,3);
      hold on
      plot(0,A0(k),[color 'o']);
      plot(tF,AF(k),[color 'o']);
      plot(T,A,color);
      
      subplot(4,1,4);
      hold on
      plot(T,Je,color);
      
      if(k==NbDof)
      
         subplot(4,1,1);
         hold on
         axis([0 tF 1.1*minx-0.1*maxx 1.1*maxx-0.1*minx]);
         
         subplot(4,1,2);
         hold on
         axis([0 tF 1.1*minv-0.1*maxv 1.1*maxv-0.1*minv]);
      
         subplot(4,1,3);
         hold on
         axis([0 tF -1.2*amax 1.2*amax]);
         
         subplot(4,1,4);
         hold on
         axis([0 tF -1.2*jmax 1.2*jmax]);
      
      end
      
   end
   
end
