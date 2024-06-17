
% Initialize the starting point of the path
start = [map(1,1), map(1,2)];

% Initialize the path with the starting point
path = start;

% Iterate over the map and add the next point in the path
for i = 2:size(map,1)
    % Get the coordinates of the current point
    current = [map(i,1), map(i,2)];
    
    % Calculate the distance between the current point and the last point in the path
    distance = norm(current - path(end,:));
    
    % If the distance is greater than a threshold (e.g. 0.1), add the current point to the path
    if distance > 0.1
        path = [path; current];
    end
end

% Create a figure window
fig = figure;

% Set the title of the figure
title('Line Following Robot Path');

% Set the axes limits to the minimum and maximum x and y coordinates of the map
xlim([min(map(:,1)) max(map(:,1))]);
ylim([min(map(:,2)) max(map(:,2))]);

% Create a rectangle object that represents the robot
robotWidth = 1; % Set the width of the robot
robotHeight = 1; % Set the height of the robot
robot = rectangle('Position', [start(1)-robotWidth/2, start(2)-robotHeight/2, robotWidth, robotHeight], ...
                  'FaceColor', 'yellow');

% Create an animated line object that represents the path robot has covered
coveredPathLine = animatedline('Color', 'b', 'LineWidth', 2, 'DisplayName', 'Covered Path');

% Create an animated line object that represents the remaining path
remainingPathLine = animatedline('Color', 'r', 'LineWidth', 2, 'DisplayName', 'Remaining Path');

% Add a legend to the figure
legend('Location', 'northwest');

% Add the first point to the covered path line
addpoints(coveredPathLine, path(1,1), path(1,2));

% Add all the points except the first point to the remaining path line
addpoints(remainingPathLine, path(2:end,1), path(2:end,2));

% Iterate over the remaining path and move the robot
for i = 2:size(path,1)
    
    % Update the position of the robot
    set(robot, 'Position', [path(i,1)-robotWidth/2, path(i,2)-robotHeight/2, robotWidth, robotHeight]);
    
    drawnow;
    
    % Add the current point to the covered path line and remove it from the remaining path line
    addpoints(coveredPathLine, path(i,1), path(i,2));
    clearpoints(remainingPathLine);
    addpoints(remainingPathLine, path(i+1:end,1), path(i+1:end,2));
    
    % Set the title of the remaining path line
    title(sprintf('Remaining Path: %d points', size(path(i+1:end,:),1)));
    xlabel('Line Following Robot');
    % Pause for 0.1 seconds
    pause(0.1);
end
