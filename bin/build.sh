#!/bin/bash
INPUT_DIR=${INPUT_DIR:-/resume/input}
OUTPUT_DIR=${OUTPUT_DIR:-/resume/output}
RESUME_TEMPLATE=${RESUME_TEMPLATE:-/resume/templates/resume.tex}
COVER_TEMPLATE=${COVER_TEMPLATE:-/resume/templates/cover-letter.tex}

mkdir -p "$INPUT_DIR" "$OUTPUT_DIR"

build() {
  local src=$1 template=$2 pdf=$3 docx=$4 tex
  mkdir -p "$(dirname "$pdf")"
  tex=$(mktemp --suffix=.tex)
  # Easier to build a docx from LaTeX than markdown
  if pandoc "$src" --from markdown+yaml_metadata_block --template "$template" --to latex --output "$tex" \
    && pandoc "$tex" --from latex --output "$docx" \
    && pandoc "$src" --from markdown+yaml_metadata_block --template "$template" --output "$pdf"; then
    printf "done!\n"
  else
    printf "FAILED\n"
    rm -f "$pdf" "$docx"
  fi
  rm -f "$tex"
}

while IFS= read -r src; do
  rel=${src#"$INPUT_DIR"/}
  base=${rel%.*}
  case "$(basename "$rel")" in
    cover-letter*) template=$COVER_TEMPLATE ;;
    *) template=$RESUME_TEMPLATE ;;
  esac
  pdf="$OUTPUT_DIR/$base.pdf"
  docx="$OUTPUT_DIR/$base.docx"
  if [ ! -e "$pdf" ] || [ ! -e "$docx" ] || [ "$src" -nt "$pdf" ] || [ "$template" -nt "$pdf" ]; then
    printf "%s building %s… " "$(date)" "$rel"
    build "$src" "$template" "$pdf" "$docx"
  fi
done < <(find -L "$INPUT_DIR" -type f \( -name '*.markdown' -o -name '*.md' \) | sort)
