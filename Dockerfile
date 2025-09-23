FROM debian:bookworm-slim

RUN apt-get update; \
apt-get install -y pandoc texlive-latex-recommended texlive-latex-extra texlive-xetex entr;

ENV SOURCE=/resume/markdown/resume.markdown \
  TEMPLATE=/resume/templates/resume-template.tex \
  PDF_OUTPUT=/resume/output/resume.pdf \
  DOCX_OUTPUT=/resume/output/resume.docx

COPY bin /bin

RUN chmod +x /bin/build-resume.sh ; \
  chmod +x /bin/watcher.sh

RUN mkdir /resume ; \
  mkdir /resume/output
WORKDIR /resume

ENTRYPOINT /bin/watcher.sh

