% Define points
p1 = [2, 3];
p2 = [5, 7];
% Euclidean norm
euclidean_dist = norm(p2 - p1);
plot([p1(1), p2(1)], [p1(2), p2(2)], '--', 'LineWidth', 2, 'DisplayName', ['Euclidean Distance: ', num2str(euclidean_dist)])
hold on
% City block norm
city_block_dist = sum(abs(p2 - p1));
plot([p1(1), p2(1)], [p1(2), p1(2)], ':r', 'LineWidth', 2, 'DisplayName', ['City Block Distance: ', num2str(city_block_dist)])
plot([p2(1), p2(1)], [p1(2), p2(2)], ':r', 'LineWidth', 2)
% Chessboard norm
chessboard_dist = max(abs(p2 - p1));
plot([p1(1), p2(1)], [p1(2), p1(2)], '-.g', 'LineWidth', 2, 'DisplayName', ['Chessboard Distance: ', num2str(chessboard_dist)])
plot([p2(1), p2(1)], [p1(2), p2(2)], '-.g', 'LineWidth', 2)
% Plot points
scatter([p1(1), p2(1)], [p1(2), p2(2)], 'ob', 'DisplayName', 'Points')
% Set labels and legend
xlabel('X')
ylabel('Y')
title('Distance Norms in Cartesian Plane')
grid on
axis equal
legend('Location', 'Best')
hold off
