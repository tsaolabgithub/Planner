function img2 = fast_pixrep(img)
%
% img2 = fast_pixrep(img)
%
% Double image size with pixel replication of the rows and
% columns. Works with multiple frames.
%

if(nargin ~= 1)
   msg = 'USAGE: img2 = fast_pixrep(img)';
   qoe(msg);error(msg);
end

[nrows ncols nother] = size(img);
nv = nrows*ncols;

% Create index map - the value at each pixel will be the
% index from the original image
img2 = 1:nv;
img2 = repmat(img2, [2 1]);
img2 = reshape(img2,[2*nrows ncols]);
img2 = reshape(img2', [1 2*nv]); %'
img2 = repmat(img2, [2 1]); 
img2 = reshape(img2, [2*nrows 2*ncols])'; %'

% Reshape the original image to be pixels-by-frames
img = reshape(img, [nv nother]);

% Map and Reshape
img2 = reshape(img(reshape1d(img2),:), [2*nrows 2*ncols nother]);

return;
