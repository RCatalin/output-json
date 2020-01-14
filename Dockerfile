# Use an official Python runtime as a parent image
FROM python:3.7.2-stretch

# Instal pipenv
RUN pip3 install pipenv

# Create the folder structure ? POC
RUN mkdir -p /nexmo/core/output_json/$(hostname)
#RUN mkdir -p /var/tmp/nexmo/test

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in requirements.txt
RUN pipenv install

# Make port 80 available to the world outside this container
#EXPOSE 80

# Define environment variable
#ENV NAME World

USER root

# Run app.py when the container launches
CMD ["python", "output_json.py"]

