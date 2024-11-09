FROM centos
MAINTAINER vikash@gmail.com

# Fix CentOS repositories
RUN cd /etc/yum.repos.d/ && \
    sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* && \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

# Install required packages using yum
RUN yum install -y httpd zip unzip java-1.8.0-openjdk

# Set working directory
WORKDIR /var/www/html/

# Manually download the ZIP file (if online URL fails, use a local file)
# If you have already downloaded the file, use: ADD photogenic.zip /var/www/html/
ADD https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip /var/www/html/

# Unzip and prepare files
RUN unzip -q "*.zip" && \
    cp -rvf photogenic/* . && \
    rm -rf photogenic photogenic.zip

# Start Apache server in the foreground
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

# Expose ports
EXPOSE 80 
