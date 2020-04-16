function drawAirplane( viewAz, viewEl, roll, pitch, yaw )

if nargin < 1
    viewAz = 180; % View from the south
    viewEl = 90; % View from directly overhead
end;
if nargin < 3
    roll = 30;
    pitch = 20;
    yaw = 10;
end

drawObject( @airplaneGeometry, viewAz, viewEl, roll, pitch, yaw );

end