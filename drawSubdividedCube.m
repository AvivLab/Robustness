function drawSubdividedCube(n)
    % Draw a cube subdivided into n^3 smaller cubes, with all edges and vertices.
    %
    % n: number of subdivisions along each edge (>=1)
    %
    % Example usage:  drawSubdividedCube(3)
    % This will create a 3x3x3 subdivision inside a unit cube.

    if nargin < 1
        n = 2;  % Default subdivision
    end

    figure('Color','w');
    hold on;
    axis equal;    % So that the cube isn't distorted
    axis on;      % Hide the axis for clarity
    view(3);       % 3D view

    % 1) Plot the vertices (points) in a meshgrid.
    [X, Y, Z] = meshgrid(0:n, 0:n, 0:n);
    plot3(X(:), Y(:), Z(:), 'ko', 'MarkerFaceColor','red', 'MarkerSize', 10);
    xticklabels({'\it a_1 = 1','','\it a_1 = 2','','\it a_1 = 3'})
    yticklabels({'\it a_2 = 1','','\it a_2 = 2','','\it a_2 = 3'})
    zticklabels({'\it a_3 = 1','','\it a_3 = 2','','\it a_3 = 3'})
    ax = gca;
    ax.FontWeight = 'bold';
    ax.XAxis.FontSize = 20;
    ax.YAxis.FontSize = 20;
    ax.ZAxis.FontSize = 20;

    % 2) Draw lines along x-direction (parallel to x-axis).
    for y = 0:n
        for z = 0:n
            % Connect (0, y, z) to (n, y, z)
            line([0, n], [y, y], [z, z], 'Color','black','LineWidth',2.5);
        end
    end

    % 3) Draw lines along y-direction (parallel to y-axis).
    for x = 0:n
        for z = 0:n
            % Connect (x, 0, z) to (x, n, z)
            line([x, x], [0, n], [z, z], 'Color','black','LineWidth',2.5);
        end
    end

    % 4) Draw lines along z-direction (parallel to z-axis).
    for x = 0:n
        for y = 0:n
            % Connect (x, y, 0) to (x, y, n)
            line([x, x], [y, y], [0, n], 'Color','black','LineWidth',2.5);
        end
    end

    title('Network of Viable Genotypes','FontWeight','bold','fontsize',28);
    hold off;
end