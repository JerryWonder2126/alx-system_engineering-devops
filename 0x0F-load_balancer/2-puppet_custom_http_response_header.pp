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

-> exec { 'Create backup of config' :
  command => '/usr/bin/env cp /etc/nginx/sites-available/default /etc/nginx/sites-available/default.bak'
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

-> file_line { 'add 404 config' :
  ensure => present,
  path   => '/etc/nginx/sites-available/default',
  after  => 'server_name _;',
  line   => "\n\t# 404 configuration\n\terror_page 404 /custom_404.html;\
            \n\tlocation /custom_404.html {\n\t\troot /var/www/html;\
             \n\t\tinternal;\n\t}\n"
}

-> file { 'Create custom_404.html file' :
  path    => '/var/www/html/custom_404.html',
  content => "Ceci n'est pas une page\n"
}


-> file_line { 'add redirect config' :
  ensure => present,
  path   => '/etc/nginx/sites-available/default',
  after  => 'server_name _;',
  line   => "\n\t# Redirect configuration\n\tlocation /redirect_me \
            {\n\t\trewrite /redirect_me https://youtube.com permanent;\n\t}\n"
}

-> service { 'Ensure nginx is running' :
  ensure     => running,
  name       => 'nginx',
  hasrestart => true
}
