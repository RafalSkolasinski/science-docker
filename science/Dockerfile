FROM jupyter/minimal-notebook:14fdfbf9cfc1

LABEL maintainer="Rafal Skolasinski <r.j.skolasinski@gmail.com>"

USER root

# add ssh-client to provide ssh-agent and ssh-add commands
RUN apt-get update && apt-get install --yes openssh-client

# Add environment file
RUN mkdir /environments
COPY environment.yml /environments/

# Create the main research environment
RUN conda install --yes conda-forge::conda=4.7.5 && \
    conda env update -n base -f /environments/environment.yml && \
    pip install xyzpy==0.3.1 tqdm==4.32.2 && \
    conda clean -tipsy

# Enable jupyter extension
ARG NODE_OPTIONS=--max-old-space-size=4096
RUN jupyter labextension install nbdime-jupyterlab && \
    jupyter labextension install @pyviz/jupyterlab_pyviz && \
    jupyter labextension install @jupyter-widgets/jupyterlab-manager@0.38 --no-build && \
    jupyter labextension install plotlywidget@0.11.0  --no-build && \
    jupyter labextension install @jupyterlab/plotly-extension@0.18.2  --no-build && \
    jupyter labextension install jupyterlab-chart-editor@1.1 --no-build && \
    jupyter lab build && \
    jupyter nbextension enable --py widgetsnbextension --sys-prefix && \
    jupyter nbextension enable --py plotlywidget --sys-prefix

# Fix permissions (required when following the base image)
RUN fix-permissions $HOME && \
    fix-permissions $CONDA_DIR

# Switch back to jovyan to avoid accidental container runs as root
USER $NB_UID
