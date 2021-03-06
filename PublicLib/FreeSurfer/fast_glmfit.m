function [beta, rvar, vdof, r] = fast_glmfit(y,X,Sn)
% [beta, rvar, vdof, r] = fast_glmfit(y,X,<Sn>)
%
% Sn is the covariance matrix of the noise AFTER any filtering.
%
% Worsley, K.J. and Friston, K.J. Analysis of fMRI Time-Series
% Revisited - Again. Neuroimage 2, 173-181, 1995.
%
% See also: fast_fratio.m
%
% $Id: fast_glmfit.m,v 1.3 2003/05/02 03:43:21 greve Exp $

if(nargin ~= 2 & nargin ~= 3)
  fprintf('[beta, rvar, vdof, r] = fast_glmfit(y,X,<Sn>)\n');
  return;
end

if(exist('Sn') ~= 1) Sn = []; end

[nf nv] = size(y);
if(size(X,1) ~= nf)
  fprintf('ERROR: X and y have different number of frames\n');
  return;
end

if(~isempty(Sn))
  if(size(Sn,1) ~= nf)
    fprintf('ERROR: Sn dimension mismatch\n');
    return;
  end
  R = eye(nf)-X*inv(X'*X)*X';
  vdof = trace(R*Sn);
else
  vdof = size(X,1) - size(X,2);
end

beta = (inv(X'*X)*X')*y;

if(nargout == 1) return; end

r = y - X*beta;
rvar = sum(r.^2)/vdof;

return;



