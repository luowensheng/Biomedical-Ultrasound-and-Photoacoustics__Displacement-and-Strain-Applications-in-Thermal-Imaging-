<p align="center">
    <a href="https://github.com/luowensheng"><img src="https://i.ibb.co/0FmPqfm/logo1a.png"></a>
</p>

<h3 align="center">Principles of Biomedical Ultrasound and Photoacoustics:</h3> 
<h1 align="center">Displacement and Strain – Applications in Thermal Imaging
</h1>
<p align="center">
    <a href="https://www.mathworks.com/products/matlab.html"><img src="https://img.shields.io/badge/Made with-MATLAB-blue.svg"></a>
    <a href="https://github.com/luowensheng/Biomedical_Image_Analysis-Displacement-and-Strain-Applications-in-Thermal-Imaging-/pulse"><img src="https://img.shields.io/badge/Maintained%3F-yes-green.svg"></a>
    <a href="https://github.com/luowensheng"><img src="https://badges.frapsoft.com/os/v2/open-source.svg?v=103"></a>

<p align="center">
  <a href="#Introduction">Introduction</a> •
  <a href="#Goals">Goals</a> •
  <a href="#Tasks">Tasks</a> •
  <a href="#Questions">Questions</a>
</p>
<br>

# Introduction
[(Back to top :arrow_up_small:)](#Displacement-and-Strain-Applications-in-Thermal-Imaging)

One of the techniques for **monitoring focused ultrasound (FUS) thermal therapy** is ultrasonic temperature estimation based on echo-time shift of ultrasound ```radio-frequency (RF)``` signals before and after FUS heating. The echo-time shift mainly
results from changes in speed of sound induced by FUS heating. It is found that the echo-time shift variation (analogy to displacement variation), named as thermal strain, between the two RF signals is linearly proportional to the temperature change δT in tissue, as defined in the following:

><div align="center"><img src="https://latex.codecogs.com/gif.latex?\delta&space;T(z)=\frac{C_{0}}{2}.K.\frac{\partial&space;}{\partial&space;_{z}}\Delta&space;t(z)" title="\delta T(z)=\frac{C_{0}}{2}.K.\frac{\partial }{\partial _{z}}\Delta t(z)" /></a></div>

where C<sub>0</sub> is the initial speed of sound, K is the lumped constant that describes the relationship between temperature and thermal strain <img src="https://latex.codecogs.com/gif.latex?\frac{\partial&space;}{\partial&space;_{z}}\Delta&space;t(z)" title="\frac{\partial }{\partial _{z}}\Delta t(z)" /></a> and the T(z) is the temperature of the medium at the depth z.
 

# Goals
From the equation shown above, the cross-correlation processing can be simply used to estimate the echo-time shift for the estimation of temperature change. In this project, from the provided RF signals in the “FUS_RFData.mat”, the goals are to:

1. Estimate echo time shift in <img src="https://latex.codecogs.com/gif.latex?\mu" title="\mu" /></a>s as a function of depth (analogy to “displacement”) with the cross-correlation processing
2. Estimate thermal strain in % as a function of depth from the echo time shift obtained in point 1.

When performing the cross-correlation processing, the results of point 1 and 2 obtained with different window size M (M = 2, 6, and 10 wavelengths relative to the center frequency) and different overlapping ratio N (N = 0%, 50%, 75%) are compared and justified.

# Tasks
The data given:
<br>
![Data given](https://i.ibb.co/kmqmPkH/1.jpg)

### **1. Estimating echo time shift in <img src="https://latex.codecogs.com/gif.latex?\mu" title="\mu" /></a>s as a function of depth with the cross-correlation processing:**
![2](https://i.ibb.co/XY21Sxf/2.jpg)<br>
![3](https://i.ibb.co/ssYhGqp/3.jpg)<br>
![4](https://i.ibb.co/qMTRmRB/4.jpg)

We see that a smaller window size leads to more noise in the data. Smoothing the data allows us to remove some of the noise. We see that the max echo time shift is over 0.06 for all of the window sizes and overlapping ratios except for when the window size is 38. The smaller window size seems to introduce more noise in the data. 

When we are performing cross correlation between two signals, we can imagine how a small window size may be unable to show the lag between the two signals especially when the lag is large.

### **2. Estimating thermal strain in % as a function of depth from the echo time shift obtained in point 1:**
![5](https://i.ibb.co/Wn3yRS4/5.jpg)<br>
![6](https://i.ibb.co/DCTcmsC/6.jpg)<br>
![7](https://i.ibb.co/4ZcSqR1/7.jpg)

We see that a smaller ratio creates more noise and the noise reduces the accuracy of that data. We see that large window sizes and small overlapping ratio create a cleaner signal and the max strain is larger whereas for a small window size and a large overlapping ratio create the noisiest signal out of them all and we see that the strain given by that combination is smaller.

A lot of smoothing is required when the data is noisy, which can lead to a loss of information, which explains why the different window sizes and overlapping ratios produce different strain results.

The maximum amount of strain that we get is **0.43** and the minimum is **0.022**. 

The idea seems to be that if we want more accurate results, the combination of having a large window sizes and small overlapping ratio seems to generate less noisy data and a higher strain.


# Questions
Submit your questions and bug reports [here](https://github.com/luowensheng/Natural-Language-Processing-Grammatical-Error-Correction-/issues)

<br>
<p align="center">  
  <sub>© luowensheng.
  </a>
 
 
 
