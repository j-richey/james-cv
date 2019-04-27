#!/usr/bin/env bash
set -e -u


readonly HELPTEXT="Script for building the example documents.

Supported Commands:
  build         Builds the example documents.
  clean         Cleans the output directory.
  help          Shows the help.

Optional Arguments:
  -h/--help     Shows this help text and exits.

The build process requires the following tools:
 * lualatex
 * pdftotext
 * convert
"


readonly OUTDIR="examples/output"


# Function for building the example resume and cover letter.
function build {

    if [ ! -d "${OUTDIR}" ]; then
        mkdir "${OUTDIR}"
    fi

    lualatex -output-directory "${OUTDIR}" examples/resume.tex
    lualatex -output-directory "${OUTDIR}" examples/cover-letter.tex
    
    # Make text version of the resume to help when uploading to websites.
    # This allows us to copy and paste into the various fields.
    pdftotext "${OUTDIR}/resume.pdf"
    # Remove non printing characters that cause problems. 
    tr -d "\004\f" < "${OUTDIR}/resume.txt" > "${OUTDIR}/resume.txt.tmp"
    mv "${OUTDIR}/resume.txt.tmp" "${OUTDIR}/resume.txt"

    # Make image versions so we can show them from the read me file.
    convert -density 96 "${OUTDIR}/resume.pdf[0]" -flatten "${OUTDIR}/resume-page-1.png"
    convert -density 96 "${OUTDIR}/resume.pdf[1]" -flatten "${OUTDIR}/resume-page-2.png"
    convert -density 96 "${OUTDIR}/cover-letter.pdf[0]" -flatten "${OUTDIR}/cover-letter.png"
}


# Cleans the output directory.
function clean {
    if [ -d "${OUTDIR}" ]; then
        echo "Cleaning ${OUTDIR}."
        rm "${OUTDIR}"/*
    fi
}


# Process the command line arguments. The build command is the default.
if [[ $# == 0 ]]; then
    build
fi

case "$1" in
"build" )
    build
    ;;
"clean" )
    clean
    ;;
"help" | "-h"  | "--help" )
    echo "${HELPTEXT}"
    ;;
*)
    echo "Invalid argument: ${1}" 1>&2
    echo "${HELPTEXT}" 1>&2
    ;;
esac


