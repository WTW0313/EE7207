% To calculate Phi
function phi = calculate_Phi(data, center, sigma)
    [nSample, ~] = size(data);
    [nCenter, ~] = size(center);
    phi = zeros(nSample, nCenter);
    for i = 1 : nCenter
        c_mat = repmat(center(i, :), nSample, 1);
        column_i_of_phi = exp((1 / (2 * sigma^2)) * sqrt(sum((data - c_mat).^2, 2)));
        phi(:, i) = column_i_of_phi;
    end
end