FROM ubuntu:20.04
MAINTAINER vikash@gmail.com

# Set environment variables to skip interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Update package list and install required packages
RUN apt-get update && \
    apt-get install -y apache2 zip unzip openjdk-11-jdk wget && \
    apt-get clean

# Set working directory
WORKDIR /var/www/html/

# Download the ZIP file using wget (more reliable than ADD)
RUN wget --tries=5 --retry-connrefused https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip -O photogenic.zip

# Unzip the downloaded file and copy its contents
RUN unzip -q photogenic.zip && \
    cp -rvf photogenic/* . && \
    rm -rf photogenic photogenic.zip

# Start Apache server in the foreground
CMD ["apachectl", "-D", "FOREGROUND"]

# Expose the required ports
EXPOSE 80 72
