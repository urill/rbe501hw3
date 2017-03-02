%% 1
% TODO: add frames picz

theta = sym('theta', [3 1]);
syms a b c d e f g;

% ans
% columns: theta d a alpha
dh = [0, d + b, -c, -pi/2; % FR->F0
    theta(1) - pi/2, 0, e, 0; % F1
    theta(2), 0, f, 0; % F2
    theta(3), 0, g, 0; % F3
    -pi/2, 0, 0, -pi/2] % FT

%% 2

T = sym(zeros(4,4,size(dh, 1)));
for joint=1:size(dh, 1)
    T(:,:,joint) = dh2mat(dh(joint,1),dh(joint,2),dh(joint,3),dh(joint,4));
end

% ans
T_R_T = T(:,:,1)*T(:,:,2)*T(:,:,3)*T(:,:,4)*T(:,:,5)

%% 3
x_t = T_R_T * [0;0;0;1];
x_t = x_t(1:3,:);
J_upper = jacobian(x_t, theta);
J_lower = [0,0,0;
           1,1,1; % thetas contribute to rotation in y
           0,0,0];
% ans
J = vertcat(J_upper, J_lower)
% ans
J_reduced_dof = J([1 3 5], :)

%% 4a
T_R_T_numeric = subs(T_R_T, [b, c, d, e, f, g], ...
                [361, 250, 380, 328, 323, 82.4]);
T_R_T_numeric = subs(T_R_T_numeric, theta, [pi/3; pi/2; pi/3]);

% ans
double(T_R_T_numeric)

%% 4b

J_numeric = subs(J, [b, c, d, e, f, g], ...
                [361, 250, 380, 328, 323, 82.4]); % mm
J_numeric = subs(J_numeric, theta, [pi/3; pi/2; pi/3]); % rad

q_dot_numeric = [pi/4; pi/4; pi/4]; % rad/s
x_dot_numeric = J_numeric * q_dot_numeric; % mm, rad/s

x_dot_numeric_deg = double(x_dot_numeric);
x_dot_numeric_deg(4:6,:) = rad2deg(x_dot_numeric_deg(4:6,:));

% ans
x_dot_numeric_deg % mm, deg/s

%% 4c
F_numeric = [50; 0; 0; 0; 0; 0]; % N, N*mm
joint_torque = J_numeric'*F_numeric;

%ans
double(joint_torque) % N*mm

% TODO: does not look right

%% 













    