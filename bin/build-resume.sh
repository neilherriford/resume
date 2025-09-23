#!/bin/bash

# Cleanup
[ -e $PDF_OUTPUT ] && rm $PDF_OUTPUT
[ -e $DOCX_OUTPUT ] && rm $DOCX_OUTPUT

markdown_path=/resume/markdown/resume.markdown
printf "$(date) rebuilding $DOCX_OUTPUT… "
# Easier to build a docx from LaTeX than markdown
buffer=$(mktemp --suffix=.tex)
pandoc $markdown_path \
  --from markdown+yaml_metadata_block \
  --template $TEMPLATE \
  --to latex \
  --output $buffer
pandoc $buffer \
  --from latex \
  --output $DOCX_OUTPUT

printf "done!\n"

printf "$(date) rebuilding $PDF_OUTPUT… "
# Could reuse the LaTex outut but this is easier
pandoc $markdown_path \
  --from markdown+yaml_metadata_block \
  --template $TEMPLATE \
  --output $PDF_OUTPUT
printf "done!\n"
printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
