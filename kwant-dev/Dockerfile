FROM jupyter/minimal-notebook:latest

LABEL maintainer="Rafal Skolasinski <r.j.Skolasinski@gmail.com>"

USER root

# Add environment files
RUN mkdir /environments
COPY environment.yml build.conf /environments/

RUN conda install --yes -c defaults conda=4.5 nb_conda=2.2.1
RUN conda env create --file /environments/environment.yml

# Make folder for kwant sources, git clone source code, add build.conf
RUN mkdir -p /src/kwant && \
    git clone https://gitlab.kwant-project.org/kwant/kwant.git /src/kwant && \
    mv /environments/build.conf /src/kwant/build.conf

# Install kwant
RUN . activate && conda activate kwant-dev && cd /src/kwant && \
    sed -i -e "s:PREFIX:$CONDA_PREFIX:g" build.conf && \
    pip install git+https://gitlab.kwant-project.org/kwant/tinyarray.git && \
    pip install .

# Fix permissions (required when following the base image)
RUN fix-permissions /opt/conda

# Cleanup all downloaded conda files
RUN conda clean --yes --all

# Switch back to jovyan to avoid accidental container runs as root
USER $NB_UID
