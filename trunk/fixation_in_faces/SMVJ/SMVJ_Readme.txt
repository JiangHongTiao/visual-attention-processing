Installation:

Extract all to desired directory.

GBVS:

Add gbvs to your path:

    Change into the directory containing this file, and run in matlab:

    matlab> gbvs_install

    If you are on a shared machine, you may get an error message such as:

      Warning: Unable to save path to file '/opt/matlab/toolbox/local/pathdef.m'
       In savepath at 162
       In gbvs_install at 5

    In that case, comment out the savepath (i.e., 'savepath' => '% savepath') 
    command in gbvs_install.m, and add this line to your startup.m file:

    run ???/gbvs_install

    where "???" is replaced by the main gbvs/ directory, which contains the
    gbvs_install function


FaceDetect:

To use the Face detection program you need to set path in matlab to the bin directory of this zip file
"FaceDetect.dll" is used by versions earlier than 7.1 while "FaceDetect.mexw32" is used by later versions
The two files "cv100.dll" and "cxcore.dll" should be placed in the same directory as the other files.


Requirements for compiling:

Matlab 7.0.0 R14 or Matlab 7.5.0 R2007b
Microsoft visual studio 2003 or 2005

Tested on:
Matlab 7.0.0 R14 with Microsoft Visual C/C++ version 7.1 in C:\Program Files\Microsoft Visual Studio .NET 2003
Matlab 7.5.0 R2007b with Microsoft Visual C++ 2005 in C:\Program Files\Microsoft Visual Studio 8

Instructions for compiling:
1. Setup Mex compiler:
   Type "mex -setup" in the command window of matlab. Follow the instructions and choose the appropriate compiler.
   The native C compiler with Matlab did not compile this program. MS visual studio compilers are preferred.
2. Change path to the /src/ directory and issue the command 
   mex FaceDetect.cpp -I../Include/ ../lib/*.lib -outdir ../bin/
   The compiled files are stored in the bin directory. Place these output files along with "cv100.dll" and "cxcore.dll"
   in desired directory and set path appropriately in matlab.

NOTE: compiling with Visual Studio 2005 version 8 compilier requires that a compiler sepcific dll be included along with 
the zip file. All the compiling on this zip are with visual studio 2003 version 7.1 compiler.

Add SMVJ to matlab path.



Usage:

[out] = SMVJ_Main(imagename,params)

imagename is the string name of an image file

if params is left blank then the default parameters are assumed for the saliency map. Use makeGBVSParams to view
the default parameters. To set cumstom parameters use makeGBVSParams and edit as necessary, then enter the structure as params.

the parameter argument:

     * initialized by algsrc/makeGBVSParams.m -- read that for details

      Some sparse notes on fields of the parameter argument:

        the two 'sigma' parameters control the extent to which information can
        travel across the image:

          (1) sigma_frac_act    
              sigma parameter in activation step of GBVS (fraction of image width)
          (2) sigma_frac_norm   
              sigma parameter in normalizaiton step of GBVS (fraction of image width)

        cyclic_type       default is 1. use 2 to have edge weights computed with
                          non-cyclic distance rules. this gives rise to a center bias.
                          
        tol               tolerance parameter. governs how accurately the principal 
			  eigenvector calculation is performed. change it to 
                          higher values to make things run faster.

        levels            the resolution of the feature maps used to compute the
                          final master map, relative to the original image size
                          
        multilevels       determines whether to instantiate one-level or multi-
                          level lattice of graph nodes for each feature map
                          
        useIttiKochInsteadOfGBVS -- set this to 1 to compute Itti/Koch map

Output:

* all put into a single structure with various descriptive fields.
* the GBVS map: master_map
    (interpolated to the resolution of the input image: master_map_resized)
* master saliency map for each channel: feat_maps (and their names, 
    map_types)
* all intermediate maps to create the previous two (intermed_maps)
* if facechannel is selected a further master map: master_map_VJSM
    this is at the resolution of the input image
    a final map ROC_VJSM scaled from 0 to 255 and rounded for use with computeROC

Notes on feature maps:

     * are produced by util/getFeatureMaps.m

     * by default, color, intensity, orientation  maps are computed.

       which channels are used is controlled by the parameters argument. in 
       particular, you can choose which of these is included by editing the 
       params.channels string (see algsrc/makeGBVSParams.m). you can set
       their relative weighting also in the parameters.

       If you want to introduce a new feature channel, put a new function into 
       util/featureChannels/ . Make sure to edit the channels string appropriately. 
       Follow pattern of other channels for proper implementation.

To produce special figures use:

createfigure(imagename,salmap,figureoutput)

where salmap is the output structure of SMVJ_Main

set figureoutput as;
	1 - for figure of image above 75th percentile
	2 - for figure with overlaid saliency map
	3 - for both

If you want to compare saliency maps to fixations (e.g., inferred from
scanpaths recorded by an eye-tracker), use:

[auc] = computeROC(SM,x,y,verbose);
 
 SM: saliency map - integer values between 0 and 255, y,x
 x: fixations x coordinates
 y: fixations y coordinates
 verbose: draw roc 0/1 (default: 1)