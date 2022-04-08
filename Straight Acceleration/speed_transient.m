function [time,  v, braking_distance] = speed_transient(straight_parameters, cornering_parameters,track_length,track_radius, optim_number, entry_vel)

threshold = 0.01;
braking_a = -1.5 * 9.81; %max braking deceleration [m/s^2]

if (track_length> 40)
    d = linspace(track_length/3, track_length,optim_number);
else
    d = linspace(0.5, track_length,optim_number);
end

allowed_v = cornerFunc(cornering_parameters,track_radius,10); %Slip Angle 10
%fprintf("Allowed Cornering Velocity %3f\n",allowed_v);

%Optimization loop to calculate best brake balance
for i = 1:optim_number %always sweep from braking entire distance
    %fprintf("Optimizing brake/accel balance, Iteration %d\n",i);
    
    braking_distance = track_length - d(i);
    
    [accel_time, accel_v] = acceleration(entry_vel, d(i),straight_parameters);
    [brake_time, exit_v] = brake_calculator(braking_a,braking_distance, accel_v(end));
    %fprintf("End Velocity %3f\n",final_v);
    if (i ~=optim_number)
        if (abs(allowed_v(end) - exit_v(end))<threshold || (exit_v(end) > allowed_v(end)))
            break %end optimization
        end
    end
end

v = [accel_v; exit_v'];
brake_time = brake_time + accel_time(end);

%fprintf("End Velocity %3f\n",final_v);
time = [accel_time,  brake_time];