file_line { 'Edit a line in /etc/ssh/ssh_config':
  path  => '/etc/ssh/ssh_config',
  line  => 'PasswordAuthentication no',
  match => 'PasswordAuthentication'
}

file_line { 'Append a line to /etc/ssh/ssh_config':
  path => '/etc/ssh/ssh_config',
  line => 'IdentityFile ~/.ssh/school'
}
