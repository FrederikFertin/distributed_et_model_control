
%% Step 2
time = power_profiles.Time;
p_ref = power_profiles.Data(:,1)/1000;
p_dc = power_profiles.Data(:,2)/1000;
p_ac = power_profiles.Data(:,3)/1000;

figure;
plot(time, p_ref, 'LineWidth', 1);
hold on
plot(time, p_dc, 'LineWidth', 1);
hold on
plot(time, p_ac, 'LineWidth', 1);
axis tight
title("Power Profiles")
xlabel('Time [s]')
ylabel('P [kW]')
ylim([-70 25])
lgd = legend('Reference Power', 'DC Power', 'AC Power');
set(lgd,'location','best')

soc = soc_profiles.Data*100;

figure;
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
xlabel('Time [s]')
ylabel('U [V]')
ylim([290 420])
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
xlabel('Time [s]')
ylabel('Temperature [C]')
ylim([0 60])
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
xlabel('Time [s]')
ylabel('Resistance [p.u.]')
ylim([0.05 0.09])

%% Step 4
figure;
plot(temp_decay.Time, temp_decay.Data);
axis tight
yline([10], '--')
T_tau = 30*0.368 + 10;
xx = abs(temp_decay.Data - T_tau) <= 0.000001;
x = temp_decay.Time(xx);
hold on
plot(x,T_tau,'.', 'MarkerSize', 10)
title(["Temperature decay over 96 hours"])
xlabel('Time [s]')
ylabel('Temperature [C]')
ylim([0 50])
lgd = legend('Battery temperature', 'Ambient temperature', ['Time constant: ', num2str(round(x/60)/60), ' hours']);
set(lgd,'location','north')


