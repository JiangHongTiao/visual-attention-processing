# Overview #



# Details #
## Abstract ##
> This research paper addressed a novel visual attention model and watershed segmentation based approach of Regions of Interest (ROIs). <br />
> This approach uses visual attention model to locate salient points, and these are selected as as the seed points of watershed segmentation. <br />
> The experimental result shows that the proposed method is effective to reduce the watershed foverimplementation.

## Introduction ##

> Content-based image retrieval (CBIR) has a challenging issue: how to deal with the significant semantic gap bwetween the **low-level image features** and **high-level semantic** concepts.

> One of the solution to retrieve the high-level semantic concepts is the detection of ROIs by region extraction and interest measurement.

> Although visual attention model is able to detect ROIs, the detected boundary is rarely accurate, it is difficult to identify its high-level semantic concept.

> In this paper, the approach learn from both visual attention models and watershed transform in order to deal with the object extraction issues.

<blockquote>
<blockquote>The result "saliency map" of visual attention is repaired by the watershed segmentation in order to deal with the <b>object extraction issues</b>. Meanwhile, we utilize the winner point in saliency map as the seed point of watershed segmentation to find attended object and the combine with saliency map to reduce over-segmentation affects.<br>
</blockquote></blockquote>

## The proposed ROIS Extraction Method ##

> The papare uses the watershed transformation proposed by Vicent and Soille which is based on immersion simulation.

> A closed, one pixel-wide contours or surfaces care produced by the technique which is based on the assumption that image contours correspond to the crest lines of the gradient magnitude image.

> Images are segmented into visually sensible regions by locating watershed regions, the winner points of visual attention model are used to measure interest of regions and determine ROI.

> The feature saliency is obained by the difference of Gaussian (DOG).

> The total saliency S is expressed under following forms: S = wI.N(I) + wC.N(C) + wO.N(O)

> where weights will be decided at the time users provide interested features.

## Experimental results ##

> The proposed approach makes the extracted boundary closer to object with no noise. Computation time is nearly equal to one of visual attention model.

## Conclusion ##

> This method combine strong points and delete weak points of both visual attention models and watershed segmentation. The mechanism can be applied in related research fields such as image compression, video surveilance and human-computer interaction.

# Comments #

This paper represents a potential way of combining watershed transform and visual attention. We should combine our watershed transform and visual attention to get justify the results.