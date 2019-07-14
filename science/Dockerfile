FROM jupyter/minimal-notebook:6c3390a9292e

LABEL maintainer="Rafal Skolasinski <r.j.skolasinski@gmail.com>"

USER root

# add ssh-client to provide ssh-agent and ssh-add commands
RUN apt-get update && apt-get install --yes openssh-client

# Switch back to jovyan to avoid accidental container runs as root
USER $NB_UID

# Add environment file
COPY environment.yml /tmp/

# Create the main research environment
RUN conda env update -n base -f /tmp/environment.yml && \
    pip install xyzpy==0.3.1 tqdm==4.32.2 && \
    conda clean -tipsy && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

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
    jupyter nbextension enable --py plotlywidget --sys-prefix && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER
