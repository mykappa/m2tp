# m2tp
matlab2tikz standalone PDF preview

## Purpose
`m2tp` lets you generate a PDF preview of a TikZ image created by matlab2tikz directly from MATLAB&reg;.

The basic idea is to be able to view and adjust graphics as you create them without having to switch back and forth between MATLAB&reg; and your LaTeX editor. The potentially time-consuming iterative adjustment process of the TikZ graphic in the main LaTeX document can thus be avoided.

## Getting Started

### Prerequisites
* [matlab2tikz](https://github.com/matlab2tikz/matlab2tikz)
* Working and up-to-date LaTeX environment with the following packages:
    * [TikZ/PGF](https://ctan.org/pkg/pgf) version 3.0 or higher
    * [pgfplots](https://ctan.org/pkg/pgfplots) version 1.13 or higher
    * [amsmath](https://www.ctan.org/pkg/amsmath) version 2.14 or higher
    * [standalone](https://www.ctan.org/pkg/standalone)
    * [hyperref](https://www.ctan.org/pkg/hyperref)

### Installation
1. Extract ZIP file or clone repository to a convenient location
2. Add directory to MATLAB&reg; path (*optional*)

## Usage
1. Create plot in MATLAB&reg;
2. Generate TikZ file with `matlab2tikz`
3. Preview TikZ file as PDF document with `m2tp`

### Example
```matlab
% Plot data
x = 0:0.01:2*pi;
y = sin(x);
figure
plot(x,y)

% Create TikZ image
matlab2tikz('my_tikz_image.tikz')

% Preview Tikz image
fig_width = 10; % pdf image width in cm
fig_height = 3; % pdf image height in cm
m2tp('my_tikz_image.tikz',[fig_width,fig_height])
```

### Remarks
Please note how matlab2tikz handles the dimensions of the output PDF file &mdash; see e.g. matlab2tikz issue [#1090](https://github.com/matlab2tikz/matlab2tikz/issues/1090).


## License
This project is licensed under the MIT License &mdash; see the LICENSE.md file for details.

## Acknowledgement
`m2tp` uses Stephen Cobeldick's [nextname](https://www.mathworks.com/matlabcentral/fileexchange/64108-next-available-filename) from the MATLAB&reg; Central File Exchange for PDF filename handling.
