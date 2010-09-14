    ---------------------------------------------------------
    "kdpee" - k-d paritioning entropy estimator.
    (c) 2008-2010 Dan Stowell.
    All rights reserved.
    ---------------------------------------------------------

ABOUT

"kdpee" is a fast multidimensional entropy estimator implemented in C, and 
with a mex binding for use in Matlab or GNU Octave.

Its theoretical background is described in the following academic paper:

	@article{Stowell:2009d,
		Author = {Stowell, D. and Plumbley, M. D.},
		Title = {Fast multidimensional entropy estimation by k-d partitioning},
		Journal = {{IEEE} Signal Processing Letters},
		Year = {2009},
		Month = {June},
		Number = {6},
		Pages = {537--540},
		Volume = {16},
		Keywords = {Entropy, estimation, multidimensional systems, multidimensional signal processing},
		Doi = {10.1109/LSP.2009.2017346}
	}


INSTALLATION

Copy this folder and its files to a convenient location in your Matlab/Octave
path.

The "mexme.m" script encapsulates a typical command to be run in Matlab or
Octave, which will compile the C function for your computer. Use "cd" to 
change to the main kdpee directory and then run "mexme.m".


USAGE

The main function is named "kdpee". In Matlab/Octave type "help kdpee" to
see usage information.

This simple example estimates the entropy of a 3D dataset with 10 data points:

  kdpee([3 4 5; 6 5 7; 6 5 4; 5 8 7; 3 5 4; 7 6 8; 9 8 7; 5 4 3; 5 5 5; 5 6 7])

(In real use you would generally want many more data points than this.)

The download includes a function "pairwiseMI" which we use to estimate
pairwise mutual information from data held in a CSV data file. This may serve
as an example of kdpee usage, or maybe you'll find it directly useful.


COPYRIGHTS

    kdpee is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    kdpee is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with kdpee.  If not, see <http://www.gnu.org/licenses/>.

