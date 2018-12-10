FROM rafalskolasinski/science:latest

LABEL maintainer="Rafal Skolasinski <r.j.skolasinski@gmail.com>"

USER root

# Install dev version of scipy
RUN pip install scipy==1.2.0rc2


# Fix permissions (required when following the base image)
RUN fix-permissions $HOME && \
    fix-permissions $CONDA_DIR

# Switch back to jovyan to avoid accidental container runs as root
USER $NB_UID
