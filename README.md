# Collection of Dockerfiles that I use in my research

## Base for images

Images are based on [jupyter/minimal-notebook](https://github.com/jupyter/docker-stacks/tree/master/minimal-notebook) and I refer to its documentation for more specific usage cases.


## Image versioning
The main image is located in [stable](stable/) directory.
First version of its conda environment is tagged as ``2018.1``.

It can be pulled as
```
docker pull rafalskolasinski/science:2018.1
```

To obtain the latest build use ``rafalskolasinski/science:latest``.

As [Kwant](https://kwant-project.org/) is a main package that I use in my research I also provide [dev](kwant-git/Dockerfile) builds made by using sources directly from [git](https://gitlab.kwant-project.org/kwant/kwant).

This images are tagged by using tag of the stable environment that served as a base and HASH of commit that was used to build Kwant, e.g. ``rafalskolasinski/science:2018.1_82baedca``.
