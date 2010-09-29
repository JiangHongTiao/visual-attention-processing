function [cA,cH,cV,cD,output_im] = dwt532d(A)

[row,col] = size(A);
output_im = zeros(row,col);

 %row filtering
    for abc = 1:row

        input_data = A(abc,1:end);

        N = length(input_data);
        odd_coef = N /2;        
        even_coef = odd_coef;   

        M1 = zeros(1,N);
        M2 = zeros(1,N);

        for x = 1:odd_coef
            x = x - 1;
            if x < odd_coef-1
%                 M1(2*x+2) = input_data(2*x+2) - bitshift((input_data(2*x+1) + input_data(2*x+3)),-1);
                M1(2*x+2) = input_data(2*x+2) - (input_data(2*x+1) + input_data(2*x+3))/2;
                M1(2*x+1) = input_data(2*x+1);
            else
%                 M1(2*x+2) = input_data(2*x+2) - bitshift((input_data(2*x+1) + input_data(2*x+1)),-1);
                M1(2*x+2) = input_data(2*x+2) - (input_data(2*x+1) + input_data(2*x+1))/2;
                M1(2*x+1) = input_data(2*x+1);
            end;
        end;

        for y = 1:even_coef
            y = y - 1;
            if y == 0
%                 M2(2*y+1) = M1(2*y+1) + bitshift((M1(2*y+2) + M1(2*y+2) + 2),-2);
                M2(2*y+1) = M1(2*y+1) + (M1(2*y+2) + M1(2*y+2) + 2)/4;
                M2(2*y+2) = M1(2*y+2);
            else
%                 M2(2*y+1) = M1(2*y+1) + bitshift((M1(2*y) + M1(2*y+2) + 2),-2);
                M2(2*y+1) = M1(2*y+1) + (M1(2*y) + M1(2*y+2) + 2)/4;
                M2(2*y+2) = M1(2*y+2);
            end;
        end;

        output_im(abc,1:col/2) = M2(1:2:end);
        output_im(abc,(col/2)+1:end) = M2(2:2:end);
    end;
    
    % column filtering
    for def = 1:col
        
        input_data = output_im(1:end,def);

        N = length(input_data);
        odd_coef = N /2;        
        even_coef = odd_coef;   

        M1 = zeros(1,N);
        M2 = zeros(1,N);
 
        for x = 1:odd_coef
            x = x - 1;
            if x < odd_coef-1
%                 M1(2*x+2) = input_data(2*x+2) - bitshift((input_data(2*x+1) + input_data(2*x+3)),-1);
                M1(2*x+2) = input_data(2*x+2) - (input_data(2*x+1) + input_data(2*x+3))/2;
                M1(2*x+1) = input_data(2*x+1);
            else
%                 M1(2*x+2) = input_data(2*x+2) - bitshift((input_data(2*x+1) + input_data(2*x+1)),-1);
                M1(2*x+2) = input_data(2*x+2) - (input_data(2*x+1) + input_data(2*x+1))/2;
                M1(2*x+1) = input_data(2*x+1);
            end;
        end;

        for y = 1:even_coef
            y = y - 1;
            if y == 0;
%                 M2(2*y+1) = M1(2*y+1) + bitshift((M1(2*y+2) + M1(2*y+2) + 2),-2);
                M2(2*y+1) = M1(2*y+1) + (M1(2*y+2) + M1(2*y+2) + 2)/4;
                M2(2*y+2) = M1(2*y+2);
            else
%                 M2(2*y+1) = M1(2*y+1) + bitshift((M1(2*y) + M1(2*y+2) + 2),-2);
                M2(2*y+1) = M1(2*y+1) + (M1(2*y) + M1(2*y+2) + 2)/4;
                M2(2*y+2) = M1(2*y+2);
            end;
        end;

      output_im(1:row/2,def) = M2(1:2:end);
      output_im((row/2)+1:end,def) = M2(2:2:end);
    end;
    
    cA = output_im(1:row/2,1:col/2);
    cH = output_im((row/2)+1:row,1:col/2);
    cV = output_im(1:row/2,(col/2)+1:col);
    cD = output_im((row/2)+1:row,(col/2)+1:col);