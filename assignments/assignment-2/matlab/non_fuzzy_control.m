clc;
clear;

% Constants
L = 2.5;
T = 0.1;
v = 0.5;

syms z;

A1 = 1;
B1 = v * T / L;
C1 = 1;
D1 = 0;

% Theta
n1 = size(A1, 1);
model1 = C1 * (z * eye(n1, n1) - A1)^(-1) * B1 + D1;
[b1, a1] = ss2tf(A1, B1, C1, D1);

A2 = 1;
B2 = v * T;
C2 = 1;
D2 = 0;

% x, y
n2 = size(A2, 1);
model2 = C2 * (z * eye(n2, n2) - A2)^(-1) * B2 + D2;
[b2, a2] = ss2tf(A2, B2, C2, D2);

% Simulation
theta_i = -10;
y_i = 10;
x_i = 50;

simulation_data = sim('car_parking');

t = simulation_data.simout.time;
y = getcolumn(simulation_data.simout.Data, 1);
theta = getcolumn(simulation_data.simout.Data, 2);
x = getcolumn(simulation_data.simout.Data, 3);
u = getcolumn(simulation_data.simout.Data, 4);

figure(1);
subplot(4, 1, 1);
plot(t, x, 'b', 'LineWidth', 2);
[main_title, ~] = title('Simulation Results', ['Initial condition:θ=', num2str(theta_i), ', y=', num2str(y_i), ', x=', num2str(x_i)]);
main_title.FontSize = 16;
xlabel('t (second)', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('x (m)', 'FontSize', 12, 'FontWeight', 'bold');
grid on;
subplot(4, 1, 2);
plot(t, y, 'r', 'LineWidth',2);
xlabel('t (second)', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('y (m)', 'FontSize', 12, 'FontWeight', 'bold');
grid on;
subplot(4, 1, 3);
plot(t, theta, 'g', 'LineWidth',2);
xlabel('t (second)', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('θ (degree)', 'FontSize', 12, 'FontWeight', 'bold');
grid on;
subplot(4, 1, 4);
plot(t, u, 'c', 'LineWidth',2);
xlabel('t (second)', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('u (degree)', 'FontSize', 12, 'FontWeight', 'bold');
grid on;

figure(2);
plot(x, y, 'c', 'LineWidth', 2);
[main_title, ~] = title('Trajactory of the Truck', ['Initial condition:θ=', num2str(theta_i), ', y=', num2str(y_i), ', x=', num2str(x_i)]);
main_title.FontSize = 16;
xlabel('x (m)', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('y (m)', 'FontSize', 12, 'FontWeight', 'bold');
grid on;


