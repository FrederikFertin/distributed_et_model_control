time = seconds(simout.Time);
p_ref = simout.Data(:,1);
p_meas = simout.Data(:,2);
p_error = simout.Data(:,3);
p_set = simout.Data(:,4);
p_min = simout.Data(:,5);
p_max = simout.Data(:,6);

l = length(time);



figure;
subplot(1,2,1)
plot(time, p_error, 'LineWidth', 1, 'LineStyle','-');
hold on
plot(time, p_ref, 'LineWidth', 1, 'LineStyle','--');
hold on
plot(time, p_meas, 'LineWidth', 1, 'LineStyle','--');
axis tight
title("PI-controller step response")
xlabel('Time [s]')
ylabel('P [W]')
ylim([-3.5e4 3e4])
%xtickformat('hh:mm')
lgd = legend('Error', 'Reference Power', 'Measured Power');
set(lgd,'location','best')

subplot(1,2,2)
plot(time(int32(l/2):l), p_error(int32(l/2):l), 'LineWidth', 1, 'LineStyle','-');
hold on
yline( 5.8, 'LineWidth', 1, 'LineStyle','--');
hold on
yline( -5.8, 'LineWidth', 1, 'LineStyle','--');
axis tight
title("Settling Time: 8.5 seconds")
xlabel('Time [s]')
ylabel('Error [W]')
ylim([-40 40])
lgd = legend('Error', '+ 0.1 %', '- 0.1 %');
set(lgd,'location','best')

%% Step 2
time = seconds(power_profiles.Time);
p_ref = power_profiles.Data(:,1)/1000;
p_dc = power_profiles.Data(:,2)/1000;
p_ac = power_profiles.Data(:,3)/1000;

figure;
subplot(2,1,1)
plot(time, p_ref, 'LineWidth', 1);
hold on
plot(time, p_dc, 'LineWidth', 1);
hold on
plot(time, p_ac, 'LineWidth', 1);
axis tight
title("Power Profiles")
xlabel('Time [h]')
ylabel('P [kW]')
ylim([-70 25])
xtickformat('hh:mm')
lgd = legend('Reference Power', 'DC Power', 'AC Power');
set(lgd,'location','best')

soc = soc_profiles.Data*100;

subplot(2,1,2)
yyaxis left
plot(time, soc, 'LineWidth', 1);
hold on
axis tight
%title("Battery SOC")
%xlabel('Time [s]')
ylabel('SOC [%]')
ylim([0 100])

v_ref = voltage_profiles.Data(:,1);
v_batt = voltage_profiles.Data(:,2);
v_oc = voltage_profiles.Data(:,3);

% figure;
yyaxis right
plot(time, v_ref, 'LineWidth', 1);
hold on
plot(time, v_batt, 'LineWidth', 1);
hold on
plot(time, v_oc, 'LineWidth', 1);
axis tight
%title("Voltage profiles")
xlabel('Time [h]')
ylabel('U [V]')
ylim([290 420])
xtickformat('hh:mm')
lgd = legend('SOC', 'Reference Voltage', 'Battery Voltage', 'Open Circuit Voltage');
set(lgd,'location','best')

title("SOC and Voltage profiles")

t_loss = thermal_losses.Data(:,1);
j_loss = thermal_losses.Data(:,2);
temp = thermal_losses.Data(:,3);

figure;
yyaxis left
plot(time, t_loss, 'LineWidth', 1);
hold on
plot(time, j_loss, 'LineWidth', 1);
hold on
ylabel('Losses [W]')
ylim([0 5000])

yyaxis right
plot(time, temp, 'LineWidth', 1);
axis tight
title("Battery losses and temperature")
xlabel('Time [h]')
ylabel('Temperature [C]')
ylim([0 60])
xtickformat('hh:mm')
lgd = legend('Thermal Losses', 'Joule Losses', 'Temperature');
set(lgd,'location','best')

r_data = int_resistance.Data;
% r_base = v_nom/i_nom;
r_base = 350.4/(58.8*3);

max_r = max(r_data)/r_base;
min_r = min(r_data)/r_base;
min_r, max_r
max_t = max(temp)

figure;
plot(time, r_data/r_base, 'LineWidth', 1)
axis tight
title("Internal resistance of battery")
xlabel('Time [h]')
xtickformat('hh:mm')
ylabel('Resistance [p.u.]')
ylim([0.05 0.09])

%% Step 4
figure;
time = seconds(temp_decay.Time);
plot(time, temp_decay.Data);
axis tight
hold on
yline([10], '--')
T_tau = 30*0.368 + 10;
xx = abs(temp_decay.Data - T_tau) <= 0.00001;
sum(xx)
x = temp_decay.Time(xx);
hold on
plot(x,T_tau,'.', 'MarkerSize', 10)
title(["Temperature decay over 96 hours"])
xlabel('Time [h]')
ylabel('Temperature [C]')
ylim([0 50])
xtickformat('hh:mm')
lgd = legend('Battery temperature', 'Ambient temperature', ['Time constant: ', num2str(round(x/60)/60), ' hours']);
set(lgd,'location','north')


%% Step 5 - visualization
time = seconds(power_profiles_trip.Time);
p_ref = power_profiles_trip.Data(:,1)/1000;
p_dc = power_profiles_trip.Data(:,2)/1000;
p_ac = power_profiles_trip.Data(:,3)/1000;

figure;
subplot(2,1,1)
plot(time, p_ref);
hold on
plot(time, p_dc);
hold on
plot(time, p_ac);
axis tight
title("Power Profiles")
xlabel('Time [h]')
ylabel('P [kW]')
ylim([-70 160])
xtickformat('hh:mm')
lgd = legend('Reference Power', 'DC Power', 'AC Power');
set(lgd,'location','best')

soc = soc_profiles_trip.Data*100;

subplot(2,1,2)
yyaxis left
plot(time, soc);
hold on
axis tight
%title("Battery SOC")
%xlabel('Time [s]')
ylabel('SOC [%]')
ylim([0 100])

v_ref = voltage_profiles_trip.Data(:,1);
v_batt = voltage_profiles_trip.Data(:,2);
v_oc = voltage_profiles_trip.Data(:,3);

% figure;
yyaxis right
plot(time, v_ref);
hold on
plot(time, v_batt);
hold on
plot(time, v_oc);
axis tight
%title("Voltage profiles")
xlabel('Time [h]')
ylabel('U [V]')
ylim([290 420])
xtickformat('hh:mm')
lgd = legend('SOC', 'Reference Voltage', 'Battery Voltage', 'Open Circuit Voltage');
set(lgd,'location','best')

title("SOC and Voltage profiles")

t_loss = thermal_losses_trip.Data(:,1);
j_loss = thermal_losses_trip.Data(:,2);
temp = thermal_losses_trip.Data(:,3);
cooling = thermal_losses_trip.Data(:,4);

figure;
yyaxis left
plot(time, t_loss);
hold on
plot(time, j_loss);
hold on
plot(time, cooling);
hold on
ylabel('Losses [W]')
ylim([0 23000])

yyaxis right
plot(time, temp);
axis tight
title("Battery losses and temperature")
xlabel('Time [h]')
ylabel('Temperature [C]')
ylim([0 40])
xtickformat('hh:mm')
lgd = legend('Thermal Losses', 'Joule Losses', 'Temperature', 'Cooling power');
set(lgd,'location','best')

max_t = max(temp)

%% Results gathering
time = consumed_energy.Time;
drive_consumption = consumed_energy.Data;
charging_energy = charged_energy.Data;

figure;
plot(charged_energy.Time, charged_energy.Data)
hold on
plot(consumed_energy.Time, consumed_energy.Data)
axis tight

%figure;
%plot(Tout_hist(:,1), Tout_hist(:,2))
%plot(rpm_hist(:,1), rpm_hist(:,2))
%%
% Find indices where power is above or equal to 0
valid_indices = power_hist(:,2) >= 0;

% Filter data using valid_indices
power_filtered = power_hist(valid_indices, 2) / 1000;
rpm_filtered = rpm_hist(valid_indices, 2);

% Plot filtered data
figure;
scatter(power_filtered, rpm_filtered, 10, "filled",'MarkerFaceAlpha',0.35)
axis tight
title("Power vs RPM")
xlabel('Power [kW]')
ylabel('rpm')
ylim([0 9000])
xlim([0 160])

%% 
without_cooling = simout


