function [M,cm,Imat,Ixx,Iyy,Izz,q] = IAssembly( Ms, cms, IVecs, qs )
%function [M,cm,Imat] = IAssembly( Ms, cms, IVecs, qs )
%IASSEMBLY Compute the center of mass, orientation of principal axes, and
%principal moments of inertia of an assembly of subsystems
%
%Ms: Each value is mass of a subsystem
%cms: Each row is x, y, z for c.m. of subsystem
%IVecs: Each row is Ixx,Iyy,Izz for a subsystem
%qs: Each row is qx, qy, qz, qw of orientation of subsystem
%
%M: Mass of assembly
%cm: Center of mass of assembly
%Ixx,Iyy,Izz: Principal moments of assembly
%q: Orientation of assembly

cm = zeros(1,3);
M = 0;
n = length( Ms ); % Number of subsystems

Imat = zeros(3,3);

for i=1:n
    M_ss = Ms(i);
    cm_ss = cms(i,:);
    M = M + M_ss;
    cm = cm + M_ss*cm_ss;
end
cm = cm / M;
for i=1:n
    M_ss = Ms(i);
    cm_ss = cms(i,:) - cm; % This time, subsystem c.m. is relative to sc c.m.
    q_ss = qs(i,:);
    Imat_ss_p = diag( IVecs(i,:) ); % Subsystem inertia tensor in own coords
    Rss_sc = ConvertRotationalRepresentation( q_ss,4,3 );
    Imat_ss = Rss_sc * Imat_ss_p * Rss_sc'; % S.S. inertia tensor in sc coords
    tcm = tilde( cm_ss );
    Imat = Imat + Imat_ss + M_ss * tcm * tcm'; % Parallel axis theorem
end
%cm
%Imat

% Now find principal axes and principal moments of inertia
[V,D] = eig( Imat );

% Force eigenvectors to be right-handed orthonormal triad
V(:,1) = V(:,1) / norm( V(:,1) );
V(:,2) = V(:,2) / norm( V(:,2) );
V(:,3) = cross( V(:,1),V(:,2) );
%V * V' % should be identity

%ImatCheck = V * D * V'

% eig sorts the eigenvalues so scrambles the eigenvectors
% Reorder them so they are as close as possible to x, y, z
[maxX, Xindex] = max( abs(V(1,:)) );
[maxY, Yindex] = max( abs(V(2,:)) );
[maxZ, Zindex] = max( abs(V(3,:)) );
sx = -1 + 2*(maxX == V(1,Xindex) );
sy = -1 + 2*(maxY == V(2,Yindex) );
sz = -1 + 2*(maxZ == V(3,Zindex) );

Rbi = [ sx*V(:,Xindex), sy*V(:,Yindex), sz*V(:,Zindex ) ];

Ixx = D(Xindex,Xindex);
Iyy = D(Yindex,Yindex);
Izz = D(Zindex,Zindex);
%Imat
%ImatCheck = Rbi * diag( [Ixx Iyy Izz] ) * Rbi'

q = ConvertRotationalRepresentation( Rbi, 3, 4 );

%Rbi = ConvertRotationalRepresentation( q, 4, 3 )
%ImatCheck = Rbi * diag( [Ixx,Iyy,Izz] ) * Rbi'

end

function rt = tilde( r )
%TILDE The tilde matrix operator (see Schaub & Junkins (3.23))

x = r(1);
y = r(2);
z = r(3);

rt = [ ...
    0, -z, y; ...
    z, 0, -x; ...
    -y, x, 0 ...
    ];

end

