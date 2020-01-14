# Use an official Python runtime as a parent image
FROM python:3.7.2-stretch

# Instal pipenv
RUN pip3 install pipenv

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in requirements.txt
RUN pipenv install

# Create the folder structure ? POC
#RUN mkdir -p /nexmo/core/output_json/$(hostname)
CMD ["mkdir -p", "/var/tmp/nexmo"]

# Make port 80 available to the world outside this container
#EXPOSE 80

# Define environment variable
#ENV NAME World

USER nexmo

# Run app.py when the container launches
CMD ["python", "output_json.py"]

