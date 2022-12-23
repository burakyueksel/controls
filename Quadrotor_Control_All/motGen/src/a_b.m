%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
% Returns the acceleration during phase B and duration of phase B for a given  %
% desired velocity at the end of phase C3.                                     %
%                                                                              %
% Inputs                                                                       %
%    vC     : desired velocity at the end of phase C3 : [1,1]                  %
%    v0     : initial velocity                        : [1,1]                  %
%    a0     : initial acceleration                    : [1,1]                  %
%    amax   : maximum acceleration                    : [1,1]                  %
%    jmax   : maximum jerk                            : [1,1]                  %
%    smax   : maximum snap                            : [1,1]                  %
%    int_ac : velocities intervals and matching cases : [2,N] with N in [2 8]  %
%                                                                              %
% Outputs                                                                      %
%    aB : acceleration during phase B : [1,1]                                  %
%    tB : duration of phase B         : [1,1]                                  %
%                                                                              %
% Author: Alexandre Boeuf: alex.boeuf[at]gmail.com                             %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [aB,tB]=a_b(vC,v0,a0,amax,jmax,smax,int_ac,epsi)

   if(vC<int_ac(2,1))
      aB=-amax;
      tB=(int_ac(2,1)-vC)/amax;
      return;
   end
   
   if(vC>int_ac(2,int_ac(1,1)+1))
      aB=amax;
      tB=(vC-int_ac(2,int_ac(1,1)+1))/amax;
      return;
   end
   
   tB=0;
   k=2;
   while(k<=int_ac(1,1)+1 && vC>int_ac(2,k))
      k=k+1;
   end
   
   if(k>int_ac(1,1)+1)
      disp('ERROR in a_b : vC not found');
      vC
      int_ac
      aB=[];
      tB=[];
      return;
   end
   
   index_int=k;
   sol=[];
   switch int_ac(1,index_int)
      case 210
         aB=-(jmax-sqrt(4*sqrt(smax*(a0*jmax^2+a0^2*smax                     ...
           +2*jmax*smax*(v0-vC)))+jmax^2))^2/(4*smax);
         return;
      case 211
         aB=(jmax^2-sqrt(jmax^4+2*a0^2*smax^2                                ...
           +4*jmax*smax^2*(v0-vC)+2*a0*jmax^2*smax))/(2*smax);
         return;
      case 2010
         aB=(jmax-sqrt(4*sqrt(smax*(a0^2*smax-a0*jmax^2                      ...
           +2*jmax*smax*(vC-v0)))+jmax^2))^2/(4*smax);
         return;
      case 2011
         aB=(sqrt(jmax^4+2*a0^2*smax^2                                       ...
           +4*jmax*smax^2*(vC-v0)-2*a0*jmax^2*smax)-jmax^2)/(2*smax);
         return;
      case 200
         a=(2*sqrt(smax)*(v0-vC))/a0;
         b=-a0;
         c=-(4*a0*sqrt(smax)*(v0-vC))/a0;
         d=-(smax*(v0-vC)^2+a0^3)/a0;
         sol=poly_root_4(1,a,b,c,d);
         sol=-1.0*sol.^2+a0;
      case 201
         a=2*jmax/sqrt(smax);
         b=(jmax^2-2*a0*smax)/smax;
         c=-4*a0*jmax/sqrt(smax);
         d=-(a0*jmax^2-a0^2*smax+2*jmax*smax*(v0-vC))/smax;
         sol=poly_root_4(1,a,b,c,d);
         sol=-1.0*sol.^2+a0;
      case 2000
         a=2*sqrt(smax)*(vC-v0)/a0;
         b=-a0;
         c=0;
         d=-(smax*(vC-v0)^2+a0^3)/a0;
         sol=poly_root_4(1,a,b,c,d);
         sol=sol.^2;
      case 2001
         a=2*jmax/sqrt(smax);
         b=((2*a0*smax+jmax^2))/smax;
         c=4*a0*jmax/sqrt(smax);
         d=(a0*jmax^2+a0^2*smax+2*jmax*smax*(v0-vC))/smax;
         sol=poly_root_4(1,a,b,c,d);
         sol=sol.^2+a0;
      otherwise
         disp('ERROR in a_b : unknown case :');
         disp(int_ac(1,index_int));
   end

   if(isempty(sol))
      dV=epsi+1;
   else
      dVmin=abs(vC-v_c(sol(1),0,v0,a0,jmax,smax));
      aB=sol(1);
      N=numel(sol);
      for k=2:N
         dV=abs(vC-v_c(sol(k),0,v0,a0,jmax,smax));
         if(dV<dVmin)
            dVmin=dV;
            aB=sol(k);
         end
      end
      dV=dVmin;
   end
   
   if(dV>epsi)
      mina=int_ac(3,index_int-1);
      maxa=int_ac(3,index_int);
      aB=(mina+maxa)/2;
      dV=vC-v_c(aB,0,v0,a0,jmax,smax);
      while(abs(dV)>epsi && abs(maxa-mina)>epsi)
         if(dV>0)
            mina=aB;
         else
            maxa=aB;
         end
         aB=(mina+maxa)/2;
         dV=vC-v_c(aB,0,v0,a0,jmax,smax);
      end
   end
   
end
