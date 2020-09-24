%function att_diff_angle = thrust_heading_rotation_angles(tar_q1,tar_q2,tqr_q3,tar_q4,act_q1,act_q2,act_q3,act_q4)
function att_diff_angle = thrust_heading_rotation_angles(tar_q,act_q)
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
%根据四元数得到旋转矩阵
%目标四元数转化成旋转矩阵（3×3向量）
body_to_ine_rotation_matrix_tar = quat_to_matrix(tar_q);
%倾转分离，分离出z轴
des_att_thrust_vec = body_to_ine_rotation_matrix_tar * [0,0,1]';

%实际四元数转化成旋转矩阵
body_to_ine_rotation_matrix_act = quat_to_matrix(act_q);
cur_att_thrust_vec = body_to_ine_rotation_matrix_act * [0,0,1]';

%% 倾转分离matlab代码移植

%误差旋转 都可以任务是 机体系的 因为是个误差 直接在当前姿态上加上这个误差即可
all_correction_quat = Q_multipli( Q_INV(act_q),tar_q);
%N系下 两个向量的旋转误差
thrust_vec_cross=cross(cur_att_thrust_vec,des_att_thrust_vec);
%z轴误差角度 弧度
thrust_vec_dot=acos(dot(cur_att_thrust_vec,des_att_thrust_vec));
thrust_vector_length=norm(thrust_vec_cross);
if( (thrust_vector_length==0) || (thrust_vec_dot==0))
    thrust_vec_cross = [0,0,1];
    thrust_vec_dot = 0.0;
else
    thrust_vec_cross = thrust_vec_cross/thrust_vector_length;
end

%轴角 转 四元数 描述的是 目标转到初始的旋转 所以对应的旋转是 tb1->cb 转轴在N系
thrust_vec_correction_quat=axis_angle2Q(thrust_vec_cross,thrust_vec_dot);
thrust_vec_correction_quat=Q_normalize(thrust_vec_correction_quat);

%%初始姿态 加上倾斜误差 之后的姿态 结果是 z轴对齐了 tb1->cb 转轴在cb系
thrust_vec_correction_quat=Q_multipli(Q_INV(act_q),Q_multipli(thrust_vec_correction_quat,act_q));
yaw_vec_correction_quat = Q_multipli(Q_INV(thrust_vec_correction_quat),Q_multipli(Q_INV(act_q),tar_q));

all_axis_angle     = to_axis_angle(all_correction_quat);
tilt_axis_angle    = to_axis_angle(thrust_vec_correction_quat);
torsion_axis_angle = to_axis_angle(yaw_vec_correction_quat);
tilt_torsion_angle = [tilt_axis_angle(1),tilt_axis_angle(2),torsion_axis_angle(3)];

att_diff_angle(1) = tilt_axis_angle(1);
att_diff_angle(2) = tilt_axis_angle(2);
att_diff_angle(3) = torsion_axis_angle(3);

%att_diff_angle_z 弧度   (0.46弧度 = 26度)
if(att_diff_angle(3) > 0.46)      
     att_diff_angle(3) = constrain(wrap_PI(att_diff_angle(3)), -0.46, 0.46);
     yaw_vec_correction_quat=from_axis_angle([0,0,att_diff_angle(3)]);
     tar_q = Q_multipli( att_from_quat,Q_multipli(thrust_vec_correction_quat,yaw_vec_correction_quat));
end


% %求期望轴角
% %点乘求轴角的角,这个值在这个函数中没有用到，在外部可能用到
% %thrust_angle = acos(constrain([0,0,1] * att_from_thrust_vec));
% %叉乘求轴角的轴(3×1向量)
% thrust_vec_cross = cross( att_from_thrust_vec,att_to_thrust_vec);
% 
% %点积用于计算目标和期望推力矢量之间的角度
% thrust_vec_dot = acos(constrain(att_from_thrust_vec' * att_to_thrust_vec , -1, 1));
% 
% %规范化推力旋转矢量
% thrust_vector_length = norm(thrust_vec_cross);
% if(thrust_vector_length == 0 || thrust_vec_dot == 0)
%     thrust_vec_cross = [0,0,1]';
%     thrust_vec_dot = 0;
% else
%     thrust_vec_cross = thrust_vec_cross / thrust_vector_length;
% end
% thrust_vec_correction_quat = from_axis_angle(thrust_vec_cross,thrust_vec_dot);
% 
% %Rotate thrust_vec_correction_quat to the att_from frame
% thrust_vec_correction_quat = att_from_thrust_vec' * thrust_vec_correction_quat * att_from_thrust_vec;
% 
% %calculate the remaining rotation required after thrust vector is rotated transformed to the att_from frame
% yaw_vec_correction_quat = thrust_vec_correction_quat' * att_from_thrust_vec' * att_to_thrust_vec;
% 
% %yaw_vec_correction_quat = thrust_vec_correction_quat;

%计算x,y的轴角误差
cor_v_xy = to_axis_angle(thrust_vec_correction_quat);
cor_v_z  = to_axis_angle(yaw_vec_correction_quat);

att_diff_angle(1) = cor_v_xy(1);
att_diff_angle(2) = cor_v_xy(2);
att_diff_angle(3) = cor_v_z(3);
end

function q_mult=Q_multipli(Q1,Q2)
    w1 = Q1(1);
    x1 = Q1(2);
    y1 = Q1(3);
    z1 = Q1(4);

    w2 = Q2(1);
    x2 = Q2(2);
    y2 = Q2(3);
    z2 = Q2(4);

    q1 = w1*w2 - x1*x2 - y1*y2 - z1*z2;
    q2 = w1*x2 + x1*w2 + y1*z2 - z1*y2;
    q3 = w1*y2 - x1*z2 + y1*w2 + z1*x2;
    q4 = w1*z2 + x1*y2 - y1*x2 + z1*w2;
    q_mult=[q1,q2,q3,q4];
end

function q=axis_angle2Q(axis,theta)
    if (theta==0)
        q=[1,0,0,0];
    else
        st2 = sin(theta/2.0);
        q1 = cos(theta/2.0);
        q2 = axis(1) * st2;
        q3 = axis(2) * st2;
        q4 = axis(3) * st2;
        q=[q1,q2,q3,q4];
    end
end

function a=wrap_PI(a)
    res = wrap_2PI(radian);
    if (res > pi) 
        res =res - 2*pi;   
    end
    a = res;
end
function a=wrap_2PI(radian)
    res = mod(radian, 2*pi);
    if (res < 0) 
        res =res + 2*pi;
    end
    a = res;
end
