# Introduction #



# Details #

## Abstract ##

> This paper presents a low memory visual saliency algorithm for implementation in hardware constrained environments.
> A low memory algorithm is described as following:
  * An image is first partitioned into image strips and then the bottom-up visual saliency is applied to each of the strips.
  * The strips are recombined to form the final saliency map.
  * The Gaussian pyramid is replaced with a hierarchical wavelet decomposition using the lifting based 5/3 Discrete Wavelet Transform (DWT).

## Introduction ##

> A low memory visual saliency algorithm for implementation in hardware constrained environments:
  * An image is first paritioned into image strips.
  * The size of the memory buffer used in storing the image during processing can be significantly reduced.
  * Using the wavelet decomposition method, a lower resolution approximation of the image at the previous level can be obtained along with the orientation sub-bands.

## Low Memory Strip Based Visual Saliency ##

> An overview of the low memory strip based approach is
  1. The input colour image of size Y rows x X columns is first partitioned into N number of strips of size R rows x X columns.
  1. The output of the VS model is a saliency strip which are added to an empty location in input image.
  1. In the VS algorithm, the DWT is used to construct the image pyramid but in this paper, the lifting based DWT method is preferred over the conventional convolution based DWT due to computational efficiency and memory savings.

> Trade-offs of the method are:

  1. **Trade-off 1:**
    * **Problem:** if just enough lines are used in a strip for the DWT decomposition, _horizontal line artifacts_ will appear in this method.
    * **Solution:** Additional overlapping lines are used to avoid _horizontal line artifacts_.
  1. **Trade-off 2:**
    * **Problem:** min-max normalisation is inaccurate.
    * **Solution** the minimum and the maximum values are stored and used to the next input images.

### Lifting Based 5/3 Discrete Wavelet Transform ###

> Outputs of the lifting based 5/3 DWT are indexed by either odd or even terms.
  * Odd terms are the high pass output
  * Even terms are the low pass output

> The lifting based implementation consists of three steps: 1) split; 2) predict and 3) update.

### Image Pyramid Construction and Minimum Required Lines ###

  * **The wavelet decomposition method** is used instead of the dyadic Gaussian pyramid.
  * The number of lines in the strip is dependent on the number of scales and how intense the user wants the salient object to be highlighted. The value of J varies accordingly. A higher value of J would require more lines in a strip
  * J = 3, minimum number of strips 8 + 8 ( additional strips ) = 16 lines. The total number of lines required is 32 for a three level decomposition.
  * Minimum number of lines = 2 x 2^(J+1)

## Bottom-up Visual Saliency Algorithm ##

> The bottom-up visual saliency algorithm which is used in the original non-strip and the strip based approach

### General Visual Saliency Algorithm ###

> Input images are YCbCr colour space which have 3 channels and the lifting based 5/3 filter is applied to each of the Y, Cb and Cr channels.
> Each sub-band will have size down-sampled by a factor of two
  * The LL band of the Y channel is used to compute the intensity feature.
  * The other three sub-bands: HL (vertical detail, V); LH ( horizontal detail, H); and HH(diagonal detail, D) will be used for computation of the orientation feature.

### Modification for the Strip Based Approach ###

> The overall Visual Saliency algorithm is the same with a few exceptions of the image pyramid and the normalization method.

  * To overcome the problem of _horizontal line artifacts_, overlapping is done at the pyramid construction level.
  * With overlappipng, the number of lines is 32. After the decomposition, the no of lines is 16.
  * 8 center lines are the only lines needed for computation while the top and bottom 4 lines are discarded.

> The algorithm allows the minimum and maximum to update itself to be used for subsequent strips and image frames.
  * The global values are compared with the local minimum and maximum of the strip. If the maximum value of strip is higher than the current global maximum, the global will be updated.

## Simulation Results and Discussion ##

> Results are simulated in MATLAB using Intel Centrino Duo 2.2 GHz processor with 2GB RAM. 20 image strips are used with overlapping, resulting in a 32 line strips. All test images are of size 320x480.

### Results ###

> Images

### Discussion of Results ###

  * With successive image frames, the contents in the frame would not change drastically in normal conditions; therefore, the min-max updating and normalising method provide a rather accurate estimation.

> To investigate the amount of memory saved using the approach, consider a memory bank having many memory blocks.

  * Non-strip saliency-based techniques can save at least 80% usage of memonry comparing to the original non-strip saliency techniques.

## Conclusion ##

  * A low memory VS using image strips for implementation.
  * The proposed strip performs as well as the non-strip approach while saving memory resources up to more than 80% depending on image size.