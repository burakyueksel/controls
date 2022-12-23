%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
% Returns the acceleration during phase G and duration of phase G for a given  %
% desired velocity at the beginning of phase E1.                               %
%                                                                              %
% Inputs                                                                       %
%    vE     : desired velocity at the beginning of phase E1 : [1,1]            %
%    vF     : final velocity                                : [1,1]            %
%    aF     : final acceleration                            : [1,1]            %
%    amax   : maximum acceleration                          : [1,1]            %
%    jmax   : maximum jerk                                  : [1,1]            %
%    smax   : maximum snap                                  : [1,1]            %
%    int_eh : velocities intervals and matching cases       : [2,N]            %
%             with N in [2 8]                                                  %
%                                                                              %
% Outputs                                                                      %
%    aG : acceleration during phase G : [1,1]                                  %
%    tG : duration of phase G         : [1,1]                                  %
%                                                                              %
% Author: Alexandre Boeuf: alex.boeuf[at]gmail.com                             %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [aG,tG]=a_g(vE,vF,aF,amax,jmax,smax,int_eh,epsi)

   if(vE<int_eh(2,1))
      aG=amax;
      tG=(int_eh(2,1)-vE)/amax;
      return;
   end
      
   if(vE>int_eh(2,int_eh(1,1)+1))
      aG=-amax;
      tG=(vE-int_eh(2,int_eh(1,1)+1))/amax;
      return;
   end
      
   k=1;
   while(k<=int_eh(1,1) && vE>int_eh(2,k+1))
      k=k+1;
   end
   
   if(k>int_eh(1,1))
      disp('ERROR in a_g : vE not found');
      aG=[];
      tG=[];
      return;
   end
   
   index_int=k;
   tG=0;
   sol=[];
   switch int_eh(1,index_int+1)
      case 210
         aG=(jmax-sqrt(4*sqrt(smax*(aF^2*smax-aF*jmax^2                      ...
           +2*jmax*smax*(vF-vE)))+jmax^2))^2/(4*smax);
         return;
      case 211
         aG=(sqrt(jmax^4+2*aF^2*smax^2-2*aF*jmax^2*smax                      ... 
           +4*jmax*smax^2*(vF-vE))-jmax^2)/(2*smax);
         return;
      case 2010
         aG=-(jmax-sqrt(4*sqrt(smax*(aF*jmax^2+aF^2*smax                     ...
           +2*jmax*smax*(vE-vF)))+jmax^2))^2/(4*smax);
         return;
      case 2011
         aG=(jmax^2-sqrt(jmax^4+2*aF^2*smax^2+2*aF*jmax^2*smax               ...
           +4*jmax*smax^2*(vE-vF)))/(2*smax);
         return;
      case 200
         a=2*smax^(1/2)*(vF-vE)/aF;
         b=-aF;
         c=0;
         d=-(smax*(vE-vF)^2+aF^3)/aF;
         sol=poly_root_4(1,a,b,c,d);
         sol=sol.^2;
      case 201
         a=2*jmax/sqrt(smax);
         b=(2*aF*smax+jmax^2)/smax;
         c=4*aF*jmax/sqrt(smax);
         d=(aF*jmax^2+aF^2*smax+2*jmax*smax*(vE-vF))/smax;
         sol=poly_root_4(1,a,b,c,d);
         sol=sol.^2+aF;
      case 2000
         a=2*sqrt(smax)*(vE-vF)/aF;
         b=-aF;
         c=4*aF*sqrt(smax)*(vF-vE)/aF;
         d=-(smax*(vE-vF)^2+aF^3)/aF;
         sol=poly_root_4(1,a,b,c,d);
         sol=-sol.^2+aF;
      case 2001
         a=2*jmax/sqrt(smax);
         b=(jmax^2-2*aF*smax)/smax;
         c=-4*aF*jmax/sqrt(smax);
         d=(aF^2*smax-aF*jmax^2+2*jmax*smax*(vF-vE))/smax;
         sol=poly_root_4(1,a,b,c,d);
         sol=-sol.^2+aF;
      otherwise
         disp('ERROR in a_g : unknown case :');
         disp(case_aGC);
   end
         
   if(isempty(sol))
      dV=epsi+1;
   else
      dVmin=abs(vE-v_e(sol(1),0,vF,aF,jmax,smax));
      aG=sol(1);
      N=numel(sol);
      for k=2:N
         dV=abs(vE-v_e(sol(k),0,vF,aF,jmax,smax));
         if(dV<dVmin)
            dVmin=dV;
            aG=sol(k);
         end
      end
   end

   if(dV>epsi)
      mina=int_eh(3,index_int);
      maxa=int_eh(3,index_int+1);
      aG=(mina+maxa)/2;
      dV=vE-v_e(aG,0,vF,aF,jmax,smax);
      while(abs(dV)>epsi && abs(maxa-mina)>epsi)
         if(dV>0)
            mina=aG;
         else
            maxa=aG;
         end
         aG=(mina+maxa)/2;
         dV=vE-v_e(aG,0,vF,aF,jmax,smax);
      end
   end
      
end
