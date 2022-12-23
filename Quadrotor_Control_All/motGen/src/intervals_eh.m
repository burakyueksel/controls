%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
% Computes the ordered acceleration intervals for phases E to H.               %
%                                                                              %
% Inputs                                                                       %
%   vF     : final velocity       : [1,1]                                      %
%   aF     : final acceleration   : [1,1]                                      %
%   amax   : maximum acceleration : [1,1]                                      %
%   jmax   : maximum jerk         : [1,1]                                      %
%   smax   : maximum snap         : [1,1]                                      %
%                                                                              %
% Output                                                                       %
%   int_eh : ordered acceleration intervals for phases E to H : [3,n]          %
%            (with n between 3 and 8).                                         %
%            int_eh(1,1)   : number of intervals                               %
%            int_eh(3,:)   : ordered acceleration intervals                    %
%            int_eh(2,:)   : corresponding velocity intervals                  %
%            int_eh(1,2:n) : corresponding values of case_EGH                  %
%                                                                              %
% Author: Alexandre Boeuf: alex.boeuf[at]gmail.com                             %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function int_eh=intervals_eh(vF,aF,amax,jmax,smax)
   aj=jmax^2/smax;
   A=[amax 0 aj -aj aF aF+aj aF-aj];
   int_eh=[-amax];
   for k=1:7
      if((A(k)*aF<=0 || abs(A(k))>=abs(aF)) && abs(A(k))<=amax)
         l=1;
         n=size(int_eh,2);
         while(l<=n && A(k)<int_eh(l))
            l=l+1;
         end
         if(l>n || abs(A(k)-int_eh(l))>1e-4)
            int_eh=[int_eh(1:l-1) A(k) int_eh(l:n)];
         end
      end
   end
   int_eh=[zeros(2,size(int_eh,2));int_eh];
   n=size(int_eh,2)-1;
   int_eh(1,1)=n;
   for k=1:n
      a1=int_eh(3,k);
      int_eh(2,k)=v_e(a1,0,vF,aF,jmax,smax);
      a2=int_eh(3,k+1);
      int_eh(1,k+1)=case_egh((a1+a2)/2,aF,jmax,smax);
   end
   int_eh(2,n+1)=v_e(int_eh(3,n+1),0,vF,aF,jmax,smax);
end
