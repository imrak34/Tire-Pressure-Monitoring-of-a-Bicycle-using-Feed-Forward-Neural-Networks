close all
clear all
clc

% Get the current working directory path
currentDir = pwd;

% Display the current working directory
disp("Current Directory:")
disp(currentDir);

% Normal Bike Data

%Specify the file names
file_names = {'p15','p30','p45'};

for i = 1:numel(file_names)
 file_name = ['_Tu_' file_names{i} '_pp'];   

 % Define the regex pattern to match the desired value
 pattern = 'p(\d+)';
 
 % Find the matching pattern in the file name
 match = regexp(file_name, pattern, 'tokens');  % tokens used to capture the numeric value

 % Extract the numeric value from the matched pattern
 numeric_value = str2double(match{1}{1}) / 10; 

 % Display the Pressure
 disp(['The pressure considered is ', num2str(numeric_value), ' bar']);

 % Specify the groups and pressures
 groups = {'G1', 'G2', 'G3', 'G4', 'G5', 'G6'};
 
 % Initialize cell arrays to store the required data

 Acc_Y_Z_data = cell(1,numel(groups));
 Time_data = cell(1,numel(groups));
 Acc_Y_Z_data_filtered = cell(1,numel(groups));
 Time_data_filtered = cell(1,numel(groups));
 Acc_Y_Z_data_filtered_fft = cell(1,numel(groups));

 %Acc_Y_Z_data_summarized = cell
 % Loop over the groups
 for groupIndex = 1:numel(groups)
    group = groups{groupIndex};
    
    % Specify the relative path to the Excel files for the current group
    relativePath = fullfile('Project Measurement Data', group, [group,file_name]);

    % Construct the full file path
    File = fullfile(currentDir, relativePath);

    % Read the data from the Excel file
    [data, headers] = xlsread(File);

    % Access the third & fourth columns of the data (acceleration in the y & z direction)
    Acc_Y_Z = data(:, [3,4]);
    
    % Access the time column
    Time = data(:, 1);

    %Extract acceleration values between 5 and 16 seconds
    timePeriodStart = 5; % Start time of the desired period
    timePeriodEnd = 16; % End time of the desired period

    % Perform logical indexing to extract acceleration values within the time period
    accelerationY_Z_filtered = Acc_Y_Z(Time >= timePeriodStart & Time <= timePeriodEnd,[1,2]);
    time_period = Time(Time >= timePeriodStart & Time <= timePeriodEnd,1);

    % Store the Acc_Y , Acc_Z data and time data in the cell arrays
    Time_data{groupIndex} = Time;
    Acc_Y_Z_data{groupIndex} = Acc_Y_Z;
    Acc_Y_Z_data_filtered{groupIndex} = accelerationY_Z_filtered;
    Time_data_filtered{groupIndex} = time_period;
    Acc_Y_Z_data_filtered_fft{groupIndex} = fft(Acc_Y_Z);

 end

 switch numeric_value
    case 1.5
        Acc_Y_Z_data_15= Acc_Y_Z_data;    % Store the Acc_Y_Z_data and Time_data for pressure_value = 1.5 bar
        Time_data_15 = Time_data;
        Acc_Y_Z_data_filtered_15 = Acc_Y_Z_data_filtered;
        Time_data_filtered_15 = Time_data_filtered;
        Acc_Y_Z_data_filtered_fft_15 = Acc_Y_Z_data_filtered_fft;

    case 3.0
        Acc_Y_Z_data_30 = Acc_Y_Z_data;   % Store the Acc_Y_Z_data and Time_data for pressure_value = 3.0 bar
        Time_data_30 = Time_data;
        Acc_Y_Z_data_filtered_30 = Acc_Y_Z_data_filtered;
        Time_data_filtered_30 = Time_data_filtered;
        Acc_Y_Z_data_filtered_fft_30 = Acc_Y_Z_data_filtered_fft;

    case 4.5
        Acc_Y_Z_data_45= Acc_Y_Z_data;    % Store the Acc_Y_Z_data and Time_data for pressure_value = 4.5 bar
        Time_data_45 = Time_data;
        Acc_Y_Z_data_filtered_45 = Acc_Y_Z_data_filtered;
        Time_data_filtered_45 = Time_data_filtered;
        Acc_Y_Z_data_filtered_fft_45 = Acc_Y_Z_data_filtered_fft;
 end
end

% Fat Bike Data
% Specify the file names
fatbike_file_names = {'p06','p10','p14'};

for i = 1:numel(fatbike_file_names)
 fatbike_file_name = ['_Fa_' fatbike_file_names{i} '_pp'];   

 % Define the regex pattern to match the desired value
 pattern = 'p(\d+)';
 
 % Find the matching pattern in the file name
 match = regexp(fatbike_file_name, pattern, 'tokens');  % tokens used to capture the numeric value

 % Extract the numeric value from the matched pattern
 numeric_value = str2double(match{1}{1}) / 10; 

 % Display the Pressure
 disp(['The pressure considered is ', num2str(numeric_value), ' bar']);

 % Specify the groups and pressures
 groups = {'G1', 'G2', 'G3', 'G4', 'G5', 'G6'};
 
 % Initialize cell arrays to store the required data

 fatbike_Acc_Y_Z_data = cell(1,numel(groups));
 fatbike_Time_data = cell(1,numel(groups));
 fatbike_Acc_Y_Z_data_filtered = cell(1,numel(groups));
 fatbike_Time_data_filtered = cell(1,numel(groups));
 fatbike_Acc_Y_Z_data_filtered_fft = cell(1,numel(groups));

 %Acc_Y_Z_data_summarized = cell
 % Loop over the groups
 for groupIndex = 1:numel(groups)
    group = groups{groupIndex};
    
    % Specify the relative path to the Excel files for the current group
    fatbike_relativePath = fullfile('Project Measurement Data', group, [group,fatbike_file_name]);

    % Construct the full file path
    fatbike_File = fullfile(currentDir, fatbike_relativePath);

    % Read the data from the Excel file
    [fatbike_data, fat_bike_headers] = xlsread(fatbike_File);

    % Access the third & fourth columns of the data (acceleration in the y & z direction)
    fatbike_Acc_Y_Z = fatbike_data(:, [3,4]);
    
    % Access the time column
    fatbike_Time = fatbike_data(:, 1);

    %Extract acceleration values between 2 and 15 seconds
    fatbike_timePeriodStart = 2; % Start time of the desired period
    fatbike_timePeriodEnd = 15; % End time of the desired period

    % Perform logical indexing to extract acceleration values within the time period
    fatbike_accelerationY_Z_filtered = fatbike_Acc_Y_Z(fatbike_Time >= fatbike_timePeriodStart & fatbike_Time <= fatbike_timePeriodEnd,[1,2]);
    fatbike_time_period = fatbike_Time(fatbike_Time >= fatbike_timePeriodStart & fatbike_Time <= fatbike_timePeriodEnd,1);

    % Store the Acc_Y , Acc_Z data and time data in the cell arrays
    fatbike_Time_data{groupIndex} = fatbike_Time;
    fatbike_Acc_Y_Z_data{groupIndex} = fatbike_Acc_Y_Z;
    fatbike_Acc_Y_Z_data_filtered{groupIndex} = fatbike_accelerationY_Z_filtered;
    fatbike_Time_data_filtered{groupIndex} = fatbike_time_period;
    fatbike_Acc_Y_Z_data_filtered_fft{groupIndex} = fft(fatbike_Acc_Y_Z);

 end

 switch numeric_value
    case 0.6
        fatbike_Acc_Y_Z_data_06 = fatbike_Acc_Y_Z_data;    % Store the Acc_Y_Z_data and Time_data for pressure_value = 0.6 bar
        fatbike_Time_data_06 = fatbike_Time_data;
        fatbike_Acc_Y_Z_data_filtered_06 = fatbike_Acc_Y_Z_data_filtered;
        fatbike_Time_data_filtered_06 = fatbike_Time_data_filtered;
        fatbike_Acc_Y_Z_data_filtered_fft_06 = fatbike_Acc_Y_Z_data_filtered_fft;

    case 1.0
        fatbike_Acc_Y_Z_data_10 = fatbike_Acc_Y_Z_data;   % Store the Acc_Y_Z_data and Time_data for pressure_value = 1.0 bar
        fatbike_Time_data_10 = fatbike_Time_data;
        fatbike_Acc_Y_Z_data_filtered_10 = fatbike_Acc_Y_Z_data_filtered;
        fatbike_Time_data_filtered_10 = fatbike_Time_data_filtered;
        fatbike_Acc_Y_Z_data_filtered_fft_10 = fatbike_Acc_Y_Z_data_filtered_fft;

    case 1.4
        fatbike_Acc_Y_Z_data_14 = fatbike_Acc_Y_Z_data;    % Store the Acc_Y_Z_data and Time_data for pressure_value = 1.4 bar
        fatbike_Time_data_14 = fatbike_Time_data;
        fatbike_Acc_Y_Z_data_filtered_14 = fatbike_Acc_Y_Z_data_filtered;
        fatbike_Time_data_filtered_14 = fatbike_Time_data_filtered;
        fatbike_Acc_Y_Z_data_filtered_fft_14 = fatbike_Acc_Y_Z_data_filtered_fft;
 end
end

% Create the Acc_Y_Z_data_summarized by concatenating the stored data
Acc_Y_Z_data_summarized = [Acc_Y_Z_data_15;Acc_Y_Z_data_30;Acc_Y_Z_data_45;fatbike_Acc_Y_Z_data_06;fatbike_Acc_Y_Z_data_10;fatbike_Acc_Y_Z_data_14];
Time_data_summarized = [Time_data_15;Time_data_30;Time_data_45;fatbike_Time_data_06;fatbike_Time_data_10;fatbike_Time_data_14];
Acc_Y_Z_data_filtered_summarized = [Acc_Y_Z_data_filtered_15;Acc_Y_Z_data_filtered_30;Acc_Y_Z_data_filtered_45;fatbike_Acc_Y_Z_data_filtered_06;fatbike_Acc_Y_Z_data_filtered_10;fatbike_Acc_Y_Z_data_filtered_14];
Time_data_filtered_summarized = [Time_data_filtered_15;Time_data_filtered_30;Time_data_filtered_45;fatbike_Time_data_filtered_06;fatbike_Time_data_filtered_10;fatbike_Time_data_filtered_14];
Acc_Y_Z_data_filtered_summarized_fft = [Acc_Y_Z_data_filtered_fft_15;Acc_Y_Z_data_filtered_fft_30;Acc_Y_Z_data_filtered_fft_45;fatbike_Acc_Y_Z_data_filtered_fft_06;fatbike_Acc_Y_Z_data_filtered_fft_10;fatbike_Acc_Y_Z_data_filtered_fft_14];

% Plot the results of Filtered Acceleration Signal for Normal Bike
%For a pressure of 1.5 bar
%{
figure(1)
tiledlayout(2, 3)

for groupIndex = 1:numel(groups)
    group = groups{groupIndex};    
    nexttile
    plot(Time_data_summarized{1,groupIndex},Acc_Y_Z_data_summarized{1,groupIndex}(:,1))
    xlabel('Time')
    ylabel('Acceleration in Y direction')
    title(group)
end

figure(2)
tiledlayout(2, 3)
    
for groupIndex = 1:numel(groups)
    group = groups{groupIndex};    
    nexttile
    plot(Time_data_summarized{1,groupIndex},Acc_Y_Z_data_summarized{1,groupIndex}(:,2))
    xlabel('Time')
    ylabel('Acceleration in Z direction')
    title(group)

end

%For a pressure of 3.0 bar
figure(3)
tiledlayout(2, 3)

for groupIndex = 1:numel(groups)
    group = groups{groupIndex};    
    nexttile
    plot(Time_data_summarized{2,groupIndex},Acc_Y_Z_data_summarized{2,groupIndex}(:,1))
    xlabel('Time')
    ylabel('Acceleration in Y direction')
    title(group)
end

figure(4)
tiledlayout(2, 3)
    
for groupIndex = 1:numel(groups)
    group = groups{groupIndex};    
    nexttile
    plot(Time_data_summarized{2,groupIndex},Acc_Y_Z_data_summarized{2,groupIndex}(:,2))
    xlabel('Time')
    ylabel('Acceleration in Z direction')
    title(group)

end

%For a pressure of 4.5 bar
figure(5)
tiledlayout(2, 3)

for groupIndex = 1:numel(groups)
    group = groups{groupIndex};
    nexttile
    plot(Time_data_summarized{3,groupIndex},Acc_Y_Z_data_summarized{3,groupIndex}(:,1))
    xlabel('Time')
    ylabel('Acceleration in Y direction')
    title(group)
end

figure(6)
tiledlayout(2, 3)
    
for groupIndex = 1:numel(groups)
    group = groups{groupIndex};    
    nexttile
    plot(Time_data_summarized{3,groupIndex},Acc_Y_Z_data_summarized{3,groupIndex}(:,2))
    xlabel('Time')
    ylabel('Acceleration in Z direction')
    title(group)

end


% Plot the results of Filtered Acceleration Signal
%For a pressure of 1.5 bar
figure(7)
tiledlayout(2, 3)

for groupIndex = 1:numel(groups)
    group = groups{groupIndex};    
    nexttile
    plot(Time_data_filtered_summarized{1,groupIndex},Acc_Y_Z_data_filtered_summarized{1,groupIndex}(:,1))
    xlabel('Time')
    ylabel('Acceleration in Y direction Filtered')
    title(group)
end

figure(8)
tiledlayout(2, 3)
    
for groupIndex = 1:numel(groups)
    group = groups{groupIndex};    
    nexttile
    plot(Time_data_filtered_summarized{1,groupIndex},Acc_Y_Z_data_filtered_summarized{1,groupIndex}(:,2))
    xlabel('Time')
    ylabel('Acceleration in Z direction Filtered')
    title(group)

end

%For a pressure of 3.0 bar
figure(9)
tiledlayout(2, 3)

for groupIndex = 1:numel(groups)
    group = groups{groupIndex};    
    nexttile
    plot(Time_data_filtered_summarized{2,groupIndex},Acc_Y_Z_data_filtered_summarized{2,groupIndex}(:,1))
    xlabel('Time')
    ylabel('Acceleration in Y direction Filtered')
    title(group)
end

figure(10)
tiledlayout(2, 3)
    
for groupIndex = 1:numel(groups)
    group = groups{groupIndex};    
    nexttile
    plot(Time_data_filtered_summarized{2,groupIndex},Acc_Y_Z_data_filtered_summarized{2,groupIndex}(:,2))
    xlabel('Time')
    ylabel('Acceleration in Z direction Filtered')
    title(group)

end

%For a pressure of 4.5 bar
figure(11)
tiledlayout(2, 3)

for groupIndex = 1:numel(groups)
    group = groups{groupIndex};
    nexttile
    plot(Time_data_filtered_summarized{3,groupIndex},Acc_Y_Z_data_filtered_summarized{3,groupIndex}(:,1))
    xlabel('Time')
    ylabel('Acceleration in Y direction Filtered')
    title(group)
end

figure(12)
tiledlayout(2, 3)
    
for groupIndex = 1:numel(groups)
    group = groups{groupIndex};    
    nexttile
    plot(Time_data_filtered_summarized{3,groupIndex},Acc_Y_Z_data_filtered_summarized{3,groupIndex}(:,2))
    xlabel('Time')
    ylabel('Acceleration in Z direction Filtered')
    title(group)

end

% Plot the results of Filtered Acceleration Signal for Normal Bike
%For a pressure of 0.6 bar

figure(13)
tiledlayout(2, 3)

for groupIndex = 1:numel(groups)
    group = groups{groupIndex};    
    nexttile
    plot(Time_data_summarized{4,groupIndex},Acc_Y_Z_data_summarized{4,groupIndex}(:,1))
    xlabel('Time')
    ylabel('Acceleration in Y direction for Fat Bike')
    title(group)
end

figure(14)
tiledlayout(2, 3)
    
for groupIndex = 1:numel(groups)
    group = groups{groupIndex};    
    nexttile
    plot(Time_data_summarized{4,groupIndex},Acc_Y_Z_data_summarized{4,groupIndex}(:,2))
    xlabel('Time')
    ylabel('Acceleration in Z direction for Fat Bike')
    title(group)

end

%For a pressure of 1.0 bar
figure(15)
tiledlayout(2, 3)

for groupIndex = 1:numel(groups)
    group = groups{groupIndex};    
    nexttile
    plot(Time_data_summarized{5,groupIndex},Acc_Y_Z_data_summarized{5,groupIndex}(:,1))
    xlabel('Time')
    ylabel('Acceleration in Y direction for Fat Bike')
    title(group)
end

figure(16)
tiledlayout(2, 3)
    
for groupIndex = 1:numel(groups)
    group = groups{groupIndex};    
    nexttile
    plot(Time_data_summarized{5,groupIndex},Acc_Y_Z_data_summarized{5,groupIndex}(:,2))
    xlabel('Time')
    ylabel('Acceleration in Z direction for Fat Bike')
    title(group)

end

%For a pressure of 1.4 bar
figure(17)
tiledlayout(2, 3)

for groupIndex = 1:numel(groups)
    group = groups{groupIndex};
    nexttile
    plot(Time_data_summarized{6,groupIndex},Acc_Y_Z_data_summarized{6,groupIndex}(:,1))
    xlabel('Time')
    ylabel('Acceleration in Y direction for Fat Bike')
    title(group)
end

figure(18)
tiledlayout(2, 3)
    
for groupIndex = 1:numel(groups)
    group = groups{groupIndex};    
    nexttile
    plot(Time_data_summarized{6,groupIndex},Acc_Y_Z_data_summarized{6,groupIndex}(:,2))
    xlabel('Time')
    ylabel('Acceleration in Z direction for Fat Bike')
    title(group)

end


% Plot the results of Filtered Acceleration Signal
%For a pressure of 0.6 bar
figure(19)
tiledlayout(2, 3)

for groupIndex = 1:numel(groups)
    group = groups{groupIndex};    
    nexttile
    plot(Time_data_filtered_summarized{4,groupIndex},Acc_Y_Z_data_filtered_summarized{4,groupIndex}(:,1))
    xlabel('Time')
    ylabel('Acceleration in Y direction Filtered for Fat Bike')
    title(group)
end

figure(20)
tiledlayout(2, 3)
    
for groupIndex = 1:numel(groups)
    group = groups{groupIndex};    
    nexttile
    plot(Time_data_filtered_summarized{4,groupIndex},Acc_Y_Z_data_filtered_summarized{4,groupIndex}(:,2))
    xlabel('Time')
    ylabel('Acceleration in Z direction Filtered for Fat Bike')
    title(group)

end

%For a pressure of 1.0 bar
figure(21)
tiledlayout(2, 3)

for groupIndex = 1:numel(groups)
    group = groups{groupIndex};    
    nexttile
    plot(Time_data_filtered_summarized{5,groupIndex},Acc_Y_Z_data_filtered_summarized{5,groupIndex}(:,1))
    xlabel('Time')
    ylabel('Acceleration in Y direction Filtered for Fat Bike')
    title(group)
end

figure(22)
tiledlayout(2, 3)
    
for groupIndex = 1:numel(groups)
    group = groups{groupIndex};    
    nexttile
    plot(Time_data_filtered_summarized{5,groupIndex},Acc_Y_Z_data_filtered_summarized{5,groupIndex}(:,2))
    xlabel('Time')
    ylabel('Acceleration in Z direction Filtered for Fat Bike')
    title(group)

end

%For a pressure of 1.4 bar
figure(23)
tiledlayout(2, 3)

for groupIndex = 1:numel(groups)
    group = groups{groupIndex};
    nexttile
    plot(Time_data_filtered_summarized{6,groupIndex},Acc_Y_Z_data_filtered_summarized{6,groupIndex}(:,1))
    xlabel('Time')
    ylabel('Acceleration in Y direction Filtered for Fat Bike')
    title(group)
end

figure(24)
tiledlayout(2, 3)
    
for groupIndex = 1:numel(groups)
    group = groups{groupIndex};    
    nexttile
    plot(Time_data_filtered_summarized{6,groupIndex},Acc_Y_Z_data_filtered_summarized{6,groupIndex}(:,2))
    xlabel('Time')
    ylabel('Acceleration in Z direction Filtered for Fat Bike')
    title(group)

end 
%}
pressures = {15,30,45,06,10,14};
pcaScores_Acc = cell(numel(pressures), numel(groups));

for pressure = 1:numel(pressures)
  for groupIndex = 1:numel(groups)
    group = groups{groupIndex};  
    [coefficient,~,~] = pca(Acc_Y_Z_data_filtered_summarized{pressure,groupIndex},'numcomponents',2);
    pcaScores_Acc{pressure,groupIndex} = coefficient;
  end
end  


coeff_1 = cell(numel(pressures), numel(groups));
coeff_2 = cell(numel(pressures), numel(groups));

for pressure = 1:numel(pressures)
    for groupIndex = 1:numel(groups)
        coeff_1{pressure, groupIndex} = pcaScores_Acc{pressure, groupIndex}(:, 1);
    end
end

for pressure = 1:numel(pressures)
    for groupIndex = 1:numel(groups)
        coeff_2{pressure, groupIndex} = pcaScores_Acc{pressure, groupIndex}(:, 2);
    end
end

pc1 = cell(numel(pressures), numel(groups));
pc2 = cell(numel(pressures), numel(groups));

for pressure = 1:numel(pressures)
    for groupIndex = 1:numel(groups)
        pc1{pressure, groupIndex} = Acc_Y_Z_data_filtered_summarized{pressure, groupIndex} * coeff_1{pressure, groupIndex};
        pc2{pressure, groupIndex} = Acc_Y_Z_data_filtered_summarized{pressure, groupIndex} * coeff_2{pressure, groupIndex};
    end
end

figure;
for pressure = 1:numel(pressures)
    subplot(1, numel(pressures), pressure);
    hold on;
    for groupIndex = 1:numel(groups)
        scatter(pc1{pressure, groupIndex}, pc2{pressure, groupIndex});
    end
    hold off;
    xlim([-100 100]);  % Set the desired limits for x-axis
    ylim([-100 100]);  % Set the desired limits for y-axis
    xlabel('PC1');
    ylabel('PC2');
    title(['Pressure ' num2str(pressures{pressure})]);
    legend(groups);
end

pc1_concatenatedArray_15 = cat(1, pc1{1,:});
    
pc1_concatenatedArray_30 = cat(1, pc1{2,:});
    
pc1_concatenatedArray_45 = cat(1, pc1{3,:});
 
pc2_concatenatedArray_15 = cat(1, pc2{1,:});
    
pc2_concatenatedArray_30 = cat(1, pc2{2,:});
    
pc2_concatenatedArray_45 = cat(1, pc2{3,:});


% Scatter plot of pc1 and pc2
figure;
scatter(pc1_concatenatedArray_15, pc2_concatenatedArray_15, 'red', 'filled');
hold on;
scatter(pc1_concatenatedArray_30, pc2_concatenatedArray_30, 'green', 'filled');
scatter(pc1_concatenatedArray_45, pc2_concatenatedArray_45, 'blue', 'filled');

% Set axis labels and title
xlabel('pc1');
ylabel('pc2');
title('Scatter Plot of pc1 and pc2');

% Create legend
legend('1.5 bar', '3.0 bar', '4.5 bar');

fatbike_pc1_concatenatedArray_06 = cat(1, pc1{4,:});
    
fatbike_pc1_concatenatedArray_10 = cat(1, pc1{5,:});
    
fatbike_pc1_concatenatedArray_14 = cat(1, pc1{6,:});
 
fatbike_pc2_concatenatedArray_06 = cat(1, pc2{4,:});
    
fatbike_pc2_concatenatedArray_10 = cat(1, pc2{5,:});
    
fatbike_pc2_concatenatedArray_14 = cat(1, pc2{6,:});

% Scatter plot of pc1 and pc2
figure;
scatter(fatbike_pc1_concatenatedArray_06, fatbike_pc2_concatenatedArray_06, 'red', 'filled');
hold on;
scatter(fatbike_pc1_concatenatedArray_10, fatbike_pc2_concatenatedArray_10, 'green', 'filled');
scatter(fatbike_pc1_concatenatedArray_14, fatbike_pc2_concatenatedArray_14, 'blue', 'filled');

% Set axis labels and title
xlabel('pc1');
ylabel('pc2');
title('Scatter Plot of pc1 and pc2');

% Create legend
legend('0.6 bar', '1.0 bar', '1.4 bar');

% Training data for neural network(groups 1,2,4 used)

training_data_15 = cat(1,pc1{1,1},pc1{1,2},pc1{1,4});
training_data_30 = cat(1,pc1{2,1},pc1{2,2},pc1{2,4});
training_data_45 = cat(1,pc1{3,1},pc1{3,2},pc1{3,4});
training_data_06 = cat(1,pc1{4,1},pc1{4,2},pc1{4,4});
training_data_10 = cat(1,pc1{5,1},pc1{5,2},pc1{5,4});
training_data_14 = cat(1,pc1{6,1},pc1{6,2},pc1{6,4});

maxSize = max([size(training_data_15, 1), size(training_data_30, 1), size(training_data_45, 1),size(training_data_06, 1), size(training_data_10, 1), size(training_data_14, 1)]);

currentSize_15 = size(training_data_15, 1);
currentSize_30 = size(training_data_30, 1);
currentSize_45 = size(training_data_45, 1);
currentSize_06 = size(training_data_06, 1);
currentSize_10 = size(training_data_10, 1);
currentSize_14 = size(training_data_14, 1);

% Calculate the number of rows to pad
numRowsToPad_15 = maxSize - currentSize_15;
numRowsToPad_30 = maxSize - currentSize_30;
numRowsToPad_45 = maxSize - currentSize_45;
numRowsToPad_06 = maxSize - currentSize_06;
numRowsToPad_10 = maxSize - currentSize_10;
numRowsToPad_14 = maxSize - currentSize_14;

% Pad the arrays with zeros
training_data_15 = [training_data_15; zeros(numRowsToPad_15, size(training_data_15, 2))];
training_data_30 = [training_data_30; zeros(numRowsToPad_30, size(training_data_30, 2))];
training_data_45 = [training_data_45; zeros(numRowsToPad_45, size(training_data_45, 2))];
training_data_06 = [training_data_06; zeros(numRowsToPad_06, size(training_data_06, 2))];
training_data_10 = [training_data_10; zeros(numRowsToPad_10, size(training_data_10, 2))];
training_data_14 = [training_data_14; zeros(numRowsToPad_14, size(training_data_14, 2))];

% Define the input training data
training_inputs = [training_data_15, training_data_30, training_data_45, training_data_06, training_data_10, training_data_14];

% Define the target outputs
targets = [1.5, 3.0, 4.5, 0.6, 1.0, 1.4];

% Create a feedforward neural network
net = feedforwardnet([10,10,10]); % You can adjust the number of hidden neurons (10 in this case)

% Define the activation function for each layer
net.layers{1}.transferFcn = 'tansig';
net.layers{2}.transferFcn = 'tansig';
net.layers{3}.transferFcn = 'tansig';

% Set the training algorithm to batch training
net.trainFcn = 'traingd'; % Use batch training

% Set the maximum number of epochs
net.trainParam.epochs = 500; % Adjust the number of epochs as needed

% Set the batch size
%net.trainParam.batchSize = 50; % Set the desired batch size

% Set the learning rate & the momentum term
net.trainParam.lr = 0.01;
net.trainParam.mc = 1.1; 

% Set the weight decay parameter
net.performParam.regularization = 0.1; 

% Configure the network
net.divideFcn = 'dividerand'; % Use random division of data for training, validation, and testing
net.divideParam.trainRatio = 0.8; % 60% of data for training
net.divideParam.valRatio = 0.1; % 20% of data for validation
net.divideParam.testRatio = 0.1; % 20% of data for testing
%net.trainParam.min_grad = 1e-10;

% Train the network
[net, tr] = train(net, training_inputs, targets);

% Test the network
outputs = net(training_inputs);

% Display the predicted outputs
disp("Predicted Outputs:");
disp(outputs);

% Calculate the mean squared error (MSE)
mseValue = mse(outputs, targets);
disp("Mean Squared Error (MSE):");
disp(mseValue);

% Testing data for Neural Network

testing_data_15 = cat(1,pc1{1,3},pc1{1,5},pc1{1,6});
testing_data_30 = cat(1,pc1{2,3},pc1{2,5},pc1{2,6});
testing_data_45 = cat(1,pc1{3,3},pc1{3,5},pc1{3,6});
testing_data_06 = cat(1,pc1{4,3},pc1{4,5},pc1{4,6});
testing_data_10 = cat(1,pc1{5,3},pc1{5,5},pc1{5,6});
testing_data_14 = cat(1,pc1{6,3},pc1{6,5},pc1{6,6});

maxSize = max([size(testing_data_15, 1), size(testing_data_30, 1), size(testing_data_45, 1),size(testing_data_06, 1), size(testing_data_10, 1), size(testing_data_14, 1)]);

currentSize_15 = size(testing_data_15, 1);
currentSize_30 = size(testing_data_30, 1);
currentSize_45 = size(testing_data_45, 1);
currentSize_06 = size(testing_data_06, 1);
currentSize_10 = size(testing_data_10, 1);
currentSize_14 = size(testing_data_14, 1);

% Calculate the number of rows to pad
numRowsToPad_15 = maxSize - currentSize_15;
numRowsToPad_30 = maxSize - currentSize_30;
numRowsToPad_45 = maxSize - currentSize_45;
numRowsToPad_06 = maxSize - currentSize_06;
numRowsToPad_10 = maxSize - currentSize_10;
numRowsToPad_14 = maxSize - currentSize_14;

% Pad the arrays with zeros
testing_data_15 = [testing_data_15; zeros(numRowsToPad_15, size(testing_data_15, 2))];
testing_data_30 = [testing_data_30; zeros(numRowsToPad_30, size(testing_data_30, 2))];
testing_data_45 = [testing_data_45; zeros(numRowsToPad_45, size(testing_data_45, 2))];
testing_data_06 = [testing_data_06; zeros(numRowsToPad_06, size(testing_data_06, 2))];
testing_data_10 = [testing_data_10; zeros(numRowsToPad_10, size(testing_data_10, 2))];
testing_data_14 = [testing_data_14; zeros(numRowsToPad_14, size(testing_data_14, 2))];

% Define the input training data
testing_inputs = [testing_data_15, testing_data_30, testing_data_45, testing_data_06, testing_data_10, testing_data_14];

desired_size = size(training_inputs, 1);
current_size = size(testing_inputs, 1);

if current_size < desired_size
   padding_size = desired_size - current_size;
   padded_testing_inputs = padarray(testing_inputs, [padding_size 0], 0, 'post');
else
   padded_testing_inputs = testing_inputs(1:desired_size, :);
end

% Test the network
outputs = net(padded_testing_inputs);

% Display the predicted outputs
disp("Predicted Outputs:");
disp(outputs);