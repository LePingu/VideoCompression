close all;
clear all;

%% Loading the folder

addpath(genpath('DCTAndQuant'));


%% Begin Treatment
[I,B1,B2,B3,P] = read_yuv('foreman/foreman_cif.yuv','cif',100,5);

%figure(1),imagesc(I), colormap('gray');
%figure(2),imagesc(P), colormap('gray');

mbSize = 8;

[motionVect, EScomputations] = motionEstimation_FS(P, I, mbSize, 8);
imgComp = motionCompensation(I, motionVect, mbSize);

imgResid = transformAndFilterDCT(P - imgComp);

imgDCTI = transformAndFilterDCT(I);

figure(3),imagesc(imgDCTI), colormap('gray');

P = imgResid+imgComp;

B1R = imgBTreated(B1,imgDCTI,imgPredFinal,0.25,0.75);
