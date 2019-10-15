clear
clc

overallSum = 0;
overallDiff = 0;

pumpandprobe = '/Users/nashadrahman/Documents/SCARLET/RPP exp/20190916/9 shot acquision (full pump and probe)/';
background = '/Users/nashadrahman/Documents/SCARLET/RPP exp/20190916/10 shot acquisition for background characterization/';
probeblocked = '/Users/nashadrahman/Documents/SCARLET/RPP exp/20190916/probe blocked shots/';
sep19 = '/Users/nashadrahman/Documents/SCARLET/RPP exp/20190919/Image Data/'


directory = sep19;
files = dir(directory);

fileNames = {files.name};

for nameCell = fileNames
    
    name = nameCell{1};
    
    if ((name ~= ".") && (name ~= ".."))

        t = Tiff(fullfile(directory, name),'r');

        imageArray = read(t);
        
        currentSum = sum(sum(imageArray));

        close(t)
        
        fprintf("name: " + name + "\t Sum: " + currentSum + "\n")
        
    end

end


for nameCell = fileNames
    
    name = nameCell{1};
    
    if ((name ~= ".") && (name ~= ".."))

        if (name(13) == 'S')
            
            sName = name;
            sTiff = Tiff(fullfile(directory, sName),'r');
            sImageArray = read(sTiff);
            
            sTopAvg = uint16((sum(sImageArray(1:460))/460));
            sNoiseAdjustedImage = sImageArray - sTopAvg;
            sNoiseAdjustedImage(sNoiseAdjustedImage<0)=0;
            sSum = sum(sum((sNoiseAdjustedImage)));

            close(sTiff)
            
            pName = eraseBetween(strrep(name, 'S', 'P'), 18, 18);
            ptiff = Tiff(fullfile(directory, pName),'r');
            pImageArray = read(ptiff);
            
            pTopAvg = uint16((sum(pImageArray(1:460))/460));
            pNoiseAdjustedImage = pImageArray - pTopAvg;
            pNoiseAdjustedImage(pNoiseAdjustedImage<0)=0;
            pSum = sum(sum((pNoiseAdjustedImage)));
            
            close(ptiff)
            
            fprintf(pName + "\n")
            fprintf("Difference (S - P) : " + (sSum - pSum) + "\n")
            
            overallDiff = overallDiff + (sSum - pSum);
            overallSum = overallSum + (sSum + pSum);
            
        end
        
    end

end


fprintf("\nOverall Sum:" + overallSum)
fprintf("\nOverall Difference:" + overallDiff)
fprintf("\nOverall Fractional Difference:" + (overallDiff/overallSum))


%imshow(Y); 
%title('Peppers Image (Y Component)');
