%example2.10
clc
clear
close('all')
%轨迹定义条件
%时间、位置和速度（a）
t_array=[0,2,4,8,10];
q_array=[10,20,0,30,40];
v_array=[0,-10,10,3,0];
%起点和终点加速度假设为0，中间点加速度都初始化为0，
acc_array=[0,0,0,0,0];
%计算轨迹
%初始位置
t=t_array(1);
q=q_array(1);
v=v_array(1);
v_array2=v_array;
acc=acc_array(1);

for k=1:length(t_array)-1
    %按照式（1-23）式确定中间点的速度值
    if(k>1)
        dk1=(q_array(k)-q_array(k-1))/(t_array(k)-t_array(k-1));
        dk2=(q_array(k+1)-q_array(k))/(t_array(k+1)-t_array(k));
        if((dk2>=0 && dk1>=0) || (dk2<=0 && dk1<=0))
            v_array2(k)=1.0/2.0*(dk1+dk2);
        else
            v_array2(k)=0;
        end  
    end
end

for k=1:length(t_array)-1
    %利用公式（1-25）求系数

    %计算各段多项式的系数
    h(k)=q_array(k+1)-q_array(k);
    T(k)=t_array(k+1)-t_array(k);
    a0(k)=q_array(k);
    a1(k)=v_array2(k);
    a2(k)=1.0/2*acc_array(k);
    a3(k)=1.0/(2*T(k)*T(k)*T(k))*(20*h(k)-(8*v_array2(k+1)+12*v_array2(k))*T(k)+(acc_array(k+1)-3*acc_array(k))/(T(k)*T(k)));
    a4(k)=1.0/(2*T(k)*T(k)*T(k)*T(k))*(-30*h(k)+(14*v_array2(k+1)+16*v_array2(k))*T(k)+(3*acc_array(k)-2*acc_array(k+1))/(T(k)*T(k)));
    a5(k)=1.0/(2*T(k)*T(k)*T(k)*T(k)*T(k))*(12*h(k)-6*(v_array2(k+1)+v_array2(k))*T(k)+(acc_array(k+1)-acc_array(k))/(T(k)*T(k)));
    
    %生成各段轨迹密化的数据点
    %局部时间坐标
    tau=t_array(k):T(k)/100:t_array(k+1);
    %全局时间坐标，由局部时间坐标组成
    t=[t,tau(2:end)];
    %位置
    qk=a0(k)+a1(k)*power(tau-tau(k),1)+a2(k)*power(tau-tau(k),2)+a3(k)*power(tau-tau(k),3)+...
        a4(k)*power(tau-tau(k),4)+a5(k)*power(tau-tau(k),5);
     %全局位置坐标
    q=[q,qk(2:end)];
    %速度
    vk=a1(k)+2*a2(k)*power(tau-tau(k),1)+3*a3(k)*power(tau-tau(k),2)+4*a4(k)*power(tau-tau(k),3)+...
        5*a5(k)*power(tau-tau(k),4);
     v=[v,vk(2:end)];
    %加速度
    acck=2*a2(k)+6*a3(k)*power(tau-tau(k),1)+12*a4(k)*power(tau-tau(k),2)+20*a5(k)*power(tau-tau(k),3);
    acc=[acc,acck(2:end)];

end
%绘图
subplot(3,1,1)
plot(t,q,'r');
hold on
plot(t_array,q_array,'o');
 axis([0,10,-5,45])
ylabel('position')
grid on
subplot(3,1,2)
plot(t,v,'b');
hold on
plot(t_array,v_array2,'o');
axis([0,10,-20,15])
ylabel('velocity')
grid on
subplot(3,1,3)
plot(t,acc,'g');
axis([0,10,-35,35])
ylabel('acceleration')
grid on
