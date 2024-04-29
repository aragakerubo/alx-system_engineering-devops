# Requirements:

# Nginx should be listening on port 80
# When querying Nginx at its root / with a GET request (requesting a page) using curl, it must return a page that contains the string Hello World!
# The redirection must be a “301 Moved Permanently”
# Your answer file should be a Puppet manifest containing commands to automatically configure an Ubuntu machine to respect above requirements


# Install nginx
package { 'nginx':
  ensure => present,
}

# Create a new file
file { '/etc/nginx/sites-available/default':
  ensure  => file,
  content => 'server {
    listen 80;
    listen [::]:80 default_server;
    root   /var/www/html/;
    index  index.html index.htm;

    location /redirect_me {
        return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;
    }

    error_page 404 /404.html;
    location /404 {
        root /var/www/html/;
        internal;
    }
}',
}

# Restart nginx
service { 'nginx':
  ensure    => running,
  enable    => true,
  subscribe => File['/etc/nginx/sites-available/default'],
}

# Create a new file
file { '/var/www/html/index.html':
  ensure  => file,
  content => 'Hello World!',
}

# Restart nginx
service { 'nginx':
  ensure    => running,
  enable    => true,
  subscribe => File['/var/www/html/index.html'],
}

