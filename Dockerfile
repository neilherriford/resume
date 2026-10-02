FROM debian:trixie-slim

RUN apt-get update; \
apt-get install -y pandoc texlive-latex-recommended texlive-latex-extra texlive-xetex entr;

ENV INPUT_DIR=/resume/input \
  OUTPUT_DIR=/resume/output \
  RESUME_TEMPLATE=/resume/templates/resume.tex \
  COVER_TEMPLATE=/resume/templates/cover-letter.tex

WORKDIR /resume

ENTRYPOINT ["/resume/bin/watcher.sh"]
