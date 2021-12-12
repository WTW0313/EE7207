% Data preparation
load('data_train.mat');
load('label_train.mat');
 
data_and_label = [data_train,label_train];
data_and_label = shuffling(data_and_label);

[train_set, valid_set, test_set] = data_divider(data_and_label, 20, 0);

% Seperate data and labels
train_labels = train_set(:, end);
valid_labels = valid_set(:, end);
test_labels = test_set(:, end);

train_data = train_set(:, 1 : end - 1);
valid_data =  valid_set(:, 1 : end - 1);
test_data = test_set(:, 1 : end - 1);

SVMModel = fitcsvm(train_data, train_labels, 'KernelFunction', 'gaussian', 'ClassNames', [-1, 1]);

% Test the SVM on train set
[output_train, score_train] = predict(SVMModel, train_data);
index_minus = find(output_train < 0);
index_plus = find(output_train >= 0);
output_train(index_minus) = -1;
output_train(index_plus) = 1;
e = output_train - train_labels;
accuracy_train = 1 - length(nonzeros(e)) / length(output_train);

% Test the RBF network on valid set:
[output_valid, score_valid] = predict(SVMModel, valid_data);
index_minus_valid = find(output_valid < 0);
indexes_plus_valid = find(output_valid >= 0);
output_valid(index_minus_valid) = -1;
output_valid(indexes_plus_valid) = 1;
e_valid = output_valid - valid_labels;
accuracy_valid = 1 - length(nonzeros(e_valid)) / length(output_valid);

% Classification on test data
load('data_test.mat');
[output_test, score_test] = predict(SVMModel, data_test);
