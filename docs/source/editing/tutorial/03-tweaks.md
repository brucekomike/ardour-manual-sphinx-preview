# required changes to the template
here is a comprehensive check list for changes you need to make.

## project settings
these files need to be changed as project basics

1. `conf.py` project config
   1. project name
   2. copyright
   3. author
   4. release
   5. language
   6. html_title
   7. html_theme_options
   8. logo
   9. optional math js（
      1.  download from https://www.mathjax.org/#installnow
      2.  place the tex-svg-full.js into `_static`
      3.  un-comment the relative lines in `conf.py`.
2. `_static/page.html` footer links


## contents
folders for sketch
1. `manual`
2. `reference`

folder for editing reference
- `editing`

## add a new section
a script to automate this:
```sh
./bin/new-section.sh <section name>
```
this script creates a subfolder in `docs/source`, then create a index and subpages from 00 to 05