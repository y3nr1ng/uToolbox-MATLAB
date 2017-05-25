classdef VolView < handle
    %VOLVIEW Display volumetric data set.
    %
    %   H = VOLVIEW() creates a default viewer.
    %   H = VOLVIEW(DATA) shows render the volume of the data in XY/YZ/XZ
    %   view.
    %   H = VOLVIEW(..., 'Title', NAME) set the title of the viewer instead
    %   of default to the variable name.

    properties (Access=private, Hidden=true)
    end

    %% Constructor and destructor
    methods
        function this = VolView(varargin)
            %CONSTRUCTOR Create a template volume viewer object.

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
    
    end
end