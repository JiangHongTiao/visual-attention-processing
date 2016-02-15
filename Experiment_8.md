# Overview #



# Details #

# Conversion with Dr Guoping Qiu #

```
[8:00:40 PM] lengoanhcat: hi sir can u hear me ?
[8:00:47 PM] lengoanhcat: i can hear u
[8:03:41 PM] guopingqiu: http://www.afapl.asso.fr/nv30_2.htm
[8:17:24 PM] lengoanhcat: Parzel window ?
[8:18:27 PM] guopingqiu: http://en.wikipedia.org/wiki/Kernel_density_estimation
[8:21:14 PM] guopingqiu: http://en.wikipedia.org/wiki/Hadamard_transform
[8:23:00 PM] guopingqiu: http://www-sop.inria.fr/members/Neil.Bruce/
[8:26:22 PM] guopingqiu: http://www.sciencedirect.com/science?_ob=ArticleURL&_udi=B6V25-4VFJS2S-1&_user=5939061&_coverDate=01%2F24%2F2009&_rdoc=1&_fmt=high&_orig=search&_sort=d&_docanchor=&view=c&_searchStrId=1311061202&_rerunOrigin=google&_acct=C000009959&_version=1&_urlVersion=0&_userid=5939061&md5=1d0da0054977a51c80eb2e9f0f166404
```

Please download [this video](http://www.viplab.cs.nott.ac.uk/download/1.5.mp4)
to see if you can produce a saliency map from it. You will note that there is a white/black square in the video, this is where the driver's eye is fixated. Unfortunately, the location data of the square is not available. See if you could do the following

  1. Automatically locate the square (i.e. find where the eyes are fixated) from the video data (this will be useful, more later)
  1. Calculate a spatiotemporal saliency map of the video.
  1. Calculate the relation between the eye fixation square and saliency features, e.g., whether the square is on a saliency point (the strength of the saliency point), the percentage of times the square is on a saliency point etc

  * Video sample for spatialtemporal saliency is a set of data recorded by Professor Geoff Underwood in the School of Psychology here in Nottingham to study driving safety on board a car.

  * Use saliency score in the vicinity of the square.

  * Put low-pass filter ( smooth ) the map to get rid of noise and only reserve saliency points.

# Conversion with Dr Kenneth #

We can try to test it with PCA, KLT, ICA, DCT in lane-mark extraction.

Figure out how correlated between Psychology data and Computing data.

  1. How many times the square hits saliency points ? ( the percentage of times )
  1. What probability of the saliency point which is hit by the eye-fixated points ? ( the strength of saliency point versus time )

Focus on the experiment 8 with video sample from Prof Guoping Qiu.

Compare the PQFT / Spatiotemporal / Koch algorithm on their eye-gazed fixation database.

Smooth and inpaint first 16 frames of the video for samples by spatial and temporal smoothing.

# Conversation with both supervisors (05/07/2010) #

The redundancy of applying both spatial and temporal saliency map is plausible by both professors. That leads to the requirement of identifying effects of spatial and temporal saliency maps separately. Then, a psychological mechanism needs to be found so as to combine both maps together if these maps fit into experimental psychological data.

Near future goals and research questions

(Dr. Kenneth)
How can I choose a suitable window size for spatial-temporal saliency ? Hint: comparing the spatial-temporal algorithm with center-surround mechanism of Itti method.

  * Answer: center belongs to {2,3,4} , theta belongs to {3,4}, surround = center + theta; therefore center-surround pairs belongs to {2-5, 2-6, 3-6,3-7, 4-7, 4-8}. Window size is the ratio between surround and centers {2.5,3,2,2.33,1.75,2} whose average is 2.26.

Comparison between Spatial, Temporal and Itti method

  * Answer: the comparison can be made on the fixations in faces database.
    * Criteria for evaluating the saliency map
      1. Extract salient objects in Videos and Images
      1. Predict the Human Eye Fixations: receiver operating characteristic (ROC) is recently used to predict human eye fixations in natural images.
      1. Image Sequences
      1. 

Spatial-Temporal Itti model

# Conversation with Dr. Kenneth (20/07/2010) #

Question: Does saliency result of spatial temporal saliency depend on the intensity value ?

Answer:

Question: Should kdensity produce the pdf with summation 1 ?

(Dr Qiu)
Automatically video processing program for various saliency algorithms ? Hint: develop a native code of programs so as to run faster.

Far future goals and research questions:

Overlay of points: Spatial-temporal PFT

# Le Ngo Anh Cat 's idea #

Buying the EMR-9 device of NAC to carry out the experiment in UNMC
Advantage: softwares and hardware are ready for you
Disadvantage: expensive, low-customizable.

Build an eye tracking system from Open-Source Project - http://www.gazegroup.org/
Advantage: inexpensive, usage of what we have done so far - camera, video database
Disadvantage: time consumption, not reliable eye-gazed database.

Contact psychology department in Nottingham, Malaysia to ask for their help on eye-gazed system.

# Experiments #

Sample video preparation

  * The video has been modified to remove eye-tracking marks, and almost all marks have been removed from the original video
    * Pros: no marks effect the simulation results
    * Cons:
      1. Marks can not be completely removed, therefore the scenes seems to be unnatural.
      1. The quality of videos are degraded too much
    * Solutions:
      1. New driving videos need taking in order to overcome the difficulties.
      1. Find the way to remove marks but do not downgrade the video quality.
    * Results: video 1.5\_repainted\_20100525T115516\_full\_modification\_4.avi

  * The infoSpatioTemporal Saliency Map is created and saved under video format.
    * Pros:
      1. The saliency maps are saved as videos which can be used as inputs of later experiments
      1. The storage space is saved tremendously.
    * Cons:
      1. The original values of saliency maps are floating points; however, they have to be converted into integer so as to be stored as video.
    * Results:
      1. Folder: 1.5\_engine-hadamard\_nc-30\_date-20100525T145555 - for marked video
      1. Folder: 1.5\_repainted\_20100525T115516\_full\_modification\_5\_engine-hadamard\_nc-30\_date-20100630T160423

  * After using evaluationSM1 method, following statistic data has been collected:
> > pctFrames\_maxsSaliency: 0.0200
> > pctFrames\_minsSaliency: 0.3700
> > avgPctScore\_avgsSaliency: 0.2912


  * Test the spatialTemporal saliency with different size of window M = 2,4,8.
    1. M = 8, the temporal saliency map is totally a black out. It is due to the fact that there is too much difference between framess
    1. M = 4 it is the right size for windows
    1. M = 2 the image are divided into too many pieces then it takes a lot of time for processing

  * Testing the spatial information only. After running spatial information on some samples, it is seem that resizing image into smaller size affect results. Therefore, the image won't be resized when they are put into spatialSaliencyMap function
    1. M = 8: the result comes out nicely
    1. M = 4: some gray-part of the road comes out as infinity values.

  * The spatial saliency works well with videos and frames captured by normal cameras, however, it may not works with the high quality images.

  * After running spatial information saliency on synthesized samples, black\_img, white\_img, hybrid, the saliency value depends on the grayscale values of these pixels. The brighter the pixels are, the larger their saliency values are.
# Results #

Add your content here.  Format your content with:
  * Text in **bold** or _italic_
  * Headings, paragraphs, and lists
  * Automatic links to other wiki pages