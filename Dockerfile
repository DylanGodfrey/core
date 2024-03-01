# Use an official Python runtime as the base image
FROM python:3.10.4-buster

# Set the working directory in the container
WORKDIR /opt/project

# Prevent .pyc files to disc
ENV PYTHONDONTWRITEBYTECODE 1
# Diable Python's I/O buffering
ENV PYTHONUNBUFFERED 1
# Add current dir to Python PATH
ENV PYTHONPATH .
ENV CORESETTINGS_IN_DOCKER true

# Install system dependencies
RUN set -xe \
    && apt-get update \
    && apt-get install -y --no-install-recommends build-essential \
    && pip install virtualenvwrapper poetry==1.4.2 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy and install Python dependencies
COPY ["poetry.lock", "pyproject.toml", "./"]
RUN poetry install --no-root

# Copy project files
COPY ["README.md", "Makefile", "./"]
COPY core core
COPY local local

# Expose port 8000
EXPOSE 8000

# Set up the entrypoint
COPY scripts/entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]