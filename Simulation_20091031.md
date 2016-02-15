# Introduction #



# Details #

## Plan ##

Experiment 1 : Running the simulations and collect how many times the machine can get the correct positions of objects ( lane marks and vehicles )

Experiment 2 : Running the watershed region-segmentation on vehicle & lane sample image

## Input Data ##

Experiment 1 : There are three input video: blurredVideo.avi, clearVideo.avi, shadowyVideo.avi

Experiment 2 : There are two small sample images: lane.png, vehicle.jpng

## Simulation ##

Experiment 1 :

ezvision -K --in=path/[video](video.md).avi --out=raster:path/ --output-frames=0-30@EVENT

-K shows all necessary steps before the attention point is extracted
--output-frames=0-30@EVENT: give 31 output frames and the frame is generated when the attention point is shifted.

Experiment 2 :

Run region\_detection.m with each sample.

## Output Data ##

Experiment 1 :

I have created to store output frames of three input videos and following tables show the simulation results

| **Video Name** | **No times of vehicle attention** | **No times of lane marks attention** |
|:---------------|:----------------------------------|:-------------------------------------|
| Blurred\_Videos | 8/30                              | 6/30                                 |
| Clear\_Videos  | 8/30                              | 14/30                                |
| Shadowy\_Videos | 5/30                              | 11/30                                |

Experiment 2 :

## Conclusion ##

After three testing cases, we can generally conclude that visual saliency alone can not act as vehicle / lane detectors well.