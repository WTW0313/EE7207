% Data preparation
load('data_train.mat');
load('label_train.mat');
 
data_and_label = [data_train,label_train];
data_and_label = shuffling(data_and_label);

[train_set, valid_set, test_set] = data_divider(data_and_label, 20, 0);

% Seperate data and labels
train_labels = train_set(:, end);
valid_labels = valid_set(:, end);
test_label = test_set(:, end);

train_data = train_set(:, 1 : end - 1);
valid_data =  valid_set(:, 1 : end - 1);
test_data = test_set(:, 1 : end - 1);

% Using SOM to find centers for RBF neural network
data = train_data;
rows = 8;
cols = 8;
learningRate1 = 0.1;
learningRate2 = 0.01;
iterLimit = 1000;
c = SOM(data, rows, cols, learningRate1, learningRate2, iterLimit);

% Calculate Phi
[rows, cols] = size(c);
d = zeros(rows, rows);
for i = 1 : rows
    for j = 1 : rows
        if j < i
            d(i, j) = sqrt((c(j, :) - c(i, :)) * (c(j, :) - c(i, :))') / 2;
        end
    end
end
sigma = max(max(d));
Phi = calculate_Phi(train_data, c, sigma);
[rows, ~] = size(Phi);
Phi = [Phi, ones(rows, 1)];

% Estimate the weights
W = weights_regression(Phi, train_labels); 

% Test the RBF network on train set:
output_train = Phi * W;
index_minus = find(output_train < 0);
index_plus = find(output_train >= 0);
output_train(index_minus) = -1;
output_train(index_plus) = 1;
e = output_train - train_labels;
accuracy_train = 1 - length(nonzeros(e)) / length(output_train);

% Test the RBF network on valid set:
Phi_valid = calculate_Phi(valid_data, c, sigma);
[rows, ~] = size(Phi_valid);
Phi_valid = [Phi_valid, ones(rows, 1)];
output_valid = Phi_valid * W;
index_minus_valid = find(output_valid < 0);
indexes_plus_valid = find(output_valid >= 0);
output_valid(index_minus_valid) = -1;
output_valid(indexes_plus_valid) = 1;
e_valid = output_valid - valid_labels;
accuracy_valid = 1 - length(nonzeros(e_valid)) / length(output_valid);

% Classification on test data
load('data_test.mat');
Phi_test = calculate_Phi(data_test, c, sigma);
[rows, ~] = size(Phi_test);
Phi_test = [Phi_test, ones(rows, 1)];
output_test = Phi_test * W;

output_test_modified = output_test;
index_minus_test = find(output_test_modified < 0);
index_plus_test = find(output_test_modified >= 0);
output_test_modified(index_minus_test) = -1;
output_test_modified(index_plus_test) = 1;

disp([accuracy_train, accuracy_valid]);

