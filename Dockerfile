# This Python package should include most dependencies for our purposes.
FROM python:3.10-slim-bullseye
# Install curl and netcat => Install poetry
RUN pip install -U pip \
    && apt-get update \
    && apt install -y curl netcat \
    && curl -sSL https://install.python-poetry.org/ | python3 -
# Set PATH enviromental variable to enable bash commands as e.g. '$ poetry version'
ENV PATH="${PATH}:/root/.local/bin"
# Application work directory inside container as per convention:
WORKDIR /usr/src/app
# Copy configuration files for '$ poetry install' before copying the rest of the repository to container for caching purposes
COPY poetry* .
COPY pyproject.toml .
# Check poetry installation and that the PATH enviromental variable works properly:
RUN poetry config virtualenvs.create false
RUN poetry install
# Now we can copy the repository files to the container.
COPY . .
# Now, set database env variables, expose the required ports and so forth!
EXPOSE 5000
# Finally, this CMD starts up the application
CMD [ "python3", "src/app.py"]