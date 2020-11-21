%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Association: Digital Communications Lab-Fall 1399
% 
% Name of Block: Initialization for Lab 4
%
% Description: Initializes all necessary values for Lab 4.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;
clear;
clc;

bit_rate = 0;
smpl_per_symbl = 8;
pkt_size = 10;
stop_time = 0; %Only needed in hardware
fs = 1;
M = 4;
k = log2(M);
modulation = 'pam';
pulse_name = 'triangular';
mode = 'correlator';