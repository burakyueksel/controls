function Rz = rotationZ(radInput)
Rz = eye(1);
Rz =   [cos(radInput)   -sin(radInput)   0;
        sin(radInput)    cos(radInput)   0;
          0               0              1];