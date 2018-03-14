FROM centos:7

RUN \
    yum -y -q update && \
    yum -y -q install \
        git texlive-latex-bin-bin texlive-texconfig \
        texlive-collection-latex texlive-collection-fontsrecommended \
        texlive-fancyhdr texlive-changepage \
        && \
    yum clean all && \
    fmtutil-sys --all && \
    texhash

COPY . /resume

WORKDIR /resume

CMD [ \
    "/usr/bin/pdflatex", "-halt-on-error", "-output-dir=outputs", \
    "-shell-escape", "output.tex" \
]
