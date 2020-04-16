function vPrime = hTransform( v, m )
%HTRANSFORM Transform a 3-vector v using homogeneous matrix m

% Make v into a column vector if it isn't already
if isequal( size(v), [ 1 3 ] )
    v = v'; % Make row vector into column vector
elseif ~isequal( size(v), [ 3 1 ] )
    disp( 'hTransform: v must be 3-vector! aborting' );
    return;
end

% Append 1 to the vector to put it in homogeneous form
v = [ v; 1 ];

% Check that m is a 4x4 matrix
if ~isequal( size(m), [ 4 4 ] )
    disp( 'hTransform: m must be 4x4 matrix! aborting' );
    return;
end

vPrime = m * v;
vPrime = vPrime(1:3); % strip off the 1
return;


