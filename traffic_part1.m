% Part 1: Simulate Traffic Flow
clear all;
clc;

% Part 1a: Simulate 24 hours of traffic using a for loop
hours = 24;
lanes = 6;
directions = 4;
traffic_data = zeros(lanes, directions, hours);
peak_hours = [8, 9, 10, 17, 18, 19];

for hour = 1:hours
    if ismember(hour, peak_hours)
        vehicles = randi([50, 100], lanes, directions);
    else
        vehicles = randi([10, 50], lanes, directions);
    end
    traffic_data(:, :, hour) = vehicles;
    disp(['Hour ', num2str(hour), ': Vehicle counts recorded']);
end
disp('Traffic simulation for 24 hours completed.');

% Part 1b: Control signal phases using a while loop
phase_timings = zeros(hours, 3);
for hour = 1:hours
    total_vehicles = sum(sum(traffic_data(:, :, hour)));
    if total_vehicles > 50
        green_duration = 60;
    elseif total_vehicles < 10
        green_duration = 20;
    else
        green_duration = 40;
    end
    red_duration = 60;
    yellow_duration = 10;
    cycle_time = red_duration + green_duration + yellow_duration;
    time_elapsed = 0;
    while time_elapsed < cycle_time
        if time_elapsed < red_duration
            disp(['Hour ', num2str(hour), ': Red phase, time = ', num2str(time_elapsed)]);
        elseif time_elapsed < (red_duration + green_duration)
            disp(['Hour ', num2str(hour), ': Green phase, time = ', num2str(time_elapsed)]);
        else
            disp(['Hour ', num2str(hour), ': Yellow phase, time = ', num2str(time_elapsed)]);
        end
        time_elapsed = time_elapsed + 10;
    end
    phase_timings(hour, :) = [red_duration, green_duration, yellow_duration];
end
disp('Signal phase simulation for 24 hours completed.');
