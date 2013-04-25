%Gabor filtering
%
% authors: beuth
% modified: temi
%
% theta => orientation
% psi => phase shift

function RF = gaborBeuthMod(kernelSize, halfSDsq, theta, f, psi, gamma)
    
    %some terms for the gabor equation
    twopiF = 2 * pi *f; 
    
    %calculate grids (calculation points) for RF
    a       = floor(kernelSize/2); %half support upper boundary
    [X,Y]   = meshgrid(-a:1:a, -a:1:a);
    XT1      = (X)  .* cos(theta) + Y.*sin(theta);
    YT1      = Y.*cos(theta) - (X) .* sin(theta);
    
    % Receptive Field (RF)
    RF = exp( - halfSDsq*(XT1.*XT1+gamma^2*YT1.*YT1)) .* cos(twopiF*XT1 + psi);
  
end