Résumé Source Documents
=======================

This repository contains the necessary code to build a PDF copy of my current
résumé.

How to Build It
===============

The original way this was written in 2013 relied on various manually-installed
LaTeX packages for Mac OS X (before it was macOS). This was ultimately not
very portable, however, so I have switched to using Docker to create an image
which is capable of compiling the résumé.

To build the Docker image, you need to run the following command inside this
repository:

```sh
docker build -t resume .
```

The `resume` name is not mandatory, but if you change it, it will affect later
commands. The build step will take some time as it requires installing several
"texlive" dependencies, and the resulting image will unfortunately be fairly
sizable (around 600MB).

Once the image is built, the resume itself can be built with a simple one-line
command:

```sh
docker run --rm -v "$(pwd)/outputs:/resume/outputs" resume
```

This will create a container from the `resume` image that was just created,
mount the `outputs/` subdirectory from the repository inside of the container
in the relevant location, and run the script to build the resume, outputting
it into `outputs/output.pdf`, before exiting and removing the container.

The `outputs/output.pdf` file is symlinked from the root of the repository as
`resume.pdf`. You'll note when first cloning the repository that this symlink
is an error because the resume has not been built at first.

Adding to the Résumé
====================

Updating the résumé by modifying any of the `output-details.bash`,
`output.tex`, or `resume.tex` files will require one of two behaviors to
ensure that the local changes are reflected in the next compilation. You must
either re-build the `resume` image as specified above, or alter the command
for compiling the resume:

```sh
docker run --rm -v "$(pwd):/resume" resume
```

Though this command is shorter, it's not recommended to regularly run the
image this way, as it could wind up creating extraneous log files or other
unexpected behavior. The recommended method mounts only the output directory,
reducing the number of things which can go wrong in unexpected ways.

License
=======

This repository is only partially licensed for outside use. The MIT license
applies to all code except as contained in the following files:

  * `resume.tex`
  * `xargs.sty`

The contents of the `resume.tex` file is Copyright 2013-2018 Stephen Belcher,
and may be reproduced but not altered without prior consent.

The contents of `xargs.sty` are licensed under the [LPPL][], though it is
recommended that you do not use the file for any purpose other than to build
this project, as it may be out of date. Instead, please refer to the [CTAN][]
for up-to-date versions of any packages.

For the contents of the MIT license applying to all other files, please see
[LICENSE.md](LICENSE.md).

Author
======

Stephen Belcher (sbelcher [plus] jobs [at] gmail [dot] com)

-----

[LPPL]: http://www.latex-project.org/lppl.txt
[CTAN]: https://ctan.org/
