function this = getColorsParams(this,nbStates)
%GETCOLORSPARAMS for class cImages, Calculate the distribution of colors inside
%                the im...
%
%           UNCLASSIFIED
%
% Member function of the class cImages
%
% function this = getColorsParams(this)
%
% Description:
%     Calculate the distribution of colors inside the image or a set of images
%     A global comment that applies to all files of the example class. This
%     comment is included in every automatically generated file for the class.
%
% Input Arguments::
%
%     this: cImages: The current or "active" object
%     nbStates: double: number of different colors in images
%
% Output Arguments::
%
%     this: cImages: The current or "active" object
%
% Author Info:
% The University of Nottingham, Malaysia Campus
% Le Ngo Anh Cat
% keyx9lna@nottingham.edu.my,lengoanhcat@gmail.com
% 0060173171399
% Refactored interface 01/04/2009 Anh Cat Le Ngo
% The University of Nottingham, Malaysia Campus
% RCS Info: ($Date:$)($Author:$)($Revision:$)
% A class_wizard v 3.0 assembled file, generated: 08-Jan-2010 15:59:35
%

%% Definition of the number of components used in GMM.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Data = double(this.mUniqueColors.value);
plotFlag = 1;
if isequal(this.mUniqueColors.format,'cielab')
    sprintf('Normalize the CIELab Color Distribution Map')
    Data = [ 1:1:size(Data,2); Data(:,:,2); Data(:,:,3)];
elseif isequal(this.mUniqueColors.format,'cie');
    sprintf('Normalize the CIE Color Distribution Map')
    r = Data(:,:,1);
    g = Data(:,:,2);
    b = Data(:,:,3);
    int = r + g + b;
    cr = safeDivide(r,int);
    cg = safeDivide(g,int);
    Data = [ 1:1:size(Data,2); cr; cg];
elseif isequal(this.mUniqueColors.format,'ddd')
    sprintf('Create the DDD Color Distribution Map')
    Data = [ Data(:,:,1); Data(:,:,2); Data(:,:,3)];
elseif isequal(this.mUniqueColors.format,'rgb');
    sprintf('Create the RGB Color Distribution Map')
    Data = [ Data(:,:,1); Data(:,:,2); Data(:,:,3)];
end
nbVar = size(Data,1);

%% Training of GMM by EM algorithm, initialized by k-means clustering.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[Priors, Mu, Sigma] = EM_init_kmeans(Data, nbStates);
[Priors, Mu, Sigma] = EM(Data, Priors, Mu, Sigma);
    
if (plotFlag == 1)
    if (isequal(this.mUniqueColors.format,'cie') || isequal(this.mUniqueColors.format,'cielab'))
    %% Plot of the data
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure('position',[10,10,1000,800],'name','Traffic Sign Color Classification Demo1');
    %plot 1D
    for n=1:nbVar-1
      subplot(3*(nbVar-1),2,(n-1)*2+1); hold on;
      plot(Data(1,:), Data(n+1,:), 'x', 'markerSize', 4, 'color', [.3 .3 .3]);
      axis([min(Data(1,:)) max(Data(1,:)) min(Data(n+1,:))-0.01 max(Data(n+1,:))+0.01]);
      xlabel('t','fontsize',16); ylabel(['x_' num2str(n)],'fontsize',16);
    end
    %plot 2D
    subplot(3*(nbVar-1),2,[2:2:2*(nbVar-1)]); hold on;
    plot(Data(2,:), Data(3,:), 'x', 'markerSize', 4, 'color', [.3 .3 .3]);
    axis([min(Data(2,:))-0.01 max(Data(2,:))+0.01 min(Data(3,:))-0.01 max(Data(3,:))+0.01]);
    xlabel('x_1','fontsize',16); ylabel('x_2','fontsize',16);

    %% Plot of the GMM encoding results
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %plot 1D
    for n=1:nbVar-1
      subplot(3*(nbVar-1),2,4+(n-1)*2+1); hold on;
      plotGMM(Mu([1,n+1],:), Sigma([1,n+1],[1,n+1],:), [0 .8 0], 1);
      axis([min(Data(1,:)) max(Data(1,:)) min(Data(n+1,:))-0.01 max(Data(n+1,:))+0.01]);
      xlabel('t','fontsize',16); ylabel(['x_' num2str(n)],'fontsize',16);
      title('GMM 1D Result');
    end
    %plot 2D
    subplot(3*(nbVar-1),2,4+[2:2:2*(nbVar-1)]); hold on;
    plotGMM(Mu([2,3],:), Sigma([2,3],[2,3],:), [0 .8 0], 1);
    axis([min(Data(2,:))-0.01 max(Data(2,:))+0.01 min(Data(3,:))-0.01 max(Data(3,:))+0.01]);
    xlabel('x_1','fontsize',16); ylabel('x_2','fontsize',16);
    title('GMM 2D Result');       
    elseif (isequal(this.mUniqueColors.format,'ddd') || isequal(this.mUniqueColors.format,'rgb'))
        sprintf('The DDD & RGB colour distribution has not yet implemented')
    end
end

if (isequal(this.mUniqueColors.format,'cie') || isequal(this.mUniqueColors.format,'cielab'))
% Get Standard Deviation and Mean of a,b components
    Mu = Mu(2:3,:);
    Sigma = Sigma(2:3,2:3,:);
    stdev = zeros(2,nbStates);
    Corr = zeros(1,nbStates);
    for j=1:nbStates
    %     stdev(1,j) = sqrt(Sigma(1,1,j));
    %     stdev(2,j) = sqrt(Sigma(2,2,j));
        stdev_tmp = real(sqrtm(Sigma(:,:,j)));
        stdev(:,j) = [stdev_tmp(1,1);stdev_tmp(2,2)];    
        Corr(1,j) = stdev(1,j)*stdev(2,j)/Sigma(1,2,j);    
        % For testing the maximum and minimum threshold
    %     nbDrawingSeg = 40;
    %     t = linspace(-pi, pi, nbDrawingSeg)';
    %     X = sqrt(3) * [cos(t) sin(t)] * stdev_tmp + repmat(Mu(:,j)',nbDrawingSeg,1);    
    %     cr = X(:,1); cg = X(:,2);
    %     aResult = exp(-(cr.^2/stdev(1,j)^2/2 + ...
    %                    cg.^2/stdev(2,j)^2/2 - ...
    %                    cr.*cg * Corr(j)/stdev(1,j)/stdev(2,j)));
    %     max(aResult)
    %     min(aResult)
        % End testing
    end
    Sigma = stdev;
    % save('/home/lengoanhcat/Documents/MATLAB/TrafficSignColorClassificati
    % on/TrafficSignHueParams.mat','Mu','Sigma','Corr');
elseif ( isequal(this.mUniqueColors.format,'ddd') || isequal(this.mUniqueColors.format,'rgb') )
    stdev = zeros(3,nbStates);
    Corr = zeros(2,nbStates);
    for j = 1:nbStates
        stdev_tmp = real(sqrtm(Sigma(:,:,j)));
        stdev(:,j) = [stdev_tmp(1,1);stdev_tmp(2,2);stdev_tmp(3,3)];    
        Corr(1,j) = stdev(1,j)*stdev(2,j)/Sigma(1,2,j); % correlation between d1 & d2    
        Corr(2,j) = stdev(1,j)*stdev(3,j)/Sigma(1,3,j); % correlation between d1 & d3
    end
    Sigma = stdev;
end

this.mUniqueColors.Mu = Mu;
this.mUniqueColors.Sigma = Sigma;
this.mUniqueColors.Corr = Corr;

end