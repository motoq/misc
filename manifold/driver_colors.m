clear;
close all;

figure; hold on;
plot([0 1], [0 1], '-k', 'LineWidth', .1);
scatter(.25, .25, 20, [1 0 0], 'filled');
scatter(.5, .5, 20,   [0 1 0], 'filled');
scatter(.75, .75, 20, [0 0 1], 'filled');
scatter(.5, .25, 20,  [1 1 0], 'filled');
scatter(.25, .75, 20, [1 0 1], 'filled');
scatter(.5, .75, 20,  [0 1 1], 'filled');
scatter(.75, .25, 20, [0 0 0], 'filled');
scatter(.25, .5, 20,  [1 .5 0], 'filled');
legend('line', '[1 0 0]', '[0 1 0]', '[0 0 1]', '[1 1 0]', '[1 0 1]',...
                                     '[0 1 1]', '[0 0 0]', '[1 .5 0]'); 
xlabel('x');
ylabel('x');
title('20 point size filled markers');


