FROM rafalskolasinski/science:2018.1

LABEL maintainer="Rafal Skolasinski <r.j.Skolasinski@gmail.com>"

USER root

ENV KWANT_HASH 82baedca

# Add environment files
COPY build-deps.yml build.conf /environments/

# Make folder for kwant sources, git clone source code, add build.conf
RUN mkdir -p /src/kwant && \
    git clone https://gitlab.kwant-project.org/kwant/kwant.git /src/kwant && \
    mv /environments/build.conf /src/kwant/build.conf

# Install git version of kwant
RUN . activate && conda activate kwant && cd /src/kwant && \
    conda remove --yes kwant tinyarray && \
    conda env update --name kwant --file /environments/build-deps.yml && \
    git checkout $KWANT_HASH && \
    sed -i -e "s:PREFIX:$CONDA_PREFIX:g" build.conf && \
    pip install git+https://gitlab.kwant-project.org/kwant/tinyarray.git && \
    pip install .

# Fix permissions (required when following the base image)
RUN fix-permissions $HOME && \
    fix-permissions $CONDA_DIR

# Cleanup all downloaded conda files
RUN conda clean --yes --all

# Switch back to jovyan to avoid accidental container runs as root
USER $NB_UID
