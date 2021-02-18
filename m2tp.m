function [status,cmd_out_str] = m2tp(tikz_fn,fig_size,varargin)
%M2TPREV matlab2tikz preview
%   Generates a PDF preview of a tikz image created by matlab2tikz using 
%   standalone compilation (requires working LaTeX environment).
%
%   (c) 2021 - Markus Kohler
% 
% 
%   INPUTS:
%       tikz_fn:            path to tikz filen to be compiled
%       fig_size:           PDF file size [width, height]
%   PARAMETERS:
%       'fig_size_unit':    PDF file size unit
%       'pdf_fn':           PDF filename
%       'pdf_fn_suff':      PDF filename suffix
%       'tex_wrapper_fn':   LaTeX wrapper file that will be compiled
%       'cmd_out':          CMD output of tex compilation flag
%       'cl_aux_files':     Clean auxiliary files flag
%       'width_def_latex':  Figure height length definition in LaTeX
%       'height_def_latex': Figure width length definition in LaTeX
%   OUTPUTS:
%       status:             LaTeX compilation status
%       cmd_out_str:        LaTeX compilation cmd output string


% Input handling
p = inputParser;
p.KeepUnmatched = true;

% Default parameter values
latex_length_units = {'in','mm','cm','pt','em','ex',...
    'pc','bp','dd','cc','sp'};
default_length_unit = 'cm';
default_pdf_fn = 'm2tp';
default_pdf_fn_suff = '';
default_tex_wrapper_fn = 'm2tp.tex';
default_cmd_out = false;
default_cl_aux_files = true;
default_height_def_latex = '\figureheight';
default_width_def_latex = '\figurewidth';

% Define required inputs and key value pair parameters
p.addRequired('tikz_fn', @(x) isStringScalar(x) || ischar(x))
p.addRequired('fig_size', @(x) isnumeric(x) && numel(x)==2)
p.addParameter('fig_size_unit', default_length_unit,...
    @(x) any(validatestring(x,latex_length_units)))
p.addParameter('pdf_fn', default_pdf_fn,...
    @(x) isStringScalar(x) || ischar(x));
p.addParameter('pdf_fn_suff', default_pdf_fn_suff,...
    @(x) isStringScalar(x) || ischar(x));
p.addParameter('tex_wrapper_fn',default_tex_wrapper_fn,...
    @(x) isStringScalar(x) || ischar(x));
p.addParameter('cmd_out', default_cmd_out,...
    @(x) islogical(x) && isscalar(x));
p.addParameter('cl_aux_files', default_cl_aux_files,...
    @(x) islogical(x) && isscalar(x));
p.addParameter('width_def_latex', default_width_def_latex,...
    @(x) isStringScalar(x) || ischar(x));
p.addParameter('height_def_latex', default_height_def_latex,...
    @(x) isStringScalar(x) || ischar(x));

% Parse inputs
parse(p,tikz_fn,fig_size,varargin{:})

% Compose LaTeX TikZ command strings
length_def = sprintf('\\newlength%s \\newlength%s',...
    p.Results.width_def_latex,p.Results.height_def_latex);
length_set = sprintf('\\setlength\\figurewidth{%.2f%s} \\setlength\\figureheight{%.2f%s}',...
    p.Results.fig_size(1),p.Results.fig_size_unit,p.Results.fig_size(2),p.Results.fig_size_unit);
fn_set = sprintf('\\def\\filename{%s}',tikz_fn);

% Define LaTeX jobname 
job_name = nextname(p.Results.pdf_fn,sprintf('%s1',p.Results.pdf_fn_suff),'.pdf');
[~, job_name] = fileparts(job_name);

% Compile TikZ image with corresponding standalone LaTeX template
comp_cmd_str = sprintf('pdflatex.exe -synctex=1 -interaction=nonstopmode -jobname=%s """%s %s %s \\input{%s} """',...
    job_name,length_def,length_set,fn_set,strrep(fullfile(which(p.Results.tex_wrapper_fn)),'\','\\'));

% cmd output handling
if p.Results.cmd_out
    status = system(comp_cmd_str);
else
    [status, cmd_out_str] = system(comp_cmd_str);
end

if ~status
    % Open compiled PDF
    open(sprintf('%s.pdf',job_name))

    % Clean auxiliary files
    if p.Results.cl_aux_files
        if exist(sprintf('%s.aux',job_name),'file'), delete(sprintf('%s.aux',job_name)), end
        if exist(sprintf('%s.log',job_name),'file'), delete(sprintf('%s.log',job_name)), end
        if exist(sprintf('%s.synctex.gz',job_name),'file'), delete(sprintf('%s.synctex.gz',job_name)), end
        if exist(sprintf('%s.out',job_name),'file'), delete(sprintf('%s.out',job_name)), end
    end

end

end
