#!/bin/bash

# Update package lists
sudo apt-get update
sudo apt-get upgrade

# Install dependencies for Ruby
sudo apt-get install -y curl gnupg2

# Install Rbenv (a tool for managing Ruby versions)
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
source ~/.bashrc

# Install Ruby-build (a plugin for rbenv to install Ruby)
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

# Install Ruby (you can change the version as needed)
rbenv install 3.0.2
rbenv global 3.0.2


# Install Nginx
sudo apt-get install -y nginx

# Start and enable Nginx to start on boot
sudo systemctl start nginx
sudo systemctl enable nginx

echo "Installation completed successfully."
