function [num_of_image] = CalNumPerImage(mat_in)
num_of_image = size(mat_in,1);

%Variable to check if the sample is 2512/2513 or other
check_var = var(mat_in(1,:));

% for image=100:100
for image=1:size(mat_in,1)
    if check_var > 10^8         % if the sample is not 2512 or 2513    
        %Extract important sections of data and translate the data to the intended threshole
        onefifth_row1 = mat_in(image, 1:50);
        onefifth_row2 = mat_in(image, 401:450) + 5643;
        onefifth_row3 = mat_in(image, 451:500) + 1478;
        onefifth_row5 = mat_in(image, 1218:1267) + 10274;
        
        %Make data rows
        row1 = [onefifth_row1 onefifth_row1 onefifth_row1 onefifth_row1 onefifth_row1];
        row2 = [onefifth_row2 onefifth_row2 onefifth_row2 onefifth_row2 onefifth_row2];
        row3 = [onefifth_row3 onefifth_row3 onefifth_row3 onefifth_row3 onefifth_row3];
        row4 = mat_in(image, 741:990) + 21325;
        row5 = [onefifth_row5 onefifth_row5 onefifth_row5 onefifth_row5 onefifth_row5];
        
    else                        % if the sample is either 2512 or 2513
        onefifth_row1 = mat_in(image, 1:50) + 10500;
        onefifth_row2 = mat_in(image, 401:450) + 11000;
        onefifth_row3 = mat_in(image, 451:500) + 11500;
        onefifth_row5 = mat_in(image, 1218:1267) + 12500;
        
        row1 = [onefifth_row1 onefifth_row1 onefifth_row1 onefifth_row1 onefifth_row1];
        row2 = [onefifth_row2 onefifth_row2 onefifth_row2 onefifth_row2 onefifth_row2];
        row3 = [onefifth_row3 onefifth_row3 onefifth_row3 onefifth_row3 onefifth_row3];
        row4 = mat_in(image, 741:990) + 12000;
        row5 = [onefifth_row5 onefifth_row5 onefifth_row5 onefifth_row5 onefifth_row5];
    end
    
    %Assemble the rows to create the data in order to make the images with scaled color
    from_re=[row1; row2; row3; row4; row5];
    
    %Create the scaled color images
    limits=[21897,25899];
    imagesc(from_re');
    c = self_colormap(435);
    colormap(c);
    caxis(limits);
    set(gca,'position',[0 0 1 1]);
    
    %Save the images
    sample_code = inputname(1);
    saveas(gcf,['C:\Users\shunt\Documents\DATA\Work_HWU_Prof_Demuliez\WhiskyCounterfeit\ImageDataSet\',...
        sample_code,'_',sprintf('%03i',image),'.png']);
    close all;
    currentpng=imread(['C:\Users\shunt\Documents\DATA\Work_HWU_Prof_Demuliez\WhiskyCounterfeit\ImageDataSet\',...
        sample_code,'_',sprintf('%03i',image),'.png']);
    resizepng=imresize(currentpng,[227 227]);
    imwrite(resizepng,['C:\Users\shunt\Documents\DATA\Work_HWU_Prof_Demuliez\WhiskyCounterfeit\ImageDataSet\',...
        sample_code,'_',sprintf('%03i',image),'.png']);
    close all;
end

end

