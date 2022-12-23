%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
% Plots all splines (position, velocity, acceleration and jerk) for all        %
% components.                                                                  %
%                                                                              %
% Inputs                                                                       %
%    X0        : initial position vector                   : [1,n]             %
%    V0        : initial velocitiy vector                  : [1,n]             %
%    A0        : initial acceleration vector               : [1,n]             %
%    XF        : final position vector                     : [1,n]             %
%    VF        : final velocitiy vector                    : [1,n]             %
%    AF        : final acceleration vector                 : [1,n]             %
%    vmax      : maximum velocity                          : [1,1]             %
%    amax      : maximum acceleration                      : [1,1]             %
%    jmax      : maximum jerk                              : [1,1]             %
%    smax      : maximum snap                              : [1,1]             %
%    tF        : total duration                            : [1,1]             %
%    Durations : duration of all phases for all components : [n,11]            %
%    Signs     : sign of the snap for all components       : [n,4]             %
%    colors    : style vector for components               : [1,n]             %
%    NbPoints  : number of displayed points in each curve  : [1,1]             %
%                                                                              %
% Author: Alexandre Boeuf: alex.boeuf[at]gmail.com                             %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [T,X,V,A,Je]=disp_spline_o(X0,V0,A0,                 ...
                        XF,VF,AF,                 ...
                        tF,Durations,Signs,       ...
                        xmax,vmax,amax,jmax,smax, ...
                        colors,NbPoints)

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
      
      durations=Durations(k,:);
      signs=Signs(k,:);
      [T,X,V,A,Je]=spline_vector(X0(k),V0(k),A0(k),XF(k),VF(k),AF(k),smax,   ...
                                                      durations,signs,NbPoints);
      
      minx=min([minx X]);
      minv=min([minv V]);
      maxx=max([maxx X]);
      maxv=max([maxv V]);

      if(k==1)
      
         subplot(4,1,1);
         hold on
         title('POSITION');
         
         subplot(4,1,2);
         hold on
         plot([0 tF],[-vmax -vmax],'k--');
         plot([0 tF],[0 0],'k--');
         plot([0 tF],[vmax vmax],'k--');
         title('VELOCITY');
      
         subplot(4,1,3);
         hold on
         plot([0 tF],[-amax -amax],'k--');
         plot([0 tF],[0 0],'k--');
         plot([0 tF],[amax amax],'k--');
         title('ACCELERATION');
         
         subplot(4,1,4);
         hold on
         plot([0 tF],[-jmax -jmax],'k--');
         plot([0 tF],[0 0],'k--');
         plot([0 tF],[jmax jmax],'k--');
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
   % Store for each DoF
   
end
