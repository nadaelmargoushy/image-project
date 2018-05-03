
%%Import image
I= imread('C:\Users\solution\Pictures\Saved Pictures\bowling_balls\black.jpg');

%%Remove noise
blur = imgaussfilt(I,4);
imshow(blur)

se = strel('disk',10);
b = imerode(blur,se);
b = imopen(b, se);
b = imdilate(b,se);
%imshow(b)
%%detect circles darker that background using hough circular transform (function in matlab)
[centers,radii] = imfindcircles(b,[80 410],'ObjectPolarity','dark', ...
          'Sensitivity',0.9)
imshow(I)
%%circle the balls
h = viscircles(centers,radii);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%get image size and number of balls detected
imageSize = size(I);
cir_num=length(radii);

%%for loop to crop each ball and remove intersection if present

% if cir_num~=1
   for i=1:cir_num
     y=centers(i,1);
     x=centers(i,2);
     r=radii(i);
     ci= [ x,y , r];     % center and radius of circle ([c_row, c_col, r])
     [xx,yy] = ndgrid((1:imageSize(1))-ci(1),(1:imageSize(2))-ci(2));
     mask = uint8((xx.^2 + yy.^2)<ci(3)^2);
     ball = uint8(zeros(size(I)));
     ball(:,:,1) = I(:,:,1).*mask;
     ball(:,:,2) = I(:,:,2).*mask;
     ball(:,:,3) = I(:,:,3).*mask;
%      imshow(ball);
%%nested loop to separat each ball
    for j=1:cir_num
        
        if i~=j
            y=centers(j,1);
            x=centers(j,2);
            r=radii(j);
            ci= [ x,y , r];     % center and radius of circle ([c_row, c_col, r])
            [xx,yy] = ndgrid((1:imageSize(1))-ci(1),(1:imageSize(2))-ci(2));
            mask = uint8((xx.^2 + yy.^2)<ci(3)^2);
            croppedImage = uint8(zeros(size(I)));
            croppedImage(:,:,1) = I(:,:,1).*mask;
            croppedImage(:,:,2) = I(:,:,2).*mask;
            croppedImage(:,:,3) = I(:,:,3).*mask;
%            imshow(croppedImage);
           ball=ball-croppedImage;
        end
        
%         ball=ball-croppedImage;
%         imshow(ball)
        
    end
%%%%%%for each ball color is determined by thresholding of rgb values
%%%%%%manually and each ball is marked by a circle of its own color
            color1=0;
            for n=-50:50
                c=centers(i,1)+n;
                r=centers(i,2)+n;
                color= impixel(I,c,r)
                color1=color1+color;
            end
            average=color1/100

            if (average(1)<220&&average(1)>170)

                if( average(2)<50&&average(2)>30)

                    if( average(3)<140&&average(3)>110)
                     h = viscircles(centers(i:i,:),radii(i),'color','m');
                    end
                end
            end

            if (average(1)<100)

                if( average(2)<145&&average(2)>115)

                    if( average(3)<127)
                     h = viscircles(centers(i:i,:),radii(i),'color','g');
                    end
                end
            end

            if (average(1)<75)

                if( average(2)<110)

                    if( average(3)<165&&average(3)>60)
                     h = viscircles(centers(i:i,:),radii(i),'color','b');
                    end
                end
            end
            if (average(1)<230)

                if( average(2)<50&&average(2)>23)

                    if( average(3)<65&&average(3)>50)
                     h = viscircles(centers(i:i,:),radii(i),'color','r');
                    end
                end
            end
            if (average(1)<160&&average(1)>120)

                if( average(2)<150&&average(2)>100)

                    if( average(3)<100&&average(3)>73)
                     h = viscircles(centers(i:i,:),radii(i),'color','r');
                    end
                end
            end
            if ( average(1)<255&&average(1)>230)

                if( average(2)<152&&average(2)>95)

                    if( average(3)<55)
                     h = viscircles(centers(i:i,:),radii(i),'color','y');
                    end
                end
            end
            if ( average(1)<150&&average(1)>130)

                if( average(2)<145&&average(2)>120)

                    if( average(3)<155)
                     h = viscircles(centers(i:i,:),radii(i),'color','k');
                    end
                end
            end
            j=j+1
    
    
  end
% end 


