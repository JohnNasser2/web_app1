# Use the official lightweight Python image.
# https://hub.docker.com/_/python
FROM python:3.7

# Allow statements and log messages to immediately appear in the Knative logs
# Install production dependencies.
RUN pip install Flask 
RUN pip install rembg
FROM gcr.io/cloud-builders/docker
 
# Copy local code to the container image.
WORKDIR /app
COPY src/app


ENV PORT 8080

# Run the web service on container startup. Here we use the gunicorn
# webserver, with one worker process and 8 threads.
# For environments with multiple CPU cores, increase the number of workers
# to be equal to the cores available.
CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 app:app