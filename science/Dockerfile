FROM jupyter/minimal-notebook:702d2f6a3eaa

LABEL maintainer="Rafal Skolasinski <r.j.skolasinski@gmail.com>"

USER root

# Add environment file
RUN mkdir /environments
COPY environment.yml build.conf /environments/

# Create the main research environment
RUN conda env update -n base -f /environments/environment.yml && \
    conda clean -tipsy

# Enable jupyter extension
RUN jupyter labextension install @pyviz/jupyterlab_pyviz

# Fix permissions (required when following the base image)
RUN fix-permissions $HOME && \
    fix-permissions $CONDA_DIR

# Add scripts and place for building source codes
VOLUME /src

ADD scripts/set.build.conf.sh /usr/local/bin/set.build.conf
ADD scripts/build.sh /usr/local/bin/build
ADD scripts/test.sh /usr/local/bin/test

# Switch back to jovyan to avoid accidental container runs as root
USER $NB_UID
