FROM jupyter/minimal-notebook:14fdfbf9cfc1

LABEL maintainer="Rafal Skolasinski <r.j.skolasinski@gmail.com>"

USER root

# add ssh-client to provide ssh-agent and ssh-add commands
RUN apt-get update && apt-get install --yes openssh-client

# Add environment file
RUN mkdir /environments
COPY environment.yml build.conf /environments/

# Create the main research environment
RUN conda env update -n base -f /environments/environment.yml && \
    pip install xyzpy==0.2.5 tqdm==4.28.1 && \
    conda clean -tipsy

# Enable jupyter extension
ARG NODE_OPTIONS=--max-old-space-size=4096
RUN jupyter nbextension enable --py widgetsnbextension --sys-prefix && \
    jupyter nbextension enable --py plotlywidget --sys-prefix && \
    jupyter labextension install nbdime-jupyterlab && \
    jupyter labextension install @pyviz/jupyterlab_pyviz && \
    jupyter labextension install @jupyter-widgets/jupyterlab-manager@0.38 --no-build && \
    jupyter labextension install plotlywidget@0.5.2  --no-build && \
    jupyter labextension install jupyterlab-chart-editor@1.0 --no-build && \
    jupyter labextension install @jupyterlab/plotly-extension@0.18.1  --no-build && \
    jupyter lab build

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
