# FGM-NW
This readme file explains the purpose of each code in this project:

1.  "eFGMstructure.m", "pFGMstructure.m" & "sFGMstructure.m"

    These codes will create the lammps struct files required for both the tensile and vibrational tests
    in seperate folders for each NW.

2.  "tensile.in" and "vibration.in"

    These are input scripts to be put in all the above created folders to carry out the vibrational
    and tensile tests necessary.

3.  "myplot.m"

    This is a plot styling function that will be called in all the codes below. This function comes with
    explanatory comments on how to use it, and the user may also tinker it to their own liking for font
    size, axes thickness, figure resolution and the like. The default setting is very well suited for 
    most publications as most of it is actually derived from "plotpub" which is also available in Github.

4.  "graphs_E_UTS.m", "bounds.m" and "plotU.m"
    
    The first file plots the stress-strain graphs and calculates the elastic moduli and ultimate tensile
    stress (UTS) values and stores them in cells in the workspace.
    The second file takes data that the first file has stored on workspace and uses them to plot the
    elastic moduli of the NWs and compares them with the different bounds (Voigt,Reuss,etc.).
    The third file simply plots the UTS values.
    The first file calls the other two files in its last two lines so it is recommended to download all
    3 together. However, if someone wishes to only plot stress-strain and store the E and UTS values in
    workspace alone, they can download just the first file and erase the last two lines from it.
    
5.  "FFT.m"

    FFT.m calculates the natural frequency of the NWs using the results of the vibrational tests applying
    MATLAB's fast fourier transform and plots the amplitude of DFT graph. 
    
6.  "plot_F_and_theoretical.m"
    Plots the natural frequencies obtained in this study and compares them with the theoretical models
    of Euler and He-Lilley.

