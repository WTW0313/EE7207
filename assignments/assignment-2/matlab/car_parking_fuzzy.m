function [] = car_parking_fuzzy(theta_i, y_i, x_i, t_end, figure_No)
    % Read fis file
    fis = readfis('fuzzy_logic');

    % Constants
    L = 2.5;
    T = 0.1;
    v = 0.5;

    % Initial values
    t = 0;
    tsim = 1;

    theta = theta_i;
    y = y_i;
    x = x_i;
    u = deg2rad(evalfis(fis,[y, theta]));

    % Plot Data
    x_plot(tsim) = x;
    y_plot(tsim) = y;
    theta_plot(tsim) = theta;
    u_plot(tsim) = rad2deg(u);

    theta = deg2rad(theta);

    while t < t_end
        x = x + v * T * cos(theta);
        y = y + v * T * sin(theta);
        theta = theta + v * T * tan(u) / L;
        u = deg2rad(evalfis(fis,[y, rad2deg(theta)]));
        t = t + T;
        tsim = tsim + 1;

        % Update plot Data
        x_plot(tsim) = x;
        y_plot(tsim) = y;
        theta_plot(tsim) = rad2deg(theta);
        u_plot(tsim) = rad2deg(u);
    end

    figure(figure_No);
    t_plot = 0 : T : t + T;
    subplot(4, 1, 1);
    plot(t_plot, x_plot, 'b', 'LineWidth', 2);
    [main_title, ~] = title('Simulation Results', ['Initial condition:θ=', num2str(theta_i), ', y=', num2str(y_i), ', x=', num2str(x_i)]);
    main_title.FontSize = 16;
    xlabel('t (second)', 'FontSize', 12, 'FontWeight', 'bold');
    ylabel('x (m)', 'FontSize', 12, 'FontWeight', 'bold');
    grid on;
    subplot(4, 1, 2);
    plot(t_plot, y_plot, 'r', 'LineWidth',2);
    xlabel('t (second)', 'FontSize', 12, 'FontWeight', 'bold');
    ylabel('y (m)', 'FontSize', 12, 'FontWeight', 'bold');
    grid on;
    subplot(4, 1, 3);
    plot(t_plot, theta_plot, 'g', 'LineWidth',2);
    xlabel('t (second)', 'FontSize', 12, 'FontWeight', 'bold');
    ylabel('θ (degree)', 'FontSize', 12, 'FontWeight', 'bold');
    grid on;
    subplot(4, 1, 4);
    plot(t_plot, u_plot, 'c', 'LineWidth',2);
    xlabel('t (second)', 'FontSize', 12, 'FontWeight', 'bold');
    ylabel('u (degree)', 'FontSize', 12, 'FontWeight', 'bold');
    grid on;
    
    figure(figure_No + 1);
    plot(x_plot, y_plot, 'c', 'LineWidth', 2);
    [main_title, ~] = title('Trajactory of the Truck', ['Initial condition:θ=', num2str(theta_i), ', y=', num2str(y_i), ', x=', num2str(x_i)]);
    main_title.FontSize = 16;
    xlabel('x (m)', 'FontSize', 12, 'FontWeight', 'bold');
    ylabel('y (m)', 'FontSize', 12, 'FontWeight', 'bold');
    grid on;
end
