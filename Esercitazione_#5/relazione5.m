clear all
clear
clc

format short e

% PREFISSI

p = 10^(-12);
n = 10^(-9);
k = 10^3;
M = 10^6;

% RESISTENZE

R_1 = 100 * k;
R_2 = 12 * k;
R_3 = 4.7 * k;
R_4 = 10 * k;
R_5 = 2.2 * k;
R_6 = 10 * k;
R_7 = 10 * k;
R_8 = 10 * k;
R_9 = 22 * k;
R_10 = 100 * k;
R_11 = 1 * k;
R_12 = 100;

% CONDENSATORI

C_1 = 100 * n;
C_2 = 100 * n;
C_3 = 15 * p;
C_4 = 100 * n;
C_5 = 100 * n;
C_6 = 100 * n;
C_7 = 100 * n;

% AMPLIFICATORE

A_d = 200 * k;
R_id = 1 * M;
R_o = 100;

% PUNTO 2.1.2
beta = R_2 / (R_1 + R_2);
beta_primo = (parallel(R_2, R_id + R_3) + R_o) / (parallel(R_2, R_id + R_3) + R_o + R_1);
R_in_0 = R_id + R_3 + parallel(R_1 + R_o, R_2);

A_v_oo = 1 / beta
A_v = A_d / (1 + beta * A_d)
R_in = R_in_0 * (1 + A_d * beta_primo)
R_out = parallel((R_o) / (1 + beta * A_d), R_1 + R_2)

% PUNTO 2.2.2
beta = - R_9 / R_10;

A_v_oo = 1 / beta
A_v = A_d / (1 + beta * A_d)
R_in = R_9 + (R_o + R_10) / (1 + A_d)
R_out = (R_9 + R_10 + R_o) / (R_9 * (1 + A_d) + R_10 + R_o) * parallel(R_o, R_9 + R_10)

% PUNTO 2.3.2

A_v_S8 = 1
A_v_S9 = 2 / 3 * (1 + R_10 / R_9) - R_10 / R_9
A_v_S10 = 1 / 3 * (1 + R_10 / R_9) - R_10 / R_9
A_v_S11 = - R_10 / R_9

% PUNTO 2.4.2.e

x = [100, 300, 500, 1000, 3000, 5000, 10000, 15000, 16000, 18000, 20000, 25000, 30000, 1000000]; % vettore con le frequenze
h_1 = C_4 * (R_1 + R_2);
h_2 = C_4 * R_2;
H = tf([h_1 1], [h_2 1]); % funzione di trasferimento
bode(H, 'b')
hold on
bode(H, x, 'r*')
grid on

% PUNTO 2.4.2.f

figure()
x = [1000, 2000, 3000, 5000, 7000, 7500, 8300, 8500, 10000, 12000, 14000, 15000, 20000, 30000, 50000]; % vettore con le frequenze
h_1 = C_5 * R_4 * (R_1 + R_2);
h_2 = C_5 * R_2 * R_4;
H = tf([h_1 0], [h_2 R_2]); % funzione di trasferimento
bode(H, 'b')
hold on
bode(H, x, 'r*')
grid on

% FUNZIONI

function result = parallel(x, y)
	result = (x * y) / (x + y);
end
