clear
clc

overallSum = 0;
overallDiff = 0;
noFilmSum = 0;
noFilmDiff = 0;
filmSum = 0;
filmDiff = 0;

pumpandprobe = '/Users/nashadrahman/Documents/SCARLET/RPP exp/20190916/9 shot acquision (full pump and probe)/';
background = '/Users/nashadrahman/Documents/SCARLET/RPP exp/20190916/10 shot acquisition for background characterization/';
probeblocked = '/Users/nashadrahman/Documents/SCARLET/RPP exp/20190916/probe blocked shots/';
sep19 = '/Users/nashadrahman/Documents/SCARLET/RPP exp/20190919/Image Data/';
oct8 = '/Users/nashadrahman/Documents/SCARLET/RPP exp/20191008/Image Data/';

directory = oct8;
files = dir(directory);

fileNames = {files.name};
% 
% for nameCell = fileNames
%     
%     name = nameCell{1};
%     
%     if ((name ~= ".") && (name ~= ".."))
% 
%         t = Tiff(fullfile(directory, name),'r');
% 
%         imageArray = read(t);
%         
%         currentSum = sum(sum(imageArray));
% 
%         close(t)
%         
%         fprintf("name: " + name + "\t Sum: " + currentSum + "\n")
%         
%     end
% 
% end


for nameCell = fileNames
    
    name = nameCell{1};
    
    if ((name ~= ".") && (name ~= ".."))

        if (name(14) == 'S')
            
            sName = name; % Uses name of file 
            pName = strrep(name, 'S', 'P'); % Replaces S with P to get corresponding P image
            
            sTiff = Tiff(fullfile(directory, sName),'r'); % Reads in Tiff for both images
            ptiff = Tiff(fullfile(directory, pName),'r');
            
            sImageArray = read(sTiff); % Converts image data to array with int16 values
            pImageArray = read(ptiff);
            
            close(sTiff) % Close Files now that the data is stored in array
            close(ptiff)
            
            % Use functions to compare images
            [Sum,diff,fracDiff] = linear_noise_reduced_image_compare(sImageArray, pImageArray);
            
            % Print Info
            fprintf("\n" +pName + "\n")
            fprintf("Difference (S - P) : " + (diff) + "\n")
            fprintf("Fractional Difference (S - P) : " + (fracDiff) + "\n")
            
            overallDiff = overallDiff + (diff);
            overallSum = overallSum + (Sum);
            
            
            thickness = extractBetween(name,"Pol_",".tif"); % Determine Thickness from File Name
            
            if thickness{1} == "0.10" 
                fprintf("No Film\n")
                noFilmDiff = noFilmDiff + (diff);
                noFilmSum = noFilmSum + (Sum);
                
            elseif str2num(thickness{1}) < 25
                filmDiff = filmDiff + (diff);
                filmSum = filmSum + (Sum);
             
            end
            
        end
        
    end

end


fprintf("\nOverall Sum:" + overallSum)
fprintf("\nOverall Difference(S-P):" + overallDiff)
fprintf("\nOverall Fractional Difference(S-P)/(S+P):" + (overallDiff/overallSum))

fprintf("\n\nNo Film Sum:" + noFilmSum)
fprintf("\nNo Film Difference(S-P):" + noFilmDiff)
fprintf("\nNo Film Fractional Difference(S-P)/(S+P):" + (noFilmDiff/noFilmSum))

fprintf("\n\nFilm Sum:" + filmSum)
fprintf("\nFilm Difference(S-P):" + filmDiff)
fprintf("\nFilm Fractional Difference(S-P)/(S+P):" + (filmDiff/filmSum))

fprintf("\n\n"+(((filmDiff/filmSum)-(noFilmDiff/noFilmSum))/(noFilmDiff/noFilmSum)))

