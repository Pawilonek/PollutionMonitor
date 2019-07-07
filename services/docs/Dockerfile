FROM python:3.7-alpine

WORKDIR /mkdocs

# Install dependencies
RUN pip install mkdocs

# Configure mkcods
RUN mkdir docs
COPY ./mkdocs.yml .

# Serve development version
CMD ["mkdocs", "serve", "--dev-addr=0.0.0.0:80"]
