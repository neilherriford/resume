# Overview
Simple container for building `PDF` and `docx` versions of my resume and cover letters
from source `markdown` files, using LaTeX templates.

## Layout
- `input/`: markdown sources
- `output/`: built `PDF` and `docx` files, mirroring `input/`
- `templates/`: `resume.tex` and `cover-letter.tex`
- `bin/`: `watcher.sh` and `build.sh`

Files named `cover-letter*` use the cover letter template, everything else uses the resume template.
`input/foo.ltd/resume.markdown` builds to `output/foo.ltd/resume.pdf` and `output/foo.ltd/resume.docx`.

## Building the docker image
```bash
docker build -t resume-builder --progress plain .
```

## Running
```bash
docker run --rm --mount type=bind,src=`pwd`,dst=/resume --name resume-builder resume-builder
```

Builds everything stale on start, then rebuilds when anything in `input/` or `templates/` changes.
New files in `input/` are picked up automatically.

## Credits
Resume template based on John [Bokma's template](https://github.com/john-bokma/resume-pandoc)
