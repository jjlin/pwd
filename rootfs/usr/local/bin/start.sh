#!/bin/bash

dpkg-reconfigure openssh-server
/etc/init.d/ssh start
passwd
exec /bin/bash
