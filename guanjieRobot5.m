% Modified DH
% ABB robot
% lujingguihua
clear;
clc;
% %机器人建模
th(1) = 0; d(1) = 0; a(1) = 0; alp(1) = 0;
th(2) = 0; d(2) = 0; a(2) = 3.20; alp(2) = pi/2;   
th(3) = 0; d(3) = 0; a(3) = 9.75; alp(3) = 0;
th(4) = 0; d(4) = 8.87; a(4) = 2; alp(4) = pi/2;
th(5) = 0; d(5) = 0; a(5) = 0; alp(5) = -pi/2;
th(6) = 0; d(6) = 0; a(6) = 0; alp(6) = pi/2;
% DH parameters  th     d    a    alpha  sigma
L1 = Link([th(1), d(1), a(1), alp(1), 0], 'modified');
L2 = Link([th(2), d(2), a(2), alp(2), 0], 'modified');
L3 = Link([th(3), d(3), a(3), alp(3), 0], 'modified');
L4 = Link([th(4), d(4), a(4), alp(4), 0], 'modified');
L5 = Link([th(5), d(5), a(5), alp(5), 0], 'modified');
L6 = Link([th(6), d(6), a(6), alp(6), 0], 'modified');
robot = SerialLink([L1, L2, L3, L4, L5, L6]); %SerialLink 类函数
robot.name='Robot-6-dof';
robot.display(); %显示D-H表

%轨迹规划参数设置
init_ang = [pi/6,0, 2*pi/3,pi/3, 0, 0];
targ_ang = [pi/2,pi/6,0,0, -pi/2, pi/6];
T =(0:0.1:5);
%关节空间轨迹规划方法
[q,qd,qdd] = jtraj(init_ang,targ_ang,T); %直接得到角度、角速度、角加速度的的序列

%%显示
figure(1);
%动画显示
subplot(1,2,1); 
title('动画过程');
robot.plot(q);
% 轨迹显示
t=robot.fkine(q);%运动学正解
rpy=tr2rpy(t);  %t中提取位置（xyz）
subplot(1,2,2);
plot2(rpy);
xlabel('X/mm'),ylabel('Y/mm'),zlabel('Z/mm');hold on
title('空间轨迹');
text(rpy(1,1),rpy(1,2),rpy(1,3),'A点');
text(rpy(51,1),rpy(51,2),rpy(51,3),'B点');
% 指定文件夹保存图片
filepath=pwd;           %保存当前工作目录
cd('C:\Users\Administrator\Desktop\pic')                %把当前工作目录切换到图片存储文件夹
print(gcf,'-djpeg','C:\Users\Administrator\Desktop\pic\1.jpeg'); %将图片保存为jpg格式，
cd(filepath)            %切回原工作目录

%单个关节的位置title('关节1位置');
figure(2);
subplot(3,2,1);
plot(T,q(:,1));
xlabel('t/s'),ylabel('θ1/rad');hold on
subplot(3,2,2);
plot(T,q(:,2));
xlabel('t/s'),ylabel('θ2/rad');hold on
subplot(3,2,3);
plot(T,q(:,3));
xlabel('t/s'),ylabel('θ3/rad');hold on
subplot(3,2,4);
plot(T,q(:,4));
xlabel('t/s'),ylabel('θ4/rad');hold on
subplot(3,2,5);
plot(T,q(:,5));
xlabel('t/s'),ylabel('θ5/rad');hold on
subplot(3,2,6);
plot(T,q(:,6));
xlabel('t/s'),ylabel('θ6/rad');hold on
% 指定文件夹保存图片
filepath=pwd;           %保存当前工作目录
cd('C:\Users\Administrator\Desktop\pic')                %把当前工作目录切换到图片存储文件夹
print(gcf,'-djpeg','C:\Users\Administrator\Desktop\pic\2.jpeg'); %将图片保存为jpg格式，
cd(filepath)            %切回原工作目录

%单个关节的速度
figure(3);
subplot(3,2,1);
plot(T,qd(:,1));
xlabel('t/s'),ylabel('Ω1/rad');hold on
subplot(3,2,2);
plot(T,qd(:,2));
xlabel('t/s'),ylabel('Ω2/rad');hold on
subplot(3,2,3);
plot(T,qd(:,3));
xlabel('t/s'),ylabel('Ω3/rad');hold on
subplot(3,2,4);
plot(T,qd(:,4));
xlabel('t/s'),ylabel('Ω4/rad');hold on
subplot(3,2,5);
plot(T,qd(:,5));
xlabel('t/s'),ylabel('Ω5/rad');hold on
subplot(3,2,6);
plot(T,qd(:,6));
xlabel('t/s'),ylabel('Ω6/rad');hold on
% 指定文件夹保存图片
filepath=pwd;           %保存当前工作目录
cd('C:\Users\Administrator\Desktop\pic')                
%把当前工作目录切换到图片存储文件夹
print(gcf,'-djpeg','C:\Users\Administrator\Desktop\pic\3.jpeg'); %将图片保存为jpg格式，
cd(filepath)            %切回原工作目录

%单个关节的加速度
figure(4);
subplot(3,2,1);
plot(T,qdd(:,1));
xlabel('t/s'),ylabel('α1/rad');hold on
subplot(3,2,2);
plot(T,qdd(:,2));
xlabel('t/s'),ylabel('α2/rad');hold on
subplot(3,2,3);
plot(T,qdd(:,3));
xlabel('t/s'),ylabel('α3/rad');hold on
subplot(3,2,4);
plot(T,qdd(:,4));
xlabel('t/s'),ylabel('α4/rad');hold on;
subplot(3,2,5);
plot(T,qdd(:,5));
xlabel('t/s'),ylabel('α5/rad');hold on
subplot(3,2,6);
plot(T,qdd(:,6));
xlabel('t/s'),ylabel('α6/rad');hold on
% 指定文件夹保存图片
filepath=pwd;           %保存当前工作目录
cd('C:\Users\Administrator\Desktop\pic')                %把当前工作目录切换到图片存储文件夹
print(gcf,'-djpeg','C:\Users\Administrator\Desktop\pic\4.jpeg'); %将图片保存为jpg格式，
cd(filepath)            %切回原工作目录
