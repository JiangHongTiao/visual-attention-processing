# Introduction #



# Details #

## Abstract ##
  * Mimicking the known signal-processing principles in the human brain
  * The proposed system is based on the attention principle: <b> An early task-dependent pre-selection </b> on interesting image regions
  * The behavior control module has a simple structure, but allows performing various tasks.
  * The complexity is distributed over the system in form of <i> local control loops </i> following human cognition aspects.

## Introduction ##
  * Attention subsystem is the center of overal system
  * Proof: A purely saliency-basedf attention generation can assist the driver during emergency situation
  * A proposed system has low complexity system control strategies
  * Complexity is distributed over the system in form of local control loops

## Related Works ##
  * German Transregional Collaborative Research Center "Cognitive Automobiles"
  * ADAS allows a simple bottom-up attention-based decomposition of road scenes but without incorporating object or prior knowledge.

## System Description ##
> Five major parts:
  * "what" pathway analyzes details of a single sport in the image.
  * "where" pathway performs the localization and tracking of a small number of objects.
  * "static domain specific tasks"
  * "environmental interaction"
  * "system control module"

### A. The "what" pathway ###
> A saliency-based map is constructed from
  * RGBY color space
  * Difference of Gaussian
  * Gabor filter kernels

  * The top-down attention can be tuned task independently by applying TD weights with the threshold = Kconj **Max(Fi).
  * The bottom-up (BU) coefficients are set object-unspecifically to detect unexpected dangerous scenes.
  * The system takes the current scene characteristics into account to determine the optimal TD weight set.
  * Compute the maximum on the current saliency map S total.
  * Get the FOA by generic region growing based segmentation.
> Internal information fusion processes improve the performance of system modules.**


## Summary and Outlook ##

  * An integrated, advanced driver assistance system that relies on human-like cognitive processing principles.
  * Based on top-down links modulation the attention task-dependently, the used internal 3D representation is highly flexible system.
