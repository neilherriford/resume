# Overview
Simple container for building `PDF` and `docx` versions of my resume
from a source `markdown` file, using a LaTeX template.

Re-creates `PDF` and `docx` document output upon changing the contents
of the `resume.markdown` file.

## Building the docker image
```bash
docker build --tag resume-builder .
```

## Running
```bash
docker run --rm --mount type=bind,src=`pwd`,dst=/resume --name resume-builder resume-builder
```
