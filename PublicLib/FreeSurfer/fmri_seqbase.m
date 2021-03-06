function base = fmri_seqbase(nTypesPerRun,NoRand)
%
% base = fmri_seqbase(nTypesPerRun,<NoRand>)
%
%
% $Id: fmri_seqbase.m,v 1.1 2003/03/04 20:47:40 greve Exp $

if(nargin==1) NoRand = 0; end

% Number of Stimulus Conditions
nCond = length(nTypesPerRun);

% make sure there are at least 2 conditions %
if(nCond < 2)
  msg = 'Number of conditions must be > 1';
  qoe(msg);error(msg);
end

% make sure that all conditions have non-zero representation %
if( length(find(nTypesPerRun==0)) ~= 0 )
  msg = 'Condition cannot have zero stimuli';
  qoe(msg);error(msg);
end

% Total number of Stimuli per Run %
nStimPerRun = sum(nTypesPerRun);

% base: Vector with each stimulus represented the 
% proper number of times. 
base = zeros(nStimPerRun,1);
n1 = 1;
for i = 1:nCond,
  n2 = n1 + nTypesPerRun(i) - 1;
  base([n1:n2]) = ones(nTypesPerRun(i),1) * (i-1);
  n1 = n2 + 1;
end

if(NoRand) return; end

base = base(randperm(nStimPerRun));

return;

