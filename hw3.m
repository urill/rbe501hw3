%% 1
% TODO: add frames picz

theta = sym('theta', [3 1]);
syms a b c d e f g;

dh = [0, d + b, -c, -pi/2; % FR->F0
    theta(1) - pi/2, 0, e, 0; % F1
    theta(2), 0, f, 0; % F2
    theta(3), 0, g, 0; % F3
    -pi/2, 0, 0, pi/2] % FT

%% 2

T = sym(zeros(4,4,5));
for joint=1:5
    T(:,:,joint) = dh2mat(dh(joint,1),dh(joint,2),dh(joint,3),dh(joint,4));
end

% ans
T_R_T = T(:,:,1)*T(:,:,2)*T(:,:,3)*T(:,:,4)*T(:,:,5)

%verify
subs(T_R_T, theta, [0;0;0])* [0;0;1;1]




    