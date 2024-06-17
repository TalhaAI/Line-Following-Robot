% Set parameters
n_curves = 5; % Number of curves in the map
n_points = 100; % Number of points per curve
x_min = -10; % Minimum x-coordinate of the map
x_max = 10; % Maximum x-coordinate of the map
y_min = -10; % Minimum y-coordinate of the map
y_max = 10; % Maximum y-coordinate of the map
z_min = -10; % Minimum z-coordinate of the map
z_max = 10; % Maximum z-coordinate of the map

% Generate random curves
map_curves = zeros(n_curves*n_points, 3); % Initialize array for curve points
for i = 1:n_curves
    % Generate random control points for the current curve
    if i == 1
        % For the first curve, start at a random point
        x1 = rand*(x_max - x_min) + x_min;
        y1 = rand*(y_max - y_min) + y_min;
        z1 = rand*(z_max - z_min) + z_min;
        x2 = x1 + rand*(x_max - x_min)/2;
        y2 = y1 + rand*(y_max - y_min)/2;
        z2 = z1 + rand*(z_max - z_min)/2;
    else
        % For subsequent curves, start at the end of the previous curve
        x1 = map_curves((i-2)*n_points+n_points, 1);
        y1 = map_curves((i-2)*n_points+n_points, 2);
        z1 = map_curves((i-2)*n_points+n_points, 3);
        x2 = x1 + rand*(x_max - x_min)/2;
        y2 = y1 + rand*(y_max - y_min)/2;
        z2 = z1 + rand*(z_max - z_min)/2;
    end
    x3 = x2 + rand*(x_max - x_min)/2;
    y3 = y2 + rand*(y_max - y_min)/2;
    z3 = z2 + rand*(z_max - z_min)/2;
    x4 = x3 + rand*(x_max - x_min)/2;
    y4 = y3 + rand*(y_max - y_min)/2;
    z4 = z3 + rand*(z_max - z_min)/2;
    % Generate points on the current curve using Bezier curve
    t = linspace(0, 1, n_points);
    px = (1-t).^3*x1 + 3*(1-t).^2.*t*x2 + 3*(1-t).*t.^2*x3 + t.^3*x4;
    py = (1-t).^3*y1 + 3*(1-t).^2.*t*y2 + 3*(1-t).*t.^2*y3 + t.^3*y4;
    pz = (1-t).^3*z1 + 3*(1-t).^2.*t*z2 + 3*(1-t).*t.^2*z3 + t.^3*z4;
    % Store points in array
    map_curves((i-1)*n_points+1:i*n_points,:) = [px' py' pz'];
end

% Display map
figure;
plot3(map_curves(:,1), map_curves(:,2), map_curves(:,3), 'b');
xlim([-10 90]);
ylim([-10 90]);

zlim([-10 90]);
title('Random')