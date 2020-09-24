function rate_target_ang_vel = attitude_controller_run_quat(tar_q,actual_roll,actual_pitch,actual_yaw)
global q
%UNTITLED3 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%������̬���
%���ʵ����̬�ǵ���Ԫ��
[act_q] = euler_to_quad(actual_roll,actual_pitch,actual_yaw);

%��ת�����㷨,�õ���̬���ʸ��
attitude_error_vector = thrust_heading_rotation_angles(tar_q,act_q);

%����̬����������������
rate_target_ang_vel = update_ang_vel_target_from_att_error(attitude_error_vector);

%�����κ�ǰ��
%ÿ��ִ����ȷ����Ԫ���ǵ�λ����
%[tar_q(1),tar_q(2),tar_q(3),tar_q(4)] = norm(tar_q(1),tar_q(2),tar_q(3),tar_q(4));
quatMag  = sqrt(tar_q(1)*tar_q(1)+tar_q(2)*tar_q(2)+tar_q(3)*tar_q(3)+tar_q(4)*tar_q(4));
if(quatMag ~= 0)
    quatMagInv = 1/quatMag;
    tar_q(1) = tar_q(1) * quatMagInv;
    tar_q(2) = tar_q(2) * quatMagInv;
    tar_q(3) = tar_q(3) * quatMagInv;
    tar_q(4) = tar_q(4) * quatMagInv;
    q(1) = tar_q(1);
    q(2) = tar_q(2);
    q(3) = tar_q(3);
    q(4) = tar_q(4);
end
    
end

