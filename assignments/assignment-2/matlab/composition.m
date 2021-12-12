function [R] = composition(R1)
    R1_len = size(R1, 1);
    R = ones(R1_len, R1_len);
    for i = 1 : R1_len
        row_vec = R1(i, :);  
        for j = 1 : R1_len
            col_vec = R1(j, :)';
            new_vec = zeros(R1_len, 1);
            for k = 1 : R1_len
                new_vec(k) = min(row_vec(k), col_vec(k));
            end
            R(i, j) = max(new_vec);
        end
    end
end