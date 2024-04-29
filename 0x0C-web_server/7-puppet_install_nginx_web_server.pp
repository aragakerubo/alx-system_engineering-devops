# Requirements:

# Nginx should be listening on port 80
# When querying Nginx at its root / with a GET request (requesting a page) using curl, it must return a page that contains the string Hello World!
# The redirection must be a “301 Moved Permanently”
# Your answer file should be a Puppet manifest containing commands to automatically configure an Ubuntu machine to respect above requirements


# Install nginx
package { 'nginx':
  ensure => 'installed',
}

# Create a new file
file { 'index.nginx-debian.html':
  path    => '/var/www/html/index.nginx-debian.html',
  content => "Hello World!",
}

# Update the default configuration
exec { 'config':
  command => 'sed -i "s/server_name _;/server_name _;\n\trewrite ^\/redirect_me https:\/\/www.youtube.com/watch?v=QH2-TGUlwu4 permanent;/" /etc/nginx/sites-available/default',
  provider => 'shell',
}

# Restart nginx
exec { 'start':
  command => 'sudo service restart nginx',
  provider => 'shell',
}
