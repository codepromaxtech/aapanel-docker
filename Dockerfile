# Use a base image with Ubuntu
FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages and dependencies
RUN apt-get update && apt-get install -y \
    wget curl sudo cron \
    && apt-get clean

# Download and install aaPanel (non-interactive)
RUN wget -O install.sh http://www.aapanel.com/script/install-ubuntu_6.0_en.sh && \
    bash install.sh y && \
    rm -f install.sh

# Expose required ports for aaPanel
EXPOSE 7800 8888

# Start aaPanel service on container startup
CMD ["bash", "-c", "/etc/init.d/bt start && tail -f /dev/null"]
