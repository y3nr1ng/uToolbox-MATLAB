classdef VolView < handle
    %VOLVIEW Display volumetric data set.
    %
    %   H = VOLVIEW() creates a default viewer.
    %   H = VOLVIEW(DATA) shows render the volume of the data in XY/YZ/XZ
    %   view.
    %   H = VOLVIEW(..., PARAM) allows detail controls of the internal
    %   parameters.
    %
    %   Parameters
    %   ----------
    %   'VoxelSize'     Set the voxel size if the data is anisotropic.
    %   'Title'         Title of the screen, default to DATA variable name.

    %% Book-keeping variables
    properties (Access=private, Hidden=true)
        % hFigure holds the handle to volume viwer's root figure object.
        hFigure;

        % hMultiView is a (2+k)x3 struct array, each row represents a handle for
        % different purpose, while each column represents XY/YZ/XZ multiview.
        % There are at least 2 types of axes - Raw and Crosshair.
        hMultiView;

        % hPreview holds the handles for the overview of current position in the
        % volumetric data.
        hPreview;
    end

    %% Layout configurations
    properties (SetAccess=protected, GetAccess=public)
        fillRatio;      % Ratio of the entire viewer respective to the screen.
        viewGap;        % Gaps (px) between the views.
        edgeGap;        % Gaps (px) between the views and the edges.
    end

    %% Data
    properties (SetAccess=protected, GetAccess=public, SetObservable)
        voxelSize;      % Voxel size along the X, Y and Z dimension.
        volumeSize;     % Dimension of the volume.
        %TODO: attach volume size variation to axes poisition update function.

        data;           % Raw data.
        %TODO: attach data change to hGraphics update callback

        cursorPos;      % Current cursor position in the
        %TODO: update preview and boundary check by cursorPos change
    end

    %% Constructor and destructor
    methods
        function this = VolView(varargin)
            %CONSTRUCTOR Create a template volume viewer object.

            p = inputParser;
            % only 3-D data is allowed
            addOptional(p, 'Data', [], @(x)(~isempty(x) && (ndims(x)==3)));
            % voxels are default to be isotropic
            addParameter(p, 'VoxelSize', [1, 1, 1], @(x)(isnumeric(x)));
            % use variable name as the default title
            addParameter(p, 'Title', inputname(1), @(x)(ischar(x)));
            parse(p, varargin{:});

            % generate the figure
            this.hFigure = figure( ...
                'Name', p.Results.Title, ...
                'NumberTitle', 'off', ...
                'Visible', 'off' ...
            );

            % populate the components

            % set layout properties
            this.fillRatio = 0.7;
            this.viewGap = 10;
            this.edgeGap = 40;

            % inject the data
            
        end

        function delete(this)
            %DESTRUCTOR Free all the resources.

            % close remaining figure
            h = this.hFigure;
            if ~isempty(h) && ishandle(h)
                close(h);
            end
        end
    end

    %% Public functions
    methods
        this = show(this, data)
        this = setCursor(this, pos)
    end

    %% Private functions
    methods (Access=Private)
    end
end
