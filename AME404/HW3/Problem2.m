%% Problem 2
clc, clear;
% Parameters
m_cl = 35.45 * 1.6605e-27;
m_be = 9.01 * 1.6605e-27;
k = 1.81e2;

% Matrix Setup
A = [-k/m_cl, k/m_cl, 0; k/m_be, -2* k/m_be, k/m_be; 0, k/m_cl, -k/m_cl];

%% Obtain 
[ev, ef_square] = eig(A);
eigenfreq = sqrt(-1 * ef_square);
max_comp = max(ev);
nev = ev./max_comp;