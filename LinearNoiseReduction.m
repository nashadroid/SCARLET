function [NoiseAdjustedImage] = LinearNoiseReduction(ImageArray)
% Reduces noise by finding average of the first 10 rows of the image, and
% subtracting that value throughout every pixel value, and setting negative
% values to 0 

    TopAvg1 = uint16((sum(ImageArray(1:4600))/4600)); % Change the 4600 to be ten rows of any dimensioned image
    NoiseAdjusting = ImageArray - TopAvg1;
    NoiseAdjusting(NoiseAdjusting<0)=0;
    
    NoiseAdjustedImage = NoiseAdjusting;
    
    
end

