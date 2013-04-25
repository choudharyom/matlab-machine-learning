function gaborProcessed = ImgGabor(ImgLocation,kernelSize,ori,phases,gamma,f,halfSDsq)

if nargin < 3
    ori=4; %ori is a constant (orientation)
end

fprintf(1, '\nInitialising data structure\n');
gaborProcessed=zeros(length(ImgLocation),ori*phases*2*prod(size(ImgLocation{1})-(kernelSize-1)));


fprintf(1, 'Now processing the images with Gabor filter\n');
output='';
for i=1:ori
    for j=1:phases
        %% Generate the Gabor function
        % Convert the orientation number into an angle (theta)
        theta        = 0 + (i-1)*pi/ori;
        
        % Generate a matrix of size 11x11 (kernelSize), containing the Gabor weights
        RF           = gaborBeuthMod(kernelSize, halfSDsq, theta, f, pi/phases * (j-1), gamma);
        
        % Normalizes the Gabor filter to a maximum value of 1
        RF           = RF.*1/max([abs(max(max(RF))) abs(min(min(RF)))]);
        
        % Normalize the Gabor filter to zero mean
        RF           = RF-sum(sum(RF))/kernelSize^2;
        
        %% Convolute each image
        for k = 1:length(ImgLocation)

            % Convolve the given image (IMAGE) using the Gabor filter (RF)
            E            = convn(ImgLocation{k}, RF, 'valid');

            % split the result into a positive and negative part, using only positive values
            E_p          = E;
            E_p(E_p<0)   = 0;
            E_n          = -E;
            E_n(E_n<0)   = 0;
            
            % Store the part results at the right position in the data vector
            lowerindex=(i-1)* phases*2*prod(size(E)) + (j-1)*2*prod(size(E)) + 1;
            upperindex=(i-1)* phases*2*prod(size(E)) + j*2*prod(size(E));
            gaborProcessed(k,lowerindex:upperindex) = reshape([E_p;E_n],[],1);

            %Progress measurement
            outputOld=output;
            outputNr=sprintf('%g',floor(( k+(j-1)*length(ImgLocation)+(i-1)*phases*length(ImgLocation) ) * 100 / (ori*phases*length(ImgLocation)) ));
            output=[outputNr,'%%'];
            if strcmp(output,outputOld)==0
                for l=1:length(outputOld)-1
                    fprintf('\b')
                end
                fprintf(output)
            end
        end
    end
end
end