delta = clf;
clear;

data = [];



[xdim, ydim] =size(data)


data_mean = mean(data')';
scattermean = data_mean*ones(1,10000);
data = data - scattermean;


[xdim ydim] = size(data);

%hebbian learning using sanger's rule
w = randn(xdim, num_components);
Y = w'*data;
%iterate until delta is smaller then limit
delta = 1;
numadjust = 0;
iteration = 0;

% slow version, ok for learning a few components  
% you may want to vectorize the codes for learning all 64 components
% you can also use the while loop: while abs(delta) > limit
% here, we will just learn three neurons (j), printing out the weights every 30 iterations 
% of the data set

for outerloop = 1:20
  for innerloop = 1:30
    for idy = 1:ydim
        xcur = data(:,idy);
        ycur = w'*xcur;
        w_delta = zeros(xdim, 6);
       
        for j = 1:6
            for i = 1:64
                 dSum = 0;
                for jj = 1:6
                    dSum = dSum + w(i,jj)*ycur(jj);
                end
                 % compute sum w_ik y_k
                    w_delta(i,j) = n * (ycur(j)*xcur(i)-(ycur(j)*dSum));

            end
        end
        w = w + w_delta;
    sum(sum(w));
    end
  end
  
   
    delta = sum(sum(w));

end
