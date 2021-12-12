% Shuffle the data
function data = shuffling(data)
    [rows,~] = size(data);
    data = data(randperm(rows), :);
end