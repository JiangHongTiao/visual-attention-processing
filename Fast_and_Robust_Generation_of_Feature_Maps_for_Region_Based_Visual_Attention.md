# Overview #




# Details #

## Abstract ##

> This article propose clustering prior to the process of visual attention in contrast to previous methods using late clustering.

> Color contrast map, symmetry map, and size contrast map are constructed as formal feature channels

> The solution can be efficiently integrated into main stream of machine vision for limited computing resources such as mobile robots.

## Introduction ##

> Requirement: a robust intelligent algorithms for analysis and recognition
> Solution: integrate feature maps for color contrast, orientation, eccentricity, symmetry and size for a region-based model.
> It accelerates the internal processes of attention and helps to bring attention into more harmony with machine vision systems.
## Problem Definition ##

> Both approaches: linear center round / frequency domain filter loses actual shapes of objects.
> Feature computation are computationally heavy while coarse scales may lose some important details
> The already known object inhibition requires the exact shape.
> Solution
  * Obtain the cluster of pixels belong to each other
  * Apply the attention related procedures on these regions.
> Need to develop an efficient and robust methods for construction of early feature maps using existing regions

## Existing methods ##
### Pixel-based approach ###
> Leads to fuzzy activity clusters
### Frequency Domain approach ###
> Leads to fuzzy activity clusters
### Region-based approach ###
> The region-based techniques lack robustness and ultimately blend feature maps of pixel-based and frequency domain techniques. They are rarely implemented in existing methods.

## Proposed methodology ##
### Color Contrast Saliency ###
### Size Saliency ###
### Symmetry Feature ###
### Orientation and Eccentricity Feature ###
### Saliency Maps of Symmetry, Orientation, and Eccentricity ###
## Results ##

## Discussion ##
## Conclusion ##