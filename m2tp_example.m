% Start clean
close all
clear

% Generate random plot(s)
numdata = 100;
dt = 0.01;

% Define number of subplots
spx = 1;
spy = 1;

figure
for i_sp = 1 : spx*spy
    x = 0 : dt : (numdata-1)*dt;
    y = 10 * randn(1, numdata);
    subplot(spx, spy, i_sp)
    plot(x, y)
    xlabel('$x$')
    ylabel('$y$')
    title('m2tp example')
    legend('data $d_{y}$')
end

% Define path and filename
path = '.\';
name = 'm2tPrev';
ext = '.tikz';

filename = [name, ext];

% Generate tikz file
matlab2tikz('filename', filename,...
    'height', '\figureheight',...
    'width', '\figurewidth',...
    'encoding', 'UTF8',...
    'showInfo', false,...
    'checkForUpdates', false,...
    'parseStrings', false,...
    'floatFormat', '%.4g',...
    'noSize', false,...
    'extraAxisOptions', 'enlargelimits=false');

% Define figure width and height for preview
figurewidth = 12;
figureheight = 5;
figuresize_unit = 'cm';

% Set file parameters
job_name = 'tikz_file';
tikz_fn = filename;
fig_size = [figurewidth, figureheight];
fig_size_unit = figuresize_unit;
pdf_fn = job_name;
pdf_fn_suff = '_prev';
cmd_out_flag = false;
cl_aux_files = true;
width_def_latex = '\figurewidth';
height_def_latex = '\figureheight';
tex_wrapper_fn = 'm2tp_custom.tex';

% Compile tikz picture and show pdf preview
% m2tp(tikz_fn, fig_size);
m2tp(tikz_fn,fig_size,...
    'fig_size_unit', fig_size_unit,...
    'pdf_fn', pdf_fn,...
    'pdf_fn_suff', pdf_fn_suff,...
    'tex_wrapper_fn', tex_wrapper_fn,...
    'cmd_out_flag', cmd_out_flag,...
    'cl_aux_files', cl_aux_files,...
    'height_def_latex', height_def_latex,...
    'width_def_latex', width_def_latex);
