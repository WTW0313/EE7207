function w = SOM(data, rows, cols, learningRate1, learningRate2, iterLimit)
    % data ---- input matrix
    % rows, cols ---- the dimension of the 2D lattice
    % learningRate ---- the learning rate in two phases
    % iterLimit ---- the times of iteration
    [nSample, nDim] = size(data);
    nNeuron = rows * cols;
    
    % Generate the initial weight vectors
    w = randn(nNeuron, nDim);
    
    % Define the initial values for the time constant and  learning rate
    eta0 = learningRate1;
    sigma0 = sqrt((rows - 1)^2 + (cols - 1)^2) / 2;
    tau1 = 1000 / log(sigma0);
    
    % Generate the lateral distance matrix
    dist = distance_matrix(rows, cols);
    
    % Self-orgnizing phase
    for k = 1 : iterLimit
        % Calculate learning rate and width of the neighbourhood function
        eta1 = eta0 * exp(-k / 1000);
        sigma = sigma0 * exp(-k / tau1);
        
        % Randomly select a training sample
        row1 = randperm(nSample, 1);
        x1 = data(row1, :);
        
        % Compete and find the winning neuron
        d1 = zeros(nNeuron, 1);
        for i = 1 : nNeuron
            d1(i, 1) = (w(i, :) - x1) * (w(i, :) - x1)';
        end
        
        [~, index_win_1] = min(d1);
        
        % Update weight vectors of all neurons
        for i = 1 : nNeuron
            h1 = exp(-dist(i, index_win_1) / 2 / sigma^2);
            w(i, :) = w(i, :) + eta1 * h1 * (x1 - w(i, :));
        end
    end
    
    % Convergence phase
    % Set the learning rate to a small constant
    eta2 = learningRate2;
    
    % Repeat 500 * nNeuron times
    for k = 1 : 500 * nNeuron
        % Randomly select a sample
        row2 = randperm(nSample, 1);
        x2 = data(row2, :);
        
        % Compete and find the winning neuron
        d2 = zeros(nNeuron, 1);
        for i = 1 : nNeuron
            d2(i, 1) = (w(i, :) - x2) * (w(i, :) - x2)';
        end
        
        [~, index_win_2] = min(d2);
        
        % Update the weight vector of the wining neuron only
        h2 = 1; 
        w(index_win_2, :) = w(index_win_2, :) + eta2 * h2 * (x2 - w(index_win_2, :));
    end
end