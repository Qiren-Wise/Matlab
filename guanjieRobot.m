clc
clear

L1 = Link([0 143 0 -pi/2]);
L2 = Link([0 0 135 0 ]);
L3 = Link([0 0 147 0]);
L4 = Link([0 0 61.05 0 ]);
r = SerialLink([L1,L2,L3,L4]);
r.name = 'Dobot';
init_ang = [0 0 0 0];
targ_ang = [pi/6 pi/6 pi/6 pi/6];
step = 40;
[q,qd,qdd] = jtraj(init_ang,targ_ang,step);
subplot(3,2,[1,3]);
r.plot(q);
title('Dobot运动');

subplot(3,2,2);
i = 1:4;
plot(q(:,i));
title('位置');
xlabel('t/s');
ylabel('p/m');
grid on;

subplot(3,2,4);
i = 1:4;
plot(qd(:,i));
title('速度');
xlabel('t/s');
ylabel('v/(m/s)');
grid on;

subplot(3,2,6);
i = 1:4;
plot(qdd(:,i));
title('加速度');
xlabel('t/s');
ylabel('a/(m/s^2)');
grid on;

p1 = r.fkine(init_ang);
p2 = r.fkine(targ_ang);
Tc = ctraj(p1,p2,step);
Tjtraj = transl(Tc);
subplot(3,2,5);
plot2(Tjtraj,'r');
title('p1 to p2 离线轨迹');
xlabel('X/mm'),ylabel('Y/mm'),zlabel('Z/mm');
grid on;
