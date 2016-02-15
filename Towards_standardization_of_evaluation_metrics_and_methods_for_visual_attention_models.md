# Overview #



# Details #

## Abstract ##

  * Need to have standard measurement techniques in visual attention models
  * This paper: a review of the evaluation techniques
  * Propose new methods and metrics

## Introduction ##

  * Lack of standard metrics and methods for measuring and evaluating outcome of models
  * This paper attempts to design standard metrics for evaluation of visual attention
  * Questions
    1. Aspects of attentions (AA) Ex: evaluation of an attentive visual research, free viewing
    1. Evaluation aspect (EA) Ex: comparing with natural attention or competence of specific tasks
    1. Output format (OF) Ex: scanpaths or fixation spots
    1. Perspective of results (PR) Ex: evaluation aspects
    1. Measurement methods (MM) to extract readings

## A Survey of Available Techniques ##

  * Acceptability = number of fixation before attending targets
  * Normalized scan path salience = compare saliency map with human eyes' fixation
  * False fixation before focusing on the place of required objects
  * Fixations and locations
  * Examine the down-sample resolution
  * Hybrid approach
  * Same features attended whether or not the scene are changed
  * Form of the standard distance h(A,B) = median(min|a-b||2)|
|:--|

## Analysis ##

> Five questions for analysis:

  1. AA aspects of attentions -> B (bottom-up), T (top-down), N (pathway-neutral)
  1. AE aspects of evaluation -> V (validation test), C (Competence-test)
  1. OF output format -> M(saliency map), F(fixation points), P(scan-path)
  1. PR perspectives of results -> L (location), S (saliency magnitudes), O(order of sequence)
  1. MM measurement methodology -> E (equivalence), D (feedback), R (attention mode)

## Proposed methods and metrics ##

> Range: 0 - 1 0 worst and 1 best
> Metric: measure model's performance against known number and location of targets

### Competence test ###

  * NS ( number of embedded salient objects ) / NF ( number of object found )
  * NS (number of salient objects ) / NA (number of times until required targets are covered )

  * Compare the sequence of ROIs by humans and algorithms
  * 2 methods of temporal anaylysis head-based and time-based
    * Head-based: locate sequence of still images
    * Time-based: duration for fixation 100ms

  * Score-S metric: higher score for fixation point along the scan-path

  * Evaluation by comparing saliency maps to a benchmark maps

> md = matching points
> Nd = total compared points
> md / Nd = similarity measure in direction

  * Counting the number of FOA nits and misses
  * Count = hit: if half of the targetr inside FOA; miss: otherwise
  * Completeness = undetected targets / detected targets

  * Performance of top-down search systems: 2 metrics
    * u(fixations / search ) less tries / target is more successful
    * u(search time) : shorter search time is successful
    * Metric of detection rate
    * Metric of number of attentional shifts before targets
    * Metric of erroneous fixations wrt the total number of targets

### Validation test ###
## Sample Implementation ##
## Conclusion ##

  * A survey of existing techniques
  * New methods are proposed that serves the purpose of advancing towards the standardization
  * Simplicity of easiness to avoid influence of non-relevant factors
  * Standardize the shape and size of saliency spots and fixation windows
  * Standardize image size and resolutions

Add your content here.  Format your content with:
  * Text in **bold** or _italic_
  * Headings, paragraphs, and lists
  * Automatic links to other wiki pages