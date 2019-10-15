function [Sum,diff,fracDiff] = linear_noise_reduced_image_compare(image1,image2)
% Returns sum, difference, and fractional difference of the integral of two images
% Reduces noise by finding average of the first 10 rows of the image, and
% subtracting that value throughout every pixel value, and setting negative
% values to 0
%   
    ImageArray1 = image1;
    ImageArray2 = image2;

    TopAvg1 = uint16((sum(ImageArray1(1:4600))/4600)); % Change the 4600 to be ten rows of any dimensioned image
    NoiseAdjustedImage1 = ImageArray1 - TopAvg1;
    NoiseAdjustedImage1(NoiseAdjustedImage1<0)=0;
    Sum1 = sum(sum((NoiseAdjustedImage1)));
    
    TopAvg2 = uint16((sum(ImageArray2(1:4600))/4600));
    NoiseAdjustedImage2 = ImageArray2 - TopAvg2;
    NoiseAdjustedImage2(NoiseAdjustedImage2<0)=0;
    Sum2 = sum(sum((NoiseAdjustedImage2)));
    
    Sum = Sum1 + Sum2;
    diff = Sum1 - Sum2;
    fracDiff = diff/Sum;
end

