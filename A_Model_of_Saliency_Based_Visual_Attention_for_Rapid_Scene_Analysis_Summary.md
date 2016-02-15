# Overview #

> 

# Details #

  * Abstract
> Multiscale image features are combined into a single topographical saliency map
> A dynamical neural network selects attended locations in order of decreasing saliency.

> ## Introduction ##
> Primates gain the remarkable ability to interpret complex scene in real-time system during million years of evolution. Despite the limit of human brains, it seem to be done by using the "focus of attention", circumscribed region. After the region is discovered  by a rapid, bottom-up, saliency driven, and task independent manner, a slower top-down, volition-controller, and task dependent manner such as lane detection and tracking will be used to find specific objects.

> The "feature itegration theory" built on a second biologically plausible architecture proposed by Koch and Ullman, explains human visual search strategies. At beginning, different spatial locations compete for the saliency and builds their own feature maps ( saliency maps for each feature ). Then all feature maps are integrated into a single "saliency map" which represents local conspicuity over the entire image.

> This model shows us the complete bottom-up saliency visual attention method without any prerequisite knowledge. However, it is flexible enough to be combined with any top-down guidance to shift attention. The prior knowledge is usually used to weight the importance of different features; therefore, those with high-weights could persist.

> ## Models ##

> Input, 640x480 static color images, are processed by **dyadic Guassian pyramids**, to create 9 spatial scales ranging from 1:1 (scale sero) to 1:256 (scale eight).
> Each features such as colors, intensity, and orientations is computed by a set of linear **"center-surround" operations** akin to visual receptive fields.

> Center-surround is implemented in the model as difference between fine and coarse scales:
    * The center c is a pixel at scale {2,3,4}.
    * The surround s is a pixel at scale {3,4}.
    * The across-scale difference between two maps is obtained by **interpolation to the finer scale and point-by-point substraction**.

> ### Extraction of Early Visual Features ###
> Intensity image is created by normalizing three color channels R(red), G(green), B(blue):
> I = (R+G+B)/3;
> Four broadly-tuned color channels are created:
    * R = r - (g+b)/2
    * G = g - (r+b)/2
    * B = b - (r+g)/2
    * Y = (r+g)/2 - |r-g|/2 - b
> The features - intensity and 4 broadly-tuned color channels - are created for each scaled images, R(l) G(l) B(l) I(l) where l = [0..8]

> Applying the **center-round** operations for intensities:
> I(c,s) = I(c) o I(s) where c = {2,3,4}, s = {3,4}

> and creates 6 intensity feature maps.

> In biologically visual systems, a so-called "color double-opponent" system exists. In the center of their receptive fields, neurons are excited by one color and inhibited by others, and reverse situations happens in the surround. The color double opponent exists for red/green and blue/yellow color pairs; therefore, the center-round operations are applied for these pairs of colors:

> RG(c,s) = | (R(c) - G(c)) o (G(s) - R(s))| <br />
> BY(c,s) = | (B(c) - Y(c)) o (Y(s) - B(s))|

> and create 12 color feature maps

> The local orientation information is obtained from image intensity using oriented Gabor pyramids O(x,theta) where theta = {0,45,90,135}. Orientation feature maps are contrast between center and surround scales:

> O(c,s,theta) = | O(c,theta) o O(s,theta) |.

> and creates 24 orientation feature maps

> Totally, 24 + 12 + 6 = 42 feature maps are created in the "Feature Extraction Process"

> ### The Saliency Map ###

> In this step, 42 features are combined into a single saliency maps where each pixels represents a scalar quantity to guide the selection of attended locations. Though 42 maps are used, salient objects are shown strongly in a few maps while the others contain noises. Thus, a map normalization, which glbally promotes maps with small number of strong peaks while globally suppressing maps which contain comparable peak response.

> Feature maps are combined into three "conspicuity maps" I at scale 4 by **across-scale addition**. The idea of using across scale addition comes from the hypothesis that similar features compete strongly for saliency. While different features contributes independently into the saliency map:

> S = 1/3(N(I) + N(C) + N(O));

> At any given time, the saliency map (SM) defines the most salient image location which the focus of attention should be directed. The Saliency Map (SM) is modelled as leaky integrate-and-fire neurons. Each SM neuron excites its corresponding WTA neuron which evolves independently of each other. Whenever the threshold is reached by a WTA neuron, a sequence of three simultaneous mechanisms are triggered:

  1. FOA is shifted to the location of the winner neuron
  1. The global inhibition of the WTA is triggered, in other words, all WTA neurons are reset
  1. Local inhibition is transiently activated in the SM. It allows the next most salient location become the winner and prevents FOA from immediately returning to a previously-attended locations.

> ## Results and discussion ##
> ### General performance ###
> When a targe differed from the surrounding distractors by its unique orientation, intensity, color, it was always first visited. Contrarily, when the target differed from the distractors by a conjunction of features (e.g, it was the only **red horizontal** bar in a mixed of **red vertical** bars and green **horizontal bars**, the search takes more time to find a target.

> The model, like human eyes, attracted to "informative" image locations according to the assumption that regions with more spectral content have more "information".

> ### Strengths and limitations ###

> Simple architecture and feed-forward feature-extraction mechanisms are capable of strong performance with complex natural scenes.

> While the systems immediately detects a target which differes from surrounding distractors by its unique size, intensity, color, or orientation, it will fail in at detecting objects salient at unimplemented features such as contour, closure, and magnocellular motion.

> A critical model component is the normalization N() which provides a general mechanism for computing saliency in any situation.

> The framework presented here can consequently be easily tailored to arbitrary tasks through the implementation of dedicated feature maps.

# Comments #

> As the strength and limitation parts of the summary has mentioned, the framework can be integrated with any new features. We can used region-based approached methods to create a specific feature maps, then tailoring the framework to work with the "region-based features". Any new frameworks should inherit from this simple but efficient approach.