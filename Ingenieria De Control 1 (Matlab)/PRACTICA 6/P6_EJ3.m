clear all; clc; format compact; s=tf('s');
G=(0.01*(1+(s/0.1))^2)/((1+(s/10))*(1+(s/1000)));
bode(G)