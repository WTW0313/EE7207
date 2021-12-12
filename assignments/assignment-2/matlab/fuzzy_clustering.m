clc;
clear;

% Original matrix
x = [0.1, 0.0, 0.2, 0.8, 0.3, 0.0, 0.5, 0.6, 0.0, 0.1, 0.3, 0.1, 0.2, 0.2, 0.1, 0.2;
    0.7, 0.5, 0.2, 0.1, 0.0, 0.4, 0.0, 0.3, 0.5, 0.6, 0.2, 0.5, 0.0, 0.6, 0.7, 0.4;
    0.2, 0.5, 0.2, 0.0, 0.4, 0.0, 0.4, 0.0, 0.1, 0.0, 0.1, 0.4, 0.2, 0.1, 0.1, 0.2;
    0.0, 0.0, 0.4, 0.1, 0.3, 0.6, 0.1, 0.1, 0.4, 0.3, 0.4, 0.0, 0.6, 0.1, 0.1, 0.2];

x = x';

n = size(x, 1);
m = size(x, 2);

R1 = ones(n, n);

% Question(a): Compute R1
for i = 1 : n
    for j = 1 : n
        % Calculate Numerator and Denominator
        Numerator = 0;
        Den1 = 0;
        Den2 = 0;
        for k = 1 : m
            Numerator = Numerator + x(i, k) * x(j, k);
            Den1 = Den1 + x(i, k) * x(i, k);
            Den2 = Den2 + x(j, k) * x(j, k);
        end
        Numerator = abs(Numerator);
        Denominator = sqrt(Den1 * Den2);
        R1(i, j) = Numerator / Denominator;
    end
end

% Question(b): Transform R1 into a fuzzy equivalence relation R
R = composition(R1);
while ~isequal(R, R1)
    R1 = R;
    R = composition(R1);
end

%% Question(c)：alpha = 0.4, 0.8
% rules: >=0.4 =1,<0.4 =0;>=0.8 =1,<0.8 =0
R_4 = zeros(n, n);
R_8 = zeros(n, n);
for i = 1 : n
    for j = 1 : n
        if (R(i, j) >= 0.4)
            R_4(i, j) = 1;
        end
        if (R(i, j) >= 0.8)
            R_8(i, j) = 1;
        end
    end
end

%% Question(d)：3 classes
target_alpha = [];
for alpha = 0.8 : 0.0001 : 1.0
	R_test = R;
    for i = 1 : n
        for j = 1 : n
            if R(i, j) >= alpha
                R_test(i, j) = 1;
            end
            if R(i, j) < alpha
                R_test(i, j) = 0;
            end		
        end
    end
    % Evaluation
	R_test =  unique(R_test, 'rows');
	class_num = size(R_test, 1);
    if class_num == 3
       fprintf("Proper alpha %f\n", alpha);
       target_alpha = [target_alpha alpha];
    end
end
if size(target_alpha, 2) > 1
    min_alpha = min(target_alpha);
    max_alpha = max(target_alpha);
end