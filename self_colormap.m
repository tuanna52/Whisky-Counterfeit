function map = self_colormap(m)
%PRISM  Prism color map
%   PRISM(M) returns an M-by-3 matrix containing repeated use
%   of six colors: red, orange, yellow, green, blue, violet.
%   PRISM, by itself, is the same length as the current figure's
%   colormap. If no figure exists, MATLAB creates one.
%
%   PRISM, with no input or output arguments, changes the colors
%   of any line objects in the current axes to the prism colors.
%
%   The colors in the PRISM map are also present, in the same order,
%   in the HSV map.  However, PRISM uses repeated copies of its six
%   colors, whereas HSV varies its colors smoothly.
%
%   See also HSV, FLAG, HOT, COOL, COLORMAP, RGBPLOT, CONTOUR.

%   C. Moler, 8-11-92.
%   Copyright 1984-2004 The MathWorks, Inc.

if nargin + nargout == 0
   h = get(gca,'Child');
   m = length(h);
elseif nargin == 0
   f = get(groot,'CurrentFigure');
   if isempty(f)
      m = size(get(groot,'DefaultFigureColormap'),1);
   else
      m = size(f.Colormap,1);
   end
end

% R = [red; orange; yellow; green; blue; violet]
% R = [ 0  0   0.25; 0   0   0.5 ; 0    0  0.75; 0  0   1  ;0  0.25   1 ;
%       0  0.5  1  ; 0  0.75  1  ; 0    1   1  ; 0  1  0.75;
%       0    1   0.5; 0  1  0.25 ; 0   1    0  ;0.25  1   0  ;0.5 1   0  ;
%       0.75 1    0 ; 1  1    0  ; 1  0.5   0  ; 1    0   0  ; 1  0  0.5 ; 1  0  1 ];
%R = [0 0 0;   1   0    0;    1  0.125  0;  1   0.25   0; 1  0.375  0;
%     1 1/2 0;  1  0.625  0;   1  0.75   0;  1   0.875  0;
%     1  1  0; 0.75  1   0;    0.5  1    0;  0.25   1  0;
%     0  1  0; 0 0.75  0.25;   0  0.5  0.5;  0  0.25  0.75;
%     0  0  1; 1/3  0   1;    2/3  0    1;   1   0  0.5];%21

  R(2:m,1:3)=hsv(m-1);
  R(1,1:3)=[0 0 0];

% Generate m/6 vertically stacked copies of r with Kronecker product.
e = ones(ceil(m/m),1);
R = kron(e,R);
R = R(1:m,:);

if nargin + nargout == 0
   % Apply to lines in current axes.
   for k = 1:m
      if strcmp(get(h(k),'type'),'line')
         set(h(k),'Color',R(k,:))
      end
   end
else
   map = R;
end
