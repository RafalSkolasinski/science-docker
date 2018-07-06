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
The last remainig step is to open web browser and go to the

    http://localhost:8888

and provide obtained token.


## Image versioning
The main image is located in [stable](stable/) directory.
First version of its conda environment is tagged as ``2018.1``.

It can be pulled as

    docker pull rafalskolasinski/science:2018.1


To obtain the latest build use ``rafalskolasinski/science:latest``.

As [Kwant](https://kwant-project.org/) is a main package that I use in my research I also provide a second environment with kwant built directly from [git](https://gitlab.kwant-project.org/kwant/kwant).


## Provided environments
Main (stable) conda [environment](stable/environment.yml) that I provide is named ``science`` and has a
display name ``Science Environment``.

Second environment has identical set of packages with the exception being Kwant that is installed from sources in version specified by ``KWANT_HASH`` variable inside the [Dockerfile](stable/Dockerfile).
The environment is named ``kwant`` and has display name ``Dev-Kwant Environment``.


## Building and installing python codes
Code development process can be simplified by working in reproducible environments, like docker container.
For this purpose I added a volume ``/src`` and convenient scripts (build and test) in ``/usr/local`` directory that can be executed through ``docker run command``.
These scripts allow to easy build and install (in development mode) python source code into the ``science`` environment.

In example, to build and install kwant from a local copy one can start the container with

    docker run --rm -d -p 8888:8888 -v /path/to/kwant:/src --name kwant rafalskolasinski/science:latest

and execute build and test of a code with

    docker exec dev set.build.conf
    docker exec dev build
    docker exec dev test -v --cov=kwant --cov-report term --flakes kwant

Note: everything after ``test`` are arguments passed to ``py.test``
Note: first command ``set.build.conf`` is specific to kwant and assures that MUPS will be configured properly.

If you want to start a clean build run following command in your ``kwant`` folder:

    git clean -fxd .
