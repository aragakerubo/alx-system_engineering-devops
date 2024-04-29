# Install nginx package
package { 'nginx':
  ensure => installed,
}

# Define custom HTTP header configuration
file { '/etc/nginx/sites-available/default':
  ensure  => file,
  content => "
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /var/www/html;
    index index.html index.htm index.nginx-debian.html;

    server_name _;

    location / {
        try_files \$uri \$uri/ =404;
    }

    location /redirect_me {
        return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;
    }

    # Custom HTTP header
    add_header X-Served-By \$hostname;
}
  ",
  require => Package['nginx'],
}

# Create a symbolic link to enable the site
file { '/etc/nginx/sites-enabled/default':
  ensure => link,
  target => '/etc/nginx/sites-available/default',
  force  => true,
  notify => Service['nginx'],
}

