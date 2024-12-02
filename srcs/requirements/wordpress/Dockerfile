FROM debian:bullseye

# Define PHP version as an environment variable
ENV PHP_VERSION 7.4

# Create the required PHP run directory
RUN mkdir -p /run/php

# Install dependencies, including curl, wget, PHP packages, and ca-certificates
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    curl \
    wget \
    php${PHP_VERSION} \
    php${PHP_VERSION}-cgi \
    php${PHP_VERSION}-mysql \
    php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-pdo \
    php${PHP_VERSION}-gd \
    php${PHP_VERSION}-cli \
    php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-redis \
    ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Update CA certificates
RUN update-ca-certificates

# Download and install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Copy custom PHP-FPM pool configuration for www.conf
COPY ./conf/www.conf /etc/php/${PHP_VERSION}/fpm/pool.d/

# Copy the custom WordPress start script
COPY ./tools/run_wordpress.sh /run_wordpress.sh

# Make the script executable
RUN chmod +x /run_wordpress.sh

# Expose port 9000 (PHP-FPM listens on this port)
EXPOSE 9000

# Set the default command to run WordPress script
CMD ["/run_wordpress.sh"]
