function r = hTranslationMatrix( t )
%HTRANSLATIONMATRIX Answer the 4x4 matrix that translates a vector in
%homogeneous coordinates 3-vector t 

r = eye(4,4); % Identity matrix

% Make t into a column vector if it isn't already
if size(t) == [ 1 3 ]
    t = t'; % Make row vector into column vector
elseif size(t) ~= [ 3 1 ]
    disp( 'hTranslationMatrix: t must be 3-vector! aborting' );
    return;
end

r(1:3,4) = t; 
return;


