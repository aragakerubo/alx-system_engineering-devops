# Requirements:

# Nginx should be listening on port 80
# When querying Nginx at its root / with a GET request (requesting a page) using curl, it must return a page that contains the string Hello World!
# The redirection must be a “301 Moved Permanently”
# Your answer file should be a Puppet manifest containing commands to automatically configure an Ubuntu machine to respect above requirements


# Install nginx
package { 'nginx':
  ensure => installed,
}

# Create a new file
file { 'index.nginx-debian.html':
  path    => '/var/www/html/index.nginx-debian.html',
  ensure  => file,
  content => "Hello World!",
}

# Update the default configuration
exec { 'update_nginx_config':
  command => 'sed -i "s|root /var/www/html;|root /var/www/html;\\n\\n    location / {\\n        return 301 /index.nginx-debian.html;\\n    }|g" /etc/nginx/sites-available/default',
  provider => shell,
}

# Restart nginx
exec { 'restart_nginx':
  command => 'systemctl restart nginx',
  provider => shell,
}
