# Use a base image with Ubuntu
FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages and dependencies
RUN apt-get update && apt-get install -y \
    wget curl sudo cron \
    && apt-get clean

# Download and run the aaPanel installation script non-interactively
RUN URL=https://www.aapanel.com/script/install_7.0_en.sh && \
    if [ -f /usr/bin/curl ]; then \
        curl -ksSO "$URL" ; \
    else \
        wget --no-check-certificate -O install_7.0_en.sh "$URL"; \
    fi && \
    bash install_7.0_en.sh aapanel && \
    rm -f install_7.0_en.sh

# Expose required ports for aaPanel
EXPOSE 7800 8888

# Start aaPanel service on container startup
CMD ["bash", "-c", "/etc/init.d/bt start && tail -f /dev/null"]
