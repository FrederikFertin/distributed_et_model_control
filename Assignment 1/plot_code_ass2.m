%% Task 6
time = seconds(simout_6.Time);
p_ref = simout_6.Data(:,1);
p_meas = simout_6.Data(:,2);
p_error = simout_6.Data(:,3);
p_set = simout_6.Data(:,4);
p_min = simout_6.Data(:,5);
p_max = simout_6.Data(:,6);

l = length(time);

figure;
subplot(1,2,1)
plot(time, p_error, 'LineWidth', 1, 'LineStyle','-');
hold on
plot(time, p_ref, 'LineWidth', 1, 'LineStyle','--');
hold on
plot(time, p_meas, 'LineWidth', 1, 'LineStyle','--');
axis tight
t = title("PI-controller step response");
fontsize(t, scale=1.3)
xlabel('Time [s]')
ylabel('P [W]')
ylim([-3.5e4 3e4])
grid("on")
%xtickformat('hh:mm')
lgd = legend('Error', 'Reference Power', 'Measured Power');
fontsize(lgd, scale=1.3)
set(lgd,'location','best')

subplot(1,2,2)
plot(time(int32(l/2):l), p_error(int32(l/2):l), 'LineWidth', 1, 'LineStyle','-');
hold on
yline( 5.8, 'LineWidth', 1, 'LineStyle','--');
hold on
yline( -5.8, 'LineWidth', 1, 'LineStyle','--');
axis tight
t = title("Settling Time: 8.5 seconds");
fontsize(t, scale=1.3)
xlabel('Time [s]')
ylabel('Error [W]')
ylim([-40 40])
grid("on")
lgd = legend('Error', '+ 0.1 %', '- 0.1 %');
fontsize(lgd, scale=1.3)
set(lgd,'location','best')

%% Task 7
time = seconds(simout_7.Time);
p_ref = simout_7.Data(:,1);
p_meas = simout_7.Data(:,2);
p_error = simout_7.Data(:,3);
p_set = simout_7.Data(:,4);
p_min = simout_7.Data(:,5);
p_max = simout_7.Data(:,6);

error = error_terms.Data(:,1);
error_p = error_terms.Data(:,2);
error_i = error_terms.Data(:,3);
error_set = error_terms.Data(:,4);

s = trafo_powers.Data(:, 1);
p = trafo_powers.Data(:, 2);
q = trafo_powers.Data(:, 3);

figure;
subplot(2,2,2)
plot(time, p_error, 'LineWidth', 1, 'LineStyle','-');
hold on
plot(time, p_ref, 'LineWidth', 1, 'LineStyle','--');
hold on
plot(time, p_meas, 'LineWidth', 1, 'LineStyle','--');
axis tight
t = title("PI-controller step responses");
fontsize(t, scale=1.3)
xlabel('Time [s]')
ylabel('P [W]')
ylim([-5.5e4 5.5e4])
grid("on")
lgd = legend('Error', 'Reference Power', 'Measured Power');
set(lgd,'location','best')
fontsize(lgd, scale=1.3)

subplot(2,2,3)
plot(time, p_set, 'LineWidth', 1, 'LineStyle','-');
hold on
plot(time, p_min, 'LineWidth', 1, 'LineStyle','--');
hold on
plot(time, p_max, 'LineWidth', 1, 'LineStyle','--');
axis tight
t = title("Controller setpoints and limits");
fontsize(t, scale=1.3)
xlabel('Time [s]')
ylabel('P [W]')
ylim([0 20e4])
grid("on")
lgd = legend('Setpoint', 'Min Power', 'Max Power');
fontsize(lgd, scale=1.3)
set(lgd,'location','best')

subplot(2,2,4)
plot(time, error_set, 'LineWidth', 1, 'LineStyle','-');
hold on
plot(time, error_p, 'LineWidth', 1, 'LineStyle','--');
hold on
plot(time, error_i, 'LineWidth', 1, 'LineStyle','--');
axis tight
t = title("Controller error terms");
fontsize(t, scale=1.3)
xlabel('Time [s]')
ylabel('P [W]')
ylim([-5e4 2e5])
grid("on")
lgd = legend('Proportional gain', 'Integral gain', 'Calculated Setpoint');
fontsize(lgd, scale=1.3)
set(lgd,'location','best')

subplot(2,2,1)
plot(time, s/1000, 'LineWidth', 1, 'LineStyle','-');
hold on
plot(time, p/1000, 'LineWidth', 1, 'LineStyle','-');
hold on
plot(time, q/1000, 'LineWidth', 1, 'LineStyle','-');
axis tight
t = title("Transformer loading");
fontsize(t, scale=1.3)
xlabel('Time [s]')
ylabel('Power [kVA]')
ylim([-120 120])
grid("on")
lgd = legend('Apparent Power [kVA]', 'Active Power [kW]', 'Reactive Power [kVAr]');
fontsize(lgd, scale=1.3)
set(lgd,'location','best')


l1 = line_currents.Data(:,1);
l2 = line_currents.Data(:,2);
l3 = line_currents.Data(:,3);
l4 = line_currents.Data(:,4);

figure;
fontsize(scale=1.2)
plot(time, l1);
hold on
plot(time, l2);
hold on
plot(time, l3);
hold on
plot(time, l4);
axis tight

t = title("Line loadings");
fontsize(t, scale=1.3)
xlabel('Time [s]')
ylabel('Power [A]')
grid("on")
lgd = legend('Cable   [A]', 'Load 1 [A]', 'Load 2 [A]', 'Load 3 [A]');
fontsize(lgd, scale=1.3)
