FROM jupyter/minimal-notebook:latest

LABEL maintainer="Rafal Skolasinski <r.j.Skolasinski@gmail.com>"

USER root

# Add environment file
RUN mkdir /environments
COPY environment.yml /environments/

# Create environment
RUN conda install --yes -c defaults conda=4.5 nb_conda=2.2.1 && \
    conda env create --file /environments/environment.yml && \
    conda clean --yes --all

# Disable nbpresent
RUN jupyter nbextension disable --py --sys-prefix nbpresent

# Fix permissions (required when following the base image)
RUN fix-permissions $HOME && \
    fix-permissions $CONDA_DIR

# Switch back to jovyan to avoid accidental container runs as root
USER $NB_UID
