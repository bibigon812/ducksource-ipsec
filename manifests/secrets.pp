define ipsec::secrets (
  Optional[String]
  $leftid  = undef,
  Optional[String]
  $rightid = undef,
  Enum['present', 'absent']
  $ensure  = 'present',
  Optional[String]
  $psk     = undef,
  Optional[String]
  $rsa     = undef,
  Optional[String]
  $xauth   = undef,
) {

  include ::ipsec::params

  $package_name = $ipsec::params::package_name
  $service_name = $ipsec::params::service_name

  $file_ensure = $ensure ? {
    'present' => file,
    default   => absent,
  }

  unless (
    ($leftid and $rightid)
    or $psk or $rsa or $xauth
    or $ensure == 'absent') {

    fail('Leftid, rightid and psk|rsa|xauth required.')
  }

  $file_name = downcase(regsubst($name, '\W', '_', 'G'))

  file { "/etc/ipsec.d/${file_name}.secrets":
    ensure  => $file_ensure,
    content => template('ipsec/sa.secrets.erb'),
    mode    => '0600',
    require => Package[ $package_name ],
    notify  => Service[ $service_name ],
  }
}
