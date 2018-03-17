# Implements question 1 and 7.
# create and manage the system's users
class users {
  # Question 7
  # replace bash profile skel so every new user gets the managed version.
  # This satisfys the requirement of adding local bin to the path as the skel file is
  # created before the users so they all inherit it.
  file { '/etc/skel/.bash_profile':
    ensure  => present,
    path    => '/etc/skel/.bash_profile',
    force   => true,
    mode    => '0644',
    owner   => 'root',
    replace => true,
    source  => 'puppet:///modules/confs/.bash_profile'
  }

  # Question 1
  #  Add user groups
  group { 'sysadmin':
    ensure => present,
  }

  group { 'cars':
    ensure => present,
  }

  group { 'trucks':
    ensure => present,
  }

  group { 'ambulances':
    ensure => present,
  }
  #  Add users
  user { 'becca':
    ensure     => present,
    password   => '$6$reiuohuweighrgw$9yX13x4Q3CmvCrf7XZFXVo7BGfHYpj3tJx5RAixkyJS6BSA71jng63TzxzOpY8E4a4/sHmKr10m9WSaco8ZNs0',
    uid        => 10012043,
    managehome => true,
    home       => '/home/becca',
    shell      => '/bin/bash',
    groups     => ['sysadmin', 'cars'],
  }

  user { 'fred':
    ensure     => present,
    password   => '$6$nhgnhmyum$G7bAXGR.dr/JIv.V6oakc9CW4RZi8u6ySnDyv/tOjzDbzwOAWlMgC8.RiiEgpyhxR.bvr6DpJ0HLikGRowCnq1',
    uid        => 10022043,
    managehome => true,
    home       => '/home/fred',
    shell      => '/bin/csh',
    groups     => ['trucks', 'cars', 'root'],
    require    => Package['tcsh']
  }

  user { 'wilma':
    ensure     => present,
    password   => '$6$uymygmhmghm$G44E.xViaD7VaUtrw.bUHltO7Z4XY32aTuRJjR09qVQUt7gQ6lHFfAgasZtmI9NTMXcC5.5HPiYd8iXnKF.EX.',
    uid        => 10032043,
    managehome => true,
    home       => '/home/wilma',
    shell      => '/bin/bash',
    groups     => ['trucks', 'cars', 'ambulances'],
  }

  #  Add ssh key for wilma
  ssh_authorized_key { 'wilma_ssh':
    user => 'wilma',
    type => 'rsa',
    key  => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQC8djweadgWfQ57S3vc5GAyINFjPnVwxSI/I3hfmFn6bw1LQR64f32VL7cigDwGffBZtpJHtgAR8NlcJgPN4qYPhTL3r2VVuY5F5AmpEOIlJZ4xa6GoU91vMeXAEKXkPVsbyD2XiEJiVqNvkNElKirQQDMgbzuZmBm2kB+sQgrdhYgbWDZkQoeu8grtJnLFuuAwRuxKHyCJnvHo8yUULz3nj85HWlYS9YuHN4+PUKNW8wk2f5INyJOWcLucUrT1goHYmr26QOhx4++vfG8O8qHJZpwEOsFb1bMg4P7BnFiL3tAf9xDsrEJXgADTRJFDoxUnS5ERJWeHZGx9vh+/JkJ9',
  }

}
