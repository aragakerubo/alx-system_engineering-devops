# Just as in task #0, we’d like you to automate the task of creating a custom HTTP header response, but with Puppet.

# The name of the custom HTTP header must be X-Served-By
# The value of the custom HTTP header must be the hostname of the server Nginx is running on
# Write 2-puppet_custom_http_response_header.pp so that it configures a brand new Ubuntu machine to the requirements asked in this task

# Install the package nginx
package { 'nginx':
  ensure => 'installed',
}

# Create a custom HTTP header response
exec { 'command':
  command => 'printf "server {\nlisten 80 default_server;\nlisten [::]:80 default_server;\nserver_name _;\nroot /var/www/html;\nadd_header X-Served-By $HOSTNAME;\nindex index.html index.htm index.nginx-debian.html;\nlocation / {\ntry_files $uri $uri/ =404;\n}\n}" > /etc/nginx/sites-available/default',
  provider => 'shell',
}

# Restart the Nginx service
service { 'nginx':
  ensure => 'running',
  enable => 'true',
  require => Exec['command'],
}
