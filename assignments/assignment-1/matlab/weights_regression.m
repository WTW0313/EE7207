% Using LSM to adjust / train the weights
function W = weights_regression(phi, label)
 W = (phi' * phi)^-1 * (phi' * label);
end