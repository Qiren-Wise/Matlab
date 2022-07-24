clear;
clc;
q_array=[0,50,150,100,40];%ָ����ֹλ��
t_array=[0,3,6,12,14];%ָ����ֹʱ��
v_array=[0,10,20,-15,0];%ָ����ֹ�ٶ�
a_array=[0,20,30,-20,0];%ָ����ֹ���ٶ�
t=[t_array(1)];q=[q_array(1)];v=[v_array(1)];a=[a_array(1)];%��ʼ״̬
for i=1:1:length(q_array)-1;%ÿһ�ι滮��ʱ��
     T=t_array(i+1)-t_array(i)
     a0=q_array(i);
     a1=v_array(i);
     a2=a_array(i)/2;
     a3=(20*q_array(i+1)-20*q_array(i)-(8*v_array(i+1)+12*v_array(i))*T-(3*a_array(i)-a_array(i+1))*T^2)/(2*T^3);
     a4=(30*q_array(i)-30*q_array(i+1)+(14*v_array(i+1)+16*v_array(i))*T+(3*a_array(i)-2*a_array(i+1))*T^2)/(2*T^4);
     a5=(12*q_array(i+1)-12*q_array(i)-(6*v_array(i+1)+6*v_array(i))*T-(a_array(i)-a_array(i+1))*T^2)/(2*T^5);%������ζ���ʽϵ�� 
     ti=t_array(i):0.001:t_array(i+1);
     qi=a0+a1*(ti-t_array(i))+a2*(ti-t_array(i)).^2+a3*(ti-t_array(i)).^3+a4*(ti-t_array(i)).^4+a5*(ti-t_array(i)).^5;
     vi=a1+2*a2*(ti-t_array(i))+3*a3*(ti-t_array(i)).^2+4*a4*(ti-t_array(i)).^3+5*a5*(ti-t_array(i)).^4;
     ai=2*a2+6*a3*(ti-t_array(i))+12*a4*(ti-t_array(i)).^2+20*a5*(ti-t_array(i)).^3;
     t=[t,ti(2:end)];q=[q,qi(2:end)];v=[v,vi(2:end)];a=[a,ai(2:end)];
end
subplot(3,1,1),plot(t,q,'r'),xlabel('t'),ylabel('position');hold on;plot(t_array,q_array,'o','color','g'),grid on;
subplot(3,1,2),plot(t,v,'b'),xlabel('t'),ylabel('velocity');hold on;plot(t_array,v_array,'*','color','y'),grid on;
subplot(3,1,3),plot(t,a,'g'),xlabel('t'),ylabel('accelerate');hold on;plot(t_array,a_array,'^','color','r'),grid on;