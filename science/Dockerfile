FROM jupyter/minimal-notebook:3772fffc4aa4

LABEL maintainer="Rafal Skolasinski <r.j.skolasinski@gmail.com>"

USER root

ENV KWANT_HASH a674bf94

# Add environment file
RUN mkdir /environments
COPY environment.yml build.conf /environments/

# Create the main research environment
RUN conda env update -n base -f /environments/environment.yml

# Install git version of kwant
RUN conda env create -n kwant -f /environments/environment.yml && \
    . activate && conda activate kwant && \
    python -m ipykernel install --name kwant --display-name "Python3 (dev-kwant)" && \
    conda remove --yes kwant tinyarray && \
    git clone https://gitlab.kwant-project.org/kwant/kwant.git /tmp/kwant && \
    cp /environments/build.conf /tmp/kwant && \
    cd /tmp/kwant && git checkout $KWANT_HASH && \
    sed -i -e "s:PREFIX:$CONDA_PREFIX:g" build.conf && \
    pip install git+https://gitlab.kwant-project.org/kwant/tinyarray.git && \
    pip install .

# Cleanup conda installation
RUN conda clean -tipsy

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
