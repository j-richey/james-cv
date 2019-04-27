% =============================================================================
% Jame's CV Class
% =============================================================================
% This class provides support for creating resumes and cover letters.
%
% Copyright 2019 James Richey
%
% This class is released under the MIT license.


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{james-cv}[2019/04/11 James's Curriculum Vitae Class]

% Inherit from the article class
\LoadClass[letter,10pt]{article}


% -----------------------------------------------------------------------------
% Required packages
% -----------------------------------------------------------------------------
% These packages are required for this class.
%

% Support PDF URLs and other info.
\RequirePackage{hyperref}

% Use for fancy titles.
\RequirePackage{titlesec}

% For setting the page margins.
\RequirePackage{geometry}

% For setting list spacing.
\RequirePackage{enumitem}

% For multi columns lists.
\RequirePackage{multicol}

% For color support.
\RequirePackage{xcolor}

% For if then else support.
\RequirePackage{xifthen}

% Used for custom bullet styles.
\RequirePackage{amssymb}

% Fonts.
\RequirePackage[opentype]{sourcesanspro}


% Set the default font used.
\setmainfont[Ligatures={NoRequired,NoCommon,NoContextual}]{sourcesanspro}


% -----------------------------------------------------------------------------
% Metadata
% -----------------------------------------------------------------------------
% These macros set metadata on the document. These are used to create the title
% block, the headers and footers, and set the PDF metadata. Configure these
% values in the preamble before the document start.
%
% Ideally these can be defied in a separate tex file and included in your resume
% and cover letter, e.g.: \input{contact-info}
%

% Set your name.
%
% The name is displayed prominently at the top of each page and used in the
% cover letter's signature block.
%
% usage:
%   \name{name}
\newcommand{\name}[1] {%
  \newcommand{\@name}{#1}
}


% Set or get your phone number.
%
% The phone number is included in the header block. Additionally your contact
% information should be included in the text of the cover letter. Thus use
% \thephone to get the phone number used.
%
% usage:
%   \phone{phone-number}
%   \thephone
\newcommand{\phone}[1] {%
  \newcommand{\thephone}{#1}
}


% Set or get your email address.
%
% This is included in the header block as a click-able mailto link. Additionally
% your contact information should be included in the text of the cover letter.
% Thus use \theemail to insert a click-able link in the text.
%
% usage:
%   \email{email}
%   \theemail
\newcommand{\email}[1] {%
  \newcommand{\@email}{#1}
}

\newcommand{\theemail} {%
  \href{mailto:\@email}{\@email}%
}


% Sets your address.
%
% This is included in the header block.
% Note: usually you just include your city, state, and zip.
%
% usage:
%   \address{city-state-zip}
\newcommand{\address}[1] {%
  \newcommand{\@address}{#1}
}

% Sets or gets your personal website.
%
% This is included in the header block as a click-able link.
%
% Use \thewebsite to insert a click-able link in the text.
%
% usage:
%   \website{url}
%   \thewebsite
\newcommand{\website}[1] {%
  \newcommand{\@website}{#1}
}

\newcommand{\thewebsite} {%
  \href{\@website}{\@website}
}


% Set the title of the resume.
%
% This is displayed at the top of the resume and part of the PDF metadata. This
% should match the title of the position you are applying for or at least
% contain similar words.
%
% usage:
%  \title{title}

% Note: the title command is part of our base class, thus we don't need to
% add it here.


% Sets the subject of the cover letter.
%
% Include the position title and any reference numbers. For example:
%   RE: Senior Software Engineer, Listing #12345
%
% usage:
%   \subject{cover-letter-subject}
\newcommand{\subject}[1] {%
  \newcommand{\@subject}{#1}
}


% Optionally sets the name of the hiring manager.
%
% This is used in the address block of the cover letter and in the cover
% letter's opening.
%
% If omitted the name will not appear in the title block and the cover letter
% opening will say "Dear Hiring Manager:"
%
% You can get access to the hiring manager name using \thehiringmanager
%
% Note: this is unused for resumes.
%
% usage:
%   \hiringmanager{name}
\newcommand{\hiringmanager}[1] {%
  \newcommand{\@hiringmanager}{#1}
}

\newcommand{\thehiringmanager} {%
  \@hiringmanager
}

% Sets the name of company you are applying to.
%
% This appears in the address block of the cover letter.
%
% Note: this is unused for resumes.
%
% usage:
%   \companyname{company}
\newcommand{\companyname}[1] {%
  \newcommand{\@companyname}{#1}
}


% Sets the address of the company you are applying to.
%
% This appears in the cover letter's address block. Use \\ to separate the
% street address from the city, state, and zip.
%
% Note: this is unused for resumes.
%
% usage:
%  \companyaddress{address}
%
\newcommand{\companyaddress}[1] {%
  \newcommand{\@companyaddress}{#1}
}


% Optionally sets the accent color of the resume.
%
% A little color makes the resume and cover letter more interesting. Shades of
% blue are populate. Set to black to disable the accent color.
%
% Use \definecolor to define a custom color.
%
% usage:
%  \accentcolor{declared-color}
\newcommand{\accentcolor}[1] {%
  \newcommand{\@accentcolor}{#1}
}
% Set the default accent color
\definecolor{@defaultaccentcolor}{HTML}{003399}
\accentcolor{@defaultaccentcolor}

% Optionally set the margin to the given size.
%
% All margins are set to the same size.
%
% usage:
%   \pagemargin{size}
\newcommand{\pagemargin}[1] {%
  \geometry{left=#1, top=#1, right=#1, bottom=#1}
}

% Set the default page margins.
\pagemargin{0.5in}


% -----------------------------------------------------------------------------
% General Macros and Environments
% -----------------------------------------------------------------------------
% The following macros and environments are useful for both resumes and cover
% letters.

% Inserts a separator elements.
%
% Some environments overload this to insert alternate separators.
%
% usage:
%   item 1 \sep{} item 2
\newcommand{\sep} {\textbar}


% -----------------------------------------------------------------------------
% Resume Specific Macros and Environments
% -----------------------------------------------------------------------------
% This class provides the following macros and environments for creating
% resumes.

% Makes the title block for the resume.
%
% The title block contains the contact information.
% This should be the first thing called after \begin{document}. Additionally,
% this sets the PDF metadata for the resume.
%
% usage:
%   \maketitle

% Macro for creating the Resume title. This also sets the PDF metadata.
\renewcommand{\maketitle} {%
  % Set the PDF metadata since all the values have been provided when
  % The title is created.
  \hypersetup{%
    pdfauthor=\@name,
    pdftitle={\@name{} - \@title{}}
  }

  \@headerblock{}%
  \vspace{0.5em}
  {\centering\formatsectiontext{\@title}\vspace{0.2em}\par}
}

% Command for making just the header block.
% This can be used by other commands that need to insert the header.
% The optional argument sets the page number (replacing the address).
\newcommand{\@headerblock}[1][] {%
  {\Huge\textbf{\textsc{\@name}}\\[-0.2em]}
  {\textcolor{\@accentcolor}{\thickdoubletitlerule}\par}
  {\textbf{#1\hfill\@address\enspace\textbar\enspace
   \thephone\enspace\textbar\enspace
   \theemail\enspace\textbar\enspace
   \thewebsite}\par}%
}

\newcommand{\thickdoubletitlerule}{%
  \titlerule[2.8pt]\\[-0.9em]\vspace{0.0em}\titlerule[1.5pt]%
}
\newcommand{\doubletitlerule}{%
  \titlerule[1.5pt]\vspace{1pt}\titlerule[0.8pt]%
}

% Set the page style of the resume an cover letter.
\newpagestyle{@resumepagestyle} {%
  % We don't do any headers or footers so this is left empty.
}

\pagestyle{@resumepagestyle}


% Inserts a page break and makes the title block for the second page.
%
% The resume uses an explicit page break for the second page.
%
% usage:
%   \makesecondpage
\newcommand{\makesecondpage}{%
  \pagebreak
  \@headerblock[Page \thepage{}]
  % Add some extra space before the contents of the new page.
  \vspace{1em}
}


% Makes a new section heading.
%
% usage:
%   \section{section}
\titleformat{\section}
            {{\color{\@accentcolor}\doubletitlerule}\vspace{-1em}\center}
            {}{0em}
            {\formatsectiontext}

\titlespacing{\section}
             {0em} % Left
             {1.5em} % Before
             {1em} % After

% Text format used for sections.
\newcommand{\formatsectiontext}[1]{%
  \Large{\textbf{\scshape{#1}}}
}


% Macro for listing your key skills.
%
% These are prominently displayed at the top of the resume. Order the skills by
% importance to the position you are applying to. List as many skills as fits
% on a single line.
%
% usage:
%  \keyskills{skill-1 | skill-2 | skill-2}
\newcommand{\keyskills}[1] {%
  % We set the box separation to zero so it does not overflow the text area.
  \setlength{\fboxsep}{0pt}%
  \colorbox{\@accentcolor}{%
    \parbox{\textwidth}{%
      {\vspace{0.3em}\centering\color{white}
       \large{\textbf{\textsc{#1}}}\par}%
    }%
  }%
  \newline
}


% Creates an environment for listing a summary of your key qualities.
%
% These are written as sentences. Use em dashes, ---,  to help break up the
% sentence.
%
% Separate each quality with \sep. This adds fancy symbols between each quality.
%
% example:
%   \begin{summary}
%   This is the first part --- the most awesome part --- of the summary.
%   \sep{}
%   This is the second part --- equally as awesome --- of the summary.
%   \end{summary}
\newenvironment{summary}
{
  % Make a custom separator for the summary section.
  \renewcommand{\sep} {%
    \par\labelitemi\hspace{0.5em}\labelitemi\hspace{0.5em}\labelitemi\par
  }
  \itshape
  \centering
  \bfseries
  % Add some spacing between the paragraphs to make them easier to read.
  \setlength{\parskip}{0.5em}
}
{}


% Command for listing skills in various categories.
%
% Each category of skills should be at most a single line long. It is OK to
% re-list skills that were in the key skills section.
%
% usage:
%  \begin{allskills}
%    \category{category-name-1}{skill-1 \sep{} skill-2 \sep{} skill-2}
%    \category{category-name-1}{skill-1 \sep{} skill-2 \sep{} skill-2}
%  \end{allskills}
\newenvironment{allskills} {%
  \newcommand{\category}[2] {%
    \textbf{\textsc{##1:}} ##2 \\[-0.5em]\par
  }
}
{%
  % Undo the space from the last category.
  \vspace{-0.5em}
}


% Creates a new employment subsection.
%
% Provide the job title, dates of holding that title, the employer, and location
% of the employer.
% usage:
%   \employment{job-title}{dates}{employer}{location}
% Job title macro.
\newcommand{\employment}[4] {%
  \textbf{#1} \hfill \textbf{#2} \newline
  #3, #4
  \\[-0.8em]
  {\textcolor{\@accentcolor}{\hrulefill}\par}
}

% Emphasizes parts of the resume.
%
% This is most useful for emphasizing accomplishments.
%
% usage:
%  \emph{text-to-emphasized}
\renewcommand{\emph}[1] {%
  \textbf{#1}%
}


% -----------------------------------------------------------------------------
% Cover Letter Specific Macros and Environments
% -----------------------------------------------------------------------------
% These macros and environments are used hen when making a cover letter.

% Makes the opening of the cover letter.
%
% If \hiringmanager was defined their name is used here. Otherwise
% "Dear Hiring Manager:" is used.
% usage:
%   \opening[optional-opening]
\newcommand{\opening}[1] {%
  % Set the PDF metadata since all the values have been provided when the
  % opening is created.
  \hypersetup{%
    pdfauthor=\@name,
    pdftitle={\@name{} - \@title{}}
  }

  % Make the header block.
  \@headerblock{}

  % Add extra space between each paragraph. Note: this must come after the
  % header block.
  \setlength{\parskip}{1em}

  % Remove the extra spacing between itemized lists as we already have extra
  % paragraph spacing.
  \setlist[itemize]{topsep=0pt}

  \vspace{1em}
  \@date\par

  % Print the hiring manager's name, if available.
  \ifthenelse{\isundefined{\@hiringmanager}} { } {\@hiringmanager\newline}
  % Print the rest of the contact information.
  \@companyname\newline
  \@companyaddress\par

  \@subject\par

  \ifthenelse{\isempty{#1}}{%
    % Check to see if we know the name of the hiring manager to use in the
    % opening.
    \ifthenelse{\isundefined{\@hiringmanager}} {%
      Dear Hiring Manager:
    }{%
      Dear \@hiringmanager:
    }%
  }{%
    % The user provided an explicit opening, so use that.
    #1
  }%
}


% Makes the cover letter's closing material.
%
% By default this is "Sincerely,". This also adds the closing text and
% signature block.
%
% \closing{[Sincerely,]}
%   Cover letter closing statement. By default this is 'Sincerely,' This also
%   adds the closing text and signature block.
%
\newcommand{\closing}[1][Sincerely,] {%
  #1\newline\par
  \@name
  \par
  Enclosure: R\'{e}sum\'{e}
}


% -----------------------------------------------------------------------------
% Useful Built-in Macros and Environments
% -----------------------------------------------------------------------------
% There are some useful built in macros and environments you can use in your
% resume or cover letter.
%
% Bulleted lists with:
%  \begin{itemize}
%    \item
%   \end{itemize}
%

% Set the default bullet style.
\renewcommand{\labelitemi} {%
  \textcolor{\@accentcolor}{\tiny$\blacksquare$}
}


% -----------------------------------------------------------------------------
% Other Document Setup
% -----------------------------------------------------------------------------
% This section contains other document setup commands.

% Configure the hyperref package
\hypersetup{
  colorlinks=true,       % false: boxed links; true: colored links
  urlcolor=black,        % color of external links
}

% Do not indent paragraphs
\setlength{\parindent}{0pt}
