# Whisky Counterfeit
Whisky counterfeit project using microwave sensor and CNN model to classify different samples

## Data from microwave sensor
The data is collected by sweeping a microwave sensor from the frequency of 24GHz to 25.5GHz with the step of 0.1GHz through different whisky samples. All data collected from this step is shown in the image below:
![Untitled](https://user-images.githubusercontent.com/35283897/152506423-5c509785-9eef-4f25-8d30-951a982e0329.png)

## Data processing
From the data above, we cut out five fragments which show the most distinct features among all samples. From these fragments, we mapped the data to image using hsv color map. Example of some samples' images is shown below:
![data2images](https://user-images.githubusercontent.com/35283897/152507552-952f2d6c-fab1-4e12-a6af-852e58924f35.png)

## Classification and Result
We use transfer learning technique with Alexnet as the CNN structure and adam as the optimization algorithm to train the classification model. The result of test images is shown in the following confusion matrix:
![fdsb](https://user-images.githubusercontent.com/35283897/152508428-11e31ca1-7cf1-4f99-9b90-c086849aa6cb.png)
