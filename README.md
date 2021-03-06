[![Build Status](https://travis-ci.org/bibigon812/bibigon812-ipsec.svg?branch=master)](https://travis-ci.org/bibigon812/bibigon812-ipsec)

## Overview
This module provides controls IPsec connections.

## Classes
* ::ipsec - class for managing of the IPsec service.
* ::ipsec::sa - class for managing Secret Association.
* ::ipsec::secrets -  class for managing secrets of the pair [leftid, rightid]

## Example

### Add configuration

```
ipsec { 'IPSEC': }

ipsec::sa { 'TEST-SA-1':
  left           => '192.168.1.1',
  leftprotoport  => all,
  leftsourceip   => '10.0.0.1',
  leftsubnet     => '10.0.0.1/32',
  right          => '192.168.2.1',
  rightprotoport => all,
  rightsubnet    => '10.0.0.2/32',
  auto           => add,
  ike            => 'aes256-sha;dh24',
}

ipsec::secrets { 'TEST-SECRETS-1':
  leftid  => '192.168.1.1',
  rightid => '192.168.2.1',
  psk     => 'preshared secret key',
}
```

### Remove configuration:

```
ipsec { 'IPSEC': }

ipsec::sa { 'TEST-SA-1':
  ensure => absent,
}

ipsec::secrets { 'TEST-SECRETS-1':
  ensure  => absent,
}
```
