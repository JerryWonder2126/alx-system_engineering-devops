# Change wrong extension .phpp to .php in wp-settings.php (wordpress config file)

exec { 'fix wordpress config file':
  command => 'sed -i s/phpp/php/g var/www/html/wp-settings.php',
  path    => '/usr/bin/env'
}
