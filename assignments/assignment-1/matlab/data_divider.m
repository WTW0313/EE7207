% Divide data into training set, validation set and test set 
function [train_data, valid_data, test_data] = data_divider(data, validation_ratio, test_ratio)
    [rows, ~] = size(data);
    validation_amount = round(rows * validation_ratio / 100);
    test_amount = round(rows * test_ratio / 100);

    data_index = 1 : rows;
    valid_index = randi([1, rows], 1, validation_amount);
    valid_data = data(valid_index, :);
    data_index = setdiff(data_index, valid_index);
    data = data(data_index, :);
    [new_rows, ~] = size(data);

    data_index = 1 : new_rows;
    test_index = randi([1, new_rows], 1 ,test_amount);
    test_data = data(test_index, :);
    data_index = setdiff(data_index, test_index);
    train_data = data(data_index, :);
end