function [cA,cD,output] = dwt531d(A)
       input_data = A;

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
        
        cA = M2(1:2:end);        
        cD = M2(2:2:end);
        output = [cA,cD];
end