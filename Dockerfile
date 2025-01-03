# Author: William Kwabla

# Python version
FROM python:3.10-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV DJANGO_SETTINGS_MODULE=bona_blog.settings

# Install system dependencies
RUN apk add --no-cache \
    postgresql-libs \
    jpeg-dev \
    zlib-dev \
    freetype-dev \
    lcms2-dev \
    openjpeg-dev \
    tiff-dev \
    tk-dev \
    tcl-dev \
    harfbuzz-dev \
    fribidi-dev \
    shadow

# Install build dependencies
RUN apk add --no-cache --virtual .build-deps \
    gcc \
    musl-dev \
    postgresql-dev \
    python3-dev \
    libffi-dev \
    build-base

# Set work directory
WORKDIR /code

# Create static and media directories
RUN mkdir -p /code/staticfiles /code/media

# Create www-data user and group
RUN addgroup -g 82 -S www-data && \
    adduser -u 82 -S -D -G www-data www-data

# Install dependencies
COPY Pipfile Pipfile.lock /code/
RUN pip install pipenv && pipenv install --system

# Remove build dependencies
RUN apk --purge del .build-deps

# Copy project
COPY . /code/

# Set ownership
RUN chown -R www-data:www-data /code

# Switch to www-data user
USER www-data
