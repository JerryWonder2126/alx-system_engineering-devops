# Setup Nginx server with a custom HTTP header

# Run updates
exec { 'Update apt-get' :
  command => '/usr/bin/env apt-get -y update'
}

# Install nginx
-> package { 'Install nginx':
  ensure  => installed,
  name    => 'nginx',
  command => '/usr/bin/env apt-get -y',
}

-> file { 'Create backup of config' :
  ensure => present,
  source => '/etc/nginx/sites-available/default',
  path   => '/etc/nginx/sites-available/default.bak'
}

-> exec { 'Parse config and create backup' :
  command => "/usr/bin/env awk '!/(\s)?#/' /etc/nginx/sites-available/default.bak > /etc/nginx/sites-available/default"
}

-> file_line { 'add header' :
  ensure => present,
  line   => "\n\tadd_header X-Served-By ${hostname};",
  path   => '/etc/nginx/sites-available/default',
  after  => 'server_name _;',
}

-> file { 'Create index file' :
  path    => '/var/www/html/index.html',
  content => "Hello World!\n"
}

-> service { 'Ensure nginx is running' :
  ensure => running,
  name   => 'nginx',
}
