# Collection of Dockerfiles that I use in my research

## Base for images

Images are based on [jupyter/minimal-notebook](https://github.com/jupyter/docker-stacks/tree/master/minimal-notebook) and I refer to its documentation for more specific usage cases.


## Basic usage of stable image

    docker pull rafalskolasinski/science:latest
    docker run --rm -d -p 8888:8888 -v $PWD:/home/jovyan/work --name science rafalskolasinski/science:latest

This will mount current working directory ($PWD) under "~/work" directory inside the container.
Please either "cd" into the directory with the simulation codes and data prior to executing above command or provide path to it instead of "($PWD)".

The container will expose a jupyter notebook to the local port 8888.

Running

    docker logs science

will show information with "token" required to access jupyter notebook.
The last remainig step is to open web browser and go to the given link that looks similar to


## Image versioning
The main image is located in [stable](stable/) directory.
First version of its conda environment is tagged as ``2018.1``.

It can be pulled as

    docker pull rafalskolasinski/science:2018.1


To obtain the latest build use ``rafalskolasinski/science:latest``.

As [Kwant](https://kwant-project.org/) is a main package that I use in my research I also provide [kwant-git](kwant-git/Dockerfile) builds made by using sources directly from [git](https://gitlab.kwant-project.org/kwant/kwant).

This images are tagged by using tag of the stable environment that served as a base and HASH of commit that was used to build Kwant, e.g. ``rafalskolasinski/science:2018.1_82baedca``.
