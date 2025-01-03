# Author: William Kwabla

# Python version
FROM python:3.10-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV DJANGO_SETTINGS_MODULE=bona_blog.settings

# Install system dependencies
RUN apt-get update && apt-get install -y \
    postgresql-client \
    libjpeg-dev \
    zlib1g-dev \
    libfreetype6-dev \
    liblcms2-dev \
    libopenjp2-7-dev \
    libtiff5-dev \
    tk-dev \
    tcl-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    gcc \
    python3-dev \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

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

# Copy project
COPY . /code/

# Set ownership
RUN chown -R www-data:www-data /code

# Switch to www-data user
USER www-data
