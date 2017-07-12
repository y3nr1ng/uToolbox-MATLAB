function J = sireconpp(I, volSz, parms)
%SIRECONPP Plan-by-plan SI reconstruction.
%
%   TBA

persistent kp;

% extract frequently used parameters
imSz = volSz(1:2);
nz = volSz(3);

% generate spectral matrix on-the-fly
M = spectramat(parms.Phases, parms.I0, parms.I1);
% phase shift values
kp = [];

% probe for the existence of Kp values
if isempty(kp)
    % create projection view along orientations and phases
    Ip = sim.wfproj(I, volSz, parms);
    % find the Kp values for each orientations
    kp = findkp(Ip, volSz(1:2), M, parms, false);
end

%DEBUG override
is = floor(nz/2);
nz = 1;

% iterate through the layers
J = zeros([parms.RetrievalInterpRatio*imSz, nz], 'single');

%DEBUG override
% for iz = 1:nz
for iz = is:is+nz-1
    tStart = tic;
    
    fprintf('z = %d\n', iz);
    
    % extract the layer
    L = I(:, :, iz, :, :);
    % use reshape instead of squeeze to avoid single orientation get
    % squeezed as well
    sz = size(L);
    sz(3) = [];
    L = reshape(L, sz);
    
    % run the reconstruction on specific layer
    J(:, :, iz) = sireconppcore(L, imSz, M, kp, parms);
    
    tElapsed = toc(tStart);
    fprintf('%.2fs elapsed\n\n', tElapsed);
end

end
