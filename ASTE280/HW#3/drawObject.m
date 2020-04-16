function drawObject( geometryFile, viewAz, viewEl, roll, pitch, yaw )

if nargin < 4
    roll = 0;
    pitch = 0;
    yaw = 0;
end

if nargin < 2 
    viewAz = 180;
    viewEl = 90;
end

rpy = hRotationMatrixZ( yaw ) * hRotationMatrixY( pitch ) * hRotationMatrixX( roll );

azel = hRotationMatrixY( 90 - viewEl ) * hRotationMatrixZ( 180 + viewAz ) ...
    * hRotationMatrixX( 180 ); % Last one: Flip over (z is up now)

toView = azel * rpy;

[p,t,q] = geometryFile()

close all
figure
axis square
axis equal
hold on

% Draw triangles
xvals = zeros(1,4);
yvals = zeros(1,4);
ss = size(t);
ntri = ss(1); % Number of triangles (number of rows in t)
for i=1:ntri
    tri = t(i,1:3);
    p1 = hTransform( p( tri(1), : ), toView );
    p2 = hTransform( p( tri(2), : ), toView );
    p3 = hTransform( p( tri(3), : ), toView );
    xvals(:) = [ -p1(2) -p2(2) -p3(2) -p1(2) ];
    yvals(:) = [ p1(1) p2(1) p3(1) p1(1) ];
    plot( xvals, yvals );
end

% Draw quadrilaterals
xvals = zeros(1,5);
yvals = zeros(1,5);
ss = size(q);
qlen = ss(1); % Number of quadrilaterals (number of rows in q)
for i=1:qlen
    quad = q(i,1:4);
    p1 = hTransform( p( quad(1), : ), toView );
    p2 = hTransform( p( quad(2), : ), toView );
    p3 = hTransform( p( quad(3), : ), toView );
    p4 = hTransform( p( quad(4), : ), toView );
    xvals(:) = [ -p1(2) -p2(2) -p3(2) -p4(2) -p1(2) ];
    yvals(:) = [ p1(1) p2(1) p3(1) p4(1) p1(1) ];
    plot( xvals, yvals );
end

end
