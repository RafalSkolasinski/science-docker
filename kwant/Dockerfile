FROM rafalskolasinski/science:latest

LABEL maintainer="Rafal Skolasinski <r.j.skolasinski@gmail.com>"

USER root

ENV KWANT_HASH 60f02546

# Install git version of kwant
RUN  . activate && \
    conda remove --yes kwant tinyarray && \
    git clone https://gitlab.kwant-project.org/kwant/kwant.git /tmp/kwant && \
    cp /environments/build.conf /tmp/kwant && \
    cd /tmp/kwant && git checkout $KWANT_HASH && \
    sed -i -e "s:PREFIX:$CONDA_PREFIX:g" build.conf && \
    pip install git+https://gitlab.kwant-project.org/kwant/tinyarray.git && \
    pip install . && \
    rm -rf /tmp/kwant && \
    conda clean -tipsy

# Fix permissions (required when following the base image)
RUN fix-permissions $HOME && \
    fix-permissions $CONDA_DIR

# Switch back to jovyan to avoid accidental container runs as root
USER $NB_UID
