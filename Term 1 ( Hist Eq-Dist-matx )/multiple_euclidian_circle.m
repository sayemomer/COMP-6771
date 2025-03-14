bw = zeros(700,700);
bw(150,150) = 1; 
bw(50,450) = 1; 
bw(150,600) = 1; 
bw(700, 200) =1; 
bw(300, 400) = 1;
bw(400, 400) = 1;
bw(500, 50) = 1;
D1 = bwdist(bw,'euclidean');
figure, imcontour(D1), title('Euclidean')