% Generate distance matrix
function M = distance_matrix(n1, n2)
    n = n1 * n2;
    M = zeros(n, n);
    for i = 1 : n
        xi = floor(i / n2);
        yi = mod(i, n2);
        if yi > 0
            xi = xi + 1;
        end
        for j = 1 : n
            xj = floor(j / n2);
            yj = mod(j, n2);
            if yj > 0
                xj = xj + 1;
            end
            M(i, j) = sqrt((xj - xi)^2 + (yj - yi)^2);
        end
    end
end