#!/bin/bash

# Install Nginx if not already installed
if ! command -v nginx &> /dev/null; then
    sudo apt-get update
    sudo apt-get install -y nginx
fi

# Create necessary directories
sudo mkdir -p /data/web_static/releases/test /data/web_static/shared

# Create a fake HTML file for testing
echo "<html><head></head><body>Test content for Nginx configuration</body></html>" | sudo tee /data/web_static/releases/test/index.html > /dev/null

# Create symbolic link
sudo ln -sf /data/web_static/releases/test /data/web_static/current

# Set ownership recursively
sudo chown -R ubuntu:ubuntu /data/

# Update Nginx configuration
sudo sed -i '/server_name _;/a location /hbnb_static/ { alias /data/web_static/current/; }' /etc/nginx/sites-available/default

# Restart Nginx
sudo service nginx restart
