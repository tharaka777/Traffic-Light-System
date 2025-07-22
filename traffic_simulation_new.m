% Smart Traffic Light Controller: Part 1 and Part 2
% Part 1: Simulate Traffic Flow (24 hours with for loop, signal phases with while loop)
% Part 2: Process Traffic Data (6x4 matrix, compute peak hours)
% Modified to make Hours 6, 7, 8, 9, 16, 17, 18 peak traffic hours

% Clear workspace and command window
clear all;
clc;

% --- Part 1: Simulate Traffic Flow ---
disp('Part 1: Simulating 24-Hour Traffic Flow');

% Initialize variables
hours = 24;
vehicle_counts = zeros(hours, 6, 4); % Store counts for 6 lanes, 4 directions
cycle_duration = 120; % Total cycle time in seconds
peak_hours = [6, 7, 8, 9, 16, 17, 18]; % Define peak hours

% Simulate 24 hours
for hour = 1:hours
    % Simulate vehicle counts (higher during peak hours)
    if ismember(hour, peak_hours)
        vehicles = randi([50, 100], 6, 4); % Higher counts (50-100) for peak hours
    else
        vehicles = randi([0, 50], 6, 4); % Lower counts (0-50) for non-peak hours
    end
    vehicle_counts(hour, :, :) = vehicles;
    disp(['Hour ', num2str(hour), ': Vehicle counts recorded']);
end
disp('Traffic simulation for 24 hours completed.');

% Simulate signal phases for Hour 1 (example)
hour = 1;
vehicles = squeeze(vehicle_counts(hour, :, :));
avg_vehicles = mean(mean(vehicles)); % Average vehicle count
green_duration = max(10, min(60, avg_vehicles * 0.5)); % Dynamic Green: 10-60s
yellow_duration = 5; % Fixed Yellow
red_duration = cycle_duration - green_duration - yellow_duration; % Red

current_time = 0;
phase = 'Red';
while current_time < cycle_duration
    if strcmp(phase, 'Red')
        disp(['Hour 1: Red phase, time = ', num2str(current_time)]);
        if current_time >= red_duration
            phase = 'Green';
            current_time = red_duration;
        end
    elseif strcmp(phase, 'Green')
        disp(['Hour 1: Green phase, time = ', num2str(current_time)]);
        if current_time >= red_duration + green_duration
            phase = 'Yellow';
            current_time = red_duration + green_duration;
        end
    elseif strcmp(phase, 'Yellow')
        disp(['Hour 1: Yellow phase, time = ', num2str(current_time)]);
        if current_time >= cycle_duration
            disp('Hour 1: Signal cycle complete');
            break;
        end
    end
    current_time = current_time + 10; % Increment by 10s for readability
end

% --- Part 2: Process Traffic Data ---
disp('Part 2: Processing Traffic Data');

% Initialize 6x4 matrix for one hour (example)
traffic_matrix = squeeze(vehicle_counts(1, :, :)); % Hour 1 matrix

% Compute total vehicles per direction per hour
total_vehicles_per_direction = zeros(hours, 4);
for hour = 1:hours
    traffic_matrix_hour = squeeze(vehicle_counts(hour, :, :));
    total_vehicles_per_direction(hour, :) = sum(traffic_matrix_hour);
end

% Find peak traffic hour
total_vehicles_all = sum(total_vehicles_per_direction, 2);
[max_vehicles, peak_hour] = max(total_vehicles_all);

% Display results
disp('Traffic Matrix for Hour 1:');
disp(traffic_matrix);
disp('Total Vehicles per Direction for All Hours:');
disp(total_vehicles_per_direction);
disp(['Peak Traffic Hour: Hour ', num2str(peak_hour), ' with ', num2str(max_vehicles), ' vehicles']);
disp('Simulation and data processing complete.');
