%% Load and explore image data
SpectroDatasetPath = fullfile('C:\Users\shunt\Documents\DATA\Work_HWU_Prof_Demuliez\WhiskyCounterfeit\ImageDataSet');
imds = imageDatastore(SpectroDatasetPath, ...
    'IncludeSubfolders',true,'LabelSource','foldernames');

img = readimage(imds,1);
graph_size=size(img);

%% Specify Training and Validation Sets
[imdsTrain,imdsValidation,imdsTest] = splitEachLabel(imds,0.7,0.15,0.15,'randomize');

%% Define Network Architecture
layers = [
    imageInputLayer(graph_size,'Name','input')
    
    convolution2dLayer(11,2,'Padding','same','Name','conv1')
    batchNormalizationLayer('Name','BN_1')
    reluLayer('Name','relu1')
    
    maxPooling2dLayer(2,'Stride',2,'Name','maxpool_1')
    
    convolution2dLayer(5,3,'Padding','same','Name','conv2')
    batchNormalizationLayer('Name','BN2')
    reluLayer('Name','relu2')
    
    maxPooling2dLayer(2,'Stride',2,'Name','maxpool_2')
    
    convolution2dLayer(3,3,'Padding','same','Name','conv3')
    batchNormalizationLayer('Name','BN3')
    reluLayer('Name','relu3')
    
    fullyConnectedLayer(41,'Name','FC')
    softmaxLayer('Name','softmax')
    classificationLayer('Name','classOutput')];

%% Specify Training Options
options = trainingOptions('sgdm', ...
    'InitialLearnRate',0.01, ...
    'MaxEpochs',60, ...
    'MiniBatchSize',30,...
    'Shuffle','every-epoch', ...
    'ValidationData',imdsValidation, ...
    'ValidationFrequency',20, ...
    'ValidationPatience',30, ...
    'Verbose',false, ...
    'Plots','training-progress');

%% Train Network Using Training Data
net = trainNetwork(imdsTrain,layers,options);

%% Compute Accuracy and classification testing
YPred_Test = classify(net,imdsTest);
YTest = imdsTest.Labels;

accuracy = sum(YPred_Test == YTest)/numel(YTest);
fprintf('accuracy = %f\n',accuracy);

figure(1),
plotconfusion(imdsTest.Labels,YPred_Test),
title('Test Confusion Matrix');

figure(2),
confusionchart(imdsTest.Labels,YPred_Test),
title('Test Confusion Chart');