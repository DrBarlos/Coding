%{
HW#1 - Problem 3
AME 404
Carlos A. Sanchez
Adams-Bashforth Method (AB Method)
%}
%{
Before we start, let us define the functions we will use for this method to
make implementation easy. 
AB2: f() 
%}
%% Setup
clear,clc;
dt = [0.5, 0.3, 0.1];
t1 = 0:dt(1):1.5;
t2 = 0:dt(2):1.5;
t3 = 0:dt(3):1.5;
y_0 = 1;
y1 = zeros(1,length(t1));
y2 = zeros(1,length(t2));
y3 = zeros(1,length(t3));
y1(1) = y_0;
y2(1) = y_0;
y3(1) = y_0;

%% Inititialization of approximations
a1 = [];
a2 = [];
a3 = [];

%% Calculations
for i = 2:length(t1)
   a1(i) = y1(i-1) + f(t1(i-1),y1(i-1)) * dt(1);
end
plot(t1,a1)