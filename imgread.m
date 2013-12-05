function imgread
    clear all; close all; clc;
    A = imread('untitled.png', 'png');
    image(A); % image file in the same folder
    [X,Y]=ginput(20) % click image 10 times
end