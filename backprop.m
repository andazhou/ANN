function encoder(NINPUTS)
% N-2-N Encoder demo, using backpropagation learning.

% David S. Touretzky,  February, 1996.  Revised January 1998.

if nargin == 0, NINPUTS = 5; end
NPATS = NINPUTS
NOUTPUTS = NINPUTS;
NHIDDENS = 2;

Patterns = 2*eye(NPATS) - 1;
Desired = Patterns;
Inputs1 = [ones(1,NPATS); Patterns];

LearnRate = 0.03;
Momentum = 0.2;
DerivIncr = 0;
TSS_Limit = 0.1*NINPUTS;
deltaW1=0;
deltaW2=0;

Weights1 = rand(NHIDDENS,1+NINPUTS)-0.5;
Weights2 = rand(NOUTPUTS,1+NHIDDENS)-0.5;

clf reset, whitebg(gcf,[0 0 0])

if NINPUTS <= 5, plotinterval = 1;
  else plotinterval = 5; end

for epoch = 1:10000

  bp_innerloop

  if rem(epoch,plotinterval) == 0
     fprintf('Epoch %4d:  Error = %f\n',epoch,TSS);
      PlotEncoder(Inputs2,Weights2)
      drawnow
     end

  if TSS < TSS_Limit, break, end

  end
