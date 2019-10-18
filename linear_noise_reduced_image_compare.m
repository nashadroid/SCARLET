function [Sum,diff,fracDiff] = linear_noise_reduced_image_compare(image1,image2)
% Returns sum, difference, and fractional difference of the integral of two images
% Reduces noise by finding average of the first 10 rows of the image, and
% subtracting that value throughout every pixel value, and setting negative
% values to 0 
%   

    Sum1 = sum(sum(LinearNoiseReduction(image1)));
    Sum2 = sum(sum(LinearNoiseReduction(image2)));
    
    Sum = Sum1 + Sum2;
    diff = Sum1 - Sum2;
    fracDiff = diff/Sum;
    
end

