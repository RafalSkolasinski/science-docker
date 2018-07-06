FROM jupyter/minimal-notebook:latest

LABEL maintainer="Rafal Skolasinski <r.j.skolasinski@gmail.com>"

USER root

ENV KWANT_HASH a674bf94

# Add environment file
RUN mkdir /environments /tmp
COPY environment.yml build.conf /environments/

# Create the main research environment
RUN conda install --yes -c defaults conda=4.5 && \
    conda env create --file /environments/environment.yml && \
    . activate && conda activate science && \
    python -m ipykernel install --name science --display-name "Science Environment"

# Install git version of kwant
RUN conda create --name kwant --clone science && \
    . activate && conda activate kwant && \
    python -m ipykernel install --name kwant --display-name "Dev-Kwant Environment" && \
    conda remove --yes kwant tinyarray && \
    git clone https://gitlab.kwant-project.org/kwant/kwant.git /tmp/kwant && \
    mv /environments/build.conf /tmp/kwant && \
    cd /tmp/kwant && git checkout $KWANT_HASH && \
    sed -i -e "s:PREFIX:$CONDA_PREFIX:g" build.conf && \
    pip install git+https://gitlab.kwant-project.org/kwant/tinyarray.git && \
    pip install .

# Cleanup conda installation
RUN conda clean -tipsy

# Fix permissions (required when following the base image)
RUN fix-permissions $HOME && \
    fix-permissions $CONDA_DIR

# Switch back to jovyan to avoid accidental container runs as root
USER $NB_UID
