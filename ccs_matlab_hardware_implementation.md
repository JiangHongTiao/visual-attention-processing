# Overview #


# Introduction #

This document is written to collect and organize data / information in DSP Hardware Implementation. It mainly focuses on the integration between MATLAB and CCS. The simulink model is designed in MATLAB and converted directly into C code used by CCS by Code Generation Tool, and several other CCS and MATLAB native softwares.

Testing Platform:

MATLAB 2010a - Full Installation
Code Composer v 3.3 - Version: 3.3.82.13 - SR12 Release
  * BIOS: 5.41.03.17
  * Code Generation Tools: v7.0.1
Target Emulators:
  * Texas Instrument PCI XDS560 Emulator
  * BlackHawk USB 560m Emulator
Camera:
  * Panasonic: SDR-S7
Monitor:
  * Philips: 150 S4

# Setup Steps #

Installation MATLAB 2010A needs following vital products
  * Simulink
  * Video and Image Processing Blockset
  * xPC Target
  * Image Processing Toolbox

Installation of Code Composer v3.3 ( CCS v3.3) - usage of CD-ROM provided in the package of DM642 EVM Module.

After installation is done, CCS v3.3 needs to be updated to the latest patch / fixes provided by the chip manufacturer Texas Instrument - ( It can only be done with a registered account at Texas Instrument )

Note: after buying / receiving any products from TI, the activation step needs to be done in order to upgrade the software )


# Designing Simulink models #

Models which can be directly configured and run on DM642 EVM needs below parameters.

  * **DM642EVM V3 Block** properties
    1. Board -> Board Support -> Libraries -> Little
      * $(Install\_dir)\c6000\csl\lib\cslDM642.lib
      * $(Install\_dir)\c6000\cgtools\lib\rts6400.lib
      * $(MATLAB\_ROOT)\toolbox\idelink\extensions\ticcs\rtlib\dsp\_rt\_c6410.lib
      * $(Install\_dir)\boards\evmdm642\lib\evmdm642bsl.lib
      * $(Install\_dir)\boards\evmdm642\drivers\lib\vport.l64
      * $(Install\_dir)\boards\evmdm642\drivers\lib\audio.l64
    1. DSP/BIOS -> TSK task manager properties -> Default stack size
      * Default stack size (bytes): 4096;

  * Configuration Parameters -> Real-time Workshop:
    1. Compiler options string: this configuration parameters can be automatically extracted from default CCS IDE settings, but --mem\_model:data=far nees to be added to prevent memory errors.

  * 



